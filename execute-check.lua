-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Kaenzy/RobloxKZ/refs/heads/main/execute-check.lua"))()

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer

-- Main UI setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ExecNotification"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 320, 0, 220)
frame.Position = UDim2.new(0.5, -160, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = frame

-- Top gradient bar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 6)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BorderSizePixel = 0
topBar.ZIndex = 2
topBar.Parent = frame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 10)
topBarCorner.Parent = topBar

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 170, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(85, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 170, 255))
})
gradient.Parent = topBar

RunService:BindToRenderStep("GradientAnimation", Enum.RenderPriority.Character.Value, function()
    gradient.Offset = Vector2.new((tick() * 0.3) % 1, 0)
end)

-- Inner glow highlight
local innerGlow = Instance.new("Frame")
innerGlow.Name = "InnerGlow"
innerGlow.Size = UDim2.new(0.98, 0, 0.96, 0)
innerGlow.Position = UDim2.new(0.01, 0, 0.02, 0)
innerGlow.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
innerGlow.BorderSizePixel = 0
innerGlow.Parent = frame

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 8)
glowCorner.Parent = innerGlow

-- Title and messages
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(0.8, 0, 0, 25)
title.Position = UDim2.new(0.05, 0, 0.08, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "Your Executor Executed this script! ✅"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Parent = frame

local successMsg = Instance.new("TextLabel")
successMsg.Name = "SuccessMsg"
successMsg.Size = UDim2.new(0.9, 0, 0, 25)
successMsg.Position = UDim2.new(0.05, 0, 0.23, 0)
successMsg.BackgroundTransparency = 1
successMsg.Font = Enum.Font.GothamSemibold
successMsg.Text = "Successfully Executed!"
successMsg.TextColor3 = Color3.fromRGB(85, 255, 127)
successMsg.TextScaled = true
successMsg.TextSize = 15
successMsg.Parent = frame

-- Information section
local infoBackground = Instance.new("Frame")
infoBackground.Name = "InfoBackground"
infoBackground.Size = UDim2.new(0.9, 0, 0.45, 0)
infoBackground.Position = UDim2.new(0.05, 0, 0.42, 0)
infoBackground.BackgroundColor3 = Color3.fromRGB(22, 22, 25)
infoBackground.BorderSizePixel = 0
infoBackground.Parent = frame

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 6)
infoCorner.Parent = infoBackground

local info = Instance.new("TextLabel")
info.Name = "Info"
info.Size = UDim2.new(0.95, 0, 0.9, 0)
info.Position = UDim2.new(0.025, 0, 0.05, 0)
info.BackgroundTransparency = 1
info.Font = Enum.Font.Gotham
info.TextColor3 = Color3.fromRGB(230, 230, 230)
info.TextScaled = true
info.TextSize = 14
info.TextXAlignment = Enum.TextXAlignment.Left
info.TextYAlignment = Enum.TextYAlignment.Top
info.Parent = infoBackground

-- Close button setup
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(0.92, 0, 0.05, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
closeButton.BorderSizePixel = 0
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 14
closeButton.AutoButtonColor = true
closeButton.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

-- Set executor info
local execName = "Unknown"
local ok, result = pcall(function() return identifyexecutor() end)
if ok then execName = result end
info.Text = string.format("Executor: %s\nPlace ID: %d\nUsername: %s", execName, game.PlaceId, player.Name)

-- Add Roblox notification and success sound
StarterGui:SetCore("SendNotification", {
    Title = "Script Executed",
    Text = "Your executor ran the script successfully!",
    Duration = 5
})

local successSound = Instance.new("Sound")
successSound.SoundId = "rbxassetid://106145041472451"
successSound.Volume = 1
successSound.Parent = SoundService
successSound:Play()

-- Make UI draggable
do
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Open and close animations
do
    frame.Size = UDim2.new(0, 0, 0, 0)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.BackgroundTransparency = 0.2

    local openTween = TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 320, 0, 220),
        Position = UDim2.new(0.5, -160, 0.5, -110),
        BackgroundTransparency = 0
    })
    openTween:Play()

    closeButton.MouseButton1Click:Connect(function()
        TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        task.delay(0.5, function() screenGui:Destroy() end)
    end)
end

-- Auto-close timer
task.delay(15, function()
    if screenGui.Parent then
        local closeTween = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1.1, 0, 0.5, -110)
        })
        closeTween:Play()
        task.delay(0.6, function() screenGui:Destroy() end)
    end
end)
