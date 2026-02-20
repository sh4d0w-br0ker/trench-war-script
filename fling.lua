--[[
KILASIK's Multi-Target Fling Exploit
ОРИГИНАЛЬНАЯ РАБОЧАЯ ВЕРСИЯ + кнопка сворачивания
НИЧЕГО НЕ МЕНЯЛ В ФЛИНГЕ И ВЫБОРЕ ПОЛЬЗОВАТЕЛЯ!
]]

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KilasikFlingGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

-- Кнопка сворачивания (НОВАЯ)
local FoldButton = Instance.new("TextButton")
FoldButton.Position = UDim2.new(0, 0, 0, 0)
FoldButton.Size = UDim2.new(0, 30, 0, 30)
FoldButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
FoldButton.BorderSizePixel = 0
FoldButton.Text = "−"
FoldButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FoldButton.Font = Enum.Font.SourceSansBold
FoldButton.TextSize = 20
FoldButton.Parent = TitleBar

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 30, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "KILASIK'S MULTI-FLING"
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = TitleBar

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 18
CloseButton.Parent = TitleBar

-- Контейнер для содержимого (для сворачивания)
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, 0, 1, -30)
Content.Position = UDim2.new(0, 0, 0, 30)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Position = UDim2.new(0, 10, 0, 10)
StatusLabel.Size = UDim2.new(1, -20, 0, 25)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Select targets to fling"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 16
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = Content

-- Player Selection Frame
local SelectionFrame = Instance.new("Frame")
SelectionFrame.Position = UDim2.new(0, 10, 0, 40)
SelectionFrame.Size = UDim2.new(1, -20, 0, 200)
SelectionFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SelectionFrame.BorderSizePixel = 0
SelectionFrame.Parent = Content

-- Player List ScrollFrame
local PlayerScrollFrame = Instance.new("ScrollingFrame")
PlayerScrollFrame.Position = UDim2.new(0, 5, 0, 5)
PlayerScrollFrame.Size = UDim2.new(1, -10, 1, -10)
PlayerScrollFrame.BackgroundTransparency = 1
PlayerScrollFrame.BorderSizePixel = 0
PlayerScrollFrame.ScrollBarThickness = 6
PlayerScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerScrollFrame.Parent = SelectionFrame

-- Start Fling Button
local StartButton = Instance.new("TextButton")
StartButton.Position = UDim2.new(0, 10, 0, 250)
StartButton.Size = UDim2.new(0.5, -15, 0, 40)
StartButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
StartButton.BorderSizePixel = 0
StartButton.Text = "START FLING"
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.Font = Enum.Font.SourceSansBold
StartButton.TextSize = 18
StartButton.Parent = Content

-- Stop Fling Button
local StopButton = Instance.new("TextButton")
StopButton.Position = UDim2.new(0.5, 5, 0, 250)
StopButton.Size = UDim2.new(0.5, -15, 0, 40)
StopButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
StopButton.BorderSizePixel = 0
StopButton.Text = "STOP FLING"
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.Font = Enum.Font.SourceSansBold
StopButton.TextSize = 18
StopButton.Parent = Content

-- Select/Deselect Buttons
local SelectAllButton = Instance.new("TextButton")
SelectAllButton.Position = UDim2.new(0, 10, 0, 300)
SelectAllButton.Size = UDim2.new(0.5, -15, 0, 30)
SelectAllButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SelectAllButton.BorderSizePixel = 0
SelectAllButton.Text = "SELECT ALL"
SelectAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectAllButton.Font = Enum.Font.SourceSans
SelectAllButton.TextSize = 14
SelectAllButton.Parent = Content

local DeselectAllButton = Instance.new("TextButton")
DeselectAllButton.Position = UDim2.new(0.5, 5, 0, 300)
DeselectAllButton.Size = UDim2.new(0.5, -15, 0, 30)
DeselectAllButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
DeselectAllButton.BorderSizePixel = 0
DeselectAllButton.Text = "DESELECT ALL"
DeselectAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DeselectAllButton.Font = Enum.Font.SourceSans
DeselectAllButton.TextSize = 14
DeselectAllButton.Parent = Content

