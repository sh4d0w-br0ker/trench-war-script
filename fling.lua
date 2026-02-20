--[[
KILASIK FLING - сворачиваемое окно
]]

pcall(function() 
    getgenv().OldPos = nil
    getgenv().FPDH = workspace.FallenPartsDestroyHeight
end)

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local SelectedTargets = {}
local FlingActive = false

repeat wait() until Player and Player.Parent

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KILASIK_FLING"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 240)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.new(0.6, 0, 0)
Title.Text = "⚡ KILASIK FLING ⚡"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = MainFrame

-- Кнопка сворачивания ( < )
local FoldBtn = Instance.new("TextButton")
FoldBtn.Size = UDim2.new(0, 30, 0, 30)
FoldBtn.Position = UDim2.new(0, 0, 0, 0)
FoldBtn.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
FoldBtn.Text = "<"   -- <--- ИЗМЕНЕНО (было "−")
FoldBtn.TextColor3 = Color3.new(1, 1, 1)
FoldBtn.Font = Enum.Font.SourceSansBold
FoldBtn.TextSize = 20
FoldBtn.Parent = Title

-- Крестик закрытия
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.new(1, 1, 1)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(0, 0, 0)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 20
CloseBtn.Parent = Title

-- Контейнер для содержимого (будем скрывать при сворачивании)
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, 0, 1, -30)
Content.Position = UDim2.new(0, 0, 0, 30)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- Кнопка "ДОБАВИТЬ"
local AddBtn = Instance.new("TextButton")
AddBtn.Position = UDim2.new(0, 10, 0, 10)
AddBtn.Size = UDim2.new(0.3, -5, 0, 30)
AddBtn.BackgroundColor3 = Color3.new(0, 0.5, 1)
AddBtn.Text = "ДОБАВИТЬ"
AddBtn.TextColor3 = Color3.new(1, 1, 1)
AddBtn.Font = Enum.Font.SourceSansBold
AddBtn.TextSize = 12
AddBtn.Parent = Content

-- Кнопка "ВСЕ"
local AllBtn = Instance.new("TextButton")
AllBtn.Position = UDim2.new(0.35, 0, 0, 10)
AllBtn.Size = UDim2.new(0.3, -5, 0, 30)
AllBtn.BackgroundColor3 = Color3.new(1, 0.5, 0)
AllBtn.Text = "ВСЕ"
AllBtn.TextColor3 = Color3.new(1, 1, 1)
AllBtn.Font = Enum.Font.SourceSansBold
AllBtn.TextSize = 12
AllBtn.Parent = Content

-- Кнопка "УБРАТЬ"
local RemoveBtn = Instance.new("TextButton")
RemoveBtn.Position = UDim2.new(0.7, 0, 0, 10)
RemoveBtn.Size = UDim2.new(0.3, -10, 0, 30)
RemoveBtn.BackgroundColor3 = Color3.new(0.8, 0, 0)
RemoveBtn.Text = "УБРАТЬ"
RemoveBtn.TextColor3 = Color3.new(1, 1, 1)
RemoveBtn.Font = Enum.Font.SourceSansBold
RemoveBtn.TextSize = 12
RemoveBtn.Parent = Content

-- Кнопка "ФЛИНГ"
local FlingBtn = Instance.new("TextButton")
FlingBtn.Position = UDim2.new(0, 10, 0, 50)
FlingBtn.Size = UDim2.new(0.45, -5, 0, 35)
FlingBtn.BackgroundColor3 = Color3.new(0, 0.8, 0)
FlingBtn.Text = "🚀 ФЛИНГ"
FlingBtn.TextColor3 = Color3.new(1, 1, 1)
FlingBtn.Font = Enum.Font.SourceSansBold
FlingBtn.TextSize = 14
FlingBtn.Parent = Content

-- Кнопка "СТОП"
local StopBtn = Instance.new("TextButton")
StopBtn.Position = UDim2.new(0.5, 5, 0, 50)
StopBtn.Size = UDim2.new(0.45, -15, 0, 35)
StopBtn.BackgroundColor3 = Color3.new(0.8, 0, 0)
StopBtn.Text = "⏹️ СТОП"
StopBtn.TextColor3 = Color3.new(1, 1, 1)
StopBtn.Font = Enum.Font.SourceSansBold
StopBtn.TextSize = 14
StopBtn.Parent = Content

-- Текст с целями
local TargetDisplay = Instance.new("TextLabel")
TargetDisplay.Position = UDim2.new(0, 10, 0, 95)
TargetDisplay.Size = UDim2.new(1, -20, 0, 60)
TargetDisplay.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
TargetDisplay.Text = "Нет выбранных целей"
TargetDisplay.TextColor3 = Color3.new(0, 255, 0)
TargetDisplay.Font = Enum.Font.SourceSans
TargetDisplay.TextSize = 12
TargetDisplay.TextWrapped = true
TargetDisplay.TextXAlignment = Enum.TextXAlignment.Left
TargetDisplay.TextYAlignment = Enum.TextYAlignment.Top
TargetDisplay.Parent = Content

-- Счётчик целей
local CountLabel = Instance.new("TextLabel")
CountLabel.Position = UDim2.new(1, -50, 1, -25)
CountLabel.Size = UDim2.new(0, 40, 0, 20)
CountLabel.BackgroundTransparency = 1
CountLabel.Text = "0"
CountLabel.TextColor3 = Color3.new(1, 1, 0)
CountLabel.Font = Enum.Font.SourceSansBold
CountLabel.TextSize = 18
CountLabel.Parent = Content

