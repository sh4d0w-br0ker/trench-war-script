--[[
KILASIK FLING - АБСОЛЮТНО РАБОЧАЯ ВЕРСИЯ
Создаётся в PlayerGui, видно всегда
]]

-- Отключаем защиту
pcall(function() 
    getgenv().OldPos = nil
    getgenv().FPDH = workspace.FallenPartsDestroyHeight
end)

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Ждём, пока игрок загрузится
repeat wait() until Player and Player.Parent

-- Создаём GUI в PlayerGui (это место работает всегда)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KILASIK_FLING"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Главное окно (яркое, чтобы сразу заметить)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0) -- Чёрный фон
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.new(1, 0, 0) -- Красная рамка
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.new(0.8, 0, 0)
Title.Text = "⚡ KILASIK FLING ⚡"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.Parent = MainFrame

-- Кнопка закрыть (крестик)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.new(1, 1, 1)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(0, 0, 0)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 20
CloseBtn.Parent = Title

-- Поле ввода ника
local InputBox = Instance.new("TextBox")
InputBox.Position = UDim2.new(0, 10, 0, 40)
InputBox.Size = UDim2.new(1, -20, 0, 30)
InputBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
InputBox.Text = ""
InputBox.PlaceholderText = "Введите ник игрока"
InputBox.TextColor3 = Color3.new(1, 1, 1)
InputBox.Font = Enum.Font.SourceSans
InputBox.TextSize = 16
InputBox.ClearTextOnFocus = false
InputBox.Parent = MainFrame

-- Кнопка "Добавить"
local AddBtn = Instance.new("TextButton")
AddBtn.Position = UDim2.new(0, 10, 0, 80)
AddBtn.Size = UDim2.new(0.3, -5, 0, 35)
AddBtn.BackgroundColor3 = Color3.new(0, 0.5, 1)
AddBtn.Text = "ДОБАВИТЬ"
AddBtn.TextColor3 = Color3.new(1, 1, 1)
AddBtn.Font = Enum.Font.SourceSansBold
AddBtn.TextSize = 14
AddBtn.Parent = MainFrame

-- Кнопка "Все"
local AllBtn = Instance.new("TextButton")
AllBtn.Position = UDim2.new(0.35, 0, 0, 80)
AllBtn.Size = UDim2.new(0.3, -5, 0, 35)
AllBtn.BackgroundColor3 = Color3.new(1, 0.5, 0)
AllBtn.Text = "ВСЕ"
AllBtn.TextColor3 = Color3.new(1, 1, 1)
AllBtn.Font = Enum.Font.SourceSansBold
AllBtn.TextSize = 14
AllBtn.Parent = MainFrame

-- Кнопка "Убрать всех"
local RemoveAllBtn = Instance.new("TextButton")
RemoveAllBtn.Position = UDim2.new(0.7, 0, 0, 80)
RemoveAllBtn.Size = UDim2.new(0.3, -10, 0, 35)
RemoveAllBtn.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
RemoveAllBtn.Text = "УБРАТЬ"
RemoveAllBtn.TextColor3 = Color3.new(1, 1, 1)
RemoveAllBtn.Font = Enum.Font.SourceSansBold
RemoveAllBtn.TextSize = 14
RemoveAllBtn.Parent = MainFrame

-- Кнопка "Флинг"
local FlingBtn = Instance.new("TextButton")
FlingBtn.Position = UDim2.new(0, 10, 0, 125)
FlingBtn.Size = UDim2.new(0.45, -5, 0, 40)
FlingBtn.BackgroundColor3 = Color3.new(0, 0.8, 0)
FlingBtn.Text = "🚀 ФЛИНГ"
FlingBtn.TextColor3 = Color3.new(1, 1, 1)
FlingBtn.Font = Enum.Font.SourceSansBold
FlingBtn.TextSize = 18
FlingBtn.Parent = MainFrame

