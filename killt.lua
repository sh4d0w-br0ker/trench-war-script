--[[
    УНИВЕРСАЛЬНЫЙ KILL СКРИПТ
    Работает на любого игрока, без проверки роли
    Использует Touch захват
]]

local player = game.Players.LocalPlayer

local function killPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then 
        warn("Игрок не найден или нет персонажа")
        return 
    end
    
    local targetChar = targetPlayer.Character
    local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetHrp then 
        warn("У цели нет HumanoidRootPart")
        return 
    end
    
    -- Сохраняем свою позицию
    local myChar = player.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then 
        warn("У вас нет персонажа")
        return 
    end
    
    local myOldPos = myChar.HumanoidRootPart.CFrame
    
    -- ШАГ 1: Телепортируемся ПРЯМО В ЖЕРТВУ (чуть выше для захвата)
    myChar.HumanoidRootPart.CFrame = targetHrp.CFrame * CFrame.new(0, 2.5, 0)
    
    -- Ждем чтобы сработали Touched события
    task.wait(0.3)
    
    -- Проверяем захват через Magnitude
    local distance = (myChar.HumanoidRootPart.Position - targetHrp.Position).Magnitude
    if distance < 5 then
        print("✅ Захват сработал! Жертва прилипла!")
    else
        print("⚠️ Захват может не сработать, пробуем еще...")
        -- Пробуем еще раз, телепортируемся точнее
        myChar.HumanoidRootPart.CFrame = targetHrp.CFrame
        task.wait(0.2)
    end
    
    -- ШАГ 2: Теперь мы касаемся друг друга, забираем жертву в космос
    local spacePos = CFrame.new(0, 999, 0) -- Высота 999
    myChar.HumanoidRootPart.CFrame = spacePos
    -- Жертва автоматом летит со мной потому что Touch сработал!
    
    -- ШАГ 3: Ждем 2 секунды пока летим
    task.wait(2)
    
    -- ШАГ 4: Возвращаемся обратно
    myChar.HumanoidRootPart.CFrame = myOldPos
    -- Жертва остается в космосе и падает вниз (умирает)
    
    print("✅ Жертва отправлена в космос!")
end

-- Функция для поиска игрока по имени (можно вводить часть ника)
local function findPlayerByName(partialName)
    partialName = partialName:lower()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Name:lower():find(partialName) then
            return v
        end
    end
    return nil
end

-- Функция для создания простого GUI
local function createKillGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KillGUI"
    screenGui.Parent = game:GetService("CoreGui")
    screenGui.ResetOnSpawn = false
    
    local frame = Instance.new("Frame")
    frame.Parent = screenGui
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.Position = UDim2.new(0.35, 0, 0.3, 0)
    frame.Size = UDim2.new(0, 250, 0, 150)
    frame.BorderSizePixel = 0
    frame.Active = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Parent = frame
    title.Size = UDim2.new(1, 0, 0, 35)
    title.Text = "UNIVERSAL KILL"
    title.TextColor3 = Color3.fromRGB(255, 50, 50)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    
    local box = Instance.new("TextBox")
    box.Parent = frame
    box.Size = UDim2.new(0.8, 0, 0, 30)
    box.Position = UDim2.new(0.1, 0, 0, 45)
    box.PlaceholderText = "Введите ник"
    box.Text = ""
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.ClearTextOnFocus = false
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 6)
    boxCorner.Parent = box
    
    local killBtn = Instance.new("TextButton")
    killBtn.Parent = frame
    killBtn.Size = UDim2.new(0.6, 0, 0, 35)
    killBtn.Position = UDim2.new(0.2, 0, 0, 90)
    killBtn.Text = "KILL"
    killBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    killBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    killBtn.Font = Enum.Font.GothamBold
    killBtn.TextSize = 16
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = killBtn
    
    local message = Instance.new("TextLabel")
    message.Parent = screenGui
    message.Size = UDim2.new(0, 300, 0, 30)
    message.Position = UDim2.new(0.7, 0, 0.9, 0)
    message.BackgroundTransparency = 1
    message.TextColor3 = Color3.fromRGB(255, 0, 0)
    message.Font = Enum.Font.Gotham
    message.TextSize = 14
    message.Text = ""
    message.TextXAlignment = Enum.TextXAlignment.Right
    
    -- Функция для показа уведомления
    local function showMsg(text, color)
        message.TextColor3 = color or Color3.fromRGB(255, 255, 255)
        message.Text = text
        task.delay(3, function() message.Text = "" end)
    end
    
    -- Обработка кнопки
    killBtn.MouseButton1Click:Connect(function()
        local target = findPlayerByName(box.Text)
        if target then
            showMsg("🔪 Убиваем "..target.Name.."...", Color3.fromRGB(0, 255, 0))
            killPlayer(target)
            box.Text = ""
        else
            showMsg("❌ Игрок не найден!", Color3.fromRGB(255, 0, 0))
        end
    end)
    
    -- Обработка Enter
    box.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local target = findPlayerByName(box.Text)
            if target then
                showMsg("🔪 Убиваем "..target.Name.."...", Color3.fromRGB(0, 255, 0))
                killPlayer(target)
                box.Text = ""
            else
                showMsg("❌ Игрок не найден!", Color3.fromRGB(255, 0, 0))
            end
        end
    end)
    
    -- Перетаскивание окна
    local dragToggle, dragStart, startPos
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragToggle = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragToggle = false end
            end)
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragToggle then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    return screenGui
end

-- ЗАПУСК
print("✅ Универсальный Kill скрипт загружен!")
print("📝 Введи ник в поле и нажми KILL или Enter")
createKillGUI()
