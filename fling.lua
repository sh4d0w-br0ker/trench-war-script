--[[
KILASIK's Compact Multi-Target Fling
Compact version with dropdown player list
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KilasikFlingGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame (smaller)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 150)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 25)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -25, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ KILASIK FLING"
Title.TextColor3 = Color3.fromRGB(255, 100, 100)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Position = UDim2.new(1, -25, 0, 0)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 16
CloseButton.Parent = TitleBar

-- Input Field
local InputFrame = Instance.new("Frame")
InputFrame.Position = UDim2.new(0, 5, 0, 30)
InputFrame.Size = UDim2.new(1, -10, 0, 30)
InputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
InputFrame.BorderSizePixel = 0
InputFrame.Parent = MainFrame

local TargetInput = Instance.new("TextBox")
TargetInput.Size = UDim2.new(1, -35, 1, 0)
TargetInput.Position = UDim2.new(0, 5, 0, 0)
TargetInput.BackgroundTransparency = 1
TargetInput.Text = ""
TargetInput.PlaceholderText = "Enter username"
TargetInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
TargetInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetInput.Font = Enum.Font.SourceSans
TargetInput.TextSize = 14
TargetInput.ClearTextOnFocus = false
TargetInput.Parent = InputFrame

local UsersListButton = Instance.new("TextButton")
UsersListButton.Size = UDim2.new(0, 30, 0, 30)
UsersListButton.Position = UDim2.new(1, -35, 0, 0)
UsersListButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
UsersListButton.BorderSizePixel = 0
UsersListButton.Text = "▼"
UsersListButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UsersListButton.Font = Enum.Font.SourceSansBold
UsersListButton.TextSize = 16
UsersListButton.Parent = InputFrame

-- Player Dropdown
local DropdownFrame = Instance.new("Frame")
DropdownFrame.Size = UDim2.new(1, 0, 0, 120)
DropdownFrame.Position = UDim2.new(0, 0, 1, 2)
DropdownFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
DropdownFrame.BorderSizePixel = 0
DropdownFrame.Visible = false
DropdownFrame.Parent = InputFrame

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1, -10, 1, -10)
PlayerList.Position = UDim2.new(0, 5, 0, 5)
PlayerList.BackgroundTransparency = 1
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 4
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.Parent = DropdownFrame

-- Control Buttons
local FlingButton = Instance.new("TextButton")
FlingButton.Position = UDim2.new(0, 5, 0, 65)
FlingButton.Size = UDim2.new(0.5, -7, 0, 35)
FlingButton.BackgroundColor3 = Color3.fromRGB(0, 160, 0)
FlingButton.BorderSizePixel = 0
FlingButton.Text = "⚡ FLING"
FlingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlingButton.Font = Enum.Font.SourceSansBold
FlingButton.TextSize = 16
FlingButton.Parent = MainFrame

local StopButton = Instance.new("TextButton")
StopButton.Position = UDim2.new(0.5, 2, 0, 65)
StopButton.Size = UDim2.new(0.5, -7, 0, 35)
StopButton.BackgroundColor3 = Color3.fromRGB(160, 0, 0)
StopButton.BorderSizePixel = 0
StopButton.Text = "■ STOP"
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.Font = Enum.Font.SourceSansBold
StopButton.TextSize = 16
StopButton.Parent = MainFrame

-- Status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Position = UDim2.new(0, 5, 0, 105)
StatusLabel.Size = UDim2.new(1, -10, 0, 20)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Ready"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = MainFrame

local CountLabel = Instance.new("TextLabel")
CountLabel.Position = UDim2.new(1, -40, 0, 105)
CountLabel.Size = UDim2.new(0, 35, 0, 20)
CountLabel.BackgroundTransparency = 1
CountLabel.Text = "0"
CountLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
CountLabel.Font = Enum.Font.SourceSansBold
CountLabel.TextSize = 14
CountLabel.TextXAlignment = Enum.TextXAlignment.Right
CountLabel.Parent = MainFrame

-- Variables
local SelectedTargets = {}
local FlingActive = false
local FlingConnection = nil
getgenv().OldPos = nil
getgenv().FPDH = workspace.FallenPartsDestroyHeight

