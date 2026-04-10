local TW = game:GetService("TweenService")--Get Tween Service

local Player = game:GetService("Players").LocalPlayer --Get The Player
local Character = workspace.Rig
local Humanoid = Character:WaitForChild("Humanoid")

local reg = game.ReplicatedStorage.Boss.BossReg

local gui = game.ReplicatedStorage.Boss.Gui

local Healthbar = script.Parent -- Get The Health Bar

local oldHP = Humanoid.Health
local newHP = Humanoid.Health
local damage = {}
local fighter = {}
local display = {}

local dead = game.ReplicatedStorage.Boss.Dead

local Players = game:GetService("Players")

for _, player in pairs(Players:GetPlayers()) do
	damage[tostring(player.Name)] = 0
end

Players.PlayerAdded:Connect(function(player)
		damage[tostring(player.Name)] = 0
end)

local list = {}
local identity = {}
local rack = 0
local comeback = game.ReplicatedStorage.Boss.Return
local dam = {}

reg.OnClientEvent:Connect(function(player,count,nami,damage)
	
	list[count] = player
	identity[count] = nami
	dam[count] = damage
	if rack < count then
		rack = count
	end
end)

dead.OnClientEvent:Connect(function(player)
	local j = 0
	while j < rack do
		j = j + 1
		comeback:FireServer(list[j],rack,dam[j],identity[j])
	end
end)

local function UpdateHealthbar() --Health Bar Size Change Function
	
	task.wait(0.1)
	newHP = Humanoid.Health
	
	local health = math.clamp(Humanoid.Health / Humanoid.MaxHealth, 0, 1) --Maths
	local info = TweenInfo.new(Humanoid.Health / Humanoid.MaxHealth,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0) --Tween Info
	local tween = TW:Create(script.Parent,info,{Size = UDim2.fromScale(health, 1)}) -- Create The Tween Then Play It
	tween:Play()
	-- Replace with your module's location
	local i = 0
	local position = 0.14
	while i < rack do
		i = i +1
		if script.Parent.Parent.Parent then
			local nam = identity[i]
			local fold = script.Parent.Parent.Parent
			
			local peep = fold:FindFirstChild(nam)
			
			if peep then
				peep:Destroy()
			end
			local credit = Instance.new("TextLabel")
			credit.Name = identity[i]
			credit.Text = tostring(list[i]).."%"
			credit.Parent = script.Parent.Parent.Parent
			credit.BackgroundTransparency = 1
			credit.TextSize = 15
			credit.Position = UDim2.new(0.255,0,position,0)		
			position = position + 0.05
			credit.Size = UDim2.new(0,175,0,37)
		end
	end
	
	

	oldHP = (Humanoid.Health)
	
	if Humanoid.Health == 0 then
		script.Parent.Parent.Parent.Enabled = false		
		tween:Cancel()
		script.Parent.Size = UDim2.new(1,0,1,0)
	end
end


UpdateHealthbar()--Update The Health Bar

gui.OnClientEvent:Connect(function(player)
	
	script.Parent.Parent.Parent.Enabled = true
	
	Character = workspace.Rig
	Humanoid = Character:WaitForChild("Humanoid")

	Humanoid:GetPropertyChangedSignal("Health"):Connect(UpdateHealthbar)
	Humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(UpdateHealthbar) 

end)
