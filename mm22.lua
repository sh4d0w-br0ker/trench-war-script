--[[
	VOID HUB ULTRA - UPDATED
]]

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local VirtualInput = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VoidHub_Ultra"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Size = UDim2.new(0, 400, 0, 380)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 8)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner", TopBar)
TopBarCorner.CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "Void Hub Ultra"
Title.Size = UDim2.new(0, 150, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.TextXAlignment = "Left"
Title.Font = Enum.Font.GothamBold

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Text = "×"
CloseBtn.Size = UDim2.new(0, 30, 1, 0)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Text = "<"
MinBtn.Size = UDim2.new(0, 30, 1, 0)
MinBtn.Position = UDim2.new(1, -65, 0, 0)
MinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinBtn.TextColor3 = Color3.new(1, 1, 1)

local LeftPanel = Instance.new("Frame", MainFrame)
LeftPanel.Size = UDim2.new(0, 80, 1, -30)
LeftPanel.Position = UDim2.new(0, 0, 0, 30)
LeftPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, -90, 1, -40)
ContentFrame.Position = UDim2.new(0, 85, 0, 35)
ContentFrame.BackgroundTransparency = 1

-- Логика сворачивания
local isMin = false
MinBtn.MouseButton1Click:Connect(function()
    isMin = not isMin
    LeftPanel.Visible = not isMin
    ContentFrame.Visible = not isMin
    MainFrame:TweenSize(isMin and UDim2.new(0, 400, 0, 30) or UDim2.new(0, 400, 0, 380), "Out", "Quad", 0.1, true)
    MinBtn.Text = isMin and ">" or "<"
end)

-- Страницы
local InfoPage = Instance.new("ScrollingFrame", ContentFrame)
InfoPage.Size = UDim2.new(1, 0, 1, 0)
InfoPage.BackgroundTransparency = 1
InfoPage.CanvasSize = UDim2.new(0, 0, 0, 0)
InfoPage.ScrollBarThickness = 4

local EspPage = Instance.new("ScrollingFrame", ContentFrame)
EspPage.Size = UDim2.new(1, 0, 1, 0)
EspPage.BackgroundTransparency = 1
EspPage.Visible = false
EspPage.CanvasSize = UDim2.new(0, 0, 0, 0)
EspPage.ScrollBarThickness = 4

local AutoPage = Instance.new("ScrollingFrame", ContentFrame)
AutoPage.Size = UDim2.new(1, 0, 1, 0)
AutoPage.BackgroundTransparency = 1
AutoPage.Visible = false
AutoPage.CanvasSize = UDim2.new(0, 0, 0, 0)
AutoPage.ScrollBarThickness = 4

local TeleportPage = Instance.new("ScrollingFrame", ContentFrame)
TeleportPage.Size = UDim2.new(1, 0, 1, 0)
TeleportPage.BackgroundTransparency = 1
TeleportPage.Visible = false
TeleportPage.CanvasSize = UDim2.new(0, 0, 0, 0)
TeleportPage.ScrollBarThickness = 4

local ScriptsPage = Instance.new("ScrollingFrame", ContentFrame)
ScriptsPage.Size = UDim2.new(1, 0, 1, 0)
ScriptsPage.BackgroundTransparency = 1
ScriptsPage.Visible = false
ScriptsPage.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptsPage.ScrollBarThickness = 4

local SettingsPage = Instance.new("ScrollingFrame", ContentFrame)
SettingsPage.Size = UDim2.new(1, 0, 1, 0)
SettingsPage.BackgroundTransparency = 1
SettingsPage.Visible = false
SettingsPage.CanvasSize = UDim2.new(0, 0, 0, 0)
SettingsPage.ScrollBarThickness = 4

-- Layout для страниц
local function setupLayout(page)
    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 5)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)
end
setupLayout(InfoPage)
setupLayout(EspPage)
setupLayout(AutoPage)
setupLayout(TeleportPage)
setupLayout(ScriptsPage)
setupLayout(SettingsPage)

