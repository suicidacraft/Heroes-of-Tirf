


local npc = script.Parent -- Assuming the script is a child of the NPC's model
local targetPosition = Vector3.new(100, 0, 100) -- Replace with your desired target position

local humanoid = npc:FindFirstChild("Humanoid")

local Iframe =  require(game.ServerScriptService.Spawnn.Iframe)

local Hit = game.ReplicatedStorage.Events.Weapons.Katana.Hit

local blinder = game.ReplicatedStorage.Boss.Bindable

local punch = npc.Humanoid:LoadAnimation(script.Punch)
local Charge = npc.Humanoid:LoadAnimation(script["Charge up"])
local jump = npc.Humanoid:LoadAnimation(script.Jump)
local jumping = npc.Humanoid:LoadAnimation(script.Jumping)
local fall = npc.Humanoid:LoadAnimation(script.Falling)
local flip = npc.Humanoid:LoadAnimation(script.Flip)
local shoot = npc.Humanoid:LoadAnimation(script.Shoot)
local hand = npc.Humanoid:LoadAnimation(script["The hand"])
local barrage = npc.Humanoid:LoadAnimation(script.Barrage)
local dash = npc.Humanoid:LoadAnimation(script.dash)
local destroyer = npc.Humanoid:LoadAnimation(script.Destroyer)
local gui = game.ReplicatedStorage.Boss.Gui

local dashDistance = 25 -- Distance of the dash
local dashCooldown = 0 -- Cooldown time between dashes
local canDash = true

local debounce = {}

local ligma = false

local name = ""
local box = script.Box
local PFX = game.ReplicatedStorage.Boss["Punch VFX"]

local count = 0

local cool = false

local nay = false
local chipsahoy = false
local relevant = false
local regen =  require(game.ServerScriptService.Spawnn.Regen)
local originalPos = npc.Script.Box.Position

local pcount = 0

local target = ""


local blease = ""
local targetdead = false

blinder.Event:Connect(function(naime)
	target = naime
	blease = naime
	target = game.Workspace:FindFirstChild(target)
end)

function thiss(hi)
	task.wait(0.001)
	local player = game.Players:FindFirstChild(blease)
	game.Players:FindFirstChild(tostring(target)).PlayerGui.Health.Enabled = true	
	game.Players:FindFirstChild(tostring(target)).PlayerGui.Health.Frame.Frame.LocalScript.Enabled = true
	gui:FireClient(player , player)
	if targetdead == true then return end
	targetdead = true

			
			

			script.Parent.Regen.Enabled = false	
          
			while target.Humanoid.Health > 0 do 
               
				task.wait(0.5)

				npc["Body Colors"].HeadColor3 = Color3.new(99,95,98)
				npc["Body Colors"].RightArmColor3 = Color3.new(25,0,0)
				npc["Body Colors"].LeftArmColor3 = Color3.new(0,95,98)

				local playerPosition = target.HumanoidRootPart.Position
				local npcPosition = npc.HumanoidRootPart.Position
				local lookAtCFrame = CFrame.lookAt(npcPosition, playerPosition)
				npc.HumanoidRootPart.CFrame = lookAtCFrame 	

				local poopoo = math.random(1,3)
				local range = math.random(1,2)

				if (target.HumanoidRootPart.Position - npc.HumanoidRootPart.Position).magnitude > 130 then

				end
		
			  
		
				if range == 1 then
					if poopoo == 1 then 
						punchattack()
					end
					if poopoo == 2 then
						Wizr()
				        punchattack(target)
						axeHand()
					end
					if poopoo == 3 then
						Wizr()
						punchattack()
					end
				end

			if range == 2 then
			
					if poopoo == 1 then
						axeHand()
						stabbytime()
					end

					if poopoo == 2 then
						BigStab()
					stabbytime()
					end
					if poopoo == 3 then
						BigStab()
					end


				end
				task.wait(1)	
			end
			    script.Parent.Regen.Enabled = true	
	npc.Humanoid:MoveTo((originalPos))
	targetdead = false
			end
	
	


