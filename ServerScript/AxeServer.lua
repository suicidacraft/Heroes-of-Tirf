local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local CS = game:GetService("CollectionService")
local axeEvents = RS.Events.Weapons.Axe
local equippedE = axeEvents.Equipped
local unequippedE = axeEvents.Unequipped
local activatedE = axeEvents.Activated
local Yessir = axeEvents.Sag
local trigger = game.ReplicatedStorage.Events.Weapons.Axe.Trigger
local checking = game.ReplicatedStorage.inCombat

local Hit = RS.Events.Weapons.Katana.Hit
local HealthManager = require(game.ServerScriptService.HealthManager)

equippedE.OnServerInvoke = function(player,weapon)
	-- on equipping weapon creates weapon model depending on the weapon parameter and attaches it to player model so it can be animated
	local char = player.Character
	local root = char:WaitForChild("HumanoidRootPart")
	if weapon == "Darius" then
		local Axe = script.B:Clone()
		local motor6d = Instance.new("Motor6D", root)
		motor6d.Part0 = root
		motor6d.Part1 = Axe.Handle
		motor6d.Name = "Handle" 
		Axe.Parent = char
		CS:AddTag(Axe, "Axe-" ..player.UserId)
		CS:AddTag(motor6d, "Axe-" .. player.UserId)		 
	end
	if weapon == "Evolution" then
		local Axe = script.Axe:Clone()
		local motor6d = Instance.new("Motor6D", root)
		motor6d.Part0 = root
		motor6d.Part1 = Axe.Handle
		motor6d.Name = "Handle" 
		Axe.Parent = char
		CS:AddTag(Axe, "Axe-" ..player.UserId)
		CS:AddTag(motor6d, "Axe-" .. player.UserId)		 
	end
	
end

unequippedE.OnServerInvoke = function(player)
	-- on unequipping weapon, destroy all parts of the weapon attached to the player
	for i, tagged in pairs(CS:GetTagged("Axe-"..player.UserId)) do
		
		
	end
end

local death = require(game.ServerScriptService.DeathDetection.Deadd)
local detecta = require(game.ServerScriptService.Spawnn.SpawnProtection)

activatedE.OnServerInvoke = function(player)
	local debounce = {}
	-- m1 creates a blade thing that is attached to edge of axe and does damage when it hits someone
	local blade1 = game.ReplicatedStorage.AxeFolder.Outer:Clone()
	blade1.Parent = player.Character.Axe
	blade1.CFrame = player.Character.Axe.Outer.CFrame
	local Weld = Instance.new("WeldConstraint")
	Weld.Parent = blade1
	Weld.Part0 = blade1
	Weld.Part1 = player.Character.Axe.Outer
	local function onTouch(hit)
		local humanoid = hit.Parent:FindFirstChild("Humanoid")
		if humanoid then
			
			if debounce[hit.Parent] == true then return end
			if death[tostring(player.Name)] == true then return end
			if tostring(hit) == "DashDetectionBox" then return end
			if detecta[tostring(hit.Parent)] == true then return end
			if hit.Parent == player.Character then return end
			if hit.Parent:FindFirstChild("Noharm") then return end
			
			local finder = hit.Parent:FindFirstChild("Ident")
			if finder == nil then
			local eneteam = game.Players:FindFirstChild(tostring(hit.Parent)).Team
			if eneteam == player.Team and player.Team ~= nil then return end
				end
				
			
			debounce[hit.Parent] = true
			HealthManager.TakeDamage(hit.Parent.Humanoid, 50, player)
			--hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health - 50
			local regstier = require(game.ReplicatedStorage["Boos Register"])
			regstier[(player.Name)] = tostring(hit.Parent)
			
			checking:FireAllClients(hit.Parent,player)
			hit.Parent.Humanoid.WalkSpeed = 15
			task.wait(1.5)
			hit.Parent.Humanoid.WalkSpeed = 35
			
		end
		task.wait(1)
		blade1:Destroy()
		
	end
	
	blade1.Touched:Connect(onTouch)
	
	
end

local darius = game.ReplicatedStorage.AxeFolder.Shig
local grab = game.ReplicatedStorage.AxeFolder.bab

