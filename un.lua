--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
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
MainFrame.Size = UDim2.new(0, 350, 0, 320)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -160)
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
        MainFrame:TweenSize(UDim2.new(0, 350, 0, 320), "Out", "Quad", 0.2, true)
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

-- Вкладка INFO
local tInfo = CreateTab("Info")
local itxt = Instance.new("TextLabel", tInfo)
itxt.Size = UDim2.new(1,0,0,50)
itxt.Text = "VOID HUB v2\nCreated by spynote my discord: @_thefinal_ officialRoblox: sedfortip"
itxt.TextColor3 = Color3.new(1,1,1)
itxt.BackgroundTransparency = 1
itxt.Font = Enum.Font.Gotham

-- Вкладка LOBBY
local tLobby = CreateTab("Lobby")

CreateButton(tLobby, "Get Police", Color3.fromRGB(50, 80, 180), function()
    RS.RemoteEvents.OutsideRole:FireServer("Gun", true)
end)

CreateButton(tLobby, "Get Swat", Color3.fromRGB(40, 40, 40), function()
    RS.RemoteEvents.OutsideRole:FireServer("SwatGun", true)
end)

-- Вкладка USER
local tUser = CreateTab("User")

local function GetTool(name)
    RS.RemoteEvents.GiveTool:FireServer(name)
end

CreateButton(tUser, "Get Medkit", Color3.fromRGB(50, 150, 50), function() GetTool("MedKit") end)
CreateButton(tUser, "Get Pizza3", Color3.fromRGB(200, 120, 50), function() GetTool("Pizza3") end)
CreateButton(tUser, "Get Lollipop", Color3.fromRGB(200, 80, 150), function() GetTool("Lollipop") end)
CreateButton(tUser, "Get TeddyBloxpin", Color3.fromRGB(150, 100, 200), function() GetTool("TeddyBloxpin") end)
CreateButton(tUser, "Get Cure", Color3.fromRGB(100, 255, 180), function() GetTool("Cure") end)
CreateButton(tUser, "Get Plank", Color3.fromRGB(160, 110, 60), function() GetTool("Plank") end)
CreateButton(tUser, "Get CarKey", Color3.fromRGB(255, 220, 50), function() GetTool("CarKey") end)
CreateButton(tUser, "Get ExpiredBloxyCola", Color3.fromRGB(120, 200, 255), function() GetTool("ExpiredBloxyCola") end)
CreateButton(tUser, "Get Pizza2", Color3.fromRGB(200, 120, 50), function() GetTool("Pizza2") end)
CreateButton(tUser, "Get Pizza1", Color3.fromRGB(200, 120, 50), function() GetTool("Pizza1") end)
CreateButton(tUser, "Get Key", Color3.fromRGB(30, 50, 25), function() GetTool("Key") end)

local foodItems = {
    {"Apple", Color3.fromRGB(200, 50, 50)},
    {"Cookie", Color3.fromRGB(150, 100, 50)},
    {"Chips", Color3.fromRGB(200, 150, 50)},
    {"BloxyCola", Color3.fromRGB(50, 50, 200)}
}
for _, item in pairs(foodItems) do
    CreateButton(tUser, "Get "..item[1], item[2], function() GetTool(item[1]) end)
end

-- ===== НОВА ВКЛАДКА WEAPONS =====
local tWeapons = CreateTab("Weapons")

-- Bat (обычная выдача)
CreateButton(tWeapons, "Get Bat", Color3.fromRGB(80, 80, 80), function()
    RS.RemoteEvents.GiveTool:FireServer("Bat")
end)

-- LinkedSword (обычная выдача)
CreateButton(tWeapons, "Get LinkedSword", Color3.fromRGB(100, 100, 200), function()
    RS.RemoteEvents.GiveTool:FireServer("LinkedSword")
end)

-- Sword (как Hammer)
CreateButton(tWeapons, "Get Sword", Color3.fromRGB(180, 180, 100), function()
    game.ReplicatedStorage.RemoteEvents.BasementWeapon:FireServer(true, "Sword")
end)

-- Gun (как Hammer)
CreateButton(tWeapons, "Get Gun", Color3.fromRGB(50, 80, 180), function()
    game.ReplicatedStorage.RemoteEvents.BasementWeapon:FireServer(true, "Gun")
end)