local Humanoid = npc.Humanoid
Humanoid:GetPropertyChangedSignal("Health"):Connect(thiss)


	
	
function BigStab(hit)
	npc.Humanoid.WalkSpeed = 75
	npc.Humanoid:MoveTo(originalPos)
	task.wait(0.3)
	dash:Play()
	npc.Sword.Handle.Transparency = 0
	npc.Sword.Blade.Transparency = 0
	npc.Sword["Meshes/Handle_Cylinder.001"].Transparency = 0
	npc.Sword.Hilt.Transparency = 0
	ligma = false
	box.Touched:Connect(function(hit)
		if tostring(hit.Parent) == "Bullet" then return end
		if tostring(hit.Parent) == "Rig" then return end
		if hit.Parent:FindFirstChild("Noharm") then return end
		if hit.Parent == nil then return end
		
		local root = hit.Parent:FindFirstChild("HumanoidRootPart")
		if root then
		if cool == true then return end
		cool = true
		ligma = true
			task.wait(1)
			cool = false
		end
	end)
	
	while ligma == false do
		npc.Humanoid.WalkSpeed = 75
		npc.Humanoid:MoveTo(target.HumanoidRootPart.Position)
		task.wait(0.1)
	end
	
	npc.Humanoid.WalkSpeed = 10
	dash:Stop()
	destroyer:Play()
	coroutine.wrap(Airwave)()
	task.wait(0.6)
	local playerPosition = target.HumanoidRootPart.Position
	local npcPosition = npc.HumanoidRootPart.Position
	local lookAtCFrame = CFrame.lookAt(npcPosition, playerPosition)
	npc.HumanoidRootPart.CFrame = lookAtCFrame
	

end

function Airwave(player)
	local char = npc
	local root = char.HumanoidRootPart
	local sword = npc.Sword
	local VFX = game.ReplicatedStorage.StickFolder.VFX:Clone()
	task.wait(0.69999)
	VFX.Parent = char.HumanoidRootPart
	VFX.Booti.CFrame = root.CFrame * CFrame.Angles(math.rad(180),0,0) * CFrame.new(0,0,30)
	VFX.Booti.Anchored = true
	local deb = {}
	for _, descendant in ipairs(VFX:GetDescendants()) do
		if descendant:IsA("Part") then
			descendant.Touched:Connect(function(hit)
				local humanoidRootPart = hit.Parent:FindFirstChild("HumanoidRootPart")
				if hit.Parent == npc then return end
				if hit.Parent:FindFirstChild("Noharm") then return end
				if humanoidRootPart then
					if deb[hit.Parent] == true then return end
					deb[hit.Parent] = true
					hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health - 30
					task.wait(1)
					deb[hit.Parent] = false
				end
			end)
		end
	end
	task.wait(0.6)
	npc.Sword.Handle.Transparency = 1
	npc.Sword.Blade.Transparency = 1
	npc.Sword["Meshes/Handle_Cylinder.001"].Transparency = 1
	npc.Sword.Hilt.Transparency = 1
	VFX:Destroy()
end


