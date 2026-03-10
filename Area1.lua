local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local ToggleBtn = Instance.new("TextButton")
local Sidebar = Instance.new("Frame")
local Container = Instance.new("Frame")

ScreenGui.Name = "VoidHub_Full_Fixed"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- ГЛАВНОЕ ОКНО
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- ШАПКА
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.Size = UDim2.new(1, 0, 0, 40)

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(0, 10)
BarCorner.Parent = TitleBar

TitleLabel.Parent = TitleBar
TitleLabel.Text = " Void Hub V2 (Full)"
TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
TitleLabel.Position = UDim2.new(0, 5, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- КНОПКА СВОРАЧИВАНИЯ
ToggleBtn.Parent = TitleBar
ToggleBtn.Text = "_"
ToggleBtn.Size = UDim2.new(0, 35, 0, 30)
ToggleBtn.Position = UDim2.new(1, -40, 0, 5)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 16
local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = ToggleBtn

-- СИСТЕМА ПЕРЕТЯГИВАНИЯ
local UIS = game:GetService("UserInputService")
local dragToggle, dragStart, startPos
local dragSpeed = 0.15

TitleBar.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        dragToggle = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragToggle = false end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragToggle then
        local delta = input.Position - dragStart
        local pos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(dragSpeed), {Position = pos}):Play()
    end
end)

-- БОКОВАЯ ПАНЕЛЬ И КОНТЕЙНЕР
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Sidebar.Position = UDim2.new(0, 5, 0, 45)
Sidebar.Size = UDim2.new(0, 70, 1, -50)

local SideLayout = Instance.new("UIListLayout")
SideLayout.Parent = Sidebar
SideLayout.Padding = UDim.new(0, 5)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

Container.Name = "Container"
Container.Parent = MainFrame
Container.Position = UDim2.new(0, 80, 0, 45)
Container.Size = UDim2.new(1, -85, 1, -50)
Container.BackgroundTransparency = 1

local tabs = {}
local function createTab(name)
    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = name
    scroll.Parent = Container
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.Visible = false
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    local layout = Instance.new("UIListLayout")
    layout.Parent = scroll
    layout.Padding = UDim.new(0, 8)
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Parent = Sidebar
    tabBtn.Size = UDim2.new(0, 60, 0, 35)
    tabBtn.Text = name
    tabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabBtn.Font = Enum.Font.Gotham
    tabBtn.TextSize = 12
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = tabBtn
    tabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.Visible = false end
        scroll.Visible = true
    end)
    tabs[name] = scroll
    return scroll
end

local tabMenu = createTab("Menu")
local tabCombat = createTab("Combat")
local tabTP = createTab("Teleport")
local tabTroll = createTab("Troll")
local tabArea51 = createTab("Area 51")
local tabKillers = createTab("Killers")
local tabSurvivor = createTab("Survivor")
local tabSettings = createTab("Settings")

-- ЛОГИКА
local player = game.Players.LocalPlayer
local espEnabled, hitboxEnabled, hpEspEnabled, killAllActive = false, false, false, false
local survivorKillAllActive = false
local hitboxSize = 30

local function tp(cf, returnBack)
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local oldPos = char.HumanoidRootPart.CFrame
        char.HumanoidRootPart.CFrame = cf
        if returnBack then task.wait(0.6) char.HumanoidRootPart.CFrame = oldPos end
    end
end

local function addBtn(parent, txt, callback, clr)
    local b = Instance.new("TextButton")
    b.Parent = parent
    b.Size = UDim2.new(1, 0, 0, 35)
    b.Text = txt
    b.BackgroundColor3 = clr or Color3.fromRGB(50, 50, 50)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 12
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = b
    b.MouseButton1Click:Connect(function() callback(b) end)
end

local function getEnemyTeam()
    local myTeam = "Survivors"
    local stats = player:FindFirstChild("leaderstats")
    if stats and stats:FindFirstChild("Team") then myTeam = stats.Team.Value
    elseif player.Team then myTeam = player.Team.Name end
    return (myTeam == "Killers") and "Survivors" or "Killers"
end

local function isPlayerKillers()
    local myTeam = "Survivors"
    local stats = player:FindFirstChild("leaderstats")
    if stats and stats:FindFirstChild("Team") then myTeam = stats.Team.Value
    elseif player.Team then myTeam = player.Team.Name end
    return myTeam == "Killers"
end

