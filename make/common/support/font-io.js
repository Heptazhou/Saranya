"use strict";

const which = require("which");

const child_process = require("child_process");
const path = require("path");
const fs = require("fs-extra");
const JsonUtil = require("./json-util");

const DumpCommand = which.sync(`otfccdump`);
const BuildCommand = which.sync(`otfccbuild`);

exports.loadFont = function loadFont(sourceFile, options) {
	return JsonUtil.parseJsonObjectFromStream(getStream(sourceFile, options));
};

function getStream(sourcefile, options) {
	if (sourcefile === "|") {
		process.stdin.resume();
		process.stdin.setEncoding("utf8");
		return process.stdin;
	}
	const ext = path.parse(sourcefile).ext;
	if (ext === ".ttf" || ext === ".otf") {
		const cp = child_process.spawn(DumpCommand, [
			sourcefile,
			...(options.prefix ? ["--glyph-name-prefix", options.prefix + "/"] : []),
			...(options.ignoreHints ? ["--ignore-hints"] : []),
			...(options.nameByHash ? ["--name-by-hash"] : []),
			"--no-bom",
			"--decimal-cmap",
			"--quiet"
		]);
		cp.stdout.setEncoding("utf8");
		return cp.stdout;
	} else {
		return fs.createReadStream(sourcefile, { encoding: "utf8" });
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////

exports.buildFont = async function buildFont(font, destination, options) {
	if (destination === "|") {
		if (process.stdout.setEncoding instanceof Function) process.stdout.setEncoding("utf8");
		await JsonUtil.fontJsonStringifyToStream(font, process.stdout, true);
	} else {
		const ext = path.parse(destination).ext;
		if (ext === ".ttf" || ext === ".otf") {
			const cp = child_process.spawn(BuildCommand, [
				...["-o", destination],
				...(options.optimize ? ["--short-post", "--subroutinize", "--force-cid"] : []),
				...(options.sign ? ["-s"] : []),
				...(options.ignoreOrder ? ["-i"] : ["-k"]),
				...(options.recalculateCharWidth ? [] : ["--keep-average-char-width"]),
				...(options.quiet ? ["--quiet"] : [])
			]);
			cp.stderr.on("data", function (data) {
				if (options.verbose) process.stderr.write(data);
			});
			await Promise.all([
				JsonUtil.fontJsonStringifyToStream(font, cp.stdin),
				cpToPromise(cp)
			]);
		} else {
			const out = fs.createWriteStream(destination);
			await JsonUtil.fontJsonStringifyToStream(font, out);
		}
	}
};

exports.cpToPromise = cpToPromise;
function cpToPromise(cp) {
	return new Promise(function (resolve, reject) {
		cp.on("close", code => {
			if (code !== 0) {
				reject(code);
			} else {
				resolve(code);
			}
		});
	});
}
