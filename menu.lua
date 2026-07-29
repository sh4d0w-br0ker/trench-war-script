-- Trench War Script | Enhanced Menu
-- Original by sh4d0w-br0ker | Modified by Spynote

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Удаление старой копии
if CoreGui:FindFirstChild("TrenchWarMenu") then
    CoreGui.TrenchWarMenu:Destroy()
end

-- Глобальные переменные
local Enabled = false
local Connection = nil
local CurrentTheme = "default"
local RainbowConnection = nil

-- Основной GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui
ScreenGui.Name = "TrenchWarMenu"
ScreenGui.ResetOnSpawn = false

-- Главное окно
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 600, 0, 400)
Main.Position = UDim2.new(0.5, -300, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 8)

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1, -50, 0, 35)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.Text = "Trench War Script"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопка сворачивания
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = Main
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -65, 0, 5)
MinBtn.Text = "−"
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
local MinCorner = Instance.new("UICorner", MinBtn)
MinCorner.CornerRadius = UDim.new(0, 4)

-- Кнопка закрытия
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Main
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, 4)

-- Контейнер для контента
local Content = Instance.new("Frame")
Content.Parent = Main
Content.Size = UDim2.new(1, 0, 1, -45)
Content.Position = UDim2.new(0, 0, 1, -5)
Content.BackgroundTransparency = 1

-- Панель вкладок (слева)
local TabPanel = Instance.new("Frame")
TabPanel.Parent = Content
TabPanel.Size = UDim2.new(0, 120, 1, 0)
TabPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TabPanel.BorderSizePixel = 0
local TabPanelCorner = Instance.new("UICorner", TabPanel)
TabPanelCorner.CornerRadius = UDim.new(0, 6)

-- Список вкладок
local TabList = Instance.new("UIListLayout")
TabList.Parent = TabPanel
TabList.Padding = UDim.new(0, 5)
TabList.SortOrder = Enum.SortOrder.LayoutOrder

-- Панель отображения (справа)
local DisplayPanel = Instance.new("Frame")
DisplayPanel.Parent = Content
DisplayPanel.Size = UDim2.new(1, -130, 1, 0)
DisplayPanel.Position = UDim2.new(0, 125, 0, 0)
DisplayPanel.BackgroundTransparency = 1

-- Функция создания вкладки
local function createTab(name, displayName)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Parent = TabPanel
    tabBtn.Size = UDim2.new(1, -10, 0, 35)
    tabBtn.Position = UDim2.new(0, 5, 0, 0)
    tabBtn.Text = displayName or name
    tabBtn.TextColor3 = Color3.new(1, 1, 1)
    tabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 16
    local tabCorner = Instance.new("UICorner", tabBtn)
    tabCorner.CornerRadius = UDim.new(0, 4)
    
    local tabContent = Instance.new("Frame")
    tabContent.Parent = DisplayPanel
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    
    -- Список для содержимого вкладки
    local contentList = Instance.new("UIListLayout")
    contentList.Parent = tabContent
    contentList.Padding = UDim.new(0, 8)
    contentList.SortOrder = Enum.SortOrder.LayoutOrder
    
    local padding = Instance.new("UIPadding")
    padding.Parent = tabContent
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, child in pairs(DisplayPanel:GetChildren()) do
            if child:IsA("Frame") then
                child.Visible = false
            end
        end
        tabContent.Visible = true
    end)
    
    return tabBtn, tabContent, contentList
end

-- Создание вкладок
local infoBtn, infoTab, infoList = createTab("Info", "ℹ Info")
local killBtn, killTab, killList = createTab("Kill", "🗡 Kill")
local getBtn, getTab, getList = createTab("Get", "📦 Get")
local mortarBtn, mortarTab, mortarList = createTab("Mortar", "💥 Mortar")
local exploitBtn, exploitTab, exploitList = createTab("Exploit", "⚡ Exploit")
local settingsBtn, settingsTab, settingsList = createTab("Settings", "⚙ Settings")

-- По умолчанию показываем Info
infoTab.Visible = true