-- player does a kind of lunge with the axe and the pointy part at the end does damage
grab.OnServerEvent:Connect(function(player,timee)
	local spike = game.ReplicatedStorage.AxeFolder.Spiky:Clone()
	spike.Parent = player.Character.Axe
	spike.CFrame = player.Character.Axe.Spike.CFrame
	local Weld = Instance.new("WeldConstraint")
	Weld.Parent = spike
	Weld.Part0 = spike
	Weld.Part1 = player.Character.Axe.Spike
	local debounce = {}
	
	spike.Touched:Connect(function(hit)
		if tostring(hit) == "DashDetectionBox" then return end
		local humanoidRootPart = hit.Parent:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart then
			if hit.Parent:FindFirstChild("Noharm") then return end
			if debounce[hit.Parent] == true then return end
			if detecta[tostring(hit.Parent)] == true then return end
			local finder = hit.Parent:FindFirstChild("Ident")
			if finder == nil then
				local eneteam = game.Players:FindFirstChild(tostring(hit.Parent)).Team
				if eneteam == player.Team and player.Team ~= nil then return end
			end
			debounce[hit.Parent] = true
			HealthManager.TakeDamage(hit.Parent.Humanoid, 30, player)
			--hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health - 30
			local regstier = require(game.ReplicatedStorage["Boos Register"])
			regstier[(player.Name)] = tostring(hit.Parent)
			task.wait(3)
			debounce[hit.Parent] = false
		end
	end)
	task.wait(timee)	
	spike:Destroy()
end)


local bodyParts = {
	Head = true, Torso = true, UpperTorso = true, LowerTorso = true,
	LeftArm = true, RightArm = true, LeftLeg = true, RightLeg = true,
	LeftUpperArm = true, LeftLowerArm = true, LeftHand = true,
	RightUpperArm = true, RightLowerArm = true, RightHand = true,
	LeftUpperLeg = true, LeftLowerLeg = true, LeftFoot = true,
	RightUpperLeg = true, RightLowerLeg = true, RightFoot = true,
	HumanoidRootPart = true
}

darius.OnServerEvent:Connect(function(player)     	---Axe grab move
	-- weld glue (red outline around axe) to axe
	local glue = game.ReplicatedStorage.AxeFolder.Adhesive:Clone()
	glue.Parent = player.Character.Axe
	glue.CFrame = player.Character.Axe.Outer.CFrame
	local Weld = Instance.new("WeldConstraint")
	Weld.Parent = glue
	Weld.Part0 = glue
	Weld.Part1 = player.Character.Axe.Outer
	local debounce = false
	
	-- when target hits glue, target's left leg gets welded to glue through "gorilla" weld for 0.1 second
	glue.Touched:Connect(function(hit)
		if tostring(hit) == "DashDetectionBox" then return end
		local humanoidRootPart = hit.Parent:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart then
			if hit.Parent:FindFirstChild("Noharm") then return end
			if debounce == true then return end
			if detecta[tostring(hit.Parent)] == true then return end
			 if tostring(hit.Parent) == "Rig" then return end
			local finder = hit.Parent:FindFirstChild("Ident")
			if finder == nil then
				local eneteam = game.Players:FindFirstChild(tostring(hit.Parent)).Team
				if eneteam == player.Team and player.Team ~= nil then return end
			end
			debounce = true
			for _, part in pairs(hit.Parent:GetDescendants()) do
				if part:IsA("BasePart") then	
					part.Massless = true
				end
			end
			humanoidRootPart.CFrame = glue.Sphere1.CFrame * CFrame.Angles(math.rad(270),math.rad(0),math.rad(270))
			local gorilla = Instance.new("WeldConstraint")
			gorilla.Parent = glue
			gorilla.Part0 = glue
			gorilla.Part1 = hit.Parent:WaitForChild("Left Leg")
			Hit:FireAllClients(hit.Parent,2)
			task.wait(0.1)
			Weld:Destroy()
			gorilla:Destroy()
			glue:Destroy()
			hit.Parent.Humanoid.WalkSpeed = 15
			task.wait(1.5)
			for _, part in pairs(hit.Parent:GetDescendants()) do
				if part:IsA("BasePart") and bodyParts[part.Name] then
	
					part.Massless = false
				end
			end
			hit.Parent.Humanoid.WalkSpeed = 35
		end
	end)
	task.wait(0.56)
	Weld:Destroy()
	glue:Destroy()
end)

