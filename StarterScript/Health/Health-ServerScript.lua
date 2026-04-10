local Player = game:GetService("Players").LocalPlayer --Get The Player

local Character = workspace.Rig
local Humanoid = Character:WaitForChild("Humanoid")

local reg = game.ReplicatedStorage.Boss.BossReg

local Healthbar = script.Parent -- Get The Health Bar

local counter = 0

local regstier = require(game.ReplicatedStorage["Boos Register"])
local damage = {}
local fighter = {}
local display = {}
local percent = {}

local blinder = game.ReplicatedStorage.Boss.Bindable

local Players = game:GetService("Players")

for _, player in pairs(Players:GetPlayers()) do
	damage[(player.Name)] = 0
end

Players.PlayerAdded:Connect(function(player)
	damage[(player.Name)] = 0
end)

local oldHP = 800
local newHP = 800



local function Update()
	task.wait(0.00001)
     
	 Character = workspace.Rig
	 Humanoid = Character:WaitForChild("Humanoid")

newHP = Humanoid.Health


for name, _ in (regstier) do
		if tostring(regstier[name]) == "Rig" then			
		damage[name] = damage[name] + math.abs(oldHP - newHP)
		percent[name] = damage[name]/800 * 100 
		display[name] = name.." "..percent[name]
		fighter[counter] = tostring(name)
		counter = counter + 1
		oldHP = Humanoid.Health
		regstier[name] = ""	
		
		blinder:Fire(name)
		
       end
	end

	local number = 0
	local position = 1
	local siri =  ""
	local count = 1

	for variable, _ in pairs(display) do
		reg:FireAllClients(display[variable],count,variable,damage[variable])
		count = count + 1
	end
	
	
	
	
end

Update()
	
Humanoid:GetPropertyChangedSignal("Health"):Connect(Update)






