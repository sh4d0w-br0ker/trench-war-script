-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local LeftPanel = Instance.new("Frame")
local RightPanel = Instance.new("Frame")
local LeftButtonContainer = Instance.new("Frame")
local LeftButtonList = Instance.new("UIListLayout")

-- Настройки отображения
ScreenGui.Name = "SpyNoteGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
MainFrame.Size = UDim2.new(0, 400, 0, 380)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TitleLabel.BorderSizePixel = 0
TitleLabel.Size = UDim2.new(0, 340, 0, 30)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = " SpyNote Exploit"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = MainFrame
MinimizeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(0, 340, 0, 0)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Text = "<"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16

CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(0, 370, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16

-- Левая панель
LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
LeftPanel.BorderSizePixel = 0
LeftPanel.Size = UDim2.new(0, 80, 1, -30)
LeftPanel.Position = UDim2.new(0, 0, 0, 30)

-- Правая панель
RightPanel.Name = "RightPanel"
RightPanel.Parent = MainFrame
RightPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
RightPanel.BorderSizePixel = 0
RightPanel.Size = UDim2.new(1, -85, 1, -35)
RightPanel.Position = UDim2.new(0, 85, 0, 35)

-- Контейнер для кнопок слева
LeftButtonContainer.Name = "LeftButtonContainer"
LeftButtonContainer.Parent = LeftPanel
LeftButtonContainer.BackgroundTransparency = 1
LeftButtonContainer.Size = UDim2.new(1, -8, 1, -8)
LeftButtonContainer.Position = UDim2.new(0, 4, 0, 4)

LeftButtonList.Name = "LeftButtonList"
LeftButtonList.Parent = LeftButtonContainer
LeftButtonList.Padding = UDim.new(0, 4)
LeftButtonList.SortOrder = Enum.SortOrder.LayoutOrder

-- Функция создания вкладок
local function createTab(tabName, displayName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Text = displayName or tabName
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.Parent = LeftButtonContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, -8, 1, -8)
    content.Position = UDim2.new(0, 4, 0, 4)
    content.BackgroundTransparency = 1
    content.Visible = false
    content.ScrollBarThickness = 3
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.Parent = RightPanel
    
    local contentList = Instance.new("UIListLayout")
    contentList.Parent = content
    contentList.Padding = UDim.new(0, 5)
    contentList.SortOrder = Enum.SortOrder.LayoutOrder
    
    btn.MouseButton1Click:Connect(function()
        for _, child in pairs(RightPanel:GetChildren()) do
            if child:IsA("ScrollingFrame") then
                child.Visible = false
            end
        end
        content.Visible = true
    end)
    
    return btn, content, contentList
end

-- Создание вкладок
local infoBtn, infoTab, infoList = createTab("Info", "Info")
local exploitBtn, exploitTab, exploitList = createTab("Exploit", "Exploit")
local farmBtn, farmTab, farmList = createTab("Farm", "Farm")
local boostBtn, boostTab, boostList = createTab("Boost", "Boost")
local teleportBtn, teleportTab, teleportList = createTab("Teleport", "Teleport")

-- По умолчанию показываем Info
infoTab.Visible = true

-- ==================== ВКЛАДКА INFO ====================
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 1, 0)
infoLabel.Text = "Create by SpyNote\n\nThanks for using this script"
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextSize = 18
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.BackgroundTransparency = 1
infoLabel.Parent = infoTab

-- ==================== ВКЛАДКА EXPLOIT ====================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local RocketEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("explodeRocket")
local BombEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("explodeBomb")

local isExploding = false
local isExplodingBomb = false
local loopConnection = nil
local loopConnectionBomb = nil

