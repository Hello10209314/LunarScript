wait(0.1)

local ui = Instance.new("ScreenGui")
ui.Parent = game:GetService("Players").LocalPlayer.PlayerGui
ui.IgnoreGuiInset = true
ui.ResetOnSpawn = false

local minifunc = false
local togglefunc = false

local text = Instance.new("TextLabel")
local uic1 = Instance.new("UICorner")
uic1.Parent = text
text.Parent = ui
text.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
text.Transparency = 0.5
text.Position = UDim2.new(0.409, 0,0.387, 0)
text.Size = UDim2.new(0, 250, 0, 30)
text.Text = "动画速度更改器"
text.RichText = true
text.TextColor3 = Color3.fromRGB(255, 255, 255)
text.TextScaled = true
text.TextTransparency = 0

local frame = Instance.new("Frame")
local uic = Instance.new("UICorner")
uic.Parent = frame
frame.Parent = text
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.Position = UDim2.new(0, 0,1, 0)
frame.Size = UDim2.new(0, 250,0, 130)

local close = Instance.new("TextButton")
local uic2 = Instance.new("UICorner")
uic2.Parent = close
close.Parent = text
close.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
close.Transparency = 0.5
close.Position = UDim2.new(0.86, 0,-1.198, 0)
close.Size = UDim2.new(0, 35, 0, 35)
close.RichText = true
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 0, 0)
close.TextScaled = true
close.TextTransparency = 0
close.MouseButton1Down:Connect(function()
	ui:Destroy()
end)

local mini = Instance.new("TextButton")
local uic3 = Instance.new("UICorner")
uic3.Parent = mini
mini.Parent = text
mini.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mini.Transparency = 0.5
mini.Position = UDim2.new(0.71, 0,-1.198, 0)
mini.Size = UDim2.new(0, 35, 0, 35)
mini.RichText = true
mini.Text = "-"
mini.TextColor3 = Color3.fromRGB(255, 0, 0)
mini.TextScaled = true
mini.TextTransparency = 0
mini.MouseButton1Down:Connect(function()
	if minifunc == false then
		minifunc = true
		frame.Visible = false
	else
		if minifunc == true then
			minifunc = false
			frame.Visible = true
		end
	end
end)

local add = Instance.new("TextButton")
local uic4 = Instance.new("UICorner")
uic4.Parent = add
add.Parent = frame
add.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
add.Transparency = 0.5
add.Position = UDim2.new(0, 0,0.452, 0)
add.Size = UDim2.new(0, 35, 0, 35)
add.RichText = true
add.Text = "+"
add.TextColor3 = Color3.fromRGB(0, 255, 0)
add.TextScaled = true
add.TextTransparency = 0

local remove = Instance.new("TextButton")
local uic5 = Instance.new("UICorner")
uic5.Parent = remove
remove.Parent = frame
remove.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
remove.Transparency = 0.5
remove.Position = UDim2.new(0.15, 0,0.452, 0)
remove.Size = UDim2.new(0, 35, 0, 35)
remove.RichText = true
remove.Text = "-"
remove.TextColor3 = Color3.fromRGB(255, 0, 0)
remove.TextScaled = true
remove.TextTransparency = 0

local speedBox = Instance.new("TextBox")
local uic6 = Instance.new("UICorner")
uic6.Parent = speedBox
speedBox.Parent = frame
speedBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
speedBox.Transparency = 0.5
speedBox.Position = UDim2.new(0, 0,0.727, 0)
speedBox.Size = UDim2.new(0, 250, 0, 35)
speedBox.RichText = true
speedBox.Text = "2"
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.TextScaled = true
speedBox.TextTransparency = 0

local func = Instance.new("TextButton")
local uic7 = Instance.new("UICorner")
uic7.Parent = func
func.Parent = frame
func.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
func.Transparency = 0.5
func.Position = UDim2.new(0, 0,0, 0)
func.Size = UDim2.new(0, 35, 0, 35)
func.RichText = true
func.Text = "关"
func.TextColor3 = Color3.fromRGB(255, 0, 0)
func.TextScaled = true
func.TextTransparency = 0

local isAnimating = false
local speedMultiplier = tonumber(speedBox.Text) or 2

local function modifyAnimationSpeed()
	while isAnimating do
		local character = game:GetService("Players").LocalPlayer.Character
		if character then
			for _, anim in pairs(character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()) do
				anim:AdjustSpeed(speedMultiplier)
			end
		end
		wait(0.1)
	end
end

func.MouseButton1Down:Connect(function()
	if togglefunc == false then
		togglefunc = true
		func.Text = "开"
		func.TextColor3 = Color3.fromRGB(0, 255, 0)
		speedMultiplier = tonumber(speedBox.Text) or 2
		isAnimating = true
		modifyAnimationSpeed()
	else
		if togglefunc == true then
			togglefunc = false
			isAnimating = false
			func.Text = "关"
			func.TextColor3 = Color3.fromRGB(255, 0, 0)
		end
	end
end)

add.MouseButton1Down:Connect(function()
	speedMultiplier = (tonumber(speedBox.Text) or 2) + 1
	speedBox.Text = tostring(speedMultiplier)
end)

remove.MouseButton1Down:Connect(function()
	speedMultiplier = (tonumber(speedBox.Text) or 2) - 1
	if speedMultiplier < 0 then speedMultiplier = 0 end
	speedBox.Text = tostring(speedMultiplier)
end)

local uis = game:GetService("UserInputService")
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	text.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

text.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = text.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

text.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

text.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
		dragInput = nil
	end
end)

uis.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)