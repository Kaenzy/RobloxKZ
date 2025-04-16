-- Free and Open-source so please leave a Star :D

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local AssetService = game:GetService("AssetService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GameExplorer"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Round corners 
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Add border instead of shadow for depth
local Border = Instance.new("UIStroke")
Border.Color = Color3.fromRGB(60, 60, 60)
Border.Thickness = 2
Border.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

-- Title Bar Corner
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

-- Fix the bottom corners of title bar
local BottomFrame = Instance.new("Frame")
BottomFrame.Name = "BottomFrame"
BottomFrame.Position = UDim2.new(0, 0, 1, -8)
BottomFrame.Size = UDim2.new(1, 0, 0, 8)
BottomFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BottomFrame.BorderSizePixel = 0
BottomFrame.Parent = TitleBar

-- Title with icon
local TitleIcon = Instance.new("TextLabel")
TitleIcon.Name = "TitleIcon"
TitleIcon.Size = UDim2.new(0, 20, 0, 20)
TitleIcon.Position = UDim2.new(0, 10, 0, 10)
TitleIcon.BackgroundTransparency = 1
TitleIcon.Font = Enum.Font.GothamBold
TitleIcon.Text = "🎮"
TitleIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleIcon.TextSize = 16
TitleIcon.Parent = TitleBar

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 40, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "View sub-places | by Kaenzy"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.AutoButtonColor = false
CloseButton.Parent = TitleBar

-- Close Button Corner
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 15)
CloseCorner.Parent = CloseButton

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.AutoButtonColor = false
MinimizeButton.Parent = TitleBar

-- Minimize Button Corner
local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 15)
MinimizeCorner.Parent = MinimizeButton

-- Reset Position Button (for when UI goes off-screen)
local ResetButton = Instance.new("TextButton")
ResetButton.Name = "ResetButton"
ResetButton.Size = UDim2.new(0, 200, 0, 50)
ResetButton.Position = UDim2.new(0.5, -100, 0, 10)
ResetButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ResetButton.Text = "Reset UI Position"
ResetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetButton.TextSize = 16
ResetButton.Font = Enum.Font.Gotham
ResetButton.Visible = false
ResetButton.Parent = ScreenGui

-- Reset Button Corner
local ResetCorner = Instance.new("UICorner")
ResetCorner.CornerRadius = UDim.new(0, 8)
ResetCorner.Parent = ResetButton

-- Search bar
local SearchBar = Instance.new("Frame")
SearchBar.Name = "SearchBar"
SearchBar.Size = UDim2.new(1, -20, 0, 30)
SearchBar.Position = UDim2.new(0, 10, 0, 45)
SearchBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SearchBar.BorderSizePixel = 0
SearchBar.Parent = MainFrame

-- Search Bar Corner
local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 6)
SearchCorner.Parent = SearchBar

-- Search Icon
local SearchIcon = Instance.new("TextLabel")
SearchIcon.Name = "SearchIcon"
SearchIcon.Size = UDim2.new(0, 20, 0, 20)
SearchIcon.Position = UDim2.new(0, 10, 0, 5)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Font = Enum.Font.GothamBold
SearchIcon.Text = "🔍"
SearchIcon.TextColor3 = Color3.fromRGB(200, 200, 200)
SearchIcon.TextSize = 14
SearchIcon.Parent = SearchBar

-- Search Box
local SearchBox = Instance.new("TextBox")
SearchBox.Name = "SearchBox"
SearchBox.Size = UDim2.new(1, -40, 1, 0)
SearchBox.Position = UDim2.new(0, 35, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.Font = Enum.Font.Gotham
SearchBox.PlaceholderText = "Search games..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.TextSize = 14
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.ClearTextOnFocus = false
SearchBox.Parent = SearchBar

-- Clear search button
local ClearSearch = Instance.new("TextButton")
ClearSearch.Name = "ClearSearch"
ClearSearch.Size = UDim2.new(0, 20, 0, 20)
ClearSearch.Position = UDim2.new(1, -25, 0, 5)
ClearSearch.BackgroundTransparency = 1
ClearSearch.Text = "✖"
ClearSearch.TextColor3 = Color3.fromRGB(150, 150, 150)
ClearSearch.TextSize = 14
ClearSearch.Font = Enum.Font.GothamBold
ClearSearch.Visible = false
ClearSearch.Parent = SearchBar

-- Scrolling Frame for Game List
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "GameList"
ScrollingFrame.Size = UDim2.new(1, -20, 1, -85)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 80)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.Parent = MainFrame

-- List Layout
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- Template Button
local Template = Instance.new("Frame")
Template.Name = "Template"
Template.Size = UDim2.new(1, 0, 0, 60)
Template.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Template.BorderSizePixel = 0
Template.Visible = false
Template.Parent = MainFrame

-- Template Corner
local TemplateCorner = Instance.new("UICorner")
TemplateCorner.CornerRadius = UDim.new(0, 6)
TemplateCorner.Parent = Template