-- ==================== ВКЛАДКА INFO ====================
local infoLabel = Instance.new("TextLabel")
infoLabel.Parent = infoTab
infoLabel.Size = UDim2.new(1, 0, 0, 80)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "Create By Spynote\nenter the name in script blox\nThanks for using this script"
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 18
infoLabel.TextYAlignment = Enum.TextYAlignment.Top

-- ==================== ВКЛАДКА KILL ====================
-- Поле ввода ника
local TargetInput = Instance.new("TextBox")
TargetInput.Parent = killTab
TargetInput.Size = UDim2.new(1, 0, 0, 30)
TargetInput.PlaceholderText = "Target Username..."
TargetInput.Text = ""
TargetInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TargetInput.TextColor3 = Color3.new(1, 1, 1)
TargetInput.Font = Enum.Font.Gotham
TargetInput.TextSize = 16
local TargetCorner = Instance.new("UICorner", TargetInput)
TargetCorner.CornerRadius = UDim.new(0, 4)

-- Список игроков
local PlayerListFrame = Instance.new("ScrollingFrame")
PlayerListFrame.Parent = killTab
PlayerListFrame.Size = UDim2.new(1, 0, 0, 100)
PlayerListFrame.BackgroundTransparency = 1
PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerListFrame.ScrollBarThickness = 3
local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = PlayerListFrame
ListLayout.Padding = UDim.new(0, 3)

-- Кнопка Kill Player
local KillBtn = Instance.new("TextButton")
KillBtn.Parent = killTab
KillBtn.Size = UDim2.new(1, 0, 0, 35)
KillBtn.Text = "🔫 Kill Player"
KillBtn.BackgroundColor3 = Color3.fromRGB(46, 139, 87)
KillBtn.TextColor3 = Color3.new(1, 1, 1)
KillBtn.Font = Enum.Font.GothamBold
KillBtn.TextSize = 16
local KillCorner = Instance.new("UICorner", KillBtn)
KillCorner.CornerRadius = UDim.new(0, 4)

-- Кнопка Kill All
local KillAllBtn = Instance.new("TextButton")
KillAllBtn.Parent = killTab
KillAllBtn.Size = UDim2.new(1, 0, 0, 35)
KillAllBtn.Text = "💀 Kill All"
KillAllBtn.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
KillAllBtn.TextColor3 = Color3.new(1, 1, 1)
KillAllBtn.Font = Enum.Font.GothamBold
KillAllBtn.TextSize = 16
local KillAllCorner = Instance.new("UICorner", KillAllBtn)
KillAllCorner.CornerRadius = UDim.new(0, 4)

-- Кнопка Aura
local AuraBtn = Instance.new("TextButton")
AuraBtn.Parent = killTab
AuraBtn.Size = UDim2.new(1, 0, 0, 35)
AuraBtn.Text = "🌀 Aura: OFF"
AuraBtn.BackgroundColor3 = Color3.fromRGB(75, 0, 130)
AuraBtn.TextColor3 = Color3.new(1, 1, 1)
AuraBtn.Font = Enum.Font.GothamBold
AuraBtn.TextSize = 16
local AuraCorner = Instance.new("UICorner", AuraBtn)
AuraCorner.CornerRadius = UDim.new(0, 4)

-- ==================== ВКЛАДКА GET ====================
-- Функция создания кнопки получения оружия
local function createGetWeaponButton(parent, weaponName, displayName)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Text = "📥 Get " .. (displayName or weaponName)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 4)
    return btn
end

local weapons = {
    {name = "Thompson", display = "Thompson"},
    {name = "Mortar", display = "Mortar"},
    {name = "M1Garand", display = "M1 Garand"},
    {name = "Machine Gun", display = "Machine Gun"},
    {name = "Sniper", display = "Sniper"}
}

local getButtons = {}
for _, w in pairs(weapons) do
    local btn = createGetWeaponButton(getTab, w.name, w.display)
    getButtons[w.name] = btn
end

