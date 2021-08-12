"use strict";

const introFont = require("../common/intro-font");
const buildFont = require("../common/build-font");
const { mergeBelow } = require("../common/merge");

const { italize } = require("../common/italize");
const shareFeatures = require("./share-features");
const gc = require("../common/gc");
const GlyphPoint = require("../common/support/glyph-point");

module.exports = async function makeFont(argv) {
	const a = await introFont({ from: argv.main, prefix: "a" });
	const b = await introFont({ from: argv.kanji, prefix: "b" });
	const c = await introFont({ from: argv.hangul, prefix: "c" });

	if (argv.italize) italize(b, 10);
	if (argv.italize) italize(c, 10);

	mergeBelow(a, b, { mergeOTL: true });
	mergeBelow(a, c, { mergeOTL: true });
	shareFeatures(a.GSUB);
	shareFeatures(a.GPOS);

	// This will make the order of glyphs in TTC less mangled
	a.glyf.__glyf_pad__ = { advanceWidth: 0, contours: [[GlyphPoint.cornerFromXY(0, 0)]] };
	a.glyph_order = gc(a, { rankMap: [["__glyf_pad__", 1]] });

	// Patch
	if (argv.hint) {
		a.name.forEach(entry => {
			switch (entry.nameID) {
				case 1:
				case 16:
					entry.nameString = entry.nameString + " H";
					break;
				case 3:
				case 4:
					entry.nameString = entry.nameString.replace(/^([a-z]+ [a-z]+ [a-z]+)/i, "$1 H");
					break;
				case 6:
					entry.nameString = entry.nameString.replace(/^([a-z]+-[a-z]+-[a-z]+)/i, "$1-H");
					break;
			}
		});
	}

	await buildFont(a, { to: argv.o });
};
