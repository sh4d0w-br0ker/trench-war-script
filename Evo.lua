--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local MinimizeBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame") -- test
local PlayerInput = Instance.new("TextBox")
local KillBtn = Instance.new("TextButton")
local KillAllBtn = Instance.new("TextButton")
local SwordBtn = Instance.new("TextButton")
local SwordAllBtn = Instance.new("TextButton")
local CaboomBtn = Instance.new("TextButton")

-- Gui
ScreenGui.Name = "VoidHubGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- H
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -150)
MainFrame.Size = UDim2.new(0, 200, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

-- Panel (TitleBar)
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 30)

TitleLabel.Parent = TitleBar
TitleLabel.Text = "  Void Hub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.BackgroundTransparency = 1
TitleLabel.Size = UDim2.new(0.6, 0, 1, 0)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 18

-- test
CloseBtn.Parent = TitleBar
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)

-- test
MinimizeBtn.Parent = TitleBar
MinimizeBtn.Text = "_"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Position = UDim2.new(1, -60, 0, 0)
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)

-- test2
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 0, 0, 30)
ContentFrame.Size = UDim2.new(1, 0, 1, -30)

PlayerInput.Parent = ContentFrame
PlayerInput.PlaceholderText = "create by spynote..."
PlayerInput.Size = UDim2.new(0, 180, 0, 30)
PlayerInput.Position = UDim2.new(0, 10, 0, 10)

KillBtn.Parent = ContentFrame
KillBtn.Text = "KILL"
KillBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
KillBtn.Position = UDim2.new(0, 10, 0, 50)
KillBtn.Size = UDim2.new(0, 180, 0, 30)

KillAllBtn.Parent = ContentFrame
KillAllBtn.Text = "KILL ALL: OFF"
KillAllBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
KillAllBtn.Position = UDim2.new(0, 10, 0, 90)
KillAllBtn.Size = UDim2.new(0, 180, 0, 30)

SwordBtn.Parent = ContentFrame
SwordBtn.Text = "SwordTP: OFF"
SwordBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
SwordBtn.Position = UDim2.new(0, 10, 0, 130)
SwordBtn.Size = UDim2.new(0, 180, 0, 30)

SwordAllBtn.Parent = ContentFrame
SwordAllBtn.Text = "SwordALL: OFF"
SwordAllBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
SwordAllBtn.Position = UDim2.new(0, 10, 0, 170)
SwordAllBtn.Size = UDim2.new(0, 180, 0, 30)

CaboomBtn.Parent = ContentFrame
CaboomBtn.Text = "CABOOM"
CaboomBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
CaboomBtn.Position = UDim2.new(0, 10, 0, 210)
CaboomBtn.Size = UDim2.new(0, 180, 0, 40)

-- logic
local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    ContentFrame.Visible = not minimized
    MainFrame.Size = minimized and UDim2.new(0, 200, 0, 30) or UDim2.new(0, 200, 0, 300)
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- logic
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

local killing = false
local killingAll = false
local swordKill = false
local swordAllKill = false

local function resetButtons()
    killing = false
    killingAll = false
    swordKill = false
    swordAllKill = false
    KillBtn.Text = "KILL"
    KillAllBtn.Text = "KILL ALL: OFF"
    SwordBtn.Text = "SwordTP: OFF"
    SwordAllBtn.Text = "SwordALL: OFF"
end

local function findTarget(namePart)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and string.lower(p.Name):find(string.lower(namePart)) then
            return p
        end
    end
    return nil
end

local function getSwordRemote()
    local char = lp.Character
    local sword = (char and char:FindFirstChild("Lightsaber")) or lp.Backpack:FindFirstChild("Lightsaber")
    return sword and sword:FindFirstChild("RemoteEvent")
end

local function getPlasmaRemote()
    return lp.Backpack:WaitForChild("Plasma Blast"):WaitForChild("RemoteEvent")
end

-- Attack Function For Laser Gun 
KillBtn.MouseButton1Click:Connect(function()
    local state = not killing
    resetButtons()
    killing = state
    KillBtn.Text = killing and "STOP" or "KILL"
    while killing do
        local target = findTarget(PlayerInput.Text)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            getPlasmaRemote():FireServer(target.Character.HumanoidRootPart.Position)
        end
        task.wait(0.1)
    end
end)

KillAllBtn.MouseButton1Click:Connect(function()
    local state = not killingAll
    resetButtons()
    killingAll = state
    KillAllBtn.Text = killingAll and "KILL ALL: ON" or "KILL ALL: OFF"
    while killingAll do
        for _, target in pairs(Players:GetPlayers()) do
            if not killingAll then break end
            if target ~= lp and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local startTime = tick()
                while tick() - startTime < 1 and killingAll do
                    if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                        getPlasmaRemote():FireServer(target.Character.HumanoidRootPart.Position)
                    end
                    task.wait(0.1)
                end
            end
        end
        task.wait(0.1)
    end
end)

-- Sword TP
SwordBtn.MouseButton1Click:Connect(function()
    local state = not swordKill
    resetButtons()
    swordKill = state
    SwordBtn.Text = swordKill and "SwordTP: ON" or "SwordTP: OFF"
    while swordKill do
        local target = findTarget(PlayerInput.Text)
        local myChar = lp.Character
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and myChar and myChar:FindFirstChild("HumanoidRootPart") then
            local targetHRP = target.Character.HumanoidRootPart
            myChar.HumanoidRootPart.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 3)
            local remote = getSwordRemote()
            if remote then remote:FireServer() end
        end
        RunService.Heartbeat:Wait()
    end
end)

SwordAllBtn.MouseButton1Click:Connect(function()
    local state = not swordAllKill
    resetButtons()
    swordAllKill = state
    SwordAllBtn.Text = swordAllKill and "SwordALL: ON" or "SwordALL: OFF"
    while swordAllKill do
        for _, target in pairs(Players:GetPlayers()) do
            if not swordAllKill then break end
            local startTime = tick()
            while tick() - startTime < 1.5 and swordAllKill do
                local myChar = lp.Character
                if target ~= lp and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and myChar and myChar:FindFirstChild("HumanoidRootPart") then
                    myChar.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                    local remote = getSwordRemote()
                    if remote then remote:FireServer() end
                else break end
                RunService.Heartbeat:Wait()
            end
        end
        task.wait(0.1)
    end
end)

-- BOOM
CaboomBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local myPos = char.HumanoidRootPart.Position
        for i = 1, 36 do
            local angle = math.rad(i * 10)
            local targetPos = Vector3.new(myPos.X + math.cos(angle) * 10, myPos.Y, myPos.Z + math.sin(angle) * 10)
            getPlasmaRemote():FireServer(targetPos)
        end
    end
end)
