local Players = game:GetService("Workspace")
local RS = game:GetService("ReplicatedStorage")
local SP = game:GetService("StarterPlayer")
local CS = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")

local axeEvents = RS.Events.Weapons.Axe
local equippedE = axeEvents.Equipped
local unequippedE = axeEvents.Unequipped
local activatedE = axeEvents.Activated
local Yessir = axeEvents.Sag

local Player = game:GetService("Players").LocalPlayer
local Playername = Player.Name
local char = Players:WaitForChild(Playername)
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")
local theList = require(game:GetService("ReplicatedStorage").KatanaFolder.Tool.KatanaLocal.List)


local animF = script:WaitForChild("AxeAnimate")
local slash1 = hum.Animator:LoadAnimation(animF:WaitForChild("Slash1"))
local grab = hum.Animator:LoadAnimation(animF:WaitForChild("Grab"))
local pull = hum.Animator:LoadAnimation(animF:WaitForChild("Pull"))
local q1 = hum.Animator:LoadAnimation(animF:WaitForChild("Concept 1"))
local q2 = hum.Animator:LoadAnimation(animF:WaitForChild("Concept 2"))
local VFX = game.ReplicatedStorage.Events.Weapons.Axe.VFX

local function switchAnimate(oldAnimate, newAnimate)
	local frozen = true
	task.spawn(function()
		while frozen do
			task.wait()
			hum.WalkSpeed = 0
			hum.JumpPower = 0
			hum.JumpHeight = 0
		end
		hum.WalkSpeed = SP.CharacterWalkSpeed
		hum.JumpPower = SP.CharacterJumpPower
		hum.JumpHeight = SP.CharacterJumpHeight
	end)
	oldAnimate.Enabled = false
	wait()
	newAnimate.Enabled = true

	frozen = false
end

local tool = script.Parent
local defaultAnimate = char:WaitForChild("Animate")
local containingScript = tool:FindFirstChild("AxeLocal")
local innerScript = containingScript:FindFirstChild("AxeAnimate")

local LocalPlayer = game:GetService("Players").LocalPlayer
local Controls = require(LocalPlayer.PlayerScripts.PlayerModule):GetControls()


local Hit = game.ReplicatedStorage.Events.Weapons.Katana.Hit

Hit.OnClientEvent:Connect(function(player,tim)
	theList[tostring(player)] = true
	task.wait(tim)
	theList[tostring(player)] = false
end)

local equip = 1


tool.Equipped:Connect(function()
	if equip == 2 then return end
	equip = 2
	local call = game.ReplicatedStorage.SpawnProtection
	switchAnimate(defaultAnimate, script.AxeAnimate)
	require(game:GetService("ReplicatedStorage").Global.username).name = char
	equippedE:InvokeServer("Evolution")
	call:InvokeServer()

end)






local debounce = false
local abs = false
local sabs = false

tool.Unequipped:Connect(function()

	unequippedE:InvokeServer()

	sabs = false

end)

local movestack = false


local mobilee = Player.PlayerGui.Mobile

tool.Activated:Connect(function()
	if debounce == false then 
		if theList[tostring(Playername)] == true then return end
		if abs == true then return end
		if movestack == true then return end
		debounce = true
		movestack = true
		sabs = true
		slash1:Play()

		print("# AnimationTracks:", #hum.Animator:GetPlayingAnimationTracks())
		task.wait(0.45)
		hum.WalkSpeed = 50

		task.wait(1.9)
		sabs = false
		hum.WalkSpeed = 25
		movestack = false
		coroutine.wrap(function()
			countdown(mobilee.M1,2,"Left Click")
		end)()
		wait(2)
		hum.WalkSpeed = SP.CharacterWalkSpeed
		task.wait(.5)
		debounce = false
	end
end)


tool.Activated:Connect(function()
	if debounce == true then return end
	if theList[tostring(Playername)] == true then return end
	if abs == true then return end
	if movestack == true then return end
	activatedE:InvokeServer()
end)



local humanoidRootPart = char:FindFirstChild("HumanoidRootPart")


local dashcoold = false
function dash()
	if theList[tostring(Playername)] == true then return end
	if dashcoold == true then return end
	humanoidRootPart.Velocity = humanoidRootPart.CFrame.LookVector * 300
	if UserInputService:IsKeyDown(Enum.KeyCode.S) then
		humanoidRootPart.Velocity = humanoidRootPart.CFrame.LookVector * -300 
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.A) then
		humanoidRootPart.Velocity = humanoidRootPart.CFrame.RightVector * -300 
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.D) then
		humanoidRootPart.Velocity = humanoidRootPart.CFrame.RightVector * 300 
	end
	dashcoold = true
	task.wait(0.25)
	humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
	coroutine.wrap(function()
		countdown(mobilee.Qkey,2,"Q")
	end)()
	task.wait(2)

	dashcoold = false