-- SwatGun (как Hammer)
CreateButton(tWeapons, "Get SwatGun", Color3.fromRGB(40, 40, 40), function()
    game.ReplicatedStorage.RemoteEvents.BasementWeapon:FireServer(true, "SwatGun")
end)

-- Hammer
CreateButton(tWeapons, "Get Hammer", Color3.fromRGB(30, 80, 40), function()
    game.ReplicatedStorage.RemoteEvents.BasementWeapon:FireServer(true, "Hammer")
end)

-- Crowbar
CreateButton(tWeapons, "Get Crowbar", Color3.fromRGB(100, 70, 30), function()
    game.ReplicatedStorage.RemoteEvents.BasementWeapon:FireServer(true, "Crowbar")
end)

-- Spanner
CreateButton(tWeapons, "Get Spanner", Color3.fromRGB(60, 100, 140), function()
    game.ReplicatedStorage.RemoteEvents.BasementWeapon:FireServer(true, "Spanner")
end)

-- Pitchfork
CreateButton(tWeapons, "Get Pitchfork", Color3.fromRGB(120, 60, 60), function()
    game.ReplicatedStorage.RemoteEvents.BasementWeapon:FireServer(true, "Pitchfork")
end)

-- Вкладка PLAYERS
local tPlrs = CreateTab("Players")
local Box = Instance.new("TextBox", tPlrs)
Box.Size = UDim2.new(1,-5,0,35)
Box.PlaceholderText = "Enter Name..."
Box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Box.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Box)

local function FindP()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():find(Box.Text:lower()) then return p end
    end
end

CreateButton(tPlrs, "Kill Target", Color3.fromRGB(180, 50, 50), function()
    local t = FindP()
    if t then RS.RemoteEvents.ToxicDrown:FireServer(1, t) end
end)

CreateButton(tPlrs, "Kill All", Color3.fromRGB(220, 20, 20), function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Player then RS.RemoteEvents.ToxicDrown:FireServer(1, p) end
    end
end)

local loop = false
local tkBtn = CreateButton(tPlrs, "TargetKill: OFF", Color3.fromRGB(70, 70, 70), function() end)

tkBtn.MouseButton1Click:Connect(function()
    loop = not loop
    if loop then
        tkBtn.Text = "TargetKill: ON"
        tkBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    else
        tkBtn.Text = "TargetKill: OFF"
        tkBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end
end)

task.spawn(function()
    while task.wait(1.5) do
        if loop then
            local t = FindP()
            if t then RS.RemoteEvents.ToxicDrown:FireServer(1, t) end
        end
    end
end)

-- ===== ВКЛАДКА TELEPORT =====
local tTeleport = CreateTab("Teleport")

local function addTPButton(name, cframe)
    CreateButton(tTeleport, name, Color3.fromRGB(80, 120, 200), function()
        local char = Player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = cframe
        end
    end)
end

addTPButton("Basement", CFrame.new(71, -15, -163))
addTPButton("House", CFrame.new(-36, 3, -200))
addTPButton("Hiding Spot", CFrame.new(-42.87, 6.43, -222.01))
addTPButton("Attic", CFrame.new(-16, 35, -220))
addTPButton("Store", CFrame.new(-422, 3, -121))
addTPButton("Sewer", CFrame.new(129, 3, -125))
addTPButton("Boss Room", CFrame.new(-39, -287, -1480))

-- ===== ВКЛАДКА MISC =====
local tMisc = CreateTab("Misc")

-- Kill Enemies
CreateButton(tMisc, "Kill Enemies", Color3.fromRGB(200, 50, 50), function()
    local enemies = game.Workspace:FindFirstChild("BadGuys")
    if enemies then
        for _, enemy in pairs(enemies:GetChildren()) do
            for i = 1, 50 do
                RS.RemoteEvents.HitBadguy:FireServer(enemy, 10)
                RS.RemoteEvents.HitBadguy:FireServer(enemy, 996)
                RS.RemoteEvents.HitBadguy:FireServer(enemy, 9)
                RS.RemoteEvents.HitBadguy:FireServer(enemy, 8)
            end
        end
    end
end)

-- Friend Cat
CreateButton(tMisc, "Be Friends with Cat", Color3.fromRGB(255, 200, 100), function()
    RS.RemoteEvents.Cattery:FireServer()
end)

-- Cat Jump Toggle
local catJumpEnabled = false
local catJumpConnection = nil
local catJumpBtn = CreateButton(tMisc, "Cat Jump: OFF", Color3.fromRGB(70, 70, 70), function() end)

catJumpBtn.MouseButton1Click:Connect(function()
    catJumpEnabled = not catJumpEnabled
    if catJumpEnabled then
        catJumpBtn.Text = "Cat Jump: ON"
        catJumpBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        
        catJumpConnection = task.spawn(function()
            while catJumpEnabled do
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("CatJumped"):FireServer()
                task.wait(0.05)
            end
        end)
    else
        catJumpBtn.Text = "Cat Jump: OFF"
        catJumpBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        if catJumpConnection then
            task.cancel(catJumpConnection)
            catJumpConnection = nil
        end
    end
end)

-- Heal Toggle
local healEnabled = false
local healConnection = nil
local healBtn = CreateButton(tMisc, "Heal: OFF", Color3.fromRGB(70, 70, 70), function() end)

healBtn.MouseButton1Click:Connect(function()
    healEnabled = not healEnabled
    if healEnabled then
        healBtn.Text = "Heal: ON"
        healBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        
        healConnection = task.spawn(function()
            while healEnabled do
                for i = 1, 200 do
                    if not healEnabled then break end
                    RS.RemoteEvents.Energy:FireServer("Cat")
                    task.wait(0.005)
                end
                task.wait(0.1)
            end
        end)
    else
        healBtn.Text = "Heal: OFF"
        healBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        if healConnection then
            task.cancel(healConnection)
            healConnection = nil
        end
    end
end)

-- Give Ladder Button
CreateButton(tMisc, "Give Ladder", Color3.fromRGB(50, 100, 200), function()
    local args = {1}
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Ladder"):FireServer(unpack(args))
end)

-- Drop all Tools Button
CreateButton(tMisc, "Drop all Tools", Color3.fromRGB(200, 100, 50), function()
    for _, tool in pairs(Player.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            tool.Parent = workspace
        end
    end
    local char = Player.Character
    if char then
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") then
                tool.Parent = workspace
            end
        end
    end
end)

-- Auto OpenFront Toggle
local autoOpenFrontEnabled = false
local autoOpenFrontConnection = nil
local autoOpenFrontBtn = CreateButton(tMisc, "Auto OpenFront: OFF", Color3.fromRGB(70, 70, 70), function() end)

autoOpenFrontBtn.MouseButton1Click:Connect(function()
    autoOpenFrontEnabled = not autoOpenFrontEnabled
    if autoOpenFrontEnabled then
        autoOpenFrontBtn.Text = "Auto OpenFront: ON"
        autoOpenFrontBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        
        autoOpenFrontConnection = task.spawn(function()
            while autoOpenFrontEnabled do
                local args = {"Front"}
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Door"):FireServer(unpack(args))
                task.wait(3)
            end
        end)
    else
        autoOpenFrontBtn.Text = "Auto OpenFront: OFF"
        autoOpenFrontBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        if autoOpenFrontConnection then
            task.cancel(autoOpenFrontConnection)
            autoOpenFrontConnection = nil
        end
    end
end)

-- Open Basement Button
CreateButton(tMisc, "Open Basement", Color3.fromRGB(100, 80, 200), function()
    local char = Player.Character
    local originalCFrame = char and char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart.CFrame
    
    RS.RemoteEvents.GiveTool:FireServer("Key")
    task.wait(0.5)
    
    local key = Player.Backpack:WaitForChild("Key")
    local args = {"Equip", key}
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("BackpackEvent"):FireServer(unpack(args))
    task.wait(0.5)
    
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(25.9161663, 3.56029963, -187.769989, -0.0267044585, -0.00717567047, -0.999617636, 0.000546747586, 0.999973953, -0.00719283475, 0.999643207, -0.000738619303, -0.026699841)
    end
    
    task.wait(2)
    
    if originalCFrame and char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = originalCFrame
    end
end)

-- Open Attic Button
CreateButton(tMisc, "Open Attic", Color3.fromRGB(150, 100, 50), function()
    local args = {1}
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Ladder"):FireServer(unpack(args))
    task.wait(0.5)
    
    local char = Player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(-19.7859402, 19.4470539, -225.477798, 0.919709146, -1.09539059e-07, 0.392600417, 9.91085827e-08, 1, 4.68363979e-08, -0.392600417, -4.16579482e-09, 0.919709146)
    end
    
    local mouse = Player:GetMouse()
    local clickStartTime = tick()
    while tick() - clickStartTime < 2 do
        local clickEvent = {
            Target = nil,
            Position = mouse.Hit.p,
            UnitRay = Ray.new(mouse.UnitRay.Origin, mouse.UnitRay.Direction),
            UserInputState = Enum.UserInputState.Begin,
            UserInputType = Enum.UserInputType.MouseButton1
        }
        game:GetService("ContextActionService"):FireInputBegan(mouse, clickEvent)
        task.wait(0.05)
    end
end)

-- Auto BasementOpen Toggle
local autoBasementOpenEnabled = false
local autoBasementOpenConnection = nil
local autoBasementOpenBtn = CreateButton(tMisc, "Auto BasementOpen: OFF", Color3.fromRGB(70, 70, 70), function() end)

autoBasementOpenBtn.MouseButton1Click:Connect(function()
    autoBasementOpenEnabled = not autoBasementOpenEnabled
    if autoBasementOpenEnabled then
        autoBasementOpenBtn.Text = "Auto BasementOpen: ON"
        autoBasementOpenBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        
        autoBasementOpenConnection = task.spawn(function()
            while autoBasementOpenEnabled do
                local args = {"Basement"}
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Door"):FireServer(unpack(args))
                task.wait(3)
            end
        end)
    else
        autoBasementOpenBtn.Text = "Auto BasementOpen: OFF"
        autoBasementOpenBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        if autoBasementOpenConnection then
            task.cancel(autoBasementOpenConnection)
            autoBasementOpenConnection = nil
        end
    end
end)

-- Вкладка SETTINGS
local tSettings = CreateTab("Settings")
local rainbowConnection = nil
local voidEnabled = false

local function UpdateTheme(color)
    MainFrame.BackgroundColor3 = color
    Header.BackgroundColor3 = color:lerp(Color3.new(0,0,0), 0.2)
    Side.BackgroundColor3 = color:lerp(Color3.new(0,0,0), 0.3)
end

local function SetVoidTheme(enabled)
    voidEnabled = enabled
    if enabled then
        MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
        Header.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
        Side.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
        for _, star in pairs(stars) do
            star.Visible = true
        end
    else
        for _, star in pairs(stars) do
            star.Visible = false
        end
    end
end

local themes = {
    {"Standard", Color3.fromRGB(25, 25, 25)},
    {"Blue", Color3.fromRGB(30, 60, 120)},
    {"Red", Color3.fromRGB(100, 30, 30)},
    {"Green", Color3.fromRGB(30, 80, 40)},
    {"Black", Color3.fromRGB(5, 5, 5)}
}

for _, theme in pairs(themes) do
    CreateButton(tSettings, theme[1], theme[2], function()
        if rainbowConnection then rainbowConnection:Disconnect() rainbowConnection = nil end
        SetVoidTheme(false)
        UpdateTheme(theme[2])
    end)
end

CreateButton(tSettings, "RAINBOW MODE", Color3.fromRGB(150, 50, 150), function()
    if rainbowConnection then 
        rainbowConnection:Disconnect() 
        rainbowConnection = nil 
        SetVoidTheme(false)
        UpdateTheme(Color3.fromRGB(25,25,25)) 
    else
        SetVoidTheme(false)
        rainbowConnection = RunService.RenderStepped:Connect(function()
            local hue = tick() % 5 / 5 
            local color = Color3.fromHSV(hue, 0.7, 0.6)
            UpdateTheme(color)
        end)
    end
end)

CreateButton(tSettings, "VOID", Color3.fromRGB(20, 20, 40), function()
    if rainbowConnection then rainbowConnection:Disconnect() rainbowConnection = nil end
    SetVoidTheme(not voidEnabled)
end)

allTabs["Info"].Visible = true
