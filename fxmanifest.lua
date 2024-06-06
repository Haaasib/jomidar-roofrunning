fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name         'jomidar-roofrunning'
version      '1.1.1'
description  'A multi-framework roof running'
author       'Hasib'

shared_scripts {
    'cfg.lua'
}

server_scripts {
    'sv.lua',
}

client_scripts {
    'cl.lua',
}
dependencies {
    'qb-core',
    'NopixelV4NPCDialogue',
    'skillchecks',
    'j-textui'
}
ui_page "web/ui.html"

files {
	"web/ui.html",
    "web/css.css",
    "web/js.js",
    'web/fonts/*.ttf',
}