end

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Q  then
		dash()
	end
end)



local humanoid = char:FindFirstChild("Humanoid")

humanoid.StateChanged:Connect(function(oldState, newState)
	if newState == Enum.HumanoidStateType.Jumping then
		jump = true
	end
end)

humanoid.StateChanged:Connect(function(oldState, newState)
	if oldState == Enum.HumanoidStateType.Landed then
		jump = false
	end
end)




local gebounce = false

local Aura = game.ReplicatedStorage.AxeFolder.Aura
local darius = game.ReplicatedStorage.AxeFolder.Shig
local spike = game.ReplicatedStorage.AxeFolder.bab

-- not sure how this is a smash (sorry) but player lunges forward with the axe, spiky part at the end does damage, then the axe grabs target and pulls them toward user
function smash()
	if theList[tostring(Playername)] == true then return end
	movestack = true
	gebounce = true
	grab:Play() 
	root.Anchored = true
	spike:FireServer(grab.length) -- spike does damage
	task.wait(grab.length)
	pull:Play()
	darius:FireServer() -- grab target, who gets pulled as pull animation is played
	task.wait(pull.length)
	movestack = false
	root.Anchored = false
	coroutine.wrap(function()
		countdown(mobilee.Ekey,2.5,"E")
	end)()
	task.wait(2.5)
	gebounce = false
end

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.E  then
		if theList[tostring(Playername)] == true then return end
		if jump == true then return end
		if gebounce == true then return end
		if movestack == true then return end
		smash()

	end
end)



local camera = game.Workspace.Camera
local camFolder = game.Workspace.Cameras
local haha = false

function zaAxo()
	if theList[tostring(Playername)] == true then return end
	haha = true
	movestack = true
	q1:Play()
	camera.CameraType = Enum.CameraType.Scriptable
	root.Anchored = true
	VFX:FireServer(q1.length)
	task.wait(q1.length)
	camera.CameraType = Enum.CameraType.Custom
	root.Anchored = false
	movestack = false
	coroutine.wrap(function()
		countdown(mobilee.Gkey,3,"G")
	end)()
	task.wait(3)
	haha = false
end


UserInputService.InputBegan:Connect(function(input)
	local awaken = (game.Players:FindFirstChild(Playername).Axe.Value)

	if input.KeyCode == Enum.KeyCode.G  then
		if movestack == true then return end
		if haha == true then return end
		zaAxo()


	end
end)


local Eevent = game.ReplicatedStorage.Mobile.E
local Gevent = game.ReplicatedStorage.Mobile.G
local Qevent = game.ReplicatedStorage.Mobile.Q
local M1event = game.ReplicatedStorage.Mobile.M1
mobilee.M1.Visible = true
mobilee.Enabled = true
mobilee.Ekey.Visible = true
mobilee.Gkey.Visible = true
mobilee.Qkey.Visible = true

Qevent.Event:Connect(function()

	dash()
end)
Eevent.Event:Connect(function()

	if theList[tostring(Playername)] == true then return end
	if jump == true then return end
	if gebounce == true then return end
	if movestack == true then return end
	smash()

end)

Gevent.Event:Connect(function()
	local awaken = (game.Players:FindFirstChild(Playername).Axe.Value)
	if tostring(awaken) == "Awakened" then

		if movestack == true then return end
		if haha == true then return end
		zaAxo()

	end
end)

function countdown(text,cdown,letter)
	local count = cdown/10
	while cdown > 0 do

		text.Text = math.round(cdown*10)/10
		task.wait(0.1)
		cdown = cdown - 0.1
		if cdown <= 0.1 then
			cdown = -1
		end
	end

	text.Text = letter

end
