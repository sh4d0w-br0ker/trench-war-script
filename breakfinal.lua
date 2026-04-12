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
MainFrame.Size = UDim2.new(0, 350, 0, 380)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -190)
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
    star.Size = UDim2.new(0, math.random(1, 2), 0, math.random(1, 2))                  star.Position = UDim2.new(math.random(), 0, math.random(), 0)
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
        MainFrame:TweenSize(UDim2.new(0, 350, 0, 380), "Out", "Quad", 0.2, true)
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

CreateButton(tLobby, "Get Fighter", Color3.fromRGB(90, 70, 10), function()
    RS.RemoteEvents.OutsideRole:FireServer("Sword", true)
end)

CreateButton(tLobby, "Get Hungry", Color3.fromRGB(150, 80, 90), function()
    RS.RemoteEvents.OutsideRole:FireServer("Chips", true)
end)

CreateButton(tLobby, "Get Medic", Color3.fromRGB(200, 87, 100), function()
    RS.RemoteEvents.OutsideRole:FireServer("MedKit", true)
end)

CreateButton(tLobby, "Get batuser", Color3.fromRGB(99, 100, 70), function()
    RS.RemoteEvents.OutsideRole:FireServer("Bat", true)
end)

CreateButton(tLobby, "Get LollipopUser", Color3.fromRGB(40, 40, 40), function()
    RS.RemoteEvents.OutsideRole:FireServer("Lollipop", true)
end)

CreateButton(tLobby, "Get Guest", Color3.fromRGB(100, 90, 100), function()
    RS.RemoteEvents.OutsideRole:FireServer("LinkedSword", true)
end)