local function isPlayerSurvivor()
    local myTeam = "Survivors"
    local stats = player:FindFirstChild("leaderstats")
    if stats and stats:FindFirstChild("Team") then myTeam = stats.Team.Value
    elseif player.Team then myTeam = player.Team.Name end
    return myTeam == "Survivors"
end

local function showNotification(parent, text, color, yOffset)
    local notification = Instance.new("TextLabel")
    notification.Parent = parent
    notification.Size = UDim2.new(1, 0, 0, 30)
    notification.Position = UDim2.new(0, 0, 0, yOffset or 140)
    notification.Text = text
    notification.TextColor3 = color or Color3.fromRGB(255, 0, 0)
    notification.BackgroundTransparency = 1
    notification.Font = Enum.Font.GothamBold
    notification.TextSize = 14
    task.delay(3, function() notification:Destroy() end)
end

local function findPlayerByName(partialName, excludeSelf)
    partialName = partialName:lower()
    for _, v in pairs(game.Players:GetPlayers()) do
        if excludeSelf and v == player then
            -- пропускаем себя
        elseif v.Name:lower():find(partialName) then
            return v
        end
    end
    return nil
end

local function getSurvivors()
    local survivors = {}
    local enemyTeam = getEnemyTeam()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player then
            local tTeam = "Survivors"
            local ts = v:FindFirstChild("leaderstats")
            if ts and ts:FindFirstChild("Team") then tTeam = ts.Team.Value
            elseif v.Team then tTeam = v.Team.Name end
            
            if tTeam == enemyTeam then
                table.insert(survivors, v)
            end
        end
    end
    return survivors
end

local function getKillers()
    local killers = {}
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player then
            local tTeam = "Survivors"
            local ts = v:FindFirstChild("leaderstats")
            if ts and ts:FindFirstChild("Team") then tTeam = ts.Team.Value
            elseif v.Team then tTeam = v.Team.Name end
            
            if tTeam == "Killers" then
                table.insert(killers, v)
            end
        end
    end
    return killers
end

-- ИСПРАВЛЕННАЯ ФУНКЦИЯ С ПРАВИЛЬНЫМ ЗАХВАТОМ!
local function teleportIntoPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    
    local targetChar = targetPlayer.Character
    local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetHrp then return end
    
    -- Сохраняем свою позицию
    local myChar = player.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
    
    local myOldPos = myChar.HumanoidRootPart.CFrame
    
    -- Телепортируемся ПРЯМО В ЖЕРТВУ (чуть выше для захвата)
    myChar.HumanoidRootPart.CFrame = targetHrp.CFrame * CFrame.new(0, 2.5, 0)
    task.wait(0.3) -- Ждем чтобы сработали Touched события
    
    -- Проверяем захват через Magnitude
    local distance = (myChar.HumanoidRootPart.Position - targetHrp.Position).Magnitude
    if distance < 5 then
        print("Захват сработал! Жертва прилипла!")
    end
    
    -- Теперь мы касаемся друг друга, забираем её в космос
    local spacePos = CFrame.new(0, 999, 0)
    myChar.HumanoidRootPart.CFrame = spacePos
    -- Жертва автоматом летит со мной потому что Touch сработал!
    
    task.wait(2)
    
    -- Возвращаемся обратно
    myChar.HumanoidRootPart.CFrame = myOldPos
    -- Жертва остается в космосе и падает
end

local function attackPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    
    local char = targetPlayer.Character
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    -- Увеличиваем хитбокс
    hrp.Size = Vector3.new(30, 30, 30)
    hrp.Transparency = 0.8
    
    -- Телепортируемся к игроку
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = hrp.CFrame
    end
    
    -- Летаем вокруг игрока 4 секунды и атакуем
    local startTime = os.clock()
    local virtualInput = game:GetService("VirtualInputManager")
    
    while os.clock() - startTime < 4 and targetPlayer.Character and hrp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") do
        -- Телепортируемся немного вокруг игрока
        local offset = Vector3.new(
            math.random(-5, 5),
            math.random(-2, 2),
            math.random(-5, 5)
        )
        
        player.Character.HumanoidRootPart.CFrame = hrp.CFrame + offset
        
        -- Имитируем клики мыши (атаку)
        virtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        task.wait(0.1)
        virtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 1)
        
        task.wait(0.2)
    end
    
    -- Возвращаем хитбокс в норму
    if hrp then
        hrp.Size = Vector3.new(2,2,1)
        hrp.Transparency = 1
    end
end