-- ==================== ВКЛАДКА MORTAR ====================
-- Поле ввода ника для миномета
local MortarTargetInput = Instance.new("TextBox")
MortarTargetInput.Parent = mortarTab
MortarTargetInput.Size = UDim2.new(1, 0, 0, 30)
MortarTargetInput.PlaceholderText = "Target Username (partial)..."
MortarTargetInput.Text = ""
MortarTargetInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MortarTargetInput.TextColor3 = Color3.new(1, 1, 1)
MortarTargetInput.Font = Enum.Font.Gotham
MortarTargetInput.TextSize = 16
local MortarTargetCorner = Instance.new("UICorner", MortarTargetInput)
MortarTargetCorner.CornerRadius = UDim.new(0, 4)

-- Кнопка Mortar Send
local MortarSendBtn = Instance.new("TextButton")
MortarSendBtn.Parent = mortarTab
MortarSendBtn.Size = UDim2.new(1, 0, 0, 35)
MortarSendBtn.Text = "💥 Mortar Send"
MortarSendBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
MortarSendBtn.TextColor3 = Color3.new(1, 1, 1)
MortarSendBtn.Font = Enum.Font.GothamBold
MortarSendBtn.TextSize = 16
local MortarSendCorner = Instance.new("UICorner", MortarSendBtn)
MortarSendCorner.CornerRadius = UDim.new(0, 4)

-- ==================== ВКЛАДКА EXPLOIT ====================
local exploitLabel = Instance.new("TextLabel")
exploitLabel.Parent = exploitTab
exploitLabel.Size = UDim2.new(1, 0, 0, 50)
exploitLabel.BackgroundTransparency = 1
exploitLabel.Text = "Coming soon..."
exploitLabel.TextColor3 = Color3.new(0.5, 0.5, 0.5)
exploitLabel.Font = Enum.Font.Gotham
exploitLabel.TextSize = 20
exploitLabel.TextYAlignment = Enum.TextYAlignment.Top

-- ==================== ВКЛАДКА SETTINGS ====================
-- Кнопка Red
local RedBtn = Instance.new("TextButton")
RedBtn.Parent = settingsTab
RedBtn.Size = UDim2.new(1, 0, 0, 35)
RedBtn.Text = "🔴 Red Theme"
RedBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
RedBtn.TextColor3 = Color3.new(1, 1, 1)
RedBtn.Font = Enum.Font.GothamBold
RedBtn.TextSize = 16
local RedCorner = Instance.new("UICorner", RedBtn)
RedCorner.CornerRadius = UDim.new(0, 4)

-- Кнопка Black
local BlackBtn = Instance.new("TextButton")
BlackBtn.Parent = settingsTab
BlackBtn.Size = UDim2.new(1, 0, 0, 35)
BlackBtn.Text = "⚫ Black Theme"
BlackBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
BlackBtn.TextColor3 = Color3.new(1, 1, 1)
BlackBtn.Font = Enum.Font.GothamBold
BlackBtn.TextSize = 16
local BlackCorner = Instance.new("UICorner", BlackBtn)
BlackCorner.CornerRadius = UDim.new(0, 4)

-- Кнопка Rainbow
local RainbowBtn = Instance.new("TextButton")
RainbowBtn.Parent = settingsTab
RainbowBtn.Size = UDim2.new(1, 0, 0, 35)
RainbowBtn.Text = "🌈 Rainbow Theme"
RainbowBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
RainbowBtn.TextColor3 = Color3.new(1, 1, 1)
RainbowBtn.Font = Enum.Font.GothamBold
RainbowBtn.TextSize = 16
local RainbowCorner = Instance.new("UICorner", RainbowBtn)
RainbowCorner.CornerRadius = UDim.new(0, 4)

-- ==================== ЛОГИКА ====================

-- Получение инструмента
local function getTool()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Pistol")
end

-- Отправка удаленного события для убийства
local function fireRemote(targetHum, targetRoot)
    local tool = getTool()
    if tool and tool:FindFirstChild("RemoteEvent") then
        tool.RemoteEvent:FireServer(targetHum, 100, {9.17, targetRoot.CFrame})
    end
