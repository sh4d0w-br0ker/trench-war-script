--[[
ULTRA SIMPLE KILASIK FLING
С кнопкой УБРАТЬ ВСЕХ и списком игроков
]]

-- Отключаем защиту если есть
pcall(function() 
    getgenv().OldPos = nil
    getgenv().FPDH = workspace.FallenPartsDestroyHeight
end)

-- Переменные
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local SelectedTargets = {}
local FlingActive = false

-- Создаем GUI самым простым способом
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlingGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui") or Player.PlayerGui

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 200)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 25)
Title.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Title.Text = "KILASIK FLING"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.Parent = MainFrame

-- Поле ввода
local InputBox = Instance.new("TextBox")
InputBox.Position = UDim2.new(0, 5, 0, 30)
InputBox.Size = UDim2.new(1, -10, 0, 25)
InputBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
InputBox.Text = ""
InputBox.PlaceholderText = "Выбери игрока ↓"
InputBox.TextColor3 = Color3.new(1, 1, 1)
InputBox.Font = Enum.Font.SourceSans
InputBox.TextSize = 14
InputBox.Parent = MainFrame

-- Кнопка добавить (теперь открывает список)
local AddBtn = Instance.new("TextButton")
AddBtn.Position = UDim2.new(0, 5, 0, 60)
AddBtn.Size = UDim2.new(0.33, -5, 0, 30)
AddBtn.BackgroundColor3 = Color3.new(0.3, 0.3, 1)
AddBtn.Text = "ДОБАВИТЬ"
AddBtn.TextColor3 = Color3.new(1, 1, 1)
AddBtn.Font = Enum.Font.SourceSansBold
AddBtn.TextSize = 12
AddBtn.Parent = MainFrame

-- Кнопка выбрать всех
local AllBtn = Instance.new("TextButton")
AllBtn.Position = UDim2.new(0.34, 2, 0, 60)
AllBtn.Size = UDim2.new(0.33, -5, 0, 30)
AllBtn.BackgroundColor3 = Color3.new(1, 0.5, 0)
AllBtn.Text = "ВСЕ"
AllBtn.TextColor3 = Color3.new(1, 1, 1)
AllBtn.Font = Enum.Font.SourceSansBold
AllBtn.TextSize = 12
AllBtn.Parent = MainFrame

-- Кнопка убрать всех (НОВАЯ)
local RemoveAllBtn = Instance.new("TextButton")
RemoveAllBtn.Position = UDim2.new(0.67, 2, 0, 60)
RemoveAllBtn.Size = UDim2.new(0.33, -7, 0, 30)
RemoveAllBtn.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
RemoveAllBtn.Text = "УБРАТЬ"
RemoveAllBtn.TextColor3 = Color3.new(1, 1, 1)
RemoveAllBtn.Font = Enum.Font.SourceSansBold
RemoveAllBtn.TextSize = 12
RemoveAllBtn.Parent = MainFrame

-- Кнопка флинг
local FlingBtn = Instance.new("TextButton")
FlingBtn.Position = UDim2.new(0, 5, 0, 95)
FlingBtn.Size = UDim2.new(0.5, -7, 0, 30)
FlingBtn.BackgroundColor3 = Color3.new(0, 0.8, 0)
FlingBtn.Text = "ФЛИНГ"
FlingBtn.TextColor3 = Color3.new(1, 1, 1)
FlingBtn.Font = Enum.Font.SourceSansBold
FlingBtn.TextSize = 14
FlingBtn.Parent = MainFrame

-- Кнопка стоп
local StopBtn = Instance.new("TextButton")
StopBtn.Position = UDim2.new(0.5, 2, 0, 95)
StopBtn.Size = UDim2.new(0.5, -7, 0, 30)
StopBtn.BackgroundColor3 = Color3.new(0.8, 0, 0)
StopBtn.Text = "СТОП"
StopBtn.TextColor3 = Color3.new(1, 1, 1)
StopBtn.Font = Enum.Font.SourceSansBold
StopBtn.TextSize = 14
StopBtn.Parent = MainFrame

-- Статус
local Status = Instance.new("TextLabel")
Status.Position = UDim2.new(0, 5, 0, 130)
Status.Size = UDim2.new(1, -10, 0, 15)
Status.BackgroundTransparency = 1
Status.Text = "Готов"
Status.TextColor3 = Color3.new(0.7, 0.7, 0.7)
Status.Font = Enum.Font.SourceSans
Status.TextSize = 12
Status.Parent = MainFrame

-- Счетчик целей
local Counter = Instance.new("TextLabel")
Counter.Position = UDim2.new(0, 5, 0, 145)
Counter.Size = UDim2.new(1, -10, 0, 15)
Counter.BackgroundTransparency = 1
Counter.Text = "Целей: 0"
Counter.TextColor3 = Color3.new(1, 1, 0)
Counter.Font = Enum.Font.SourceSansBold
Counter.TextSize = 12
Counter.Parent = MainFrame