-- Переключение вкладок
local function showPage(p)
    InfoPage.Visible = (p == "info")
    EspPage.Visible = (p == "esp")
    AutoPage.Visible = (p == "auto")
    TeleportPage.Visible = (p == "teleport")
    ScriptsPage.Visible = (p == "scripts")
    SettingsPage.Visible = (p == "settings")
end

local b1 = Instance.new("TextButton", LeftPanel)
b1.Size = UDim2.new(1,0,0,30); b1.Text = "Info"
b1.MouseButton1Click:Connect(function() showPage("info") end)

local b2 = Instance.new("TextButton", LeftPanel)
b2.Size = UDim2.new(1,0,0,30); b2.Position = UDim2.new(0,0,0,35); b2.Text = "Esp"
b2.MouseButton1Click:Connect(function() showPage("esp") end)

local b3 = Instance.new("TextButton", LeftPanel)
b3.Size = UDim2.new(1,0,0,30); b3.Position = UDim2.new(0,0,0,70); b3.Text = "Auto"
b3.MouseButton1Click:Connect(function() showPage("auto") end)

local b4 = Instance.new("TextButton", LeftPanel)
b4.Size = UDim2.new(1,0,0,30); b4.Position = UDim2.new(0,0,0,105); b4.Text = "Teleport"
b4.MouseButton1Click:Connect(function() showPage("teleport") end)

local b5 = Instance.new("TextButton", LeftPanel)
b5.Size = UDim2.new(1,0,0,30); b5.Position = UDim2.new(0,0,0,140); b5.Text = "Scripts"
b5.MouseButton1Click:Connect(function() showPage("scripts") end)

local b6 = Instance.new("TextButton", LeftPanel)
b6.Size = UDim2.new(1,0,0,30); b6.Position = UDim2.new(0,0,0,175); b6.Text = "Settings"
b6.MouseButton1Click:Connect(function() showPage("settings") end)

-- Функция создания кнопки
local function createBtn(txt, parent, callback, color)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -10, 0, 35)
    b.Text = txt
    b.BackgroundColor3 = color or Color3.fromRGB(45, 45, 45)
    b.TextColor3 = Color3.new(1, 1, 1)
    local corner = Instance.new("UICorner", b)
    corner.CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(callback)
    return b
end

-- Функция создания кнопки-переключателя
local function createToggle(txt, parent, callback, colorOn)
    local state = false
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -10, 0, 35)
    b.Text = txt .. " OFF"
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    b.TextColor3 = Color3.new(1, 1, 1)
    local corner = Instance.new("UICorner", b)
    corner.CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = txt .. (state and " ON" or " OFF")
        b.BackgroundColor3 = state and (colorOn or Color3.fromRGB(0, 150, 0)) or Color3.fromRGB(45, 45, 45)
        callback(state)
    end)
    return b
end

-- INFO PAGE
local infoText = Instance.new("TextLabel", InfoPage)
infoText.Size = UDim2.new(1, -10, 0, 80)
infoText.Text = "VOID HUB ULTRA\n\nCreated by xXram000dieXx\nVersion 3.5"
infoText.TextColor3 = Color3.new(1, 1, 1)
infoText.BackgroundTransparency = 1
infoText.TextWrapped = true
infoText.Font = Enum.Font.GothamBold

-- Конфиг и переменные
local cfg = {Murder = false, Sheriff = false, Innocent = false, GunEsp = false, CoinEsp = false}
local autoGunState = false
local murderKillState = false
local killAllState = false
local autoCoinState = false
local oldPos = nil
local isTeleporting = false
local originalPos = nil
local rainbowConnection = nil
local noclipConnection = nil
local autoCoinConnection = nil

-- ESP PAGE
createToggle("Esp Murder", EspPage, function(s) cfg.Murder = s end, Color3.fromRGB(200, 0, 0))
createToggle("Esp Sheriff", EspPage, function(s) cfg.Sheriff = s end, Color3.fromRGB(0, 100, 255))
createToggle("Esp Innocent", EspPage, function(s) cfg.Innocent = s end, Color3.fromRGB(0, 200, 0))
createToggle("Esp GunDrop", EspPage, function(s) cfg.GunEsp = s end, Color3.fromRGB(200, 0, 255))
createToggle("Esp Coin", EspPage, function(s) cfg.CoinEsp = s end, Color3.fromRGB(255, 255, 0))