-- Функция для смены цвета GUI
local function changeGuiColor(color)
    if color == "green" then
        MainFrame.BackgroundColor3 = Color3.fromRGB(15, 50, 15)
        TitleBar.BackgroundColor3 = Color3.fromRGB(30, 80, 30)
        Sidebar.BackgroundColor3 = Color3.fromRGB(20, 60, 20)
    elseif color == "red" then
        MainFrame.BackgroundColor3 = Color3.fromRGB(50, 15, 15)
        TitleBar.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
        Sidebar.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
    else -- standard
        MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    end
end

-- Функция для создания поля ввода
local function createInput(parent, placeholder, defaultValue, callback, isKillersTab, isSurvivorTab)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = UDim2.new(1, 0, 0, 45)
    frame.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(1, 0, 0, 18)
    label.Text = placeholder
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local box = Instance.new("TextBox")
    box.Parent = frame
    box.Position = UDim2.new(0, 0, 0, 22)
    box.Size = UDim2.new(0.7, 0, 0, 23)
    box.Text = tostring(defaultValue)
    box.PlaceholderText = "Введите ник"
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    box.TextColor3 = Color3.new(1, 1, 1)
    box.Font = Enum.Font.Gotham
    box.TextSize = 13
    box.ClearTextOnFocus = false
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 6)
    boxCorner.Parent = box
    
    local btnText = "Kill"
    local btnColor = Color3.fromRGB(150, 0, 0)
    
    if isSurvivorTab then
        btnText = "Kill"
        btnColor = Color3.fromRGB(0, 100, 200)
    end
    
    local killBtn = Instance.new("TextButton")
    killBtn.Parent = frame
    killBtn.Position = UDim2.new(0.75, 0, 0, 22)
    killBtn.Size = UDim2.new(0.25, -5, 0, 23)
    killBtn.Text = btnText
    killBtn.BackgroundColor3 = btnColor
    killBtn.TextColor3 = Color3.new(1, 1, 1)
    killBtn.Font = Enum.Font.Gotham
    killBtn.TextSize = 12
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = killBtn
    
    killBtn.MouseButton1Click:Connect(function()
        callback(box.Text)
    end)
    
    box.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(box.Text)
        end
    end)
    
    return frame
end

-- Функция для создания/обновления HP ESP
local function updateHpEsp(char, isEnemy)
    if not hpEspEnabled or not isEnemy then
        if char:FindFirstChild("HpEsp") then
            char.HpEsp:Destroy()
        end
        return
    end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    if not char:FindFirstChild("HpEsp") then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "HpEsp"
        billboard.Parent = char
        billboard.AlwaysOnTop = true
        billboard.Size = UDim2.new(0, 90, 0, 30)
        billboard.StudsOffset = Vector3.new(0, 3.5, 0)
        billboard.Adornee = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
        
        local bg = Instance.new("Frame")
        bg.Name = "Background"
        bg.Parent = billboard
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        bg.BackgroundTransparency = 0.4
        bg.BorderSizePixel = 0
        
        local bgCorner = Instance.new("UICorner")
        bgCorner.CornerRadius = UDim.new(0, 6)
        bgCorner.Parent = bg
        
        local hpLabel = Instance.new("TextLabel")
        hpLabel.Name = "HpLabel"
        hpLabel.Parent = bg
        hpLabel.Size = UDim2.new(1, 0, 1, 0)
        hpLabel.BackgroundTransparency = 1
        hpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        hpLabel.Font = Enum.Font.GothamBold
        hpLabel.TextSize = 16
        hpLabel.TextScaled = true
    end
    
    local billboard = char:FindFirstChild("HpEsp")
    if billboard then
        local hpLabel = billboard.Background.HpLabel
        if hpLabel then
            local hp = math.floor(humanoid.Health)
            local maxHp = math.floor(humanoid.MaxHealth)
            hpLabel.Text = hp .. "/" .. maxHp
            
            if hp/maxHp > 0.7 then
                hpLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            elseif hp/maxHp > 0.3 then
                hpLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
            else
                hpLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            end
        end
    end
end