-- Variables
local SelectedTargets = {}
local PlayerCheckboxes = {}
local FlingActive = false
local FlingConnection = nil
getgenv().OldPos = nil
getgenv().FPDH = workspace.FallenPartsDestroyHeight

-- Функция обновления списка игроков (ОРИГИНАЛЬНАЯ)
local function RefreshPlayerList()
    for _, child in pairs(PlayerScrollFrame:GetChildren()) do
        child:Destroy()
    end
    PlayerCheckboxes = {}

    local PlayerList = Players:GetPlayers()  
    table.sort(PlayerList, function(a, b) return a.Name:lower() < b.Name:lower() end)  
  
    local yPosition = 5  
    for _, player in ipairs(PlayerList) do  
        if player ~= Player then  
            local PlayerEntry = Instance.new("Frame")  
            PlayerEntry.Size = UDim2.new(1, -10, 0, 30)  
            PlayerEntry.Position = UDim2.new(0, 5, 0, yPosition)  
            PlayerEntry.BackgroundColor3 = Color3.fromRGB(50, 50, 50)  
            PlayerEntry.BorderSizePixel = 0  
            PlayerEntry.Parent = PlayerScrollFrame  
              
            local Checkbox = Instance.new("TextButton")  
            Checkbox.Size = UDim2.new(0, 24, 0, 24)  
            Checkbox.Position = UDim2.new(0, 3, 0.5, -12)  
            Checkbox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)  
            Checkbox.BorderSizePixel = 0  
            Checkbox.Text = ""  
            Checkbox.Parent = PlayerEntry  
              
            local Checkmark = Instance.new("TextLabel")  
            Checkmark.Size = UDim2.new(1, 0, 1, 0)  
            Checkmark.BackgroundTransparency = 1  
            Checkmark.Text = "✓"  
            Checkmark.TextColor3 = Color3.fromRGB(0, 255, 0)  
            Checkmark.TextSize = 18  
            Checkmark.Font = Enum.Font.SourceSansBold  
            Checkmark.Visible = SelectedTargets[player.Name] ~= nil  
            Checkmark.Parent = Checkbox  
              
            local NameLabel = Instance.new("TextLabel")  
            NameLabel.Size = UDim2.new(1, -35, 1, 0)  
            NameLabel.Position = UDim2.new(0, 30, 0, 0)  
            NameLabel.BackgroundTransparency = 1  
            NameLabel.Text = player.Name  
            NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  
            NameLabel.TextSize = 16  
            NameLabel.Font = Enum.Font.SourceSans  
            NameLabel.TextXAlignment = Enum.TextXAlignment.Left  
            NameLabel.Parent = PlayerEntry  
              
            local ClickArea = Instance.new("TextButton")  
            ClickArea.Size = UDim2.new(1, 0, 1, 0)  
            ClickArea.BackgroundTransparency = 1  
            ClickArea.Text = ""  
            ClickArea.ZIndex = 2  
            ClickArea.Parent = PlayerEntry  
              
            ClickArea.MouseButton1Click:Connect(function()  
                if SelectedTargets[player.Name] then  
                    SelectedTargets[player.Name] = nil  
                    Checkmark.Visible = false  
                else  
                    SelectedTargets[player.Name] = player  
                    Checkmark.Visible = true  
                end  
                UpdateStatus()  
            end)  
              
            PlayerCheckboxes[player.Name] = {  
                Entry = PlayerEntry,  
                Checkmark = Checkmark  
            }  
              
            yPosition = yPosition + 35  
        end  
    end  
  
    PlayerScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPosition + 5)
end

local function CountSelectedTargets()
    local count = 0
    for _ in pairs(SelectedTargets) do
        count = count + 1
    end
    return count