-- Кнопка закрыть (маленькая в углу)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Position = UDim2.new(1, -20, 0, 0)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.BackgroundColor3 = Color3.new(1, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 14
CloseBtn.Parent = Title

-- Окно выбора игроков (появляется при нажатии ДОБАВИТЬ)
local PlayerListFrame = Instance.new("Frame")
PlayerListFrame.Size = UDim2.new(1, 0, 0, 150)
PlayerListFrame.Position = UDim2.new(0, 0, 1, 5)
PlayerListFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.Visible = false
PlayerListFrame.ZIndex = 10
PlayerListFrame.Parent = InputBox

local PlayerListTitle = Instance.new("TextLabel")
PlayerListTitle.Size = UDim2.new(1, 0, 0, 20)
PlayerListTitle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
PlayerListTitle.Text = "ВЫБЕРИ ИГРОКА"
PlayerListTitle.TextColor3 = Color3.new(1, 1, 1)
PlayerListTitle.Font = Enum.Font.SourceSansBold
PlayerListTitle.TextSize = 12
PlayerListTitle.ZIndex = 10
PlayerListTitle.Parent = PlayerListFrame

local PlayerScroll = Instance.new("ScrollingFrame")
PlayerScroll.Size = UDim2.new(1, 0, 1, -20)
PlayerScroll.Position = UDim2.new(0, 0, 0, 20)
PlayerScroll.BackgroundTransparency = 1
PlayerScroll.BorderSizePixel = 0
PlayerScroll.ScrollBarThickness = 5
PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerScroll.ZIndex = 10
PlayerScroll.Parent = PlayerListFrame

-- Функция обновления списка игроков
local function UpdatePlayerList()
    -- Очищаем список
    for _, child in pairs(PlayerScroll:GetChildren()) do
        child:Destroy()
    end
    
    local yPos = 0
    local players = Players:GetPlayers()
    table.sort(players, function(a, b) return a.Name:lower() < b.Name:lower() end)
    
    for _, player in ipairs(players) do
        if player ~= Player then
            local playerBtn = Instance.new("TextButton")
            playerBtn.Size = UDim2.new(1, -10, 0, 25)
            playerBtn.Position = UDim2.new(0, 5, 0, yPos)
            playerBtn.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
            playerBtn.BorderSizePixel = 0
            playerBtn.Text = player.Name
            playerBtn.TextColor3 = Color3.new(1, 1, 1)
            playerBtn.Font = Enum.Font.SourceSans
            playerBtn.TextSize = 14
            playerBtn.ZIndex = 10
            playerBtn.Parent = PlayerScroll
            
            -- Подсветка при наведении
            playerBtn.MouseEnter:Connect(function()
                playerBtn.BackgroundColor3 = Color3.new(0.35, 0.35, 0.35)
            end)
            playerBtn.MouseLeave:Connect(function()
                playerBtn.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
            end)
            
            -- Выбор игрока
            playerBtn.MouseButton1Click:Connect(function()
                InputBox.Text = player.Name
                PlayerListFrame.Visible = false
                -- Автоматически добавляем игрока
                SelectedTargets[player.Name] = player
                
                local count = 0
                for _ in pairs(SelectedTargets) do count = count + 1 end
                Counter.Text = "Целей: " .. count
                Status.Text = "Добавлен: " .. player.Name
            end)
            
            yPos = yPos + 27
        end
    end
    
    PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- Показать/скрыть список игроков при нажатии на кнопку ДОБАВИТЬ
AddBtn.MouseButton1Click:Connect(function()
    UpdatePlayerList()
    PlayerListFrame.Visible = not PlayerListFrame.Visible
end)

-- Скрывать список при клике вне его
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        wait()
        if PlayerListFrame.Visible then
            local mousePos = game:GetService("UserInputService"):GetMouseLocation()
            local framePos = PlayerListFrame.AbsolutePosition
            local frameSize = PlayerListFrame.AbsoluteSize
            
            if mousePos.X < framePos.X or mousePos.X > framePos.X + frameSize.X or
               mousePos.Y < framePos.Y or mousePos.Y > framePos.Y + frameSize.Y then
                PlayerListFrame.Visible = false
            end
        end
    end
end)

-- Функция обновления счетчика
local function UpdateCounter()
    local count = 0
    for _ in pairs(SelectedTargets) do count = count + 1 end
    Counter.Text = "Целей: " .. count
end

-- Выбрать всех
AllBtn.MouseButton1Click:Connect(function()
    SelectedTargets = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Player then
            SelectedTargets[player.Name] = player
        end
    end
    UpdateCounter()
    Status.Text = "Выбрано ВСЕ"
end)

-- Убрать всех (НОВАЯ КНОПКА)
RemoveAllBtn.MouseButton1Click:Connect(function()
    SelectedTargets = {}
    UpdateCounter()
    Status.Text = "Список очищен"
end)