local function startSpamming()
    if loopConnection then loopConnection:Disconnect() end
    loopConnection = RunService.Heartbeat:Connect(function()
        if not isExploding then return end
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local myPos = character.HumanoidRootPart.Position
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            if backpack and backpack:FindFirstChild("Launcher") then
                local stats = backpack.Launcher:FindFirstChild("Stats")
                local boom = backpack.Launcher:FindFirstChild("Assets") and backpack.Launcher.Assets:FindFirstChild("Rocket") and backpack.Launcher.Assets.Rocket:FindFirstChild("Boom")
                if stats and boom then
                    local angle = math.random() * math.pi * 2
                    local radius = math.random() * 15
                    local offsetX = math.cos(angle) * radius
                    local offsetZ = math.sin(angle) * radius
                    local offsetY = (math.random() * 10) - 5
                    local targetPos = Vector3.new(myPos.X + offsetX, myPos.Y + offsetY, myPos.Z + offsetZ)
                    RocketEvent:FireServer(1786627148.7338, stats, targetPos, boom)
                end
            end
        end
    end)
end

local function startSpammingBomb()
    if loopConnectionBomb then loopConnectionBomb:Disconnect() end
    loopConnectionBomb = RunService.Heartbeat:Connect(function()
        if not isExplodingBomb then return end
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local myPos = character.HumanoidRootPart.Position
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            if backpack and backpack:FindFirstChild("Bomb") then
                local stats = backpack.Bomb:FindFirstChild("Stats")
                if stats then
                    local angle = math.random() * math.pi * 2
                    local radius = math.random() * 15
                    local offsetX = math.cos(angle) * radius
                    local offsetZ = math.sin(angle) * radius
                    local offsetY = (math.random() * 10) - 5
                    local targetPos = Vector3.new(myPos.X + offsetX, myPos.Y + offsetY, myPos.Z + offsetZ)
                    BombEvent:FireServer(1786628033.2256, stats, targetPos)
                end
            end
        end
    end)
end

local rocketBtn = Instance.new("TextButton")
rocketBtn.Size = UDim2.new(1, 0, 0, 40)
rocketBtn.Text = "Rocket-Sploit OFF"
rocketBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
rocketBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
rocketBtn.Font = Enum.Font.SourceSansBold
rocketBtn.TextSize = 14
rocketBtn.BorderSizePixel = 0
rocketBtn.Parent = exploitTab
Instance.new("UICorner", rocketBtn).CornerRadius = UDim.new(0, 6)

rocketBtn.MouseButton1Click:Connect(function()
    isExploding = not isExploding
    if isExploding then
        rocketBtn.Text = "Rocket-Sploit ON"
        rocketBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        rocketBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        startSpamming()
    else
        rocketBtn.Text = "Rocket-Sploit OFF"
        rocketBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        rocketBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if loopConnection then loopConnection:Disconnect() loopConnection = nil end
    end
end)

local bombBtn = Instance.new("TextButton")
bombBtn.Size = UDim2.new(1, 0, 0, 40)
bombBtn.Text = "Bomb-Sploit OFF"
bombBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
bombBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
bombBtn.Font = Enum.Font.SourceSansBold
bombBtn.TextSize = 14
bombBtn.BorderSizePixel = 0
bombBtn.Parent = exploitTab
Instance.new("UICorner", bombBtn).CornerRadius = UDim.new(0, 6)

bombBtn.MouseButton1Click:Connect(function()
    isExplodingBomb = not isExplodingBomb
    if isExplodingBomb then
        bombBtn.Text = "Bomb-Sploit ON"
        bombBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        bombBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        startSpammingBomb()
    else
        bombBtn.Text = "Bomb-Sploit OFF"
        bombBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        bombBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if loopConnectionBomb then loopConnectionBomb:Disconnect() loopConnectionBomb = nil end
    end
end)

-- ==================== ВКЛАДКА FARM ====================
local BoostEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("generateBoost")
local RankUpEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("rankUp")

local isBoosting = false
local isRankUp = false
local isRankAuto = false
local isMoneyAuto = false
local loopConnectionBoost = nil
local loopConnectionRankUp = nil
local loopConnectionRankAuto = nil
local loopConnectionMoneyAuto = nil

local boostBtn = Instance.new("TextButton")
boostBtn.Size = UDim2.new(1, 0, 0, 32)
boostBtn.Text = "Max-Level OFF"
boostBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
boostBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
boostBtn.Font = Enum.Font.SourceSansBold
boostBtn.TextSize = 13
boostBtn.BorderSizePixel = 0
boostBtn.Parent = farmTab
Instance.new("UICorner", boostBtn).CornerRadius = UDim.new(0, 6)