-- Game Name
local GameName = Instance.new("TextLabel")
GameName.Name = "GameName"
GameName.Size = UDim2.new(1, -20, 0, 30)
GameName.Position = UDim2.new(0, 10, 0, 5)
GameName.BackgroundTransparency = 1
GameName.Font = Enum.Font.Gotham
GameName.TextColor3 = Color3.fromRGB(255, 255, 255)
GameName.TextSize = 14
GameName.TextXAlignment = Enum.TextXAlignment.Left
GameName.TextTruncate = Enum.TextTruncate.AtEnd
GameName.Parent = Template

-- Place ID
local PlaceId = Instance.new("TextLabel")
PlaceId.Name = "PlaceId"
PlaceId.Size = UDim2.new(0.7, -20, 0, 20)
PlaceId.Position = UDim2.new(0, 10, 0, 35)
PlaceId.BackgroundTransparency = 1
PlaceId.Font = Enum.Font.Gotham
PlaceId.TextColor3 = Color3.fromRGB(200, 200, 200)
PlaceId.TextSize = 12
PlaceId.TextXAlignment = Enum.TextXAlignment.Left
PlaceId.Parent = Template

-- Copy Button
local CopyButton = Instance.new("TextButton")
CopyButton.Name = "CopyButton"
CopyButton.Size = UDim2.new(0, 50, 0, 25)
CopyButton.Position = UDim2.new(0.7, 0, 0, 32)
CopyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CopyButton.Text = "Copy"
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.TextSize = 12
CopyButton.Font = Enum.Font.Gotham
CopyButton.Parent = Template

-- Copy Button Corner
local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 4)
CopyCorner.Parent = CopyButton

-- Join Button
local JoinButton = Instance.new("TextButton")
JoinButton.Name = "JoinButton"
JoinButton.Size = UDim2.new(0, 50, 0, 25)
JoinButton.Position = UDim2.new(0.7, 55, 0, 32)
JoinButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
JoinButton.Text = "Join"
JoinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
JoinButton.TextSize = 12
JoinButton.Font = Enum.Font.Gotham
JoinButton.Parent = Template

-- Join Button Corner
local JoinCorner = Instance.new("UICorner")
JoinCorner.CornerRadius = UDim.new(0, 4)
JoinCorner.Parent = JoinButton

-- Loading message
local LoadingMessage = Instance.new("TextLabel")
LoadingMessage.Name = "LoadingMessage"
LoadingMessage.Size = UDim2.new(1, -20, 0, 30)
LoadingMessage.Position = UDim2.new(0, 10, 0, 135)
LoadingMessage.BackgroundTransparency = 1
LoadingMessage.Font = Enum.Font.Gotham
LoadingMessage.Text = "Loading games..."
LoadingMessage.TextColor3 = Color3.fromRGB(200, 200, 200)
LoadingMessage.TextSize = 14
LoadingMessage.Parent = MainFrame

-- Status bar
local StatusBar = Instance.new("Frame")
StatusBar.Name = "StatusBar"
StatusBar.Size = UDim2.new(1, 0, 0, 3)
StatusBar.Position = UDim2.new(0, 0, 1, -3)
StatusBar.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
StatusBar.BorderSizePixel = 0
StatusBar.Parent = MainFrame

-- Variables
local dragging = false
local dragInput
local dragStart
local startPos
local minimized = false
local minimizedSize = UDim2.new(0, 400, 0, 40)
local normalSize = UDim2.new(0, 400, 0, 300)
local gameItems = {}

-- Functions
local function updateInput(input)
    local delta = input.Position - dragStart
    local newPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    
    -- Create smooth dragging effect
    local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(MainFrame, tweenInfo, {Position = newPosition})
    tween:Play()
end

local function filterGames(searchText)
    searchText = string.lower(searchText)
    
    for _, gameItem in pairs(gameItems) do
        local gameName = string.lower(gameItem.GameName.Text)
        local placeId = string.lower(gameItem.PlaceId.Text)
        
        if searchText == "" or string.find(gameName, searchText) or string.find(placeId, searchText) then
            gameItem.Visible = true
        else
            gameItem.Visible = false
        end
    end
    
    -- Update canvas size after filtering
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
end