function stabbytime(hit)
	npc.Humanoid.WalkSpeed = 75
	npc.Humanoid:MoveTo(originalPos)
	task.wait(0.3)
	npc.Sword.Handle.Transparency = 0
	npc.Sword.Blade.Transparency = 0
	npc.Sword["Meshes/Handle_Cylinder.001"].Transparency = 0
	npc.Sword.Hilt.Transparency = 0
	dash:Play()
	ligma = false
	box.Touched:Connect(function(hit)
		if tostring(hit.Parent) == "Bullet" then return end
		if tostring(hit.Parent) == "Rig" then return end
		if hit.Parent == nil then return end
		if hit.Parent:FindFirstChild("Noharm") then return end
		local root = hit.Parent:FindFirstChild("HumanoidRootPart")
		if root then
			if cool == true then return end
			cool = true
			ligma = true
			task.wait(1)
			cool = false
		end
	end)
	
	
	while ligma == false do
		npc.Humanoid.WalkSpeed = 75
		npc.Humanoid:MoveTo(target.HumanoidRootPart.Position)
		task.wait(0.1)
	end
	npc.Humanoid.WalkSpeed = 10
	local i = 0
	dash:Stop()
	local playerPosition = target.HumanoidRootPart.Position
	local npcPosition = npc.HumanoidRootPart.Position
	local lookAtCFrame = CFrame.lookAt(npcPosition, playerPosition)
	npc.HumanoidRootPart.CFrame = lookAtCFrame 
    task.wait(0.2)
	while i < 5 do
		barrage:Play()
		local playerPosition = target.HumanoidRootPart.Position
		local npcPosition = npc.HumanoidRootPart.Position
		local lookAtCFrame = CFrame.lookAt(npcPosition, playerPosition)
		npc.HumanoidRootPart.CFrame = lookAtCFrame 
		npc.Humanoid.WalkSpeed = 25
		npc.Humanoid:MoveTo(target.HumanoidRootPart.Position)
		coroutine.wrap(cinconuts)(npc)
		i = i + 1
		task.wait(barrage.Length)
	end
	npc.Humanoid.WalkSpeed = 10
	npc.Sword.Handle.Transparency = 1
	npc.Sword.Blade.Transparency = 1
	npc.Sword["Meshes/Handle_Cylinder.001"].Transparency = 1
	npc.Sword.Hilt.Transparency = 1
end



function cinconuts(player)
	local deb = {}
	local char = npc
	local root = char.HumanoidRootPart
	local sword = npc.Sword
	local VFX = game.ReplicatedStorage.StickFolder.bETTI:Clone()
	task.wait(0.1)
	VFX.Parent = char
	VFX.CFrame = sword.Handle.CFrame * CFrame.Angles(math.rad(270),0,0) * CFrame.new(0,0,5)
	VFX.Anchored = true
	VFX.Touched:Connect(function(hit)
		local humanoidRootPart = hit.Parent:FindFirstChild("HumanoidRootPart")
		if hit.Parent == npc then return end
		if hit.Parent:FindFirstChild("Noharm") then return end
		if humanoidRootPart then
			if deb[hit.Parent] == true then return end
			deb[hit.Parent] = true
			hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health - 5
			Hit:FireAllClients(hit.Parent,0.4)
			hit.Parent.HumanoidRootPart.Anchored = true
			task.wait(0.4)
			hit.Parent.HumanoidRootPart.Anchored = false
			task.wait(1)
			deb[hit.Parent] = false
		end
	end)
	task.wait(0.2)
	VFX:Destroy()
end


function axeHand(hit)
	local smoke = npc.Script["Smoke VFX"]
	local axe = npc["Axe VFX"]
	axe.AXHandle.Transparency = 0
	axe.Blade.Transparency = 0
	axe.Back.Transparency = 0
	smoke.Anchored = false
	local motor6d = Instance.new("Motor6D")
	motor6d.Parent = npc.HumanoidRootPart
	motor6d.Part0 = npc.HumanoidRootPart
	motor6d.Part1 = smoke
	relevant = true
	
	axe.Blade.Touched:Connect(function(hit)
		if relevant == false then return end	
		if tostring(hit) == "Ground" then
			relevant = false
			motor6d:Destroy()
			smoke.Anchored = true
			smoke.Transparency = 0
			smoke.Growth.Enabled = true
			smoke.Damage.Enabled = true
		end
	end)

	hand:Play()
	task.wait(0.8)

	axe.AXHandle.Transparency = 01
	axe.Blade.Transparency = 01
	axe.Back.Transparency = 01
	
end


