ESX = exports['es_extended']:getSharedObject()

-- Actualizar el estado de hambre y sed
RegisterNetEvent('esx_status:update')
AddEventHandler('esx_status:update', function(name, value)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil then
        -- Solo actualizamos el valor de hambre o sed
        if name == 'hunger' or name == 'thirst' then
            -- Actualizar estado de hambre o sed
            TriggerClientEvent('esx_status:setStatus', _source, name, value)
        end
    end
end)

-- Enviar el dinero en banco al cliente
ESX.RegisterServerCallback('esx_status:getMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local bankMoney = 0
    for i=1, #xPlayer.accounts, 1 do
        if xPlayer.accounts[i].name == 'bank' then
            bankMoney = xPlayer.accounts[i].money
        end
    end
    cb(bankMoney)
end)