boostBtn.MouseButton1Click:Connect(function()
    isBoosting = not isBoosting
    if isBoosting then
        boostBtn.Text = "Max-Level ON"
        boostBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        boostBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        loopConnectionBoost = RunService.Heartbeat:Connect(function()
            if not isBoosting then return end
            BoostEvent:FireServer("Levels", 180, 5)
        end)
    else
        boostBtn.Text = "Max-Level OFF"
        boostBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        boostBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if loopConnectionBoost then loopConnectionBoost:Disconnect() loopConnectionBoost = nil end
    end
end)

local rankUpBtn = Instance.new("TextButton")
rankUpBtn.Size = UDim2.new(1, 0, 0, 32)
rankUpBtn.Text = "RankUp OFF"
rankUpBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
rankUpBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
rankUpBtn.Font = Enum.Font.SourceSansBold
rankUpBtn.TextSize = 13
rankUpBtn.BorderSizePixel = 0
rankUpBtn.Parent = farmTab
Instance.new("UICorner", rankUpBtn).CornerRadius = UDim.new(0, 6)

rankUpBtn.MouseButton1Click:Connect(function()
    isRankUp = not isRankUp
    if isRankUp then
        rankUpBtn.Text = "RankUp ON"
        rankUpBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        rankUpBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        loopConnectionRankUp = RunService.Heartbeat:Connect(function()
            if not isRankUp then return end
            RankUpEvent:FireServer()
        end)
    else
        rankUpBtn.Text = "RankUp OFF"
        rankUpBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        rankUpBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if loopConnectionRankUp then loopConnectionRankUp:Disconnect() loopConnectionRankUp = nil end
    end
end)

local rankAutoBtn = Instance.new("TextButton")
rankAutoBtn.Size = UDim2.new(1, 0, 0, 32)
rankAutoBtn.Text = "Rank-Auto OFF"
rankAutoBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
rankAutoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
rankAutoBtn.Font = Enum.Font.SourceSansBold
rankAutoBtn.TextSize = 13
rankAutoBtn.BorderSizePixel = 0
rankAutoBtn.Parent = farmTab
Instance.new("UICorner", rankAutoBtn).CornerRadius = UDim.new(0, 6)

rankAutoBtn.MouseButton1Click:Connect(function()
    isRankAuto = not isRankAuto
    if isRankAuto then
        rankAutoBtn.Text = "Rank-Auto ON"
        rankAutoBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        rankAutoBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        loopConnectionRankAuto = task.spawn(function()
            while isRankAuto do
                for i = 1, 10 do
                    if not isRankAuto then break end
                    BoostEvent:FireServer("Levels", 180, 5)
                    task.wait(0.1)
                end
                if not isRankAuto then break end
                task.wait(6)
                if not isRankAuto then break end
                RankUpEvent:FireServer()
                task.wait(6)
            end
        end)
    else
        rankAutoBtn.Text = "Rank-Auto OFF"
        rankAutoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        rankAutoBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if loopConnectionRankAuto then task.cancel(loopConnectionRankAuto) loopConnectionRankAuto = nil end
    end
end)

-- Money-Auto
local moneyAutoBtn = Instance.new("TextButton")
moneyAutoBtn.Size = UDim2.new(1, 0, 0, 32)
moneyAutoBtn.Text = "Money-Auto OFF"
moneyAutoBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
moneyAutoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
moneyAutoBtn.Font = Enum.Font.SourceSansBold
moneyAutoBtn.TextSize = 13
moneyAutoBtn.BorderSizePixel = 0
moneyAutoBtn.Parent = farmTab
Instance.new("UICorner", moneyAutoBtn).CornerRadius = UDim.new(0, 6)