-- Флинг
FlingBtn.MouseButton1Click:Connect(function()
    local count = 0
    for _ in pairs(SelectedTargets) do count = count + 1 end
    
    if count == 0 then
        Status.Text = "Нет целей!"
        return
    end
    
    FlingActive = true
    Status.Text = "ФЛИНГАЮ " .. count .. " целей..."
    
    spawn(function()
        while FlingActive do
            for name, player in pairs(SelectedTargets) do
                if FlingActive and player and player.Parent then
                    flingPlayer(player)
                    wait(0.1)
                end
            end
            wait(0.5)
        end
    end)
end)

-- Стоп
StopBtn.MouseButton1Click:Connect(function()
    FlingActive = false
    Status.Text = "Остановлено"
end)

-- Закрыть
CloseBtn.MouseButton1Click:Connect(function()
    FlingActive = false
    ScreenGui:Destroy()
end)

-- ОРИГИНАЛЬНАЯ ФУНКЦИЯ ФЛИНГА (ПОЛНОСТЬЮ ИЗ ТВОЕГО КОДА)
local function flingPlayer(TargetPlayer)
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart
    local TCharacter = TargetPlayer.Character
    if not TCharacter then return end

    local THumanoid  
    local TRootPart  
    local THead  
    local Accessory  
    local Handle  
    
    if TCharacter:FindFirstChildOfClass("Humanoid") then  
        THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")  
    end  
    if THumanoid and THumanoid.RootPart then  
        TRootPart = THumanoid.RootPart  
    end  
    if TCharacter:FindFirstChild("Head") then  
        THead = TCharacter.Head  
    end  
    if TCharacter:FindFirstChildOfClass("Accessory") then  
        Accessory = TCharacter:FindFirstChildOfClass("Accessory")  
    end  
    if Accessory and Accessory:FindFirstChild("Handle") then  
        Handle = Accessory.Handle  
    end  
    
    if Character and Humanoid and RootPart then  
        if RootPart.Velocity.Magnitude < 50 then  
            getgenv().OldPos = RootPart.CFrame  
        end  
        
        if THumanoid and THumanoid.Sit then  
            Status.Text = "Ошибка: " .. TargetPlayer.Name .. " сидит"
            return  
        end  
        
        if THead then  
            workspace.CurrentCamera.CameraSubject = THead  
        elseif Handle then  
            workspace.CurrentCamera.CameraSubject = Handle  
        elseif THumanoid and TRootPart then  
            workspace.CurrentCamera.CameraSubject = THumanoid  
        end  
        
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then  
            return  
        end  
        
        local FPos = function(BasePart, Pos, Ang)  
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang  
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)  
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)  
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)  
        end  
        
        local SFBasePart = function(BasePart)  
            local TimeToWait = 2  
            local Time = tick()  
            local Angle = 0  
            repeat  
                if RootPart and THumanoid then  
                    if BasePart.Velocity.Magnitude < 50 then  
                        Angle = Angle + 100  
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))  
                        task.wait()  
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))  
                        task.wait()  
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))  
                        task.wait()  
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))  
                        task.wait()  
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle),0 ,0))  
                        task.wait()  
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))  
                        task.wait()  
                    else  
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))  
                        task.wait()  
                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))  
                        task.wait()  
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))  
                        task.wait()  
                        
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))  
                        task.wait()  
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))  
                        task.wait()  
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))  
                        task.wait()  
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))  
                        task.wait()  
                    end  
                end  
            until Time + TimeToWait < tick() or not FlingActive  
        end  
        
        workspace.FallenPartsDestroyHeight = 0/0  
        
        local BV = Instance.new("BodyVelocity")  
        BV.Parent = RootPart  
        BV.Velocity = Vector3.new(0, 0, 0)  
        BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)  
        
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)  
        
        if TRootPart then  
            SFBasePart(TRootPart)  
        elseif THead then  
            SFBasePart(THead)  
        elseif Handle then  
            SFBasePart(Handle)  
        else  
            Status.Text = "Нет частей для флинга"  
            return
        end  
        
        BV:Destroy()  
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)  
        workspace.CurrentCamera.CameraSubject = Humanoid  
        
        if getgenv().OldPos then  
            repeat  
                RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)  
                Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))  
                Humanoid:ChangeState("GettingUp")  
                for _, part in pairs(Character:GetChildren()) do  
                    if part:IsA("BasePart") then  
                        part.Velocity, part.RotVelocity = Vector3.new(), Vector3.new()  
                    end  
                end  
                task.wait()  
            until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25  
            workspace.FallenPartsDestroyHeight = getgenv().FPDH  
        end  
    end  
end

print([[ 
╔══════════════════════════════════╗
║   KILASIK FLING ЗАГРУЖЕН!        ║
╠══════════════════════════════════╣
║ • ДОБАВИТЬ - открыть список      ║
║ • ВСЕ - выбрать всех             ║
║ • УБРАТЬ - очистить список       ║
║ • ФЛИНГ/СТОП - запуск/остановка  ║
╚══════════════════════════════════╝
]])

-- Обновляем счетчик при старте
UpdateCounter()