function Wizr(hit)
	local circle = npc.Circle
	circle.Magic.Transparency = 0
	circle.Magic2.Transparency = 0



	circle.light.Pro.Enabled = true
	local j = 0
	while j < 200 do 
		
		j = j+1
		shoot:Play()
		local playerPosition = target.HumanoidRootPart.Position
		local npcPosition = npc.HumanoidRootPart.Position
		local lookAtCFrame = CFrame.lookAt(npcPosition, playerPosition)
		npc.HumanoidRootPart.CFrame = lookAtCFrame 	
		task.wait(0.0001)
	end
	shoot:Stop()
	circle.Magic.Transparency = 01
	circle.Magic2.Transparency = 01



	circle.light.Pro.Enabled = false

end


function gapclose(hit)
	local already = false
	npc.Humanoid.StateChanged:Connect(function(oldState, newState)
		if oldState == Enum.HumanoidStateType.Landed then
			if already == true then return end
			already = true
			local land = game.ReplicatedStorage.Boss.Land:Clone()
			land.Parent = npc.HumanoidRootPart
			land.CFrame = npc["Left Leg"].CFrame * CFrame.new(0,1,0)
			land.Anchored = true
			local landbounce = {}
			land.Touched:Connect(function(hit)
				if hit.Parent:FindFirstChild("HumanoidRootPart") then
					if tostring(hit.Parent) == "Rig" then return end
					if hit.Parent:FindFirstChild("Noharm") then return end
					if landbounce[hit.Parent] == true then return end
					if Iframe[tostring(hit.Parent)] == true then return end
					landbounce[hit.Parent] = true
					hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health-10

				end
			end)
			task.wait(0.25)
			fall:Stop()
			land.Anchored = false
			land:Destroy()
		end
	end)
	jump:Play()
	local playerPosition = hit.Parent.HumanoidRootPart.Position
	local npcPosition = npc.HumanoidRootPart.Position
	local lookAtCFrame = CFrame.lookAt(npcPosition, playerPosition)
	npc.HumanoidRootPart.CFrame = lookAtCFrame	
	task.wait(jump.Length)

	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000) 

	bodyVelocity.Velocity = Vector3.new(0, 3000, 0)
	bodyVelocity.Parent = npc.HumanoidRootPart
	jumping:Play()
	local past = npc.HumanoidRootPart.CFrame
	task.wait(0.2)
	local JFX = game.ReplicatedStorage.Boss["Jump VFx"]:Clone()
	JFX.Parent = npc.HumanoidRootPart
	JFX.part1.CFrame = past
	task.wait(0.1)
	JFX.part1.Anchored = true
	task.wait(0.2)
	JFX.part1.Anchored = true
	JFX:Destroy()
	jumping:Stop()
	fall:Play()
	local endTime = tick() + 1
	npc.HumanoidRootPart.CFrame = hit.Parent.HumanoidRootPart.CFrame * CFrame.new(0,30,0)
	while tick() < endTime do					
		local direction = (hit.Parent.HumanoidRootPart.Position - npc.HumanoidRootPart.Position).Unit
		bodyVelocity.Velocity = direction * 1000 + Vector3.new(0, 100, 0)
		task.wait(0.001)  
	end
	bodyVelocity.Velocity = Vector3.new(0,-10000,0)
	task.wait(0.5)
	bodyVelocity:Destroy()
end