-- AUTO PAGE
createToggle("Auto GunDrop", AutoPage, function(s) autoGunState = s end, Color3.fromRGB(150, 100, 0))

-- Auto murder kill (с возвратом на место)
createToggle("Auto murder kill", AutoPage, function(s)
    murderKillState = s
    if s then
        task.spawn(function()
            while murderKillState do
                local lp = Players.LocalPlayer
                local char = lp.Character
                if not char then task.wait(1) continue end
                
                -- Проверяем есть ли у нас Gun
                local hasGun = false
                local gunTool = nil
                if lp.Backpack then
                    for _, tool in pairs(lp.Backpack:GetChildren()) do
                        if tool.Name:lower():find("gun") or tool.Name:lower():find("pistol") or tool.Name:lower():find("revolver") then
                            hasGun = true
                            gunTool = tool
                            break
                        end
                    end
                end
                if char then
                    for _, tool in pairs(char:GetChildren()) do
                        if tool:IsA("Tool") and (tool.Name:lower():find("gun") or tool.Name:lower():find("pistol") or tool.Name:lower():find("revolver")) then
                            hasGun = true
                            gunTool = tool
                            break
                        end
                    end
                end
                
                if not hasGun then
                    task.wait(1)
                    continue
                end
                
                -- Берем оружие в руки
                if gunTool and gunTool.Parent == lp.Backpack then
                    gunTool.Parent = char
                end
                
                -- Ищем Murder
                local murder = nil
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= lp and p.Character then
                        local hasKnife = false
                        if p.Character:FindFirstChild("Knife") then
                            hasKnife = true
                        end
                        if p.Backpack and p.Backpack:FindFirstChild("Knife") then
                            hasKnife = true
                        end
                        if hasKnife then
                            murder = p
                            break
                        end
                    end
                end
                
                if murder and murder.Character and murder.Character:FindFirstChild("HumanoidRootPart") then
                    local murderHrp = murder.Character.HumanoidRootPart
                    local myHrp = char:FindFirstChild("HumanoidRootPart")
                    if myHrp then
                        -- Сохраняем позицию перед телепортом
                        originalPos = myHrp.CFrame
                        
                        -- Телепорт сзади мурдера
                        local behindPos = murderHrp.CFrame * CFrame.new(0, 0, 5)
                        myHrp.CFrame = behindPos
                        task.wait(0.2)
                        
                        -- Стреляем через евент Gun
                        local gun = char:FindFirstChildWhichIsA("Tool")
                        if gun and gun:FindFirstChild("Shoot") then
                            local shootEvent = gun:FindFirstChild("Shoot")
                            if shootEvent:IsA("RemoteEvent") then
                                shootEvent:FireServer(murderHrp.CFrame, murderHrp.CFrame)
                            end
                        else
                            VirtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                            task.wait(0.05)
                            VirtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                        end
                        
                        task.wait(0.5)
                        
                        -- Возвращаемся на место
                        if originalPos and char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = originalPos
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    end
end, Color3.fromRGB(200, 50, 50))

-- Auto kill all (bring всех к себе)
createToggle("Auto kill all", AutoPage, function(s)
    killAllState = s
    if s then
        task.spawn(function()
            while killAllState do
                local lp = Players.LocalPlayer
                local char = lp.Character
                if not char then task.wait(1) continue end
                
                -- Проверяем есть ли у нас Knife
                local hasKnife = false
                if lp.Backpack then
                    for _, tool in pairs(lp.Backpack:GetChildren()) do
                        if tool.Name == "Knife" then
                            hasKnife = true
                            tool.Parent = char
                            break
                        end
                    end
                end
                if char then
                    for _, tool in pairs(char:GetChildren()) do
                        if tool:IsA("Tool") and tool.Name == "Knife" then
                            hasKnife = true
                            break
                        end
                    end
                end
                
                if not hasKnife then
                    task.wait(1)
                    continue
                end
                
                local myHrp = char:FindFirstChild("HumanoidRootPart")
                if not myHrp then task.wait(1) continue end
                
                -- Bring всех ко мне и увеличиваем хитбоксы
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= lp and p.Character then
                        local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            hrp.CFrame = myHrp.CFrame * CFrame.new(0, 0, 3)
                            hrp.Size = Vector3.new(1000, 1000, 1000)
                            hrp.Transparency = 0.8
                            hrp.CanCollide = false
                        end
                    end
                end
                
                task.wait(2)
                
                -- Кликаем в центр экрана
                local viewport = workspace.CurrentCamera.ViewportSize
                local centerX = viewport.X / 2
                local centerY = viewport.Y / 2
                
                VirtualInput:SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
                task.wait(0.05)
                VirtualInput:SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
                
                task.wait(0.5)
            end
        end)
    else
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                end
            end
        end
    end
end, Color3.fromRGB(150, 0, 0))

-- Auto coin farm
createToggle("Auto coin farm", AutoPage, function(s)
    autoCoinState = s
    if s then
        -- Включаем Noclip
        noclipConnection = RunService.Stepped:Connect(function()
            local char = Players.LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        
        -- Запускаем сбор монет
        autoCoinConnection = task.spawn(function()
            while autoCoinState do
                local lp = Players.LocalPlayer
                local char = lp.Character
                if not char then task.wait(1) continue end
                
                local myHrp = char:FindFirstChild("HumanoidRootPart")
                if not myHrp then task.wait(1) continue end
                
                -- Ищем все Coin_Server
                local coins = {}
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name == "Coin_Server" and obj:IsA("BasePart") then
                        table.insert(coins, obj)
                    end
                end
                
                if #coins > 0 then
                    for _, coin in pairs(coins) do
                        if not autoCoinState then break end
                        -- Летим к монете со средней скоростью
                        local targetPos = coin.Position
                        local distance = (myHrp.Position - targetPos).Magnitude
                        
                        while distance > 5 and autoCoinState do
                            local currentPos = myHrp.Position
                            local direction = (targetPos - currentPos).Unit
                            local newPos = currentPos + direction * 20
                            myHrp.CFrame = CFrame.new(newPos, targetPos)
                            task.wait(0.05)
                            distance = (myHrp.Position - targetPos).Magnitude
                        end
                        
                        task.wait(0.1)
                    end
                else
                    task.wait(1)
                end
            end
        end)
    else
        -- Выключаем Noclip
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        if autoCoinConnection then
            task.cancel(autoCoinConnection)
            autoCoinConnection = nil
        end
        -- Возвращаем коллизию
        local char = Players.LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end, Color3.fromRGB(255, 200, 0))

-- TELEPORT PAGE
-- TP random innocent
createBtn("TP Random Innocent", TeleportPage, function()
    local lp = Players.LocalPlayer
    local innocents = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local hasK = p.Character:FindFirstChild("Knife") or (p.Backpack and p.Backpack:FindFirstChild("Knife"))
            local hasG = p.Character:FindFirstChild("Gun") or (p.Backpack and p.Backpack:FindFirstChild("Gun"))
            if not hasK and not hasG then
                table.insert(innocents, p)
            end
        end
    end
    if #innocents > 0 then
        local target = innocents[math.random(1, #innocents)]
        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            lp.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 3)
        end
    end
end, Color3.fromRGB(0, 150, 0))

-- TP murder
createBtn("TP Murder", TeleportPage, function()
    local lp = Players.LocalPlayer
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local hasKnife = p.Character:FindFirstChild("Knife") or (p.Backpack and p.Backpack:FindFirstChild("Knife"))
            if hasKnife then
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    lp.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 3)
                end
                break
            end
        end
    end
end, Color3.fromRGB(200, 0, 0))

-- TP sheriff
createBtn("TP Sheriff", TeleportPage, function()
    local lp = Players.LocalPlayer
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local hasGun = p.Character:FindFirstChild("Gun") or (p.Backpack and p.Backpack:FindFirstChild("Gun"))
            if hasGun then
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    lp.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 3)
                end
                break
            end
        end
    end
end, Color3.fromRGB(0, 100, 255))

-- SCRIPTS PAGE
createBtn("Invisible Script", ScriptsPage, function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-invisible-script-138580"))()
end, Color3.fromRGB(100, 50, 200))

-- SETTINGS PAGE
local colorFrame = Instance.new("Frame", SettingsPage)
colorFrame.Size = UDim2.new(1, -10, 0, 100)
colorFrame.BackgroundTransparency = 1

local colorTitle = Instance.new("TextLabel", colorFrame)
colorTitle.Size = UDim2.new(1, 0, 0, 25)
colorTitle.Text = "Цвета GUI"
colorTitle.TextColor3 = Color3.new(1, 1, 1)
colorTitle.BackgroundTransparency = 1
colorTitle.Font = Enum.Font.GothamBold

local function changeGuiColor(color)
    if rainbowConnection then
        rainbowConnection:Disconnect()
        rainbowConnection = nil
    end
    MainFrame.BackgroundColor3 = color
    TopBar.BackgroundColor3 = color:lerp(Color3.new(0, 0, 0), 0.2)
    LeftPanel.BackgroundColor3 = color:lerp(Color3.new(0, 0, 0), 0.3)
end

local colors = {
    {"Standard", Color3.fromRGB(20, 20, 20)},
    {"Red", Color3.fromRGB(100, 30, 30)},
    {"Green", Color3.fromRGB(30, 80, 40)},
    {"Black", Color3.fromRGB(5, 5, 5)},
    {"Yellow", Color3.fromRGB(100, 100, 30)},
    {"Purple", Color3.fromRGB(70, 30, 100)},
    {"Blue", Color3.fromRGB(30, 30, 100)},
    {"LightBlue", Color3.fromRGB(30, 100, 120)}
}

local function createColorButton(name, color, x, y)
    local btn = Instance.new("TextButton", colorFrame)
    btn.Size = UDim2.new(0.23, -2, 0, 30)
    btn.Position = UDim2.new(x, 0, y, 0)
    btn.Text = name
    btn.BackgroundColor3 = color
    btn.TextColor3 = (name == "Yellow") and Color3.fromRGB(0, 0, 0) or Color3.new(1, 1, 1)
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function() changeGuiColor(color) end)
end

