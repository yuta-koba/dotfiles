"use strict";
exports.__esModule = true;
exports.activate = function (oni) {
    console.log("config activated");
    // Input
    //
    // Add input bindings here:
    //
    oni.input.bind("<c-enter>", function () { return console.log("Control+Enter was pressed"); });
    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")
};
exports.deactivate = function (oni) {
    console.log("config deactivated");
};
exports.configuration = {
    /*
     * add custom config here, such as
     */
    "browser.defaultUrl": "https://google.com",
    "experimental.vcs.sidebar": true,
    "experimental.indentLines.enabled": true,
    "experimental.markdownPreview.enabled": true,
    //"oni.bookmarks": ["~/Documents"],
    "oni.useDefaultConfig": false,
    "experimental.vcs.blame.enabled": true,
    "experimental.vcs.blame.mode": "auto",
    "experimental.vcs.blame.timeout": 0,
    "oni.loadInitVim": true,
    "oni.hideMenu": true,
    //"editor.fontFamily": "Monaco",
    "editor.fontSize": "15px",
    "editor.quickInfo.delay": 0,
    "editor.linePadding": 0,
    "editor.fullScreenOnStart": true,
    "environment.additionalPaths": [
        "/usr/bin",
        "/usr/local/bin",
        "/Users/lunarxlark/.zplug/bin"
    ],
    // UI customizations
    "ui.animations.enabled": true,
    "ui.fontSmoothing": "auto",
    "ui.colorscheme": "nord",
    "sidebar.enabled": false,
    //"sidebar.default.open": false,
    "statusbar.enabled": false,
    "tabs.height": "1.5em"
};
