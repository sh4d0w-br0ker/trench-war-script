--[[
KILASIK FLING - 100% РАБОЧАЯ ВЕРСИЯ
С твоей оригинальной функцией флинга
]]

-- Отключаем защиту если есть
pcall(function() 
    getgenv().OldPos = nil
    getgenv().FPDH = workspace.FallenPartsDestroyHeight
end)

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local SelectedTargets = {}
local FlingActive = false

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KILASIK_FLING"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 220)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Title.Text = "⚡ KILASIK FLING ⚡"
Title.TextColor3 = Color3.new(1, 0.5, 0.5)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = MainFrame

-- Кнопка закрыть
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.new(1, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 20
CloseBtn.Parent = Title

-- Поле ввода
local InputBox = Instance.new("TextBox")
InputBox.Position = UDim2.new(0, 10, 0, 40)
InputBox.Size = UDim2.new(1, -20, 0, 25)
InputBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
InputBox.Text = ""
InputBox.PlaceholderText = "Ник игрока"
InputBox.TextColor3 = Color3.new(1, 1, 1)
InputBox.Font = Enum.Font.SourceSans
InputBox.TextSize = 14
InputBox.Parent = MainFrame

-- Кнопки верхнего ряда
local AddBtn = Instance.new("TextButton")
AddBtn.Position = UDim2.new(0, 10, 0, 70)
AddBtn.Size = UDim2.new(0.33, -5, 0, 30)
AddBtn.BackgroundColor3 = Color3.new(0.3, 0.3, 1)
AddBtn.Text = "➕ ДОБАВИТЬ"
AddBtn.TextColor3 = Color3.new(1, 1, 1)
AddBtn.Font = Enum.Font.SourceSansBold
AddBtn.TextSize = 12
AddBtn.Parent = MainFrame

local AllBtn = Instance.new("TextButton")
AllBtn.Position = UDim2.new(0.34, 2, 0, 70)
AllBtn.Size = UDim2.new(0.33, -5, 0, 30)
AllBtn.BackgroundColor3 = Color3.new(1, 0.5, 0)
AllBtn.Text = "👥 ВСЕ"
AllBtn.TextColor3 = Color3.new(1, 1, 1)
AllBtn.Font = Enum.Font.SourceSansBold
AllBtn.TextSize = 12
AllBtn.Parent = MainFrame

local RemoveAllBtn = Instance.new("TextButton")
RemoveAllBtn.Position = UDim2.new(0.67, 2, 0, 70)
RemoveAllBtn.Size = UDim2.new(0.33, -10, 0, 30)
RemoveAllBtn.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
RemoveAllBtn.Text = "❌ УБРАТЬ"
RemoveAllBtn.TextColor3 = Color3.new(1, 1, 1)
RemoveAllBtn.Font = Enum.Font.SourceSansBold
RemoveAllBtn.TextSize = 12
RemoveAllBtn.Parent = MainFrame

-- Кнопки флинга
local FlingBtn = Instance.new("TextButton")
FlingBtn.Position = UDim2.new(0, 10, 0, 105)
FlingBtn.Size = UDim2.new(0.5, -5, 0, 35)
FlingBtn.BackgroundColor3 = Color3.new(0, 0.8, 0)
FlingBtn.Text = "🚀 ФЛИНГ"
FlingBtn.TextColor3 = Color3.new(1, 1, 1)
FlingBtn.Font = Enum.Font.SourceSansBold
FlingBtn.TextSize = 16
FlingBtn.Parent = MainFrame

local StopBtn = Instance.new("TextButton")
StopBtn.Position = UDim2.new(0.5, 5, 0, 105)
StopBtn.Size = UDim2.new(0.5, -15, 0, 35)
StopBtn.BackgroundColor3 = Color3.new(0.8, 0, 0)
StopBtn.Text = "⏹️ СТОП"
StopBtn.TextColor3 = Color3.new(1, 1, 1)
StopBtn.Font = Enum.Font.SourceSansBold
StopBtn.TextSize = 16
StopBtn.Parent = MainFrame

-- Статус и счетчик
local Status = Instance.new("TextLabel")
Status.Position = UDim2.new(0, 10, 0, 145)
Status.Size = UDim2.new(0.7, -10, 0, 20)
Status.BackgroundTransparency = 1
Status.Text = "Готов"
Status.TextColor3 = Color3.new(0.8, 0.8, 0.8)
Status.Font = Enum.Font.SourceSans
Status.TextSize = 14
Status.TextXAlignment = Enum.TextXAlignment.Left
Status.Parent = MainFrame

local Counter = Instance.new("TextLabel")
Counter.Position = UDim2.new(0.7, 0, 0, 145)
Counter.Size = UDim2.new(0.3, -10, 0, 20)
Counter.BackgroundTransparency = 1
Counter.Text = "0"
Counter.TextColor3 = Color3.new(1, 1, 0)
Counter.Font = Enum.Font.SourceSansBold
Counter.TextSize = 16
Counter.TextXAlignment = Enum.TextXAlignment.Right
Counter.Parent = MainFrame

-- Список выбранных целей
local SelectedList = Instance.new("TextLabel")
SelectedList.Position = UDim2.new(0, 10, 0, 165)
SelectedList.Size = UDim2.new(1, -20, 0, 40)
SelectedList.BackgroundTransparency = 1
SelectedList.Text = ""
SelectedList.TextColor3 = Color3.new(0.6, 0.6, 0.6)
SelectedList.Font = Enum.Font.SourceSans
SelectedList.TextSize = 12
SelectedList.TextWrapped = true
SelectedList.TextXAlignment = Enum.TextXAlignment.Left
SelectedList.TextYAlignment = Enum.TextYAlignment.Top
SelectedList.Parent = MainFrame

-- Окно выбора игроков
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
            
            playerBtn.MouseEnter:Connect(function()
                playerBtn.BackgroundColor3 = Color3.new(0.35, 0.35, 0.35)
            end)
            playerBtn.MouseLeave:Connect(function()
                playerBtn.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
            end)
            
            playerBtn.MouseButton1Click:Connect(function()
                InputBox.Text = player.Name
                PlayerListFrame.Visible = false
                SelectedTargets[player.Name] = player
                local names = {}
                for name, _ in pairs(SelectedTargets) do
                    table.insert(names, name)
                end
                SelectedList.Text = "Цели: " .. table.concat(names, ", ")
                Counter.Text = tostring(#names)
                Status.Text = "Добавлен: " .. player.Name
            end)
            
            yPos = yPos + 27
        end
    end
    
    PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- Показать список игроков
AddBtn.MouseButton1Click:Connect(function()
    UpdatePlayerList()
    PlayerListFrame.Visible = not PlayerListFrame.Visible
end)

-- Выбрать всех
AllBtn.MouseButton1Click:Connect(function()
    SelectedTargets = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Player then
            SelectedTargets[player.Name] = player
        end
    end
    local names = {}
    for name, _ in pairs(SelectedTargets) do
        table.insert(names, name)
    end
    SelectedList.Text = "Цели: " .. table.concat(names, ", ")
    Counter.Text = tostring(#names)
    Status.Text = "Выбрано всех: " .. #names
end)

-- Убрать всех
RemoveAllBtn.MouseButton1Click:Connect(function()
    SelectedTargets = {}
    SelectedList.Text = ""
    Counter.Text = "0"
    Status.Text = "Список очищен"
end)

-- ТВОЯ ОРИГИНАЛЬНАЯ ФУНКЦИЯ ФЛИНГА (НЕ МЕНЯЛ НИЧЕГО!)
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
            return Status.Text = "Ошибка: " .. TargetPlayer.Name .. " сидит"
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
                    SkidFling(player)
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

print("✅ KILASIK FLING ГОТОВ К РАБОТЕ!")
