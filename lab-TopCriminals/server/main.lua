ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('lab-TopCriminals:getData', function(source, cb)
    local data = {}
    MySQL.Async.fetchAll('SELECT * FROM jobs ORDER BY score DESC',{}, function(result)   
        for k, v in pairs(result) do
            local label = v.label
            local score = v.score
            local type = v.type
            table.insert(data, {label = label, score = score, type = type})
        end
        cb(data)
    end)
end)

function setScore(name, amount)
    MySQL.Async.execute(
        "UPDATE `jobs` SET `score`= @score WHERE `name` = @name",
        {["@score"] = amount, ["@name"] = name},
        function()
        end)
end

function getScore(name)
    return tonumber(
        MySQL.Sync.fetchScalar(
            "SELECT `score` FROM jobs WHERE name = @name ",
            {["@name"] = name}
        )
    )
end

function giveScore(name, amount)
    MySQL.Async.execute(
        "UPDATE `jobs` SET `score`= `score` + @score WHERE `name` = @name",
        {["@score"] = amount, ["@name"] = name},
        function()
    end)
end

function removeScore(name, amount)
    MySQL.Async.execute(
        "UPDATE `jobs` SET `score`= `score` - @score WHERE `name` = @name",
        {["@score"] = amount, ["@name"] = name},
        function()
    end)
end

-- Admin Commands
RegisterCommand("givescore", function(source, args, rawCommand)
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
			if args[1] ~= nil then
				local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
				if xTarget ~= nil then
					if args[2] ~= nil then
						giveScore(xTarget.job.name, tonumber(args[2]))
					end
				end
			end
		end
	end
end,false)

RegisterCommand("removescore", function(source, args, rawCommand)
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
			if args[1] ~= nil then
				local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
				if xTarget ~= nil then
					if args[2] ~= nil then
						removeScore(xTarget.job.name, tonumber(args[2]))
					end
				end
			end
		end
	end
end,false)

RegisterCommand("setscore", function(source, args, rawCommand)
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
			if args[1] ~= nil then
				local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
				if xTarget ~= nil then
					if args[2] ~= nil then
						setScore(xTarget.job.name, tonumber(args[2]))
					end
				end
			end
		end
	end
end,false)