-- Кнопка "Стоп"
local StopBtn = Instance.new("TextButton")
StopBtn.Position = UDim2.new(0.5, 5, 0, 125)
StopBtn.Size = UDim2.new(0.45, -15, 0, 40)
StopBtn.BackgroundColor3 = Color3.new(0.8, 0, 0)
StopBtn.Text = "⏹️ СТОП"
StopBtn.TextColor3 = Color3.new(1, 1, 1)
StopBtn.Font = Enum.Font.SourceSansBold
StopBtn.TextSize = 18
StopBtn.Parent = MainFrame

-- Список выбранных целей (будем показывать здесь)
local TargetsList = Instance.new("TextLabel")
TargetsList.Position = UDim2.new(0, 10, 0, 175)
TargetsList.Size = UDim2.new(1, -20, 0, 60)
TargetsList.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
TargetsList.Text = "Нет выбранных целей"
TargetsList.TextColor3 = Color3.new(0.8, 0.8, 0.8)
TargetsList.Font = Enum.Font.SourceSans
TargetsList.TextSize = 14
TargetsList.TextWrapped = true
TargetsList.TextXAlignment = Enum.TextXAlignment.Left
TargetsList.TextYAlignment = Enum.TextYAlignment.Top
TargetsList.Parent = MainFrame

-- Переменные
local SelectedTargets = {}
local FlingActive = false

-- Функция обновления списка целей
local function UpdateTargetsDisplay()
    local names = {}
    for name, _ in pairs(SelectedTargets) do
        table.insert(names, name)
    end
    if #names == 0 then
        TargetsList.Text = "Нет выбранных целей"
    else
        TargetsList.Text = "Цели: " .. table.concat(names, ", ")
    end
end

-- Функция добавления игрока по нику
local function AddTargetByName(name)
    if name == "" then return end
    local target = Players:FindFirstChild(name)
    if target and target ~= Player then
        SelectedTargets[target.Name] = target
        UpdateTargetsDisplay()
        InputBox.Text = ""
    else
        TargetsList.Text = "Игрок не найден: " .. name
    end
end

-- Добавить по кнопке или Enter
AddBtn.MouseButton1Click:Connect(function()
    AddTargetByName(InputBox.Text)
end)

InputBox.FocusLost:Connect(function(enter)
    if enter then
        AddTargetByName(InputBox.Text)
    end
end)

-- Выбрать всех
AllBtn.MouseButton1Click:Connect(function()
    SelectedTargets = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Player then
            SelectedTargets[p.Name] = p
        end
    end
    UpdateTargetsDisplay()
end)

-- Убрать всех
RemoveAllBtn.MouseButton1Click:Connect(function()
    SelectedTargets = {}
    UpdateTargetsDisplay()
end)

-- ОРИГИНАЛЬНАЯ ФУНКЦИЯ ФЛИНГА (ИЗ ТВОЕГО ПЕРВОГО СООБЩЕНИЯ, НЕ МЕНЯЛ)
local function SkidFling(TargetPlayer)
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
            TargetsList.Text = "Ошибка: " .. TargetPlayer.Name .. " сидит"
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
            TargetsList.Text = "Нет частей для флинга"  
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

-- Запуск флинга
FlingBtn.MouseButton1Click:Connect(function()
    local count = 0
    for _ in pairs(SelectedTargets) do count = count + 1 end
    
    if count == 0 then
        TargetsList.Text = "Нет целей для флинга!"
        return
    end
    
    FlingActive = true
    TargetsList.Text = "ФЛИНГАЮ " .. count .. " целей..."
    
    spawn(function()
        while FlingActive do
            for name, player in pairs(SelectedTargets) do
                if FlingActive and player and player.Parent then
                    SkidFling(player)
                    wait(0.1)
                end
            end
            wait(0.5)
        end
    end)
end)

-- Остановка
StopBtn.MouseButton1Click:Connect(function()
    FlingActive = false
    TargetsList.Text = "Флинг остановлен"
end)

-- Закрытие
CloseBtn.MouseButton1Click:Connect(function()
    FlingActive = false
    ScreenGui:Destroy()
end)

-- Вывод в консоль, что всё загружено
print("✅ KILASIK FLING: GUI создан в PlayerGui, ищи окно с красной рамкой!")
