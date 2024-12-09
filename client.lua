ESX = exports['es_extended']:getSharedObject()


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)

        local playerPed = PlayerPedId()
        local playerData = ESX.GetPlayerData()
        
        local rank = playerData.job and playerData.job.grade_label or 'Sin grado'


        -- Verificar si el jugador está en un vehículo
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local rpm = 0
        local speed = 0
        local fuel = 0
        local showSpeed = false
        if vehicle ~= 0 then
            rpm = GetVehicleCurrentRpm(vehicle) * 6000  -- Multiplicamos por 6000 para obtener el valor en RPM
            speed = GetEntitySpeed(vehicle) * 3.6  -- Velocidad en km/h
            showSpeed = true
            fuel = GetVehicleFuelLevel(vehicle) -- Obtiene el nivel de combustible
        end

        local health = math.ceil(GetEntityHealth(playerPed) - 100)
        local hunger = 100
        local thirst = 100

        -- Obtener hambre y sed
        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            hunger = status.getPercent()
        end)

        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = status.getPercent()
        end)

        local money = playerData.money
        local bank = 0

        if playerData.accounts then
            for i = 1, #playerData.accounts, 1 do
                if playerData.accounts[i].name == 'bank' then
                    bank = playerData.accounts[i].money
                end
            end
        end

        if playerData.accounts then
            for i = 1, #playerData.accounts, 1 do
                if playerData.accounts[i].name == 'money' then
                    money = playerData.accounts[i].money
                end
            end
        end

        local job = playerData.job and playerData.job.label or 'Sin trabajo'
        local isMapOpen = IsPauseMenuActive()

        if isMapOpen then
            SendNUIMessage({ type = 'hideHUD' })
        else
            SendNUIMessage({
                type = 'updateHUD',
                health = health,
                hunger = hunger,
                thirst = thirst,
                money = money,
                bank = bank,
                job = job,
                rank = rank,
                speed = speed,  
                rpm = rpm,  
                fuel = fuel, 
                showSpeed = showSpeed
            })
        end
    end
end)
