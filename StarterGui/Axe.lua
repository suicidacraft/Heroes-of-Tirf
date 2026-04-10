local RS = game:GetService("ReplicatedStorage")
local hover = RS.Gui.HoverKatana
local unhover = RS.Gui.unHoverKatana
local SwordKing = script.Parent.WorldModel.AxeAnimation
local humanoid = SwordKing:WaitForChild("Humanoid")
local animation = script:WaitForChild("Idle")
local idle = humanoid:LoadAnimation(animation)
local stance = script:WaitForChild("Cocky")
local idle2 = humanoid:LoadAnimation(stance)
local sheathe = script:WaitForChild("unsheathing")
local equip = humanoid:LoadAnimation(sheathe)
local stop = false

idle:Play()

script.Parent.MouseEnter:Connect(function()
	equip:Play()
	task.wait(idle.Length)
	if stop == false then
		idle2:Play()

	end
end)


script.Parent.MouseLeave:Connect(function()
	equip:Stop()
	idle2:Stop()
	stop = true
	idle:Play()
	stop = false
end)