Yessir.OnServerEvent:Connect(function(player)
	local glue = game.ReplicatedStorage.AxeFolder.Glue:Clone()
	glue.Parent = player.Character.B
	glue.CFrame = player.Character.B.Union.CFrame * CFrame.Angles(0,math.rad(0),math.rad(180))
	local Weld = Instance.new("WeldConstraint")
	Weld.Parent = glue
	Weld.Part0 = glue
	Weld.Part1 = player.Character.B.Union1
	local debounce = false
	glue.Touched:Connect(function(hit)
		if tostring(hit) == "DashDetectionBox" then return end
	  local humanoidRootPart = hit.Parent:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart then
			if hit.Parent:FindFirstChild("Noharm") then return end
		  if debounce == true then return end
			if detecta[tostring(hit.Parent)] == true then return end
			if tostring(hit.Parent) == "Rig" then return end
			local finder = hit.Parent:FindFirstChild("Ident")
			if finder == nil then
				local eneteam = game.Players:FindFirstChild(tostring(hit.Parent)).Team
				if eneteam == player.Team and player.Team ~= nil then return end
			end
			debounce = true
			for _, part in pairs(hit.Parent:GetDescendants()) do
				if part:IsA("BasePart") then
					part.Massless = true
				end
			end
		    humanoidRootPart.CFrame = glue.Parent.Sphere1.CFrame * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
			local gorilla = Instance.new("WeldConstraint")
			gorilla.Parent = glue
			gorilla.Part0 = glue
			gorilla.Part1 = hit.Parent:WaitForChild("Left Leg")
			task.wait(0.28)
			
			local bosition = hit.Parent.HumanoidRootPart.CFrame
			
			gorilla:Destroy()
			glue:Destroy()
			hit.Parent.HumanoidRootPart.CFrame = bosition
			local axepos = player.Character.B.Part.CFrame
			trigger:FireClient(player,hit.Parent,axepos)
			local ident = hit.Parent:FindFirstChild("Ident")
			if ident == "nill" then
				trigger:FireClient(hit.Parent,hit.Parent,axepos)
			end
			hit.Parent.HumanoidRootPart.Anchored = true
			detecta[hit.Parent] = true
			detecta[tostring(player.Character)] = true
			player.Character.Archivable = true
			local clone = player.Character:Clone()
			clone.Parent = workspace
			clone.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
			local hoop = clone.Humanoid.Animator:LoadAnimation(script:WaitForChild("Hoop"))
			
			for _, part in pairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.Transparency = 1
				end
			end
			debounce = false
			local still = clone.Humanoid.Animator:LoadAnimation(script:WaitForChild("Still"))
			still:Play()
			local stun = hit.Parent.Humanoid.Animator:LoadAnimation(script:WaitForChild("Stun"))
			local wake = hit.Parent.Humanoid.Animator:LoadAnimation(script:WaitForChild("Recover"))
			stun:Play()
			local lebon = game.Workspace.Lebon:Clone()
			lebon.Parent = hit.Parent
			lebon.SurfaceGui.ImageLabel.ImageTransparency = 0
			lebon.CFrame = hit.Parent.HumanoidRootPart.CFrame 
			lebon.CFrame = CFrame.new(lebon.Position + (lebon.CFrame.RightVector * -20))
			lebon.CFrame = CFrame.new(lebon.Position + (lebon.CFrame.ZVector * -15))
			lebon.CFrame = CFrame.new(lebon.Position + (lebon.CFrame.UpVector * 20))
			lebon.CFrame = CFrame.new(lebon.Position) * CFrame.Angles(math.rad(0),math.rad(hit.Parent.HumanoidRootPart.Orientation.Y-90),math.rad(0))
			lebon.Anchored = true
			task.wait(2)
			
			hoop:Play()
			wake:Play()
			task.wait(wake.length)
			stun:Stop()
			task.wait(hoop.length-wake.length)
			still:Stop()
			HealthManager.TakeDamage(hit.Parent.Humanoid, 100, player)
			--hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health-100
			checking:FireAllClients(hit.Parent,player)
			task.wait(0.2)
			lebon:Destroy()
			clone:Destroy()
			
			detecta[hit.Parent] = false
			detecta[tostring(player.Character)] = false
			hit.Parent.HumanoidRootPart.Anchored = false
			for _, part in pairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.Transparency = 0
					player.Character.HumanoidRootPart.Transparency = 1
				end
			end
		
			
		end
	end)
	task.wait(0.2)
	if glue then
		glue:Destroy()
	end
end)


local Aura = game.ReplicatedStorage.AxeFolder.Aura

Aura.OnServerEvent:Connect(function(player)
	local parti = game.ReplicatedStorage.AxeFolder.ParticleEmitter:Clone()
	parti.Parent = player.Character
	parti.CFrame = player.Character.HumanoidRootPart.CFrame
	local beld = Instance.new("WeldConstraint")
	beld.Parent = player.Character
	beld.Part0 = player.Character.Torso
	beld.Part1 = parti
	
	task.wait(1)
	parti:Destroy()
end)