-- Выпадающий список игроков
local Dropdown = Instance.new("Frame")
Dropdown.Size = UDim2.new(0.8, 0, 0, 150)
Dropdown.Position = UDim2.new(0.1, 0, 0, 75)
Dropdown.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Dropdown.BorderSizePixel = 2
Dropdown.BorderColor3 = Color3.new(1, 1, 1)
Dropdown.Visible = false
Dropdown.ZIndex = 10
Dropdown.Parent = MainFrame

local DropdownTitle = Instance.new("TextLabel")
DropdownTitle.Size = UDim2.new(1, 0, 0, 20)
DropdownTitle.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
DropdownTitle.Text = "ВЫБЕРИ ИГРОКА"
DropdownTitle.TextColor3 = Color3.new(1, 1, 1)
DropdownTitle.Font = Enum.Font.SourceSansBold
DropdownTitle.TextSize = 14
DropdownTitle.ZIndex = 10
DropdownTitle.Parent = Dropdown

local PlayerScroller = Instance.new("ScrollingFrame")
PlayerScroller.Size = UDim2.new(1, 0, 1, -20)
PlayerScroller.Position = UDim2.new(0, 0, 0, 20)
PlayerScroller.BackgroundTransparency = 1
PlayerScroller.BorderSizePixel = 0
PlayerScroller.ScrollBarThickness = 5
PlayerScroller.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerScroller.ZIndex = 10
PlayerScroller.Parent = Dropdown

-- Логика сворачивания
local isFolded = false
local fullSize = UDim2.new(0, 280, 0, 240)
local foldedSize = UDim2.new(0, 280, 0, 30)

FoldBtn.MouseButton1Click:Connect(function()
    isFolded = not isFolded
    if isFolded then
        MainFrame.Size = foldedSize
        Content.Visible = false
        FoldBtn.Text = ">"   -- <--- ИЗМЕНЕНО (было "+")
    else
        MainFrame.Size = fullSize
        Content.Visible = true
        FoldBtn.Text = "<"   -- <--- ИЗМЕНЕНО (было "−")
    end
end)

-- Функция обновления списка игроков
local function UpdatePlayerList()
    for _, child in pairs(PlayerScroller:GetChildren()) do
        child:Destroy()
    end
    
    local y = 0
    local players = Players:GetPlayers()
    table.sort(players, function(a, b) return a.Name:lower() < b.Name:lower() end)
    
    for _, p in ipairs(players) do
        if p ~= Player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 25)
            btn.Position = UDim2.new(0, 5, 0, y)
            btn.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
            btn.Text = p.Name
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Font = Enum.Font.SourceSans
            btn.TextSize = 14
            btn.ZIndex = 10
            btn.Parent = PlayerScroller
            
            btn.MouseEnter:Connect(function()
                btn.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
            end)
            btn.MouseLeave:Connect(function()
                btn.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
            end)
            
            btn.MouseButton1Click:Connect(function()
                SelectedTargets[p.Name] = p
                UpdateDisplay()
                Dropdown.Visible = false
            end)
            
            y = y + 26
        end
    end
    
    PlayerScroller.CanvasSize = UDim2.new(0, 0, 0, y + 5)
end

local function UpdateDisplay()
    local names = {}
    for name, _ in pairs(SelectedTargets) do
        table.insert(names, name)
    end
    if #names == 0 then
        TargetDisplay.Text = "Нет выбранных целей"
    else
        TargetDisplay.Text = "Цели: " .. table.concat(names, ", ")
    end
    CountLabel.Text = tostring(#names)
end

-- Показать дропдаун
AddBtn.MouseButton1Click:Connect(function()
    UpdatePlayerList()
    Dropdown.Visible = not Dropdown.Visible
end)

-- Закрыть дропдаун при клике вне
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        task.wait()
        if Dropdown.Visible then
            local mousePos = game:GetService("UserInputService"):GetMouseLocation()
            local dropPos = Dropdown.AbsolutePosition
            local dropSize = Dropdown.AbsoluteSize
            if mousePos.X < dropPos.X or mousePos.X > dropPos.X + dropSize.X or
               mousePos.Y < dropPos.Y or mousePos.Y > dropPos.Y + dropSize.Y then
                Dropdown.Visible = false
            end
        end
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
    UpdateDisplay()
end)

-- Убрать всех
RemoveBtn.MouseButton1Click:Connect(function()
    SelectedTargets = {}
    UpdateDisplay()
end)

-- ТВОЯ ОРИГИНАЛЬНАЯ ФУНКЦИЯ ФЛИНГА (НЕ ТРОГАЛ)
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
            TargetDisplay.Text = "Ошибка: " .. TargetPlayer.Name .. " сидит"
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
            TargetDisplay.Text = "Нет частей для флинга"  
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

-- ФЛИНГ
FlingBtn.MouseButton1Click:Connect(function()
    local count = 0
    for _ in pairs(SelectedTargets) do count = count + 1 end
    if count == 0 then
        TargetDisplay.Text = "Нет целей!"
        return
    end
    FlingActive = true
    TargetDisplay.Text = "ФЛИНГАЮ " .. count .. " целей..."
    
    spawn(function()
        while FlingActive do
            for _, player in pairs(SelectedTargets) do
                if FlingActive and player and player.Parent then
                    SkidFling(player)
                    wait(0.1)
                end
            end
            wait(0.5)
        end
    end)
end)

-- СТОП
StopBtn.MouseButton1Click:Connect(function()
    FlingActive = false
    TargetDisplay.Text = "Остановлено"
    UpdateDisplay()
end)

-- ЗАКРЫТЬ
CloseBtn.MouseButton1Click:Connect(function()
    FlingActive = false
    ScreenGui:Destroy()
end)

print("✅ KILASIK FLING: сворачиваемое окно загружено!")