end

local function UpdateStatus()
    local count = CountSelectedTargets()
    if FlingActive then
        StatusLabel.Text = "Flinging " .. count .. " target(s)"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    else
        StatusLabel.Text = count .. " target(s) selected"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

local function ToggleAllPlayers(select)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Player then
            local checkboxData = PlayerCheckboxes[player.Name]
            if checkboxData then
                if select then
                    SelectedTargets[player.Name] = player
                    checkboxData.Checkmark.Visible = true
                else
                    SelectedTargets[player.Name] = nil
                    checkboxData.Checkmark.Visible = false
                end
            end
        end
    end
    UpdateStatus()
end

local function Message(Title, Text, Time)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = Title,
        Text = Text,
        Duration = Time or 5
    })
end

-- ТВОЯ ОРИГИНАЛЬНАЯ ФУНКЦИЯ ФЛИНГА (НИЧЕГО НЕ МЕНЯЛ!)
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
            return Message("Error", TargetPlayer.Name .. " is sitting", 2)  
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
            return Message("Error", TargetPlayer.Name .. " has no valid parts", 2)  
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
    else  
        return Message("Error", "Your character is not ready", 2)  
    end  
end

local function StartFling()
    if FlingActive then return end

    local count = CountSelectedTargets()  
    if count == 0 then  
        StatusLabel.Text = "No targets selected!"  
        wait(1)  
        StatusLabel.Text = "Select targets to fling"  
        return  
    end  
  
    FlingActive = true  
    UpdateStatus()  
    Message("Started", "Flinging " .. count .. " targets", 2)  
  
    spawn(function()  
        while FlingActive do  
            local validTargets = {}  
              
            for name, player in pairs(SelectedTargets) do  
                if player and player.Parent then  
                    validTargets[name] = player  
                else  
                    SelectedTargets[name] = nil  
                    local checkbox = PlayerCheckboxes[name]  
                    if checkbox then  
                        checkbox.Checkmark.Visible = false  
                    end  
                end  
            end  
              
            for _, player in pairs(validTargets) do  
                if FlingActive then  
                    SkidFling(player)  
                    wait(0.1)  
                else  
                    break  
                end  
            end  
              
            UpdateStatus()  
            wait(0.5)  
        end  
    end)
end

local function StopFling()
    if not FlingActive then return end
    FlingActive = false  
    UpdateStatus()  
    Message("Stopped", "Fling has been stopped", 2)
end

-- Сворачивание/разворачивание
local isFolded = false
local fullSize = UDim2.new(0, 300, 0, 350)
local foldedSize = UDim2.new(0, 300, 0, 30)

FoldButton.MouseButton1Click:Connect(function()
    isFolded = not isFolded
    if isFolded then
        MainFrame.Size = foldedSize
        Content.Visible = false
        FoldButton.Text = "+"
    else
        MainFrame.Size = fullSize
        Content.Visible = true
        FoldButton.Text = "−"
    end
end)

-- Button connections (ВСЕ КАК БЫЛО)
StartButton.MouseButton1Click:Connect(StartFling)
StopButton.MouseButton1Click:Connect(StopFling)
SelectAllButton.MouseButton1Click:Connect(function() ToggleAllPlayers(true) end)
DeselectAllButton.MouseButton1Click:Connect(function() ToggleAllPlayers(false) end)
CloseButton.MouseButton1Click:Connect(function()
    StopFling()
    ScreenGui:Destroy()
end)

-- Player joining/leaving
Players.PlayerAdded:Connect(RefreshPlayerList)
Players.PlayerRemoving:Connect(function(player)
    if SelectedTargets[player.Name] then
        SelectedTargets[player.Name] = nil
    end
    RefreshPlayerList()
    UpdateStatus()
end)

-- Initialize
RefreshPlayerList()
UpdateStatus()
Message("Loaded", "KILASIK's Multi-Target Fling GUI loaded!", 3)
