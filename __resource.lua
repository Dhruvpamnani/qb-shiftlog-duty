resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "html/index.html"
description "Qbus Attendence Made by LEGEND|TGB#1058"
server_scripts {
    'server/server.lua',
    'config.lua',
}

client_scripts {
    'client/client.lua'
}

files {
    'html/index.html',
    'html/script.js',
}