local VFX = game.ReplicatedStorage.Events.Weapons.Axe.VFX

-- the cool skill where glowing red axe is summoned from the air and slams the ground i think?
VFX.OnServerEvent:Connect(function(player,this)
	local debounce = {}
	local blade1 = game.ReplicatedStorage.AxeFolder.Outer:Clone()
	blade1.Parent = player.Character.Axe
	blade1.CFrame = player.Character.Axe.Outer.CFrame
	local Weld = Instance.new("WeldConstraint")
	Weld.Parent = blade1
	Weld.Part0 = blade1
	Weld.Part1 = player.Character.Axe.Outer
	local detecta = require(game.ServerScriptService.Spawnn.SpawnProtection)
	local function onTouch(hit)
		if tostring(hit) == "DashDetectionBox" then return end
		local humanoid = hit.Parent:FindFirstChild("Humanoid")
		if humanoid then
			if hit.Parent:FindFirstChild("Noharm") then return end
			if debounce[hit.Parent] == true then return end
			if death[tostring(player.Name)] == true then return end
			if detecta[tostring(hit.Parent)] == true then return end
			local finder = hit.Parent:FindFirstChild("Ident")
			if finder == nil then
				local eneteam = game.Players:FindFirstChild(tostring(hit.Parent)).Team
				if eneteam == player.Team and player.Team ~= nil then return end
			end
			debounce[hit.Parent] = true
			HealthManager.TakeDamage(hit.Parent.Humanoid, 30, player)
			--hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health - 30
			local regstier = require(game.ReplicatedStorage["Boos Register"])
			regstier[(player.Name)] = tostring(hit.Parent)
			checking:FireAllClients(hit.Parent,player)
			hit.Parent.Humanoid.WalkSpeed = 15
			task.wait(1.5)
			hit.Parent.Humanoid.WalkSpeed = 35
		end
		task.wait(1)
		blade1:Destroy()

	end

	blade1.Touched:Connect(onTouch)

	
	local Vx = game.ReplicatedStorage.AxeFolder["Axe VFX"]:Clone()
	Vx.Parent = player.Character
	Vx["Meshes/Axe VFX_Cylinder"].CFrame = player.Character.Torso.CFrame
	local motor6d = Instance.new("Motor6D")
	motor6d.Parent = player.Character.HumanoidRootPart
	motor6d.Part0 = player.Character.HumanoidRootPart
	motor6d.Part1 = Vx["Meshes/Axe VFX_Cylinder"]
	task.wait(0.6)
	local Smoke = game.ReplicatedStorage.AxeFolder["Smoke VFx"]:Clone()
	Smoke.Parent = player.Character
	Smoke.part1.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(player.Character.HumanoidRootPart.CFrame.LookVector)
	Smoke.part1.CFrame = Smoke.part1.CFrame * CFrame.new(0,0,-30)
	Smoke.part1.CFrame = Smoke.part1.CFrame * CFrame.Angles(math.rad(0),math.rad(90),0)
	local deobunce = {}
	local Iframe =  require(game.ServerScriptService.Spawnn.Iframe)
	Smoke.part1.Touched:Connect(function(hit)
		
		if tostring(hit.Parent) == tostring(player.Character) then return end
		if deobunce[hit.Parent] == true then return end
		if detecta[tostring(hit.Parent)] == true then return end
		if Iframe[tostring(hit.Parent)] == true then return end
		if tostring(hit) == "DashDetectionBox" then return end
		if hit.Parent:FindFirstChild("Noharm") then return end
		local humanoidRootPart = hit.Parent:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart then
			local finder = hit.Parent:FindFirstChild("Ident")
			if finder == nil then
				local eneteam = game.Players:FindFirstChild(tostring(hit.Parent)).Team
				if eneteam == player.Team and player.Team ~= nil then return end
			end	
			deobunce[hit.Parent] = true
			HealthManager.TakeDamage(hit.Parent.Humanoid, 30, player)
			--hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health - 30
			local regstier = require(game.ReplicatedStorage["Boos Register"])
			regstier[(player.Name)] = tostring(hit.Parent)
			checking:FireAllClients(hit.Parent,player)
			task.wait(3)
			deobunce[hit.Parent] = false

		end
	end)
	task.wait(this-0.1)
	Vx:Destroy()
	Smoke:Destroy()
	
end)