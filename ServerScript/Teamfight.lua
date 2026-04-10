local CS = game:GetService("CollectionService")
local folder = workspace.TeamFightStarter
local buttonA = folder.ButtonA
local buttonB = folder.ButtonB
local teamevent = game.ReplicatedStorage.TeamFight.Rem
local spectevent = game.ReplicatedStorage.TeamFight.Spectate
local listA = {}
local listB = {}
local numbaA = 0
local numbaB = 0
local currentA = ""
local currentB = ""


local restbutt = folder.ResetButton

local displayA = folder.ListA
local displayB = folder.ListB

local biggestButton = folder.BigButton


buttonA.ClickDetector.MouseClick:Connect(function(player)
	for i, v in ipairs(listA) do 
		if tostring(v) == tostring(player) then return end
	end
	numbaA = numbaA + 1
	listA[numbaA] = player
	currentA = ""
	for i, v in ipairs(listA) do
		currentA = currentA..tostring(v).."\n"
	end
	displayA.SurfaceGui.TextLabel.Text = currentA
	for i, v in ipairs(listB) do 
		if tostring(v) == tostring(player) then 
			table.remove(listB,i)
			numbaB = numbaB - 1
		end
	end
	currentB = ""
	for i, v in ipairs(listB) do
		currentB = currentB..tostring(v).."\n"
	end
	displayB.SurfaceGui.TextLabel.Text = currentB
end)

game.Players.PlayerRemoving:Connect(function(player)
	for i, v in ipairs(listA) do
		if tostring(v) == tostring(player) then
			table.remove(listA,i)
			numbaA = numbaA - 1
		end
	end
	currentA = ""
	for i, v in ipairs(listA) do
		currentA = currentA..tostring(v).."\n"
	end
	displayA.SurfaceGui.TextLabel.Text = currentA
	for i, v in ipairs(listB) do
		if tostring(v) == tostring(player) then
			table.remove(listB,i)
			numbaB = numbaB - 1
		end
	end
	currentB = ""
	for i, v in ipairs(listB) do
		currentB = currentB..tostring(v).."\n"
	end
	displayB.SurfaceGui.TextLabel.Text = currentB
end)

buttonB.ClickDetector.MouseClick:Connect(function(player)
	
	for i, v in ipairs(listB) do 
		if tostring(v) == tostring(player) then return end	
	end
	for i, v in ipairs(listA) do 
		if tostring(v) == tostring(player) then 
			table.remove(listA,i)
			numbaA = numbaA - 1
		end
	end
	numbaB = numbaB + 1
	listB[numbaB] = player
	currentA = ""
	currentB = ""
	for i, v in ipairs(listA) do
		currentA = currentA..tostring(v).."\n"
	end
	displayA.SurfaceGui.TextLabel.Text = currentA
	for i, v in ipairs(listB) do
		
		currentB = currentB..tostring(v).."\n"
	end
	displayB.SurfaceGui.TextLabel.Text = currentB
end)

local tax1 = workspace.TeamFightStarter.TeamA.SurfaceGui.TextBox
local tax2 =workspace.TeamFightStarter.TeamB.SurfaceGui.TextBox


local tex = game.ReplicatedStorage.TeamFight.Text
local done = game.ReplicatedStorage.TeamFight.Done