createColorButton("Standard", Color3.fromRGB(20, 20, 20), 0, 0.35)
createColorButton("Red", Color3.fromRGB(100, 30, 30), 0.26, 0.35)
createColorButton("Green", Color3.fromRGB(30, 80, 40), 0.52, 0.35)
createColorButton("Black", Color3.fromRGB(5, 5, 5), 0.78, 0.35)
createColorButton("Yellow", Color3.fromRGB(100, 100, 30), 0, 0.7)
createColorButton("Purple", Color3.fromRGB(70, 30, 100), 0.26, 0.7)
createColorButton("Blue", Color3.fromRGB(30, 30, 100), 0.52, 0.7)
createColorButton("LBlue", Color3.fromRGB(30, 100, 120), 0.78, 0.7)

-- Rainbow кнопка
createBtn("RAINBOW MODE", SettingsPage, function()
    if rainbowConnection then
        rainbowConnection:Disconnect()
        rainbowConnection = nil
        changeGuiColor(Color3.fromRGB(20, 20, 20))
    else
        rainbowConnection = RunService.RenderStepped:Connect(function()
            local hue = tick() % 5 / 5
            local color = Color3.fromHSV(hue, 0.7, 0.6)
            MainFrame.BackgroundColor3 = color
            TopBar.BackgroundColor3 = color:lerp(Color3.new(0, 0, 0), 0.2)
            LeftPanel.BackgroundColor3 = color:lerp(Color3.new(0, 0, 0), 0.3)
        end)
    end
end, Color3.fromRGB(150, 50, 150))