-- Update player dropdown
local function UpdatePlayerList()
    for _, child in pairs(PlayerList:GetChildren()) do
        child:Destroy()
    end
    
    local yPos = 0
    local players = Players:GetPlayers()
    table.sort(players, function(a, b) return a.Name:lower() < b.Name:lower() end)
    
    for _, player in ipairs(players) do
        if player ~= Player then
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -5, 0, 25)
            button.Position = UDim2.new(0, 2, 0, yPos)
            button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            button.BorderSizePixel = 0
            button.Text = player.Name
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Font = Enum.Font.SourceSans
            button.TextSize = 14
            button.TextXAlignment = Enum.TextXAlignment.Left
            button.Parent = PlayerList
            
            -- Selected indicator
            local indicator = Instance.new("Frame")
            indicator.Size = UDim2.new(0, 3, 0.5, -3)
            indicator.Position = UDim2.new(1, -5, 0.5, -1)
            indicator.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            indicator.BorderSizePixel = 0
            indicator.Visible = false
            indicator.Parent = button
            
            button.MouseButton1Click:Connect(function()
                TargetInput.Text = player.Name
                DropdownFrame.Visible = false
            end)
            
            if SelectedTargets[player.Name] then
                indicator.Visible = true
            end
            
            yPos = yPos + 26
        end
    end
    
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- Toggle dropdown
UsersListButton.MouseButton1Click:Connect(function()
    UpdatePlayerList()
    DropdownFrame.Visible = not DropdownFrame.Visible
end)

-- Close dropdown when clicking outside
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local pos = UserInputService:GetMouseLocation()
        local absPos = DropdownFrame.AbsolutePosition
        local absSize = DropdownFrame.AbsoluteSize
        
        if not (pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and
                pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y) and
                not UsersListButton:IsMouseOver() then
            DropdownFrame.Visible = false
        end
    end
end)

-- Add target from input
local function AddTargetFromInput()
    local name = TargetInput.Text:gsub("%s+", "")
    if name ~= "" then
        local player = Players:FindFirstChild(name)
        if player and player ~= Player then
            SelectedTargets[player.Name] = player
            StatusLabel.Text = "✓ Added: "..player.Name
            CountLabel.Text = tostring(#SelectedTargets)
            TargetInput.Text = ""
            UpdatePlayerList()
        else
            StatusLabel.Text = "✗ Player not found"
        end
    end
end

TargetInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        AddTargetFromInput()
    end
end)

-- Fling function (same as before)
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
            return StatusLabel.Text = "✗ "..TargetPlayer.Name.." is sitting"  
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
            return StatusLabel.Text = "✗ No valid parts"  
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

-- Start flinging
local function StartFling()
    if FlingActive then return end
    
    local count = #SelectedTargets
    if count == 0 then
        StatusLabel.Text = "No targets selected!"
        return
    end
    
    FlingActive = true
    StatusLabel.Text = "⚡ Flinging "..count.." targets..."
    CountLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    
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
end

-- Stop flinging
local function StopFling()
    FlingActive = false
    StatusLabel.Text = "Stopped"
    CountLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
end

-- Clear all targets
local function ClearTargets()
    SelectedTargets = {}
    CountLabel.Text = "0"
    StatusLabel.Text = "Cleared"
    UpdatePlayerList()
end

-- Button connections
FlingButton.MouseButton1Click:Connect(StartFling)
StopButton.MouseButton1Click:Connect(StopFling)
CloseButton.MouseButton1Click:Connect(function()
    StopFling()
    ScreenGui:Destroy()
end)

-- Right click on status to clear
StatusLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        ClearTargets()
    end
end)

-- Player join/leave
Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(function(player)
    SelectedTargets[player.Name] = nil
    CountLabel.Text = tostring(#SelectedTargets)
    UpdatePlayerList()
end)

-- Initialize
UpdatePlayerList()
StatusLabel.Text = "Ready | Right-click to clear"
CountLabel.Text = "0"

print("✅ KILASIK Compact Fling loaded!")