function abridged()
	for i, v in ipairs(game.Teams:GetDescendants()) do
		v:Destroy()
	end
	if #listA == 0 then return end
	if #listB == 0 then return end
	local teamA = Instance.new("Team")
	teamA.Parent = game.Teams
	teamA.TeamColor = BrickColor.new("Crimson")
	teamA.Name = tax1.Text
	CS:AddTag(teamA,"teamA")


	local teamB = Instance.new("Team")
	teamB.Parent = game.Teams
	teamB.TeamColor = BrickColor.new("Cyan")
	teamB.Name = tax2.Text
	CS:AddTag(teamB,"teamB")
	local dead1 = {}
	local dead2 = {}
	local deadcount1 = 0
	local deadcount2 = 0
	
	local pos1 = Vector3.new(-2278.78, 10, 389.46)
	local pos2 = Vector3.new(-1622.49, 10, 634.01)
	displayA.SurfaceGui.TextLabel.Text = ""
	displayB.SurfaceGui.TextLabel.Text = ""
	for i, v in ipairs(listA) do
		v.Team = teamA
		v.Character.HumanoidRootPart.Anchored = true
		v.Character.HumanoidRootPart.CFrame = CFrame.new(pos1)
		v.Character.HumanoidRootPart.Anchored = false
		coroutine.wrap(function()
			v.Character.HumanoidRootPart.Anchored = true
			task.wait(2)
			v.Character.HumanoidRootPart.Anchored = false
		end)()
		v.Character.Humanoid.Health = 100
		v.Character:WaitForChild("Humanoid").Died:Connect(function(player)
		v.Team = nil
			if #teamA:GetPlayers() == 0 then
				tex:FireAllClients(teamB.Name)
				biggestButton.ClickDetector.MaxActivationDistance = 32
				for i, v in ipairs(teamB:GetPlayers()) do
					v.Character.Humanoid.Health = 100
					v.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-29.78, 2.5, 31.74))
					v.Team = nil
					for i, v in ipairs(dead1) do
						done:FireClient(v,teamA:GetPlayers())
					end
					for i, v in ipairs(dead2) do
						done:FireClient(v,teamB:GetPlayers())
					end
				end
			end
			task.wait(1.5)
			deadcount1 = deadcount1 + 1
			dead1[deadcount1] = v
			for i, v in ipairs(dead1) do
			spectevent:FireClient(v,teamA:GetPlayers())
			end
		end)
	end

	for i, v in ipairs(listB) do
		v.Team = teamB
		v.Character.HumanoidRootPart.Anchored = true
		v.Character.HumanoidRootPart.CFrame = CFrame.new(pos2)
		v.Character.HumanoidRootPart.Anchored = false
		coroutine.wrap(function()
			v.Character.HumanoidRootPart.Anchored = true
			task.wait(2)
			v.Character.HumanoidRootPart.Anchored = false
		end)()
		v.Character.Humanoid.Health = 100
		v.Character:WaitForChild("Humanoid").Died:Connect(function(player)
		v.Team = nil
			spectevent:FireClient(v,teamB:GetPlayers())
			if #teamB:GetPlayers() == 0 then
				tex:FireAllClients(teamA.Name)
				biggestButton.ClickDetector.MaxActivationDistance = 32
				for i, v in ipairs(teamA:GetPlayers()) do
					v.Character.Humanoid.Health = 100
					v.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-29.78, 2.5, 31.74))
					v.Team = nil
					for i, v in ipairs(dead1) do
						done:FireClient(v,teamA:GetPlayers())
					end
					for i, v in ipairs(dead2) do
						done:FireClient(v,teamB:GetPlayers())
					end
				end
			end
			task.wait(1.5)
			deadcount2 = deadcount2 + 1
			dead2[deadcount2] = v
			for i, v in ipairs(dead2) do
			spectevent:FireClient(v,teamB:GetPlayers())
			end
		end)
	end
	biggestButton.ClickDetector.MaxActivationDistance = 0
	listA = {}
	listB = {}
	numbaA = 0
	numbaB = 0
end

biggestButton.ClickDetector.MouseClick:connect(function(player)
	for i, v in ipairs(listA) do 
		if tostring(v) == tostring(player) then 
			abridged()
		end
	end
	for i, v in ipairs(listB) do 
		if tostring(v) == tostring(player) then 
			abridged()
		end
	end
end)

teamevent.OnServerEvent:Connect(function(player,first,second)
	if first == "" then return end
	if second == "" then return end
	
	tax1.Text = first
	tax2.Text = second

end)

restbutt.ClickDetector.MouseClick:Connect(function(player)
	for i, v in ipairs(listA) do 
		if tostring(v) == tostring(player) then 
			table.remove(listA,i)
			numbaA = numbaA - 1
		end
	end
	for i, v in ipairs(listB) do 
		if tostring(v) == tostring(player) then 
			table.remove(listB,i)
			numbaB = numbaB - 1
		end
	end
	currentA = ""
	currentB = ""
	for i, v in ipairs(listA) do
		currentA = currentA..tostring(v).."\n"
	end
	displayA.SurfaceGui.TextLabel.Text = currentA
	for i, v in ipairs(listB) do

		currentB = currentB..tostring(v).."\n"
	end
	displayB.SurfaceGui.TextLabel.Text = currentB
	player.Team = nil
end)