-- Изменение названия GUI
local nameFrame = Instance.new("Frame", SettingsPage)
nameFrame.Size = UDim2.new(1, -10, 0, 70)
nameFrame.BackgroundTransparency = 1

local nameTitle = Instance.new("TextLabel", nameFrame)
nameTitle.Size = UDim2.new(1, 0, 0, 25)
nameTitle.Text = "Название GUI"
nameTitle.TextColor3 = Color3.new(1, 1, 1)
nameTitle.BackgroundTransparency = 1
nameTitle.Font = Enum.Font.GothamBold

local nameBox = Instance.new("TextBox", nameFrame)
nameBox.Size = UDim2.new(0.7, 0, 0, 30)
nameBox.Position = UDim2.new(0, 0, 0, 30)
nameBox.PlaceholderText = "Void Hub Ultra"
nameBox.Text = "Void Hub Ultra"
nameBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
nameBox.TextColor3 = Color3.new(1, 1, 1)
local boxCorner = Instance.new("UICorner", nameBox)
boxCorner.CornerRadius = UDim.new(0, 6)

local applyBtn = Instance.new("TextButton", nameFrame)
applyBtn.Size = UDim2.new(0.25, -5, 0, 30)
applyBtn.Position = UDim2.new(0.75, 0, 0, 30)
applyBtn.Text = "Применить"
applyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
applyBtn.TextColor3 = Color3.new(1, 1, 1)
local btnCorner = Instance.new("UICorner", applyBtn)
btnCorner.CornerRadius = UDim.new(0, 6)

