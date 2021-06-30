import { CliProc, Ot } from "ot-builder";

import { dropGlyphNames } from "../helpers/drop.mjs";
import { simplifySingleSub } from "../helpers/feature-simplify.mjs";
import { readFont, writeFont } from "../helpers/font-io.mjs";
import { italize } from "../helpers/geometry.mjs";

export default (async function makeFont(argv) {
	const main = await readFont(argv.main);
	const kanji = await readFont(argv.kanji);
	const hangul = await readFont(argv.hangul);

	addTrivialGdef(kanji);
	addTrivialGdef(hangul);

	if (argv.italize) {
		italize(kanji, 10);
		italize(hangul, 10);
	}

	CliProc.mergeFonts(main, hangul, Ot.ListGlyphStoreFactory);
	CliProc.mergeFonts(main, kanji, Ot.ListGlyphStoreFactory);

	shareFeatures(main.gsub);
	shareFeatures(main.gpos);
	CliProc.consolidateFont(main);

	dropGlyphNames(main);
	simplifySingleSub(main.gsub, "vert");
	simplifySingleSub(main.gsub, "vrt2");

	if (argv.hint)
		main.name.records.forEach(entry => {
			switch (entry.nameID) {
				case 1:
				case 16:
					entry.value = String(entry.value) + " H";
					break;
				case 3:
				case 4:
					entry.value = String(entry.value).replace(/^([a-z]+ [a-z]+ [a-z]+)/i, "$1 H");
					break;
				case 6:
					entry.value = String(entry.value).replace(/^([a-z]+-[a-z]+-[a-z]+)/i, "$1-H");
					break;
			}
		});

	await writeFont(argv.o, main);
});

function addTrivialGdef(font) {
	if (!font.gdef) {
		font.gdef = new Ot.Gdef.Table();
	}
	if (!font.gdef.glyphClassDef || !font.gdef.glyphClassDef.size) {
		font.gdef.glyphClassDef = new Map();
		for (const g of font.glyphs.decideOrder()) {
			font.gdef.glyphClassDef.set(g, Ot.Gdef.GlyphClass.Base);
		}
	}
}

function shareFeatures(table) {
	if (!table || !table.scripts) return;
	const langDflt = table.scripts.get("DFLT").defaultLanguage;

	for (const [scriptTag, script] of table.scripts) {
		if (script.defaultLanguage && isFarEastScript(scriptTag)) {
			script.defaultLanguage.features = [
				...script.defaultLanguage.features,
				...langDflt.features
			];
		}

		for (const [langTag, lang] of script.languages) {
			if (isFarEastScript(scriptTag) || isFarEastLanguage(langTag)) {
				lang.features = [...lang.features, ...langDflt.features];
			}
		}
	}
}

function isFarEastScript(tag) {
	return tag === "hani" || tag === "kana" || tag === "bopo" || tag === "hang";
}
function isFarEastLanguage(tag) {
	tag = tag.trim();
	return tag === "JAN" || tag === "KOR" || tag === "ZHS" || tag === "ZHT" || tag === "ZHH";
}