end

-- Выполнение убийства по имени
local function executeKill(targetName)
    if targetName == "" then return end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Name:lower():sub(1, #targetName) == targetName:lower() and p.Character then
            local hum = p.Character:FindFirstChild("Humanoid")
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            if hum and root and hum.Health > 0 then
                fireRemote(hum, root)
            end
        end
    end
end

-- Обновление списка игроков
local function updatePlayerList()
    for _, child in pairs(PlayerListFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pBtn = Instance.new("TextButton")
            pBtn.Parent = PlayerListFrame
            pBtn.Size = UDim2.new(1, -5, 0, 25)
            pBtn.Text = p.Name
            pBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            pBtn.TextColor3 = Color3.new(0.8, 0.8, 0.8)
            pBtn.BorderSizePixel = 0
            pBtn.Font = Enum.Font.Gotham
            pBtn.TextSize = 14
            local pCorner = Instance.new("UICorner", pBtn)
            pCorner.CornerRadius = UDim.new(0, 3)
            pBtn.MouseButton1Click:Connect(function()
                TargetInput.Text = p.Name
            end)
        end
    end
    PlayerListFrame.CanvasSize = UDim2.new(0, 0, #PlayerListFrame:GetChildren() * 28, 0)
end

-- Обновление списка при открытии вкладки Kill
killBtn.MouseButton1Click:Connect(function()
    updatePlayerList()
end)

-- Обработчики для вкладки Kill
KillBtn.MouseButton1Click:Connect(function()
    executeKill(TargetInput.Text)
end)

KillAllBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChild("Humanoid")
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            if hum and root and hum.Health > 0 then
                fireRemote(hum, root)
            end
        end
    end
end)

AuraBtn.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    AuraBtn.Text = Enabled and "🌀 Aura: ON" or "🌀 Aura: OFF"
    AuraBtn.BackgroundColor3 = Enabled and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(75, 0, 130)
    if Enabled then
        Connection = RunService.Heartbeat:Connect(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local hum = p.Character:FindFirstChild("Humanoid")
                    local root = p.Character:FindFirstChild("HumanoidRootPart")
                    if hum and root and hum.Health > 0 then
                        fireRemote(hum, root)
                    end
                end
            end
        end)
    else
        if Connection then
            Connection:Disconnect()
            Connection = nil
        end
    end
end)

-- ==================== ЛОГИКА ДЛЯ ВКЛАДКИ GET ====================
local function getWeapon(weaponName)
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return end
    
    -- Проверяем, есть ли уже оружие в backpack
    if backpack:FindFirstChild(weaponName) then
        return true
    end
    
    -- Отправляем событие для получения оружия (используем FlareGunShoot как триггер)
    local remote = ReplicatedStorage:FindFirstChild("FlareGunShoot")
    if not remote then return false end
    
    -- Подготавливаем аргументы
    local flareGun = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Flare Gun")
    if not flareGun then return false end
    
    local handle = flareGun:FindFirstChild("Handle")
    if not handle then return false end
    
    local shoot = handle:FindFirstChild("Shoot")
    if not shoot then return false end
    
    local args = {
        flareGun,
        CFrame.new(24.842269897460938, 9.5367431640625e-07, 83.40064239501953, 
            0.8785162568092346, -0.08361032605171204, 0.4703386425971985, 
            7.4505797087454084e-09, 0.9845643639564514, 0.17502230405807495, 
            -0.47771236300468445, -0.1537599414587021, 0.8649559020996094),
        {
            knockback = true,
            damage = 50,
            canDamage = true,
            speed = 100,
            damageRadius = 20,
            rangeBasedDamage = true,
            lifeTime = 10
        },
        shoot
    }
    
    -- Отправляем событие в цикле, пока оружие не появится
    local function waitForWeapon()
        while not backpack:FindFirstChild(weaponName) do
            pcall(function()
                remote:FireServer(unpack(args))
            end)
            task.wait(0.1)
        end
        -- Телепортируем игрока
        LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(-107, 102.999016, -800, -1, 0, 0, 0, 1, 0, 0, 0, -1))
    end
    
    coroutine.wrap(waitForWeapon)()
    return true
