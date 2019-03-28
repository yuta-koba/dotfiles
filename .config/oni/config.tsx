
import * as React from "react"
import * as Oni from "oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")

    // Input
    //
    // Add input bindings here:
    //
    oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"))

    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")

}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}

export const configuration = {
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
    "editor.fullScreenOnStart" : true,

    "environment.additionalPaths": [
      "/usr/bin",
      "/usr/local/bin",
      "/Users/lunarxlark/.zplug/bin"
    ],

  "language.go.languageServer.command": "bingo",

    // UI customizations
    "ui.animations.enabled": true,
    "ui.fontSmoothing": "auto",
    "ui.colorscheme": "tender",

    "sidebar.enabled": false,
    //"sidebar.default.open": false,

    "statusbar.enabled": false,

    "tabs.height": "1.5em",
}