function icemelo(hit)
	dash:Play()
	
	local playerPosition = hit.Parent.HumanoidRootPart.Position
	local npcPosition = npc.HumanoidRootPart.Position
	local lookAtCFrame = CFrame.lookAt(npcPosition, playerPosition)
	npc.HumanoidRootPart.CFrame = lookAtCFrame 	
	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000) 

	task.wait(0.01) 
	bodyVelocity.Parent = npc.HumanoidRootPart
	local icemelody = game.ReplicatedStorage.Boss.Icemelody:Clone()
	icemelody.Parent = npc.Script
	icemelody.CFrame = npc.HumanoidRootPart.CFrame
	local Weld2 = Instance.new("WeldConstraint")
	Weld2.Parent = icemelody
	Weld2.Part0 = icemelody
	Weld2.Part1 = npc.HumanoidRootPart
	
	icemelody.Touched:Connect(function(ice)
		if ice.Parent == nil then return end
		local poot = ice.Parent:FindFirstChild("HumanoidRootPart")
		if poot then
			nay = true
			bodyVelocity.Velocity = Vector3.new(0,0,0)
			bodyVelocity:Destroy()
			icemelody:Destroy()
		end
	end)

	while nay == false do
		bodyVelocity.Velocity = (hit.Parent.HumanoidRootPart.Position - npc.HumanoidRootPart.Position) * 8
		local playerPosition = hit.Parent.HumanoidRootPart.Position
		local npcPosition = npc.HumanoidRootPart.Position
		local lookAtCFrame = CFrame.lookAt(npcPosition, playerPosition)
		npc.HumanoidRootPart.CFrame = lookAtCFrame 	
		task.wait(0.001)	
	end
	
	nay = false
	bodyVelocity:Destroy()
	dash:Stop()
	flip:Play()
	
	local groundY = 1  -- Replace this with the actual Y position of the ground
	local pass = npc["Left Leg"].CFrame
	local newCFrame = CFrame.new(pass.Position.X, groundY, pass.Position.Z)
	npc["Left Leg"].CFrame = newCFrame
	local wasd = false
	local be = false
	local icebounce = {}
	npc["Left Arm"].Touched:Connect(function(bad)
		if wasd == true then return end
		  if tostring(bad) == "Ground" then
		local icee = game.ReplicatedStorage.Boss.Ice:Clone()
		icee.Parent = npc.HumanoidRootPart
		icee.CFrame = npc["Left Leg"].CFrame * CFrame.new(0,5,0)
		icee.CFrame = CFrame.new(icee.Position) * CFrame.Angles(0,0,math.rad(90))
		icee.Anchored = true
		icee.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("HumanoidRootPart") then
				if tostring(hit.Parent) == "Rig" then return end
					if hit.Parent:FindFirstChild("Noharm") then return end
					if icebounce[hit.Parent] == true then return end
					if Iframe[tostring(hit.Parent)] == true then return end
					icebounce[hit.Parent] = true
					hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health-20
					end
				end)
		task.wait(0.25)
		icee:Destroy()
		end
	end)
	local bodyVelocity = Instance.new("BodyVelocity")	
	bodyVelocity.MaxForce = Vector3.new(4000,4000,4000)
	bodyVelocity.Parent = npc.HumanoidRootPart
	bodyVelocity.Velocity = (hit.Parent.HumanoidRootPart.Position - npc.HumanoidRootPart.Position) * 3
	task.wait(flip.Length)		
	bodyVelocity:Destroy()
	wasd = true
end



function jumpattack(hit)
	local already = false
	npc.Humanoid.StateChanged:Connect(function(oldState, newState)
		if oldState == Enum.HumanoidStateType.Landed then
			if already == true then return end
			already = true
			local land = game.ReplicatedStorage.Boss.Land:Clone()
			land.Parent = npc.HumanoidRootPart
			land.CFrame = npc["Left Leg"].CFrame * CFrame.new(0,1,0)
			land.Anchored = true
			local landbounce = {}
			land.Touched:Connect(function(hit)
				if hit.Parent:FindFirstChild("HumanoidRootPart") then
					if tostring(hit.Parent) == "Rig" then return end
					if hit.Parent:FindFirstChild("Noharm") then return end
					if landbounce[hit.Parent] == true then return end
					if Iframe[tostring(hit.Parent)] == true then return end
					landbounce[hit.Parent] = true
					hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health-20
					
				end
			end)
			task.wait(0.25)
			fall:Stop()
			land.Anchored = false
			land:Destroy()
		end
	end)
	jump:Play()
	local playerPosition = hit.Parent.HumanoidRootPart.Position
	local npcPosition = npc.HumanoidRootPart.Position
	local lookAtCFrame = CFrame.lookAt(npcPosition, playerPosition)
	npc.HumanoidRootPart.CFrame = lookAtCFrame	
	task.wait(jump.Length)
	
	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000) 

	bodyVelocity.Velocity = Vector3.new(0, 4000, 0)
	bodyVelocity.Parent = npc.HumanoidRootPart
	jumping:Play()
	local past = npc.HumanoidRootPart.CFrame
	task.wait(0.2)
	local JFX = game.ReplicatedStorage.Boss["Jump VFx"]:Clone()
	JFX.Parent = npc.HumanoidRootPart
	JFX.part1.CFrame = past
	task.wait(0.1)
	JFX.part1.Anchored = true
	task.wait(0.2)
	JFX.part1.Anchored = true
	JFX:Destroy()
	jumping:Stop()
	fall:Play()
	local endTime = tick() + 1		
	while tick() < endTime do					
	local direction = (hit.Parent.HumanoidRootPart.Position - npc.HumanoidRootPart.Position).Unit
	bodyVelocity.Velocity = direction * 1000 + Vector3.new(0, 100, 0)
	task.wait(0.001)  
	end
	bodyVelocity.Velocity = Vector3.new(0,-10000,0)
	task.wait(0.5)
	bodyVelocity:Destroy()

	
  end	