applyBtn.MouseButton1Click:Connect(function()
    local newName = nameBox.Text
    if newName ~= "" then
        Title.Text = newName
    end
end)

-- Главный цикл ESP и GunDrop
RunService.RenderStepped:Connect(function()
    local lp = Players.LocalPlayer
    local char = lp.Character
    
    -- ESP Игроков
    for _, p in pairs(Players:GetPlayers()) do
        if p == lp then continue end
        local pChar = p.Character
        if pChar and pChar:FindFirstChild("HumanoidRootPart") then
            local high = pChar:FindFirstChild("VoidEsp") or Instance.new("Highlight", pChar)
            high.Name = "VoidEsp"
            
            local hasK = pChar:FindFirstChild("Knife") or (p.Backpack and p.Backpack:FindFirstChild("Knife"))
            local hasG = pChar:FindFirstChild("Gun") or (p.Backpack and p.Backpack:FindFirstChild("Gun"))
            
            local color = nil
            if cfg.Murder and hasK then color = Color3.fromRGB(255, 0, 0)
            elseif cfg.Sheriff and hasG then color = Color3.fromRGB(0, 100, 255)
            elseif cfg.Innocent and not hasK and not hasG then color = Color3.fromRGB(0, 255, 0) end
            
            high.Enabled = (color ~= nil)
            if color then high.FillColor = color end
        end
    end
    
    -- ESP Coin_Server
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "Coin_Server" and obj:IsA("BasePart") then
            local high = obj:FindFirstChild("CoinEsp") or Instance.new("Highlight", obj)
            high.Name = "CoinEsp"
            high.FillColor = Color3.fromRGB(255, 255, 0)
            high.OutlineColor = Color3.fromRGB(255, 200, 0)
            high.Enabled = cfg.CoinEsp
        end
    end

    -- GunDrop логика
    local gun = workspace:FindFirstChild("GunDrop", true)
    if gun and gun:IsA("BasePart") then
        local gHigh = gun:FindFirstChild("GunHigh") or Instance.new("Highlight", gun)
        gHigh.Name = "GunHigh"
        gHigh.FillColor = Color3.fromRGB(200, 0, 255)
        gHigh.Enabled = cfg.GunEsp
        
        if autoGunState and char and char:FindFirstChild("HumanoidRootPart") then
            if not isTeleporting then
                oldPos = char.HumanoidRootPart.CFrame
                isTeleporting = true
            end
            char.HumanoidRootPart.CFrame = gun.CFrame
        end
    else
        if isTeleporting and oldPos and char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = oldPos
            isTeleporting = false
            oldPos = nil
        end
    end
end)

print("Void Hub Ultra Loaded!")
