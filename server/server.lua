local QBCore = exports['qb-core']:GetCoreObject()

local attendenceApi = "https://qbus.onno204.nl/qbus-management/backend/fivem/log"

RegisterServerEvent('qb-attendence:server:Createattendence')
AddEventHandler('qb-attendence:server:Createattendence', function(name, title, color, message, tagEveryone)
    local tag = tagEveryone ~= nil and tagEveryone or false
    local webHook = Config.Webhooks[name] ~= nil and Config.Webhooks[name] or Config.Webhooks["default"]
    local embedData = {
        {
            ["title"] = title,
            ["color"] = Config.Colors[color] ~= nil and Config.Colors[color] or Config.Colors["default"],
            ["footer"] = {
                ["text"] = os.date("%c"),
            },
            ["description"] = message,
        }
    }
    PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = "On-off duty bot",embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = "On-off duty bot", content = "@everyone"}), { ['Content-Type'] = 'application/json' })
    end
end)

RegisterServerEvent('qb-attendence:server:sendattendence')
AddEventHandler('qb-attendence:server:sendattendence', function(citizenid, attendencetype, data)
    local dataString = ""
    data = data ~= nil and data or {}
    for key,value in pairs(data) do 
        if dataString ~= "" then
            dataString = dataString .. "&"
        end
        dataString = dataString .. key .."="..value
    end
    local requestUrl = string.format("%s?citizenid=%s&logtype=%s&%s", attendenceApi, citizenid, logtype, dataString)
    requestUrl = string.gsub(requestUrl, ' ', "%%20")
    PerformHttpRequest(requestUrl, function(err, text, headers) end, 'GET', '')
end)

--'made by LEGEND|TGB#1058''