function punchattack()
	
	local playerPosition = target.HumanoidRootPart.Position
	local npcPosition = npc.HumanoidRootPart.Position
	local lookAtCFrame = CFrame.lookAt(npcPosition, playerPosition)
	npc.HumanoidRootPart.CFrame = lookAtCFrame 

	dash:Stop()
	Charge:Play()
	task.wait(Charge.Length)
	punch:Play()
	task.wait(punch.Length)
	local playerPosition = target.HumanoidRootPart.Position
	local npcPosition = npc.HumanoidRootPart.Position
	local lookAtCFrame = CFrame.lookAt(npcPosition, playerPosition)
	
	npc.HumanoidRootPart.CFrame = lookAtCFrame 
	local PFX = game.ReplicatedStorage.Boss["Punch VFX"]:Clone()
	PFX.Parent = npc
	PFX.part1.CFrame = lookAtCFrame 
	PFX.part1.Transparency = 0
	PFX.part2.Transparency = 0
	PFX.part3.Transparency =0
	PFX.part4.Transparency = 0
	PFX.part5.Transparency = 0
	PFX.part1.CFrame = lookAtCFrame
	local punchbox = {}
	PFX.Hitbox.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("HumanoidRootPart") then
			if tostring(hit.Parent) == "Rig" then return end
			if hit.Parent:FindFirstChild("Noharm") then return end
			if punchbox[hit.Parent] == true then return end
			if Iframe[tostring(hit.Parent)] == true then return end
			punchbox[hit.Parent] = true
			hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health-35
		end
	end)
	local hass = npc.HumanoidRootPart.CFrame.LookVector 
	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.Velocity = hass * 100
	bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bodyVelocity.Parent = PFX.part1

	local bodyForce = Instance.new("BodyForce", PFX.part1)
	bodyForce.Force = Vector3.new(0, PFX.part1:GetMass() * workspace.Gravity, 0)
	local bodyForce = Instance.new("BodyForce", PFX.part2)
	bodyForce.Force = Vector3.new(0, PFX.part2:GetMass() * workspace.Gravity, 0)
	local bodyForce = Instance.new("BodyForce", PFX.part3)
	bodyForce.Force = Vector3.new(0, PFX.part3:GetMass() * workspace.Gravity, 0)
	local bodyForce = Instance.new("BodyForce", PFX.part4)
	bodyForce.Force = Vector3.new(0, PFX.part4:GetMass() * workspace.Gravity, 0)

	task.wait(0.25)
	PFX.part1.Transparency = 0.2
	PFX.part2.Transparency = 0.3
	PFX.part3.Transparency = 0.4
	PFX.part4.Transparency = 0.1
	PFX.part5.Transparency = 0.2
	task.wait(0.25)
	PFX.part1.Transparency = 0.7
	PFX.part2.Transparency = 0.6
	PFX.part3.Transparency = 0.8
	PFX.part4.Transparency = 0.9
	PFX.part5.Transparency = 0.9
	task.wait(0.5)
	PFX:Destroy()
end