moneyAutoBtn.MouseButton1Click:Connect(function()
    isMoneyAuto = not isMoneyAuto
    if isMoneyAuto then
        moneyAutoBtn.Text = "Money-Auto ON"
        moneyAutoBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        moneyAutoBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        loopConnectionMoneyAuto = RunService.Heartbeat:Connect(function()
            if not isMoneyAuto then return end
            BoostEvent:FireServer("Coins", 1000, 99999999)
        end)
    else
        moneyAutoBtn.Text = "Money-Auto OFF"
        moneyAutoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        moneyAutoBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if loopConnectionMoneyAuto then loopConnectionMoneyAuto:Disconnect() loopConnectionMoneyAuto = nil end
    end
end)

-- ==================== ВКЛАДКА BOOST ====================
local function createBoostButton(parent, text, color, boostType, value1, value2)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = color
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        local Event = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("generateBoost")
        Event:FireServer(boostType, value1, value2)
    end)
    
    return btn
end

-- Кнопки Boost
createBoostButton(boostTab, "💰 99M Give Money", Color3.fromRGB(255, 215, 0), "Coins", 1000, 99999999)
createBoostButton(boostTab, "🪙 1M Give Money", Color3.fromRGB(255, 180, 50), "Coins", 1000, 1000000)
createBoostButton(boostTab, "⚡ SuperJump Give", Color3.fromRGB(100, 200, 255), "SuperJump", 600, 2)
createBoostButton(boostTab, "🧱 BrickBoost Give", Color3.fromRGB(200, 150, 100), "BrickBoost", 900000, 9)
createBoostButton(boostTab, "📈 XPBoost Give", Color3.fromRGB(150, 100, 200), "XPBoost", 900000, 9000)
createBoostButton(boostTab, "⭐ Levels Give", Color3.fromRGB(100, 200, 100), "Levels", 300, 5)
createBoostButton(boostTab, "🪙 CoinBoost Give", Color3.fromRGB(255, 200, 100), "CoinBoost", 9999999, 9999999)

