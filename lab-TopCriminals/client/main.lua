ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    Citizen.Wait(800)
    PlayerData = ESX.GetPlayerData() -- Setting PlayerData vars
end)


RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(Player)
    PlayerData = Player
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(Job)
    PlayerData.job = Job -- Setting PlayerJob on change or player loaded
end)

RegisterCommand(Config.Command, function()
    Leaderboard()
end)

function Leaderboard()

    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
	
	SendNUIMessage({
		message		 = "show"
	})

    ESX.TriggerServerCallback('lab-TopCriminals:getData', function(cb)
        local count = 0
        for k,v in pairs(cb) do
            if v.type == 'gang' or v.type == 'mafia' or v.type == 'cartel' then
                SendNUIMessage({
                    message		 = "add",
                    label = v.label:gsub("^%l", string.upper),
                    score = v.score,
                    type = v.type:gsub("^%l", string.upper)
                })
                count = count+1
            end
            if count >= 10 then
                break
            end
        end
    end)

	SetTimecycleModifier('hud_def_blur')
	
	ESX.SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)

end

function closeGui()
  SetNuiFocus(false, false)
  SendNUIMessage({message = "hide"})
  SetTimecycleModifier('default')
end

RegisterNUICallback('quit', function(data, cb)
  closeGui()
  cb('ok')
end)