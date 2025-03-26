"use strict";
/*---------------------------------------------------------------------------------------------
 *  Homepage:   https://github.com/sainnhe/everforest-vscode
 *  Copyright:  2020 Sainnhe Park <i@sainnhe.dev>
 *  License:    MIT
 *--------------------------------------------------------------------------------------------*/
Object.defineProperty(exports, "__esModule", { value: true });
exports.getPalette = void 0;
const foreground_1 = require("./dark/foreground");
const hard_1 = require("./dark/background/hard");
const medium_1 = require("./dark/background/medium");
const soft_1 = require("./dark/background/soft");
const foreground_2 = require("./light/foreground");
const hard_2 = require("./light/background/hard");
const medium_2 = require("./light/background/medium");
const soft_2 = require("./light/background/soft");
function getPalette(configuration, variant) {
    let paletteBackground = medium_1.default;
    let paletteForeground = foreground_1.default;
    if (variant === "dark") {
        paletteForeground = foreground_1.default;
        switch (configuration.darkContrast // {{{
        ) {
            case "hard": {
                paletteBackground = hard_1.default;
                break;
            }
            case "medium": {
                paletteBackground = medium_1.default;
                break;
            }
            case "soft": {
                paletteBackground = soft_1.default;
                break;
            }
            default: {
                paletteBackground = medium_1.default;
            }
        } // }}}
    }
    else {
        paletteForeground = foreground_2.default;
        switch (configuration.lightContrast // {{{
        ) {
            case "hard": {
                paletteBackground = hard_2.default;
                break;
            }
            case "medium": {
                paletteBackground = medium_2.default;
                break;
            }
            case "soft": {
                paletteBackground = soft_2.default;
                break;
            }
            default: {
                paletteBackground = medium_2.default;
            }
        } // }}}
    }
    return {
        // {{{
        bg0: paletteBackground.bg0,
        bg1: paletteBackground.bg1,
        bg: paletteBackground.bg,
        bg2: paletteBackground.bg2,
        bg3: paletteBackground.bg3,
        bg4: paletteBackground.bg4,
        bg5: paletteBackground.bg5,
        grey0: paletteBackground.grey0,
        grey1: paletteBackground.grey1,
        grey2: paletteBackground.grey2,
        shadow: paletteBackground.shadow,
        fg: paletteForeground.fg,
        red: paletteForeground.red,
        orange: paletteForeground.orange,
        yellow: paletteForeground.yellow,
        green: paletteForeground.green,
        aqua: paletteForeground.aqua,
        blue: paletteForeground.blue,
        purple: paletteForeground.purple,
        dimRed: paletteForeground.dimRed,
        dimOrange: paletteForeground.dimOrange,
        dimYellow: paletteForeground.dimYellow,
        dimGreen: paletteForeground.dimGreen,
        dimAqua: paletteForeground.dimAqua,
        dimBlue: paletteForeground.dimBlue,
        dimPurple: paletteForeground.dimPurple,
        badge: paletteForeground.badge,
    }; // }}}
}
exports.getPalette = getPalette;
// vim: fdm=marker fmr={{{,}}}:
//# sourceMappingURL=index.js.map