-- ЦИКЛ ОБНОВЛЕНИЯ (ESP, HITBOX, HP ESP)
task.spawn(function()
    while task.wait(0.2) do
        local enemy = getEnemyTeam()
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= player and v.Character then
                local char = v.Character
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local tTeam = "Survivors"
                local ts = v:FindFirstChild("leaderstats")
                if ts and ts:FindFirstChild("Team") then tTeam = ts.Team.Value
                elseif v.Team then tTeam = v.Team.Name end
                
                local isEnemy = (tTeam == enemy)

                -- ESP
                if espEnabled and isEnemy then
                    if not char:FindFirstChild("VoidESP") then
                        local h = Instance.new("Highlight", char)
                        h.Name = "VoidESP"
                        h.FillColor = (enemy == "Killers") and Color3.new(1,0,0) or Color3.new(0,1,0)
                        h.FillTransparency = 0.5
                    end
                else
                    if char:FindFirstChild("VoidESP") then char.VoidESP:Destroy() end
                end

                -- Hitbox (с изменяемым размером)
                if hrp then
                    if (hitboxEnabled and isEnemy) or killAllActive then
                        hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                        hrp.Transparency = 0.8
                        hrp.CanCollide = false
                    else
                        hrp.Size = Vector3.new(2,2,1)
                        hrp.Transparency = 1
                        hrp.CanCollide = false
                    end
                end
                
                -- HP ESP
                updateHpEsp(char, isEnemy)
            end
        end
        
        -- Для себя делаем хитбокс невидимым
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local myHrp = player.Character.HumanoidRootPart
            myHrp.Transparency = 1
            myHrp.Size = Vector3.new(2,2,1)
            myHrp.CanCollide = false
            myHrp.LocalTransparencyModifier = 1
        end
    end
end)

-- ВЕРНУЛ ВСЕ ОРУЖИЕ В COMBAT
addBtn(tabCombat, "GET ВИНТОВКА", function() tp(CFrame.new(2.5, 268.1, 187.3), true) end, Color3.fromRGB(170, 40, 40))
addBtn(tabCombat, "GET ВИНТОВКА 2", function() tp(CFrame.new(114.77, 323.7, 675.5), true) end, Color3.fromRGB(170, 40, 40))
addBtn(tabCombat, "GET СНАЙПЕРКУ", function() tp(CFrame.new(201, 301.6, 159.5), true) end, Color3.fromRGB(90, 40, 140))
addBtn(tabCombat, "GET СНАЙПЕРКА 2", function() tp(CFrame.new(70.7, 281.4, 30.4), true) end, Color3.fromRGB(120, 80, 200))
addBtn(tabCombat, "GET КАЛАШ", function() tp(CFrame.new(320, 274.6, 141.7), true) end, Color3.fromRGB(180, 100, 30))
addBtn(tabCombat, "GET ЛАЗЕРНЫЙ", function() tp(CFrame.new(113, 335.8, 571.2), true) end, Color3.fromRGB(40, 140, 140))
addBtn(tabCombat, "GET ПАТРОНЫ", function() tp(CFrame.new(185.2, 314.3, 438.4), true) end, Color3.fromRGB(40, 140, 40))
addBtn(tabCombat, "GET ДИГЛ", function() tp(CFrame.new(56.8, 296.5, 265), true) end, Color3.fromRGB(40, 70, 170))
addBtn(tabCombat, "GET МП5", function() tp(CFrame.new(-147.7, 313.8, 281.1), true) end, Color3.fromRGB(75, 75, 75))
addBtn(tabCombat, "GET БЕРЕТЫ", function() tp(CFrame.new(229.96, 373.86, 50.13), true) end, Color3.fromRGB(200, 150, 50))

