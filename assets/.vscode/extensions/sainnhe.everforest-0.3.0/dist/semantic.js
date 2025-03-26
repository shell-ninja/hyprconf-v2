"use strict";
/*---------------------------------------------------------------
 *  Homepage:   https://github.com/sainnhe/everforest-vscode
 *  Copyright:  2020 Sainnhe Park <i@sainnhe.dev>
 *  License:    MIT
 *--------------------------------------------------------------*/
Object.defineProperty(exports, "__esModule", { value: true });
exports.getSemantic = void 0;
const palette_1 = require("./palette");
function getSemantic(configuration, variant) {
    const palette = (0, palette_1.getPalette)(configuration, variant);
    return {
        // General {{{
        operatorOverload: `${palette.orange}`,
        memberOperatorOverload: `${palette.orange}`,
        // }}}
        // JavaScript {{{
        "variable.defaultLibrary:javascript": `${palette.purple}`,
        "property.defaultLibrary:javascript": `${palette.purple}`,
        // }}}
        // JavaScript React {{{
        "variable.defaultLibrary:javascriptreact": `${palette.purple}`,
        "property.defaultLibrary:javascriptreact": `${palette.purple}`,
        // }}}
        // TypeScript {{{
        "class:typescript": `${palette.aqua}`,
        "interface:typescript": `${palette.aqua}`,
        "enum:typescript": `${palette.purple}`,
        "enumMember:typescript": `${palette.blue}`,
        "namespace:typescript": `${palette.purple}`,
        "variable.defaultLibrary:typescript": `${palette.purple}`,
        "property.defaultLibrary:typescript": `${palette.purple}`,
        // }}}
        // TypeScript React {{{
        "class:typescriptreact": `${palette.aqua}`,
        "interface:typescriptreact": `${palette.aqua}`,
        "enum:typescriptreact": `${palette.purple}`,
        "enumMember:typescriptreact": `${palette.blue}`,
        "namespace:typescriptreact": `${palette.purple}`,
        "variable.defaultLibrary:typescriptreact": `${palette.purple}`,
        "property.defaultLibrary:typescriptreact": `${palette.purple}`,
        // }}}
        // Python {{{
        "intrinsic:python": `${palette.purple}`,
        "module:python": `${palette.blue}`,
        "class:python": `${palette.aqua}`,
        // }}}
        // Rust {{{
        "macro:rust": `${palette.aqua}`,
        "namespace:rust": `${palette.purple}`,
        "selfKeyword:rust": `${palette.purple}`,
        // }}}
    };
}
exports.getSemantic = getSemantic;
// vim: fdm=marker fmr={{{,}}}:
//# sourceMappingURL=semantic.js.map