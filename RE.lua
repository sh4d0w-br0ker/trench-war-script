local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer

-- Видалення старої копії
if Player.PlayerGui:FindFirstChild("VoidHubGui") then
    Player.PlayerGui.VoidHubGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VoidHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 100
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- ГОЛОВНЕ ВІКНО
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 420)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
MainFrame.ClipsDescendants = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 8)

-- ЗВЕЗДЫ ДЛЯ VOID ТЕМЫ
local StarsContainer = Instance.new("Frame")
StarsContainer.Size = UDim2.new(1, 0, 1, 0)
StarsContainer.BackgroundTransparency = 1
StarsContainer.Parent = MainFrame

local stars = {}
for i = 1, 100 do
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, math.random(1, 2), 0, math.random(1, 2))
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    star.BackgroundTransparency = 0.5
    star.BorderSizePixel = 0
    star.Visible = false
    star.Parent = StarsContainer
    table.insert(stars, star)
end

-- ХЕДЕР
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner", Header)
HeaderCorner.CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Text = "  VOID HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1
Title.TextXAlignment = "Left"
Title.Parent = Header

local ExitBtn = Instance.new("TextButton")
ExitBtn.Text = "✕"
ExitBtn.Size = UDim2.new(0, 35, 1, 0)
ExitBtn.Position = UDim2.new(1, -35, 0, 0)
ExitBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
ExitBtn.BackgroundTransparency = 1
ExitBtn.Parent = Header
ExitBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Text = "—"
MinimizeBtn.Size = UDim2.new(0, 35, 1, 0)
MinimizeBtn.Position = UDim2.new(1, -70, 0, 0)
MinimizeBtn.TextColor3 = Color3.new(0.8, 0.8, 0.8)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Parent = Header

-- САЙДБАР
local Side = Instance.new("Frame")
Side.Size = UDim2.new(0, 90, 1, -35)
Side.Position = UDim2.new(0, 0, 0, 35)
Side.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Side.BorderSizePixel = 0
Side.Parent = MainFrame

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -100, 1, -45)
Container.Position = UDim2.new(0, 95, 0, 40)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

-- ЛОГІКА ЗГОРТАННЯ
local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    Side.Visible = not isMinimized
    Container.Visible = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 350, 0, 35), "Out", "Quad", 0.2, true)
        MinimizeBtn.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 350, 0, 420), "Out", "Quad", 0.2, true)
        MinimizeBtn.Text = "—"
    end
end)

local allTabs = {}

local function CreateTab(name)
    local f = Instance.new("ScrollingFrame")
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundTransparency = 1
    f.ScrollBarThickness = 2
    f.Visible = false
    f.CanvasSize = UDim2.new(0, 0, 0, 0)
    f.AutomaticCanvasSize = Enum.AutomaticSize.Y
    f.Parent = Container

    local layout = Instance.new("UIListLayout", f)
    layout.Padding = UDim.new(0, 5)

    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 30)
    b.Text = name
    b.Font = Enum.Font.Gotham
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Parent = Side

    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)

    b.MouseButton1Click:Connect(function()
        for _, t in pairs(allTabs) do t.Visible = false end
        f.Visible = true
    end)

    allTabs[name] = f
    return f
end

local function CreateButton(parent, text, color, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -5, 0, 35)
    b.Text = text
    b.BackgroundColor3 = color
    b.Font = Enum.Font.GothamSemibold
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(callback)
    return b
end

Instance.new("UIListLayout", Side).Padding = UDim.new(0, 5)
Instance.new("UIPadding", Side).PaddingLeft = UDim.new(0, 5)