-- TELEPORT
addBtn(tabTP, "TP 1", function() tp(CFrame.new(174.9, 311, 371), false) end)
addBtn(tabTP, "TP 2", function() tp(CFrame.new(196.9, 313.4, 372.8), false) end)
addBtn(tabTP, "TP RANDOM", function()
    local p = game.Players:GetPlayers()
    table.remove(p, table.find(p, player))
    if #p > 0 then
        local t = p[math.random(1,#p)]
        if t.Character and t.Character:FindFirstChild("HumanoidRootPart") then tp(t.Character.HumanoidRootPart.CFrame, false) end
    end
end, Color3.fromRGB(80, 80, 150))

-- TROLL
addBtn(tabTroll, "Esp all: OFF", function(b) 
    espEnabled = not espEnabled 
    b.Text = "Esp all: "..(espEnabled and "ON" or "OFF") 
    b.BackgroundColor3 = espEnabled and Color3.fromRGB(0,150,0) or Color3.fromRGB(50,50,50) 
end)

addBtn(tabTroll, "Hitbox all: OFF", function(b) 
    hitboxEnabled = not hitboxEnabled 
    b.Text = "Hitbox all: "..(hitboxEnabled and "ON" or "OFF") 
    b.BackgroundColor3 = hitboxEnabled and Color3.fromRGB(0,150,0) or Color3.fromRGB(50,50,50) 
end)

addBtn(tabTroll, "HpEsp all: OFF", function(b)
    hpEspEnabled = not hpEspEnabled
    b.Text = "HpEsp all: "..(hpEspEnabled and "ON" or "OFF")
    b.BackgroundColor3 = hpEspEnabled and Color3.fromRGB(0,100,200) or Color3.fromRGB(50,50,50)
    
    if not hpEspEnabled then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("HpEsp") then
                v.Character.HpEsp:Destroy()
            end
        end
    end
end)

-- AREA 51
addBtn(tabArea51, "Get патроны", function() 
    tp(CFrame.new(184.373947, 314.102753, 437.209137, -0.941430867, -3.7041751e-08, -0.337206006, -2.10029727e-09, 1, -1.03985293e-07, 0.337206006, -9.71867351e-08, -0.941430867), true) 
end, Color3.fromRGB(255, 215, 0))

addBtn(tabArea51, "Get дробовик", function() 
    tp(CFrame.new(169.514648, 313.777954, 439.303528, -0.999640346, -0.00418779766, 0.0264875852, -0.00472095702, 0.999786854, -0.0200982448, -0.0263977721, -0.0202160627, -0.999447107), true) 
end, Color3.fromRGB(255, 140, 0))

addBtn(tabArea51, "Get MP5", function() 
    tp(CFrame.new(276.345459, 313.97998, 379.311615, -0.999999404, -1.24689168e-05, 0.00111457845, -1.32938621e-05, 0.999999702, -0.000740136718, -0.00111456891, -0.000740151096, -0.999999106), true) 
end, Color3.fromRGB(100, 149, 237))

addBtn(tabArea51, "Get desertEagle", function() 
    tp(CFrame.new(388.24176, 517.979919, 288.101135, -0.999999702, -8.38141645e-08, -0.000738911913, -8.38194154e-08, 1, 7.07209002e-09, 0.000738911913, 7.13402315e-09, -0.999999702), true) 
end, Color3.fromRGB(210, 180, 140))

addBtn(tabArea51, "Get Sniper", function() 
    tp(CFrame.new(403.631653, 512.779968, 463.301208, -0.99999994, 1.72834191e-08, -0.000376791257, 1.72725585e-08, 1, 2.88291577e-08, 0.000376791257, 2.88226474e-08, -0.99999994), true) 
end, Color3.fromRGB(138, 43, 226))

-- KILLERS
local killersTitle = Instance.new("TextLabel")
killersTitle.Parent = tabKillers
killersTitle.Size = UDim2.new(1, 0, 0, 35)
killersTitle.Text = "KILLERS MENU"
killersTitle.TextColor3 = Color3.new(1, 0, 0)
killersTitle.BackgroundTransparency = 1
killersTitle.Font = Enum.Font.GothamBold
killersTitle.TextSize = 18

-- Поле ввода ника
createInput(tabKillers, "Введите ник жертвы:", "", function(inputText)
    if not isPlayerKillers() then
        showNotification(tabKillers, "You No Killers!", Color3.fromRGB(255, 0, 0), 140)
        return
    end
    
    local target = findPlayerByName(inputText, true)
    if target then
        showNotification(tabKillers, "Атака на "..target.Name.."!", Color3.fromRGB(0, 255, 0), 140)
        attackPlayer(target)
    else
        showNotification(tabKillers, "Игрок не найден!", Color3.fromRGB(255, 0, 0), 140)
    end
end, true, false)

-- Кнопка Kill All
local killAllBtn = Instance.new("TextButton")
killAllBtn.Parent = tabKillers
killAllBtn.Size = UDim2.new(1, 0, 0, 45)
killAllBtn.Position = UDim2.new(0, 0, 0, 100)
killAllBtn.Text = "KILL ALL: OFF"
killAllBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
killAllBtn.TextColor3 = Color3.new(1, 1, 1)
killAllBtn.Font = Enum.Font.GothamBold
killAllBtn.TextSize = 16

local killAllCorner = Instance.new("UICorner")
killAllCorner.CornerRadius = UDim.new(0, 8)
killAllCorner.Parent = killAllBtn

-- Переменные для контроля цикла
local killAllRunning = false

killAllBtn.MouseButton1Click:Connect(function()
    if not isPlayerKillers() then
        showNotification(tabKillers, "You No Killers!", Color3.fromRGB(255, 0, 0), 160)
        return
    end
    
    killAllActive = not killAllActive
    killAllBtn.Text = "KILL ALL: "..(killAllActive and "ON" or "OFF")
    killAllBtn.BackgroundColor3 = killAllActive and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(50, 50, 50)
    
    if killAllActive then
        killAllRunning = true
        task.spawn(function()
            while killAllActive and killAllRunning do
                if not isPlayerKillers() then
                    killAllActive = false
                    killAllRunning = false
                    killAllBtn.Text = "KILL ALL: OFF"
                    killAllBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    showNotification(tabKillers, "You No Killers!", Color3.fromRGB(255, 0, 0), 160)
                    break
                end
                
                local survivors = getSurvivors()
                if #survivors > 0 then
                    for _, target in ipairs(survivors) do
                        if not killAllActive or not killAllRunning then break end
                        attackPlayer(target)
                        task.wait(0.5)
                    end
                else
                    task.wait(1)
                end
            end
        end)
    else
        killAllRunning = false
    end
end)

-- Информация
local killersInfo = Instance.new("TextLabel")
killersInfo.Parent = tabKillers
killersInfo.Size = UDim2.new(1, 0, 0, 70)
killersInfo.Position = UDim2.new(0, 0, 0, 160)
killersInfo.Text = "• Можно вводить часть ника\n• Kill All атакует всех выживших\n• Атака длится 4 секунды"
killersInfo.TextColor3 = Color3.fromRGB(150, 150, 150)
killersInfo.BackgroundTransparency = 1
killersInfo.Font = Enum.Font.Gotham
killersInfo.TextSize = 12
killersInfo.TextWrapped = true
killersInfo.TextXAlignment = Enum.TextXAlignment.Left

-- SURVIVOR
local survivorTitle = Instance.new("TextLabel")
survivorTitle.Parent = tabSurvivor
survivorTitle.Size = UDim2.new(1, 0, 0, 35)
survivorTitle.Text = "SURVIVOR MENU"
survivorTitle.TextColor3 = Color3.fromRGB(0, 150, 255)
survivorTitle.BackgroundTransparency = 1
survivorTitle.Font = Enum.Font.GothamBold
survivorTitle.TextSize = 18

-- Поле ввода ника для Survivor
createInput(tabSurvivor, "Введите ник Killers:", "", function(inputText)
    if not isPlayerSurvivor() then
        showNotification(tabSurvivor, "You Not A Survivor!", Color3.fromRGB(255, 0, 0), 140)
        return
    end
    
    local target = findPlayerByName(inputText, true)
    if target then
        -- Проверяем, что цель - Killers
        local tTeam = "Survivors"
        local ts = target:FindFirstChild("leaderstats")
        if ts and ts:FindFirstChild("Team") then tTeam = ts.Team.Value
        elseif target.Team then tTeam = target.Team.Name end
        
        if tTeam == "Killers" then
            showNotification(tabSurvivor, "Захват "..target.Name.."!", Color3.fromRGB(0, 255, 0), 140)
            teleportIntoPlayer(target) -- ИСПОЛЬЗУЕМ ИСПРАВЛЕННУЮ ФУНКЦИЮ С ЗАХВАТОМ
        else
            showNotification(tabSurvivor, "Это не Killers!", Color3.fromRGB(255, 165, 0), 140)
        end
    else
        showNotification(tabSurvivor, "Игрок не найден!", Color3.fromRGB(255, 0, 0), 140)
    end
end, false, true)

-- Кнопка Kill All Killers
local survivorKillAllBtn = Instance.new("TextButton")
survivorKillAllBtn.Parent = tabSurvivor
survivorKillAllBtn.Size = UDim2.new(1, 0, 0, 45)
survivorKillAllBtn.Position = UDim2.new(0, 0, 0, 100)
survivorKillAllBtn.Text = "KILL ALL KILLERS: OFF"
survivorKillAllBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
survivorKillAllBtn.TextColor3 = Color3.new(1, 1, 1)
survivorKillAllBtn.Font = Enum.Font.GothamBold
survivorKillAllBtn.TextSize = 14

local survivorKillAllCorner = Instance.new("UICorner")
survivorKillAllCorner.CornerRadius = UDim.new(0, 8)
survivorKillAllCorner.Parent = survivorKillAllBtn

-- Переменные для контроля цикла Survivor
local survivorKillAllRunning = false

survivorKillAllBtn.MouseButton1Click:Connect(function()
    if not isPlayerSurvivor() then
        showNotification(tabSurvivor, "You Not A Survivor!", Color3.fromRGB(255, 0, 0), 160)
        return
    end
    
    survivorKillAllActive = not survivorKillAllActive
    survivorKillAllBtn.Text = "KILL ALL KILLERS: "..(survivorKillAllActive and "ON" or "OFF")
    survivorKillAllBtn.BackgroundColor3 = survivorKillAllActive and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(50, 50, 50)
    
    if survivorKillAllActive then
        survivorKillAllRunning = true
        task.spawn(function()
            while survivorKillAllActive and survivorKillAllRunning do
                if not isPlayerSurvivor() then
                    survivorKillAllActive = false
                    survivorKillAllRunning = false
                    survivorKillAllBtn.Text = "KILL ALL KILLERS: OFF"
                    survivorKillAllBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    showNotification(tabSurvivor, "You Not A Survivor!", Color3.fromRGB(255, 0, 0), 160)
                    break
                end
                
                local killers = getKillers()
                if #killers > 0 then
                    for _, target in ipairs(killers) do
                        if not survivorKillAllActive or not survivorKillAllRunning then break end
                        showNotification(tabSurvivor, "Захват "..target.Name.."!", Color3.fromRGB(0, 150, 255), 160)
                        teleportIntoPlayer(target) -- ИСПОЛЬЗУЕМ ИСПРАВЛЕННУЮ ФУНКЦИЮ
                        task.wait(0.5)
                    end
                else
                    task.wait(1)
                end
            end
        end)
    else
        survivorKillAllRunning = false
    end
end)

-- Информация для Survivor
local survivorInfo = Instance.new("TextLabel")
survivorInfo.Parent = tabSurvivor
survivorInfo.Size = UDim2.new(1, 0, 0, 90)
survivorInfo.Position = UDim2.new(0, 0, 0, 160)
survivorInfo.Text = "• Телепорт ПРЯМО В Killers (Y+2.5)\n• Захват через Touched + проверка Magnitude\n• Жертва летит с тобой в космос (Y=999)\n• Ты возвращаешься, жертва падает"
survivorInfo.TextColor3 = Color3.fromRGB(150, 150, 150)
survivorInfo.BackgroundTransparency = 1
survivorInfo.Font = Enum.Font.Gotham
survivorInfo.TextSize = 12
survivorInfo.TextWrapped = true
survivorInfo.TextXAlignment = Enum.TextXAlignment.Left

-- SETTINGS
-- Заголовок
local settingsTitle = Instance.new("TextLabel")
settingsTitle.Parent = tabSettings
settingsTitle.Size = UDim2.new(1, 0, 0, 35)
settingsTitle.Text = "НАСТРОЙКИ ГУИ"
settingsTitle.TextColor3 = Color3.new(1, 1, 1)
settingsTitle.BackgroundTransparency = 1
settingsTitle.Font = Enum.Font.GothamBold
settingsTitle.TextSize = 16

-- Кнопки выбора цвета
local colorFrame = Instance.new("Frame")
colorFrame.Parent = tabSettings
colorFrame.Size = UDim2.new(1, 0, 0, 45)
colorFrame.BackgroundTransparency = 1

local standardBtn = Instance.new("TextButton")
standardBtn.Parent = colorFrame
standardBtn.Size = UDim2.new(0.3, -2, 0, 30)
standardBtn.Position = UDim2.new(0, 0, 0, 0)
standardBtn.Text = "Standard"
standardBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
standardBtn.TextColor3 = Color3.new(1, 1, 1)
standardBtn.Font = Enum.Font.Gotham
standardBtn.TextSize = 12
Instance.new("UICorner", standardBtn).CornerRadius = UDim.new(0, 6)
standardBtn.MouseButton1Click:Connect(function() changeGuiColor("standard") end)

local greenBtn = Instance.new("TextButton")
greenBtn.Parent = colorFrame
greenBtn.Size = UDim2.new(0.3, -2, 0, 30)
greenBtn.Position = UDim2.new(0.35, 0, 0, 0)
greenBtn.Text = "Green"
greenBtn.BackgroundColor3 = Color3.fromRGB(30, 80, 30)
greenBtn.TextColor3 = Color3.new(1, 1, 1)
greenBtn.Font = Enum.Font.Gotham
greenBtn.TextSize = 12
Instance.new("UICorner", greenBtn).CornerRadius = UDim.new(0, 6)
greenBtn.MouseButton1Click:Connect(function() changeGuiColor("green") end)

local redBtn = Instance.new("TextButton")
redBtn.Parent = colorFrame
redBtn.Size = UDim2.new(0.3, -2, 0, 30)
redBtn.Position = UDim2.new(0.7, 0, 0, 0)
redBtn.Text = "Red"
redBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
redBtn.TextColor3 = Color3.new(1, 1, 1)
redBtn.Font = Enum.Font.Gotham
redBtn.TextSize = 12
Instance.new("UICorner", redBtn).CornerRadius = UDim.new(0, 6)
redBtn.MouseButton1Click:Connect(function() changeGuiColor("red") end)

-- Разделитель
local separator = Instance.new("Frame")
separator.Parent = tabSettings
separator.Size = UDim2.new(1, 0, 0, 2)
separator.Position = UDim2.new(0, 0, 0, 50)
separator.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
separator.BorderSizePixel = 0

-- Заголовок для хитбокса
local hitboxTitle = Instance.new("TextLabel")
hitboxTitle.Parent = tabSettings
hitboxTitle.Size = UDim2.new(1, 0, 0, 35)
hitboxTitle.Position = UDim2.new(0, 0, 0, 60)
hitboxTitle.Text = "НАСТРОЙКИ ХИТБОКСА"
hitboxTitle.TextColor3 = Color3.new(1, 1, 1)
hitboxTitle.BackgroundTransparency = 1
hitboxTitle.Font = Enum.Font.GothamBold
hitboxTitle.TextSize = 16

-- Поле ввода для размера хитбокса
local function createSettingsInput(parent, placeholder, defaultValue, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = UDim2.new(1, 0, 0, 45)
    frame.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(1, 0, 0, 18)
    label.Text = placeholder
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local box = Instance.new("TextBox")
    box.Parent = frame
    box.Position = UDim2.new(0, 0, 0, 22)
    box.Size = UDim2.new(0.7, 0, 0, 23)
    box.Text = tostring(defaultValue)
    box.PlaceholderText = "Введите значение"
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    box.TextColor3 = Color3.new(1, 1, 1)
    box.Font = Enum.Font.Gotham
    box.TextSize = 13
    box.ClearTextOnFocus = false
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 6)
    boxCorner.Parent = box
    
    local applyBtn = Instance.new("TextButton")
    applyBtn.Parent = frame
    applyBtn.Position = UDim2.new(0.75, 0, 0, 22)
    applyBtn.Size = UDim2.new(0.25, -5, 0, 23)
    applyBtn.Text = "Применить"
    applyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    applyBtn.TextColor3 = Color3.new(1, 1, 1)
    applyBtn.Font = Enum.Font.Gotham
    applyBtn.TextSize = 11
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = applyBtn
    
    applyBtn.MouseButton1Click:Connect(function()
        local value = tonumber(box.Text)
        if value then
            callback(value)
        end
    end)
    
    box.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local value = tonumber(box.Text)
            if value then
                callback(value)
            end
        end
    end)
    
    return frame
end

createSettingsInput(tabSettings, "Размер хитбокса (по умолч. 30):", hitboxSize, function(value)
    hitboxSize = value
    local notification = Instance.new("TextLabel")
    notification.Parent = tabSettings
    notification.Size = UDim2.new(1, 0, 0, 25)
    notification.Position = UDim2.new(0, 0, 0, 140)
    notification.Text = "✓ Хитбокс изменен на "..value
    notification.TextColor3 = Color3.fromRGB(0, 255, 0)
    notification.BackgroundTransparency = 1
    notification.Font = Enum.Font.Gotham
    notification.TextSize = 13
    task.delay(2, function() notification:Destroy() end)
end)

-- Информация
local infoLabel = Instance.new("TextLabel")
infoLabel.Parent = tabSettings
infoLabel.Size = UDim2.new(1, 0, 0, 45)
infoLabel.Position = UDim2.new(0, 0, 0, 170)
infoLabel.Text = "Значение по умолчанию: 30\nРекомендуется: 30-50"
infoLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
infoLabel.BackgroundTransparency = 1
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 11
infoLabel.TextWrapped = true

-- MENU
local l = Instance.new("TextLabel", tabMenu)
l.Size = UDim2.new(1,0,0,45)
l.Text = "Created By\nxXram000dieXx"
l.TextColor3, l.BackgroundTransparency, l.Font, l.TextSize = Color3.new(1,1,1), 1, Enum.Font.GothamBold, 14

-- СВОРАЧИВАНИЕ
local open = true
ToggleBtn.MouseButton1Click:Connect(function()
    open = not open
    MainFrame:TweenSize(open and UDim2.new(0, 350, 0, 400) or UDim2.new(0, 350, 0, 40), "Out", "Quart", 0.3, true)
    Sidebar.Visible, Container.Visible = open, open
end)

tabs["Menu"].Visible = true
