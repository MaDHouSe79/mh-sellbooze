fx_version 'cerulean'
game 'gta5'

description 'mh-sellbooze'
version '1.0.0'


shared_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua', -- replace with desired language
    'config.lua'
}

client_scripts {'client/main.lua',}
server_scripts {'server/main.lua', 'server/update.lua'}

lua54 'yes'