end

-- Назначаем обработчики для кнопок Get
for weaponName, btn in pairs(getButtons) do
    btn.MouseButton1Click:Connect(function()
        btn.Text = "⏳ Getting " .. weaponName .. "..."
        btn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
        getWeapon(weaponName)
        btn.Text = "📥 Get " .. weaponName
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end)
end

-- ==================== ЛОГИКА ДЛЯ ВКЛАДКИ MORTAR ====================
MortarSendBtn.MouseButton1Click:Connect(function()
    local targetName = MortarTargetInput.Text
    if targetName == "" then return end
    
    local targetPlayer = nil
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Name:lower():sub(1, #targetName) == targetName:lower() then
            targetPlayer = p
            break
        end
    end
    
    if not targetPlayer or not targetPlayer.Character then
        print("Target not found or no character")
        return
    end
    
    local root = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local pos = root.Position
    local mortar = LocalPlayer:FindFirstChild("Backpack"):FindFirstChild("Mortar")
    if not mortar then
        print("Mortar not found in backpack")
        return
    end
    
    local remote = mortar:FindFirstChild("RemoteEvent")
    if not remote then
        print("RemoteEvent not found on Mortar")
        return
    end
    
    -- Сохраняем текущую позицию
    local currentPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local savedCFrame = currentPos and currentPos.CFrame or CFrame.new(0, 0, 0)
    
    -- Телепортируемся к цели
    LocalPlayer.Character:SetPrimaryPartCFrame(root.CFrame + Vector3.new(0, 2, 0))
    
    -- Отправляем событие
    local args = {
        vector.create(pos.X, pos.Y, pos.Z)
    }
    pcall(function()
        remote:FireServer(unpack(args))
    end)
    
    -- Возвращаемся на место
    task.wait(0.2)
    LocalPlayer.Character:SetPrimaryPartCFrame(savedCFrame)
end)

-- ==================== ЛОГИКА ДЛЯ ВКЛАДКИ SETTINGS ====================
local function setTheme(color)
    Main.BackgroundColor3 = color
    TabPanel.BackgroundColor3 = color
    -- Меняем цвет фона всех кнопок и элементов
    for _, child in ipairs(TabPanel:GetChildren()) do
        if child:IsA("TextButton") then
            child.BackgroundColor3 = Color3.fromRGB(color.R * 1.5, color.G * 1.5, color.B * 1.5)
        end
    end
end

RedBtn.MouseButton1Click:Connect(function()
    if RainbowConnection then
        RainbowConnection:Disconnect()
        RainbowConnection = nil
    end
    setTheme(Color3.fromRGB(40, 10, 10))
end)

BlackBtn.MouseButton1Click:Connect(function()
    if RainbowConnection then
        RainbowConnection:Disconnect()
        RainbowConnection = nil
    end
    setTheme(Color3.fromRGB(20, 20, 20))
end)

RainbowBtn.MouseButton1Click:Connect(function()
    if RainbowConnection then
        RainbowConnection:Disconnect()
        RainbowConnection = nil
    end
    local hue = 0
    RainbowConnection = RunService.Heartbeat:Connect(function()
        hue = (hue + 0.005) % 1
        local color = Color3.fromHSV(hue, 1, 0.3)
        Main.BackgroundColor3 = color
        TabPanel.BackgroundColor3 = color
    end)
end)

-- ==================== УПРАВЛЕНИЕ ОКНОМ ====================
local function toggleContent()
    -- Не используем сворачивание, просто скрываем/показываем
end

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

CloseBtn.MouseButton1Click:Connect(function()
    if Connection then
        Connection:Disconnect()
        Connection = nil
    end
    if RainbowConnection then
        RainbowConnection:Disconnect()
        RainbowConnection = nil
    end
    ScreenGui:Destroy()
end)

print("✅ Trench War Script Enhanced Loaded.")