CreateButton(tLobby, "Get Stealthy", Color3.fromRGB(90, 200, 40), function()
    RS.RemoteEvents.OutsideRole:FireServer("TeddyBloxpin", true)
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
CreateButton(tUser, "Get EpicPizza", Color3.fromRGB(77, 100, 89), function() GetTool("EpicPizza") end)

local foodItems = {
    {"Apple", Color3.fromRGB(200, 50, 50)},
    {"Cookie", Color3.fromRGB(150, 100, 50)},
    {"Chips", Color3.fromRGB(200, 150, 50)},
    {"BloxyCola", Color3.fromRGB(50, 50, 200)}
}
for _, item in pairs(foodItems) do
    CreateButton(tUser, "Get "..item[1], item[2], function() GetTool(item[1]) end)
end

-- ===== ВКЛАДКА ITEMS =====
local tItems = CreateTab("Items")

-- Только предметы (без еды)
local itemsList = {
    {"Key", Color3.fromRGB(30, 50, 25)},
    {"CarKey", Color3.fromRGB(255, 220, 50)},
    {"Plank", Color3.fromRGB(160, 110, 60)},
    {"TeddyBloxpin", Color3.fromRGB(150, 100, 200)},
    {"Cure", Color3.fromRGB(100, 255, 180)},
    {"MedKit", Color3.fromRGB(50, 150, 50)}
}

for _, item in pairs(itemsList) do
    CreateButton(tItems, "Get "..item[1], item[2], function()
        RS.RemoteEvents.GiveTool:FireServer(item[1])
    end)
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

CreateButton(tWeapons, "Get Broom", Color3.fromRGB(150, 10, 89), function()
    game.ReplicatedStorage.RemoteEvents.BasementWeapon:FireServer(true, "Broom")
end)

CreateButton(tWeapons, "Get Breaker", Color3.fromRGB(250, 70, 99), function()
    game.ReplicatedStorage.RemoteEvents.BasementWeapon:FireServer(true, "Breaker")
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
addTPButton("larry House", CFrame.new(-1805.54561, 4961.04932, -2426.79102, -0.98962009, 3.316136293-09, -0.143708378, 1.78976622e-09, 1, 1.075058e-08, 0.143708378, 1.03817852e-08, -0.98962009))
addTPButton("Auto park", CFrame.new(-3113.70776, 1418.43811, -1972.401, -0.472113997, 0.303905189, -0.827496231, -3.9409386e-08, 0.938696563, 0.344744503, 0.881537497, 0.162758738, -0.443171769))
addTPButton("Load players", CFrame.new(-1214.32019, 13.7232265, -79.6718445, 0.919825017, 0.14922373, -0.362841815, -8.02136313e-09, 0.924841106, 0.380353689, 0.392328829, -0.34985885, 0.850691974))

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

-- Padlock find
local padlockBtn = CreateButton(tMisc, "PadlockFound", Color3.fromRGB(200, 100, 50), function()
    local args = {game:GetService("Players"):WaitForChild(Player.Name)}
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("PadlockDetector"):FireServer(unpack(args))
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
    local RS = game:GetService("ReplicatedStorage")
    local remote = RS:WaitForChild("RemoteEvents"):WaitForChild("AddIngredient")

    local function clearBackpack()
        local backpack = Player:WaitForChild("Backpack")
        local tools = {}

        -- собираем имена
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") then
                table.insert(tools, tool.Name)
            end
        end

        -- отправляем евенты
        for _, name in ipairs(tools) do
            local args = {name}
            remote:FireServer(unpack(args))
        end

        return #tools
    end

    task.spawn(function()
        while true do
            local count = clearBackpack()
            if count == 0 then break end
            task.wait(0.3)
        end
    end)
end)

-- Auto OpenFront Toggle
local autoOpenFrontEnabled = false
local autoOpenFrontBtn = CreateButton(tMisc, "Auto OpenFront: OFF", Color3.fromRGB(70, 70, 70), function() end)

autoOpenFrontBtn.MouseButton1Click:Connect(function()
    autoOpenFrontEnabled = not autoOpenFrontEnabled

    if autoOpenFrontEnabled then
        autoOpenFrontBtn.Text = "Auto OpenFront: ON"
        autoOpenFrontBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)

        task.spawn(function()
            while autoOpenFrontEnabled do
                local args = {"Front"}
                game:GetService("ReplicatedStorage")
                    :WaitForChild("RemoteEvents")
                    :WaitForChild("Door")
                    :FireServer(unpack(args))

                task.wait(2) -- теперь 2 секунды как ты хотел
            end
        end)

    else
        autoOpenFrontBtn.Text = "Auto OpenFront: OFF"
        autoOpenFrontBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end
end)

-- Open Basement Button
CreateButton(tMisc, "Open Basement", Color3.fromRGB(100, 80, 200), function()
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("UnlockDoor"):FireServer()
end)

-- ScaryLarry End Button (GetKeys + CarEnding)
CreateButton(tMisc, "ScaryLarry End", Color3.fromRGB(180, 50, 180), function()
    local RS = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents")
    RS:WaitForChild("GetKeys"):FireServer()
    task.wait(0.1)
    RS:WaitForChild("CarEnding"):FireServer()
    ShowNotification("ScaryLarry End triggered! (GetKeys + CarEnding)", false)
end)


-- Turn on basement Button
CreateButton(tMisc, "Turn on basement", Color3.fromRGB(80, 150, 80), function()
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("BasementMission"):FireServer()
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

-- Heal All Button
local healAllBtn = CreateButton(tMisc, "Heal All", Color3.fromRGB(50, 150, 100), function()
    task.spawn(function()
        -- Выдаем два MedKit
        for i = 1, 2 do
            game:GetService("ReplicatedStorage").RemoteEvents.GiveTool:FireServer("MedKit")
            task.wait(0.1)
        end
        
        -- Ждем появления MedKit в инвентаре
        task.wait(0.5)
        
        -- Получаем список всех игроков
        local allPlayers = {}
        for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
            if plr ~= Player then
                table.insert(allPlayers, plr)
            end
        end
        
        -- Перемешиваем список
        for i = #allPlayers, 2, -1 do
            local j = math.random(i)
            allPlayers[i], allPlayers[j] = allPlayers[j], allPlayers[i]
        end
        
        -- Берем первых 6 (или сколько есть)
        local healList = {}
        for i = 1, math.min(6, #allPlayers) do
            table.insert(healList, allPlayers[i])
        end
        
        -- Запоминаем кого уже лечили
        local healed = {}
        
        -- Достаем MedKit из инвентаря
        local backpack = Player.Backpack
        local medKits = {}
        
        -- Собираем все MedKit
        for _, tool in pairs(backpack:GetChildren()) do
            if tool.Name == "MedKit" then
                table.insert(medKits, tool)
            end
        end
        
        -- Лечим каждым MedKit
        for kitIndex, medKit in pairs(medKits) do
            if kitIndex > 2 then break end -- только два MedKit
            
            -- Экипируем MedKit
            local argsEquip = {"Equip", medKit}
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("BackpackEvent"):FireServer(unpack(argsEquip))
            task.wait(0.2)
            
            -- Лечим игроков (каждым MedKit лечим тех, кого еще не лечили)
            local toHeal = {}
            for _, plr in pairs(healList) do
                if not healed[plr.Name] then
                    table.insert(toHeal, plr)
                    healed[plr.Name] = true
                    if #toHeal >= 6 then break end
                end
            end
            
            -- Если некого лечить, выходим
            if #toHeal == 0 then break end
            
            -- Лечим выбранных игроков
            for _, plr in pairs(toHeal) do
                local healArgs = {plr}
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("HealPlayer"):FireServer(unpack(healArgs))
                task.wait(0.05)
            end
            
            -- Снимаем MedKit (дропаем)
            local dropArgs = {medKit.Name}
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("AddIngredient"):FireServer(unpack(dropArgs))
            task.wait(0.1)
        end
        
        ShowNotification("Healed " .. #healList .. " players!", false)
    end)
end)

-- Find safe
CreateButton(tMisc, "Find Safe", Color3.fromRGB(120, 120, 200), function()
    local house = workspace:FindFirstChild("TheHouse")
    if not house then return end

    for _, obj in pairs(house:GetDescendants()) do
        if obj.Name == "Painting" then

            local click = obj:FindFirstChildOfClass("ClickDetector")
            if click then

                local startTime = tick()

                while tick() - startTime < 3 do
                    fireclickdetector(click)
                    task.wait() -- максимально быстро (каждый кадр)
                end

            end
        end
    end
end)

-- open safe
CreateButton(tMisc, "Open Safe", Color3.fromRGB(200, 150, 50), function()
    local codeNote = workspace:FindFirstChild("CodeNote")
    if not codeNote then return end

    local gui = codeNote:FindFirstChild("SurfaceGui")
    if not gui then return end

    local label = gui:FindFirstChild("TextLabel")
    if not label then return end

    local code = label.Text
    if not code or code == "" then return end

    -- отправляем код в сервер
    game:GetService("ReplicatedStorage")
        :WaitForChild("RemoteEvents")
        :WaitForChild("Safe")
        :FireServer(code)
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

-- instant slip
CreateButton(tMisc, "Instant Slip", Color3.fromRGB(100, 180, 255), function()
    local args = {
        Vector3.new(2.182706832885742, 13.64895248413086, -107.35334777832031)
    }

    game:GetService("ReplicatedStorage")
        :WaitForChild("RemoteEvents")
        :WaitForChild("IceSlip")
       :FireServer(unpack(args))
end)

-- Auto bedHeal
local bedHealEnabled = false
local bedHealConnection = nil

local bedHealBtn = CreateButton(tMisc, "Auto BedHeal: OFF", Color3.fromRGB(70, 70, 70), function() end)

bedHealBtn.MouseButton1Click:Connect(function()
    bedHealEnabled = not bedHealEnabled

    if bedHealEnabled then
        bedHealBtn.Text = "Auto BedHeal: ON"
        bedHealBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)

        bedHealConnection = task.spawn(function()
            while bedHealEnabled do
                game:GetService("ReplicatedStorage")
                    :WaitForChild("RemoteEvents")
                    :WaitForChild("BedTime")
                    :FireServer()

                task.wait() -- спам каждый кадр (почти)
            end
        end)
    else
        bedHealBtn.Text = "Auto BedHeal: OFF"
        bedHealBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)

        if bedHealConnection then
            task.cancel(bedHealConnection)
            bedHealConnection = nil
        end
    end
end)

-- Click Painting2
local clickPaintingEnabled = false

local clickPaintingBtn = CreateButton(tMisc, "ClickpaintingCat: OFF", Color3.fromRGB(70, 70, 70), function() end)

clickPaintingBtn.MouseButton1Click:Connect(function()
    clickPaintingEnabled = not clickPaintingEnabled

    if clickPaintingEnabled then
        clickPaintingBtn.Text = "ClickpaintingCat: ON"
        clickPaintingBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)

        task.spawn(function()
            while clickPaintingEnabled do
                local house = workspace:FindFirstChild("TheHouse")
                local painting = house and house:FindFirstChild("Painting2")
                local clickDetector = painting and painting:FindFirstChild("ClickDetector")

                if clickDetector then
                    fireclickdetector(clickDetector)
                end

                task.wait(0.1)
            end
        end)

    else
        clickPaintingBtn.Text = "ClickpaintingCat: OFF"
        clickPaintingBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end
end)

-- CatSpam Toggle
local catSpamEnabled = false
local catSpamBtn = CreateButton(tMisc, "CatSpam: OFF", Color3.fromRGB(70, 70, 70), function() end)

catSpamBtn.MouseButton1Click:Connect(function()
    catSpamEnabled = not catSpamEnabled
    if catSpamEnabled then
        catSpamBtn.Text = "CatSpam: ON"
        catSpamBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        task.spawn(function()
            while catSpamEnabled do
                game:GetService("ReplicatedStorage").RemoteEvents.Cattery:FireServer()
                task.wait(0.2)
            end
        end)
    else
        catSpamBtn.Text = "CatSpam: OFF"
        catSpamBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end
end)

-- MOUSE Spam
local getKeysSpamEnabled = false
local getKeysSpamBtn = CreateButton(tMisc, "GetKeys Spam: OFF", Color3.fromRGB(70, 70, 70), function() end)

getKeysSpamBtn.MouseButton1Click:Connect(function()
    getKeysSpamEnabled = not getKeysSpamEnabled
    if getKeysSpamEnabled then
        getKeysSpamBtn.Text = "Mouse Spam: ON"
        getKeysSpamBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        task.spawn(function()
            while getKeysSpamEnabled do
                game:GetService("ReplicatedStorage").RemoteEvents.GetKeys:FireServer()
                task.wait(0.2)
            end
        end)
    else
        getKeysSpamBtn.Text = "Mouse Spam: OFF"
        getKeysSpamBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end
end)


-- PieinfinityHeal Toggle
local pieHealEnabled = false
local pieHealBtn = CreateButton(tMisc, "PieinfinityHeal: OFF", Color3.fromRGB(70, 70, 70), function() end)

pieHealBtn.MouseButton1Click:Connect(function()
    pieHealEnabled = not pieHealEnabled
    if pieHealEnabled then
        pieHealBtn.Text = "PieinfinityHeal: ON"
        pieHealBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        task.spawn(function()
            while pieHealEnabled do
                local args = {false, 1, math.huge, false}
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("EatPie"):FireServer(unpack(args))
                task.wait(0.1)
            end
        end)
    else
        pieHealBtn.Text = "PieinfinityHeal: OFF"
        pieHealBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end
end)

-- Kill Me Button
CreateButton(tMisc, "Kill Me", Color3.fromRGB(180, 50, 50), function()
    local args = {-math.huge}
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Energy"):FireServer(unpack(args))
end)

-- ===== ВКЛАДКА ENERGY =====
local tEnergy = CreateTab("Energy")

-- Секция для управления энергией
local energySection = Instance.new("Frame")
energySection.Size = UDim2.new(1, -10, 0, 100)
energySection.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
energySection.BackgroundTransparency = 0.3
energySection.BorderSizePixel = 0
energySection.Parent = tEnergy

local energyCorner = Instance.new("UICorner", energySection)
energyCorner.CornerRadius = UDim.new(0, 8)

-- Заголовок
local energyTitle = Instance.new("TextLabel")
energyTitle.Text = "Energy Control"
energyTitle.Font = Enum.Font.GothamBold
energyTitle.TextSize = 13
energyTitle.TextColor3 = Color3.fromRGB(200, 200, 220)
energyTitle.BackgroundTransparency = 1
energyTitle.Size = UDim2.new(1, -15, 0, 25)
energyTitle.Position = UDim2.new(0, 10, 0, 5)
energyTitle.TextXAlignment = Enum.TextXAlignment.Left
energyTitle.Parent = energySection

-- Поле ввода
local energyBox = Instance.new("TextBox")
energyBox.Size = UDim2.new(1, -20, 0, 35)
energyBox.Position = UDim2.new(0, 10, 0, 35)
energyBox.PlaceholderText = "Enter number..."
energyBox.Text = "200"
energyBox.Font = Enum.Font.Gotham
energyBox.TextSize = 12
energyBox.TextColor3 = Color3.new(1,1,1)
energyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
energyBox.BorderSizePixel = 0
energyBox.Parent = energySection

local boxCorner = Instance.new("UICorner", energyBox)
boxCorner.CornerRadius = UDim.new(0, 6)

-- Кнопка Minus Energy
local minusBtn = Instance.new("TextButton")
minusBtn.Size = UDim2.new(1, -20, 0, 35)
minusBtn.Position = UDim2.new(0, 10, 0, 75)
minusBtn.Text = "Minus Energy"
minusBtn.Font = Enum.Font.GothamSemibold
minusBtn.TextSize = 12
minusBtn.TextColor3 = Color3.new(1,1,1)
minusBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
minusBtn.BorderSizePixel = 0
minusBtn.Parent = energySection

local btnCorner = Instance.new("UICorner", minusBtn)
btnCorner.CornerRadius = UDim.new(0, 6)

minusBtn.MouseButton1Click:Connect(function()
    local num = tonumber(energyBox.Text)
    if num then
        local args = {-num}
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Energy"):FireServer(unpack(args))
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