-- ==================== ВКЛАДКА TELEPORT ====================
local teleportLocations = {
    {name = "Rank-locate 1", cframe = CFrame.new(167.458801, 3.99999952, -461.267822, -0.0205902141, 1.03945247e-07, -0.999787986, -9.05540265e-09, 1, 1.04153784e-07, 0.999787986, 1.11980318e-08, -0.0205902141)},
    {name = "Rank-locate 2", cframe = CFrame.new(187.101135, 4, -790.899902, 0.0867438689, -9.12409561e-08, -0.996230662, -4.25562696e-08, 1, -9.52916395e-08, 0.996230662, 5.0661825e-08, 0.0867438689)},
    {name = "Rank-locate 3", cframe = CFrame.new(-203.430862, 3.99999952, -774.396729, -0.391095996, 9.35421411e-08, 0.920349896, -6.77780748e-11, 1, -1.01666387e-07, -0.920349896, -3.98236963e-08, -0.391095996)},
    {name = "Rank-locate 4", cframe = CFrame.new(166.218277, 3.99999976, -1064.69727, -0.621202469, -4.3991605e-08, 0.7836501, 9.389165e-10, 1, 5.68810741e-08, -0.7836501, 3.60704462e-08, -0.621202469)},
    {name = "Rank-locate 5", cframe = CFrame.new(-181.670471, 4, -1035.18848, 0.704589069, 4.3971621e-08, 0.709615529, -7.2299069e-09, 1, -5.47867209e-08, -0.709615529, 3.34716717e-08, 0.704589069)},
    {name = "Rank-locate 6", cframe = CFrame.new(-206.904831, 5.00000334, -439.515991, 0.182909459, 1.14718695e-07, 0.98312974, -9.29889623e-08, 1, -9.9386817e-08, -0.98312974, -7.32414307e-08, 0.182909459)},
    {name = "Rank-locate 10", cframe = CFrame.new(123.108238, 4.91997194, -117.154259, -0.347524792, -5.69058045e-08, 0.937670767, 1.57439946e-08, 1, 6.65235973e-08, -0.937670767, 3.78812821e-08, -0.347524792)},
    {name = "Rank-locate 15", cframe = CFrame.new(-219.853165, 3.99999976, -161.199127, 0.643851399, -6.43128573e-08, 0.765150547, -3.60351891e-08, 1, 1.14375091e-07, -0.765150547, -1.01212905e-07, 0.643851399)},
    {name = "Rank-locate 20", cframe = CFrame.new(73.9177704, 3.99999952, 146.812759, -0.269838154, 1.30406344e-08, -0.962905705, 6.04557071e-09, 1, 1.1848833e-08, 0.962905705, -2.62404742e-09, -0.269838154)},
    {name = "Rank-locate 25", cframe = CFrame.new(-156.812469, 3.99999952, 162.209518, 0.310643882, 3.89508479e-08, 0.950526357, -8.39437178e-08, 1, -1.35443337e-08, -0.950526357, -7.55832517e-08, 0.310643882)},
    {name = "Rank-locate 30", cframe = CFrame.new(95.0631409, 3.99991775, 451.948761, 0.118211098, 9.62520446e-08, -0.992988467, -1.91280503e-09, 1, 9.67039711e-08, 0.992988467, -9.53208978e-09, 0.118211098)},
    {name = "Rank-locate 35", cframe = CFrame.new(-199.268753, 76.0099945, 445.830933, 0.336052507, -3.70056128e-08, 0.941843271, 8.53661248e-08, 1, 8.83173978e-09, -0.941843271, 7.7433576e-08, 0.336052507)},
    {name = "Rank-locate 40", cframe = CFrame.new(84.2065659, 4, 742.238708, 0.427007765, 7.82616922e-08, -0.90424794, 1.23969466e-08, 1, 9.24030701e-08, 0.90424794, -5.06667419e-08, 0.427007765)},
    {name = "Rank-locate 45", cframe = CFrame.new(-213.870026, 13.1399422, 752.287537, 0.00968265999, 1.24771526e-08, 0.999953151, -1.06153459e-08, 1, -1.23749482e-08, -0.999953151, -1.04950253e-08, 0.00968265999)},
    {name = "Rank-locate 50", cframe = CFrame.new(221.550461, 154.000107, 1093.78088, -0.451885819, -1.04366343e-07, -0.892075777, 1.13528982e-08, 1, -1.22743558e-07, 0.892075777, -6.55937171e-08, -0.451885819)},
    {name = "Rank-locate 55", cframe = CFrame.new(-293.905273, 131.204086, 1093.3064, 0.102143332, -6.50763354e-08, 0.994769692, 7.20758564e-08, 1, 5.80177222e-08, -0.994769692, 6.57727597e-08, 0.102143332)}
}

for _, loc in ipairs(teleportLocations) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 28)
    btn.Text = loc.name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 11
    btn.BorderSizePixel = 0
    btn.Parent = teleportTab
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = loc.cframe
        end
    end)
end

-- Сворачивание
local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 400, 0, 30), "Out", "Quad", 0.2, true)
        LeftPanel.Visible = false
        RightPanel.Visible = false
        MinimizeButton.Text = ">"
    else
        MainFrame:TweenSize(UDim2.new(0, 400, 0, 380), "Out", "Quad", 0.2, true)
        LeftPanel.Visible = true
        RightPanel.Visible = true
        MinimizeButton.Text = "<"
    end
end)

-- Закрытие
CloseButton.MouseButton1Click:Connect(function()
    isExploding = false
    isExplodingBomb = false
    isBoosting = false
    isRankUp = false
    isRankAuto = false
    isMoneyAuto = false
    if loopConnection then loopConnection:Disconnect() end
    if loopConnectionBomb then loopConnectionBomb:Disconnect() end
    if loopConnectionBoost then loopConnectionBoost:Disconnect() end
    if loopConnectionRankUp then loopConnectionRankUp:Disconnect() end
    if loopConnectionRankAuto then task.cancel(loopConnectionRankAuto) end
    if loopConnectionMoneyAuto then loopConnectionMoneyAuto:Disconnect() end
    ScreenGui:Destroy()
end)

-- Делаем первую вкладку активной
infoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
infoBtn.TextColor3 = Color3.new(1, 1, 1)
