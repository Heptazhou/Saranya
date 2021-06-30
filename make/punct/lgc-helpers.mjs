import { copyGeometryData } from "../helpers/geometry.mjs";
import { GlyphFinder } from "../helpers/glyph-finder.mjs";

export function transferMonoGeometry(main, lgc, isTerm) {
	const find = new GlyphFinder(main);
	for (let u = 0x2000; u < 0x20a0; u++) {
		if (shallSkip(u, isTerm)) continue;
		const gSrc = lgc.cmap.unicode.get(u);
		const gDst = main.cmap.unicode.get(u);
		if (gSrc && gDst) copyGeometryData(gDst, gSrc);

		const gPwid = find.subst("pwid", gDst);
		if (gPwid && gPwid !== gDst) copyGeometryData(gPwid, gDst);
	}
}

function shallSkip(unicode, isTerm) {
	return isTerm
		? // 双引号|单引号
		  [0x2018, 0x2019, 0x201c, 0x201d].includes(unicode)
		: // 双引号|单引号|省略号
		  [0x2018, 0x2019, 0x201c, 0x201d, 0x2026].includes(unicode);
}
