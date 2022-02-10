Config = {}

Config.Command = 'topcriminals'

--[[ Export Usage:

Get a jobs score:
    local job_name = 'ballas'       -- The name of the job
    local score = exports['lab-TopCriminals']:getScore(job_name)

Set a jobs score:
    local job_name = 'ballas'       -- The name of the job
    local amount = 10               -- The amount of score
    local score = exports['lab-TopCriminals']:setScore(job_name, amount)

Give score to a job:
    local job_name = 'ballas'       -- The name of the job
    local amount = 10               -- The amount of score
    local score = exports['lab-TopCriminals']:giveScore(job_name, amount)

Remove score from a job:
    local job_name = 'ballas'       -- The name of the job
    local amount = 10               -- The amount of score
    local score = exports['lab-TopCriminals']:removeScore(job_name, amount)
    
]]