-- Функция для создания плавающего окна
local function CreateFloatWindow(title, remoteType)
    local FloatFrame = Instance.new("Frame")
    FloatFrame.Size = UDim2.new(0, 300, 0, 200)
    FloatFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    FloatFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    FloatFrame.BorderSizePixel = 0
    FloatFrame.BackgroundTransparency = 0.05
    FloatFrame.Active = true
    FloatFrame.Draggable = true
    FloatFrame.Parent = ScreenGui
    
    local FloatCorner = Instance.new("UICorner", FloatFrame)
    FloatCorner.CornerRadius = UDim.new(0, 8)
    
    -- Заголовок
    local FloatHeader = Instance.new("Frame")
    FloatHeader.Size = UDim2.new(1, 0, 0, 30)
    FloatHeader.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    FloatHeader.BorderSizePixel = 0
    FloatHeader.Parent = FloatFrame
    
    local FloatHeaderCorner = Instance.new("UICorner", FloatHeader)
    FloatHeaderCorner.CornerRadius = UDim.new(0, 8)
    
    local FloatTitle = Instance.new("TextLabel")
    FloatTitle.Text = title
    FloatTitle.Font = Enum.Font.GothamBold
    FloatTitle.TextSize = 12
    FloatTitle.Size = UDim2.new(1, -60, 1, 0)
    FloatTitle.Position = UDim2.new(0, 10, 0, 0)
    FloatTitle.TextColor3 = Color3.new(1, 1, 1)
    FloatTitle.BackgroundTransparency = 1
    FloatTitle.TextXAlignment = "Left"
    FloatTitle.Parent = FloatHeader
    
    local FloatMinimize = Instance.new("TextButton")
    FloatMinimize.Text = "—"
    FloatMinimize.Size = UDim2.new(0, 30, 1, 0)
    FloatMinimize.Position = UDim2.new(1, -60, 0, 0)
    FloatMinimize.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    FloatMinimize.BackgroundTransparency = 1
    FloatMinimize.Parent = FloatHeader
    
    local FloatClose = Instance.new("TextButton")
    FloatClose.Text = "✕"
    FloatClose.Size = UDim2.new(0, 30, 1, 0)
    FloatClose.Position = UDim2.new(1, -30, 0, 0)
    FloatClose.TextColor3 = Color3.fromRGB(255, 80, 80)
    FloatClose.BackgroundTransparency = 1
    FloatClose.Parent = FloatHeader
    
    -- Контент
    local FloatContent = Instance.new("Frame")
    FloatContent.Size = UDim2.new(1, -20, 1, -50)
    FloatContent.Position = UDim2.new(0, 10, 0, 40)
    FloatContent.BackgroundTransparency = 1
    FloatContent.Parent = FloatFrame
    
    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(1, 0, 0, 80)
    TextBox.Position = UDim2.new(0, 0, 0, 0)
    TextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    TextBox.TextColor3 = Color3.new(1, 1, 1)
    TextBox.Text = ""
    TextBox.TextWrapped = true
    TextBox.TextXAlignment = "Left"
    TextBox.TextYAlignment = "Top"
    TextBox.ClearTextOnFocus = false
    TextBox.Parent = FloatContent
    
    local TextBoxCorner = Instance.new("UICorner", TextBox)
    TextBoxCorner.CornerRadius = UDim.new(0, 6)
    
    local GenerateBtn = Instance.new("TextButton")
    GenerateBtn.Size = UDim2.new(1, 0, 0, 30)
    GenerateBtn.Position = UDim2.new(0, 0, 0, 90)
    GenerateBtn.Text = "Generate Event"
    GenerateBtn.BackgroundColor3 = Color3.fromRGB(80, 100, 200)
    GenerateBtn.Font = Enum.Font.GothamSemibold
    GenerateBtn.TextColor3 = Color3.new(1, 1, 1)
    GenerateBtn.Parent = FloatContent
    
    local GenerateCorner = Instance.new("UICorner", GenerateBtn)
    GenerateCorner.CornerRadius = UDim.new(0, 6)
    
    local FireBtn = Instance.new("TextButton")
    FireBtn.Size = UDim2.new(1, 0, 0, 35)
    FireBtn.Position = UDim2.new(0, 0, 0, 130)
    if remoteType == "Event" then
        FireBtn.Text = "Fire Event"
    else
        FireBtn.Text = "Call Function"
    end
    FireBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
    FireBtn.Font = Enum.Font.GothamSemibold
    FireBtn.TextColor3 = Color3.new(1, 1, 1)
    FireBtn.Parent = FloatContent
    
    local FireCorner = Instance.new("UICorner", FireBtn)
    FireCorner.CornerRadius = UDim.new(0, 6)
    
    local PathLabel = Instance.new("TextLabel")
    PathLabel.Size = UDim2.new(1, 0, 0, 20)
    PathLabel.Position = UDim2.new(0, 0, 0, 175)
    PathLabel.Text = "Path: " .. title
    PathLabel.Font = Enum.Font.Gotham
    PathLabel.TextSize = 10
    PathLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    PathLabel.BackgroundTransparency = 1
    PathLabel.Parent = FloatContent
    
    local isFloatMinimized = false
    FloatMinimize.MouseButton1Click:Connect(function()
        isFloatMinimized = not isFloatMinimized
        if isFloatMinimized then
            FloatContent.Visible = false
            FloatFrame:TweenSize(UDim2.new(0, 300, 0, 30), "Out", "Quad", 0.2, true)
            FloatMinimize.Text = "+"
        else
            FloatContent.Visible = true
            FloatFrame:TweenSize(UDim2.new(0, 300, 0, 200), "Out", "Quad", 0.2, true)
            FloatMinimize.Text = "—"
        end
    end)
    
    FloatClose.MouseButton1Click:Connect(function()
        FloatFrame:Destroy()
    end)
    
    -- Генерация аргументов
    GenerateBtn.MouseButton1Click:Connect(function()
        local remotePath = title
        local args = {}
        
        -- Пытаемся определить тип аргументов по названию
        if remotePath:find("Tool") or remotePath:find("Give") then
            args = {"DefaultTool"}
        elseif remotePath:find("Message") or remotePath:find("Chat") then
            args = {"Hello World"}
        elseif remotePath:find("Door") then
            args = {"Front"}
        elseif remotePath:find("Energy") then
            args = {100}
        elseif remotePath:find("Teleport") or remotePath:find("TP") then
            args = {CFrame.new(0, 0, 0)}
        elseif remotePath:find("Kill") or remotePath:find("Damage") then
            args = {Player, 100}
        else
            args = {true}
        end
        
        TextBox.Text = game:GetService("HttpService"):JSONEncode(args)
    end)
    
    -- Fire/Call
    FireBtn.MouseButton1Click:Connect(function()
        local success, args = pcall(function()
            return game:GetService("HttpService"):JSONDecode(TextBox.Text)
        end)
        
        if not success then
            TextBox.Text = "Invalid JSON! Use format: [\"value1\", 123, true]"
            return
        end
        
        local remote = RS:FindFirstChild("RemoteEvents")
        if remoteType == "Function" then
            remote = RS:FindFirstChild("RemoteFunctions")
        end
        
        if remote then
            local target = remote:FindFirstChild(title:match("[^/]+$"))
            if target then
                if remoteType == "Event" then
                    target:FireServer(unpack(args))
                else
                    target:InvokeServer(unpack(args))
                end
                TextBox.Text = "✓ " .. remoteType .. " fired successfully!\n" .. TextBox.Text
            else
                TextBox.Text = "Remote not found!"
            end
        else
            TextBox.Text = "Remote folder not found!"
        end
    end)
    
    return FloatFrame
end

-- Вкладка INFO (только информация)
local tInfo = CreateTab("Info")
local itxt = Instance.new("TextLabel", tInfo)
itxt.Size = UDim2.new(1,0,0,80)
itxt.Text = "VOID HUB v2\nCreated by spynote\nDiscord: @_thefinal_\nRoblox: sedfortip"
itxt.TextColor3 = Color3.new(1,1,1)
itxt.BackgroundTransparency = 1
itxt.Font = Enum.Font.Gotham

-- Вкладка EVENTS
local tEvents = CreateTab("Events")

local function ScanRemotes(parent, path, buttonParent, remoteType)
    for _, child in pairs(parent:GetChildren()) do
        local newPath = path .. "/" .. child.Name
        if child:IsA("RemoteEvent") and remoteType == "Event" then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -5, 0, 30)
            btn.Text = child.Name
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
            btn.Font = Enum.Font.Gotham
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.TextSize = 11
            btn.Parent = buttonParent
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            
            btn.MouseButton1Click:Connect(function()
                CreateFloatWindow(newPath, "Event")
            end)
        elseif child:IsA("RemoteFunction") and remoteType == "Function" then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -5, 0, 30)
            btn.Text = child.Name
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
            btn.Font = Enum.Font.Gotham
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.TextSize = 11
            btn.Parent = buttonParent
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            
            btn.MouseButton1Click:Connect(function()
                CreateFloatWindow(newPath, "Function")
            end)
        elseif child:IsA("Folder") or child:IsA("Model") then
            ScanRemotes(child, newPath, buttonParent, remoteType)
        end
    end
end

-- Сканируем RemoteEvents
local eventsContainer = Instance.new("ScrollingFrame")
eventsContainer.Size = UDim2.new(1, 0, 1, 0)
eventsContainer.BackgroundTransparency = 1
eventsContainer.ScrollBarThickness = 4
eventsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
eventsContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
eventsContainer.Parent = tEvents

local eventsLayout = Instance.new("UIListLayout", eventsContainer)
eventsLayout.Padding = UDim.new(0, 3)

local eventsLabel = Instance.new("TextLabel")
eventsLabel.Size = UDim2.new(1, 0, 0, 25)
eventsLabel.Text = "=== REMOTE EVENTS ==="
eventsLabel.TextColor3 = Color3.fromRGB(200, 200, 100)
eventsLabel.BackgroundTransparency = 1
eventsLabel.Font = Enum.Font.GothamBold
eventsLabel.Parent = eventsContainer

local remoteEventsFolder = RS:FindFirstChild("RemoteEvents")
if remoteEventsFolder then
    ScanRemotes(remoteEventsFolder, "ReplicatedStorage.RemoteEvents", eventsContainer, "Event")
end

-- Вкладка FUNCTIONS
local tFunctions = CreateTab("Functions")

local functionsContainer = Instance.new("ScrollingFrame")
functionsContainer.Size = UDim2.new(1, 0, 1, 0)
functionsContainer.BackgroundTransparency = 1
functionsContainer.ScrollBarThickness = 4
functionsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
functionsContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
functionsContainer.Parent = tFunctions

local functionsLayout = Instance.new("UIListLayout", functionsContainer)
functionsLayout.Padding = UDim.new(0, 3)

local functionsLabel = Instance.new("TextLabel")
functionsLabel.Size = UDim2.new(1, 0, 0, 25)
functionsLabel.Text = "=== REMOTE FUNCTIONS ==="
functionsLabel.TextColor3 = Color3.fromRGB(100, 200, 200)
functionsLabel.BackgroundTransparency = 1
functionsLabel.Font = Enum.Font.GothamBold
functionsLabel.Parent = functionsContainer

local remoteFunctionsFolder = RS:FindFirstChild("RemoteFunctions")
if remoteFunctionsFolder then
    ScanRemotes(remoteFunctionsFolder, "ReplicatedStorage.RemoteFunctions", functionsContainer, "Function")
end

-- Вкладка SETTINGS
local tSettings = CreateTab("Settings")

local function UpdateTheme(color)
    MainFrame.BackgroundColor3 = color
    Header.BackgroundColor3 = color:lerp(Color3.new(0,0,0), 0.2)
    Side.BackgroundColor3 = color:lerp(Color3.new(0,0,0), 0.3)
    for _, star in pairs(stars) do
        star.Visible = false
    end
end

CreateButton(tSettings, "White Theme", Color3.fromRGB(200, 200, 200), function()
    UpdateTheme(Color3.fromRGB(200, 200, 200))
    MainFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Header.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    Side.BackgroundColor3 = Color3.fromRGB(190, 190, 190)
end)

CreateButton(tSettings, "Red Theme", Color3.fromRGB(150, 50, 50), function()
    UpdateTheme(Color3.fromRGB(150, 50, 50))
end)

CreateButton(tSettings, "Black Theme", Color3.fromRGB(15, 15, 15), function()
    UpdateTheme(Color3.fromRGB(15, 15, 15))
end)

CreateButton(tSettings, "Void Theme", Color3.fromRGB(8, 8, 12), function()
    UpdateTheme(Color3.fromRGB(8, 8, 12))
    Header.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    Side.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
    for _, star in pairs(stars) do
        star.Visible = true
    end
end)

allTabs["Info"].Visible = true
