import buildFont from "../common/build-font.mjs";
import gc from "../common/gc.mjs";
import introFont from "../common/intro-font.mjs";
import { italize } from "../common/italize.mjs";
import { mergeBelow } from "../common/merge.mjs";
import GlyphPoint from "../common/support/glyph-point.mjs";

import shareFeatures from "./share-features.mjs";

export default (async function makeFont(argv) {
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
});