local function populateGameList()
    -- Clear existing items
    for _, child in ipairs(ScrollingFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Reset gameItems table
    gameItems = {}
    
    -- Display loading message
    LoadingMessage.Visible = true
    
    -- Get games list
    local pages
    
    -- Wrap in pcall to handle potential errors
    local success, result = pcall(function()
        pages = AssetService:GetGamePlacesAsync()
        return true
    end)
    
    if not success then
        LoadingMessage.Text = "Error loading games."
        wait(2)
        LoadingMessage.Visible = false
        return
    end
    
    local gameCount = 0
    
    -- Function to process pages
    local function processPages()
        for _, place in pairs(pages:GetCurrentPage()) do
            gameCount = gameCount + 1
            
            -- Clone template
            local gameItem = Template:Clone()
            gameItem.Name = "GameItem_" .. gameCount
            gameItem.Visible = true
            gameItem.LayoutOrder = gameCount
            
            -- Set data
            gameItem.GameName.Text = place.Name
            gameItem.PlaceId.Text = "ID: " .. tostring(place.PlaceId)
            
            -- Store for filtering
            table.insert(gameItems, gameItem)
            
            -- Set button functions
            gameItem.CopyButton.MouseButton1Click:Connect(function()
                if setclipboard then -- Check if function exists
                    setclipboard(tostring(place.PlaceId))
                    
                    -- Visual feedback
                    local originalText = gameItem.CopyButton.Text
                    local originalColor = gameItem.CopyButton.BackgroundColor3
                    
                    gameItem.CopyButton.Text = "Copied!"
                    gameItem.CopyButton.BackgroundColor3 = Color3.fromRGB(40, 180, 100)
                    
                    wait(1)
                    
                    gameItem.CopyButton.Text = originalText
                    gameItem.CopyButton.BackgroundColor3 = originalColor
                end
            end)
            
            gameItem.JoinButton.MouseButton1Click:Connect(function()
                -- Visual feedback
                local originalText = gameItem.JoinButton.Text
                gameItem.JoinButton.Text = "Joining..."
                
                -- Try to teleport
                local success, error = pcall(function()
                    TeleportService:Teleport(place.PlaceId, LocalPlayer)
                end)
                
                if not success then
                    gameItem.JoinButton.Text = "Error"
                    wait(1)
                    gameItem.JoinButton.Text = originalText
                end
            end)
            
            -- Add hover effects
            gameItem.MouseEnter:Connect(function()
                TweenService:Create(gameItem, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            end)
            
            gameItem.MouseLeave:Connect(function()
                TweenService:Create(gameItem, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
            end)
            
            -- Button hover effects
            for _, button in pairs({gameItem.CopyButton, gameItem.JoinButton}) do
                button.MouseEnter:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = button.BackgroundColor3:Lerp(Color3.fromRGB(255, 255, 255), 0.2)}):Play()
                end)
                
                button.MouseLeave:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = button == gameItem.CopyButton and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(70, 130, 180)}):Play()
                end)
                
                button.MouseButton1Down:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0, 48, 0, 23), Position = button.Position + UDim2.new(0, 1, 0, 1)}):Play()
                end)
                
                button.MouseButton1Up:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0, 50, 0, 25), Position = button.Position - UDim2.new(0, 1, 0, 1)}):Play()
                end)
            end
            
            -- Add to scroll frame with animation
            gameItem.Parent = ScrollingFrame
            gameItem.Position = UDim2.new(0, -400, 0, 0)
            TweenService:Create(gameItem, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, gameCount * 0.05), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        end
        
        -- Check if there are more pages
        if not pages.IsFinished then
            pages:AdvanceToNextPageAsync()
            processPages()
        else
            -- Hide loading message when done
            LoadingMessage.Visible = false
            
            -- Update canvas size
            ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
            
            -- Show completion animation in status bar
            local originalSize = StatusBar.Size
            TweenService:Create(StatusBar, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 3)}):Play()
            wait(0.3)
            StatusBar.Position = UDim2.new(1, 0, 1, -3)
            StatusBar.Size = UDim2.new(0, 0, 0, 3)
            TweenService:Create(StatusBar, TweenInfo.new(0.3), {Size = originalSize, Position = UDim2.new(0, 0, 1, -3)}):Play()
        end
    end
    
    -- Start processing pages
    processPages()
end

-- Setup dragging
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    -- Add closing animation
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(MainFrame.Position.X.Scale, MainFrame.Position.X.Offset + 200, MainFrame.Position.Y.Scale, MainFrame.Position.Y.Offset + 150)}):Play()
    wait(0.3)
    ScreenGui:Destroy()
end)

-- Minimize button functionality
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    if minimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = minimizedSize}):Play()
        MinimizeButton.Text = "+"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = normalSize}):Play()
        MinimizeButton.Text = "−"
    end
end)

-- Reset button functionality
ResetButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -200, 0.5, -150)}):Play()
    ResetButton.Visible = false
end)

-- Show reset button when Alt+R is pressed
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.R and UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) then
        ResetButton.Visible = true
        
        -- Auto-hide after 5 seconds
        wait(5)
        if ResetButton.Visible then
            ResetButton.Visible = false
        end
    end
end)

-- Search functionality
SearchBox.Changed:Connect(function(property)
    if property == "Text" then
        filterGames(SearchBox.Text)
        ClearSearch.Visible = SearchBox.Text ~= ""
    end
end)

ClearSearch.MouseButton1Click:Connect(function()
    SearchBox.Text = ""
    ClearSearch.Visible = false
end)

-- Button hover effects
for _, button in pairs({CloseButton, MinimizeButton}) do
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = button.BackgroundColor3:Lerp(Color3.fromRGB(255, 255, 255), 0.2)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = button == CloseButton and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(70, 70, 70)}):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0, 28, 0, 28), Position = button.Position + UDim2.new(0, 1, 0, 1)}):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0, 30, 0, 30), Position = button.Position - UDim2.new(0, 1, 0, 1)}):Play()
    end)
end

-- Populate game list with animation delay
wait(0.5)
populateGameList()

-- Opening animation
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = normalSize, Position = UDim2.new(0.5, -200, 0.5, -150)}):Play()
