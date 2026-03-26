--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer

-- Hello
if CoreGui:FindFirstChild("VoidHub") then CoreGui.VoidHub:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VoidHub"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 300)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -30, 0, 35)
Title.Text = "Void Hub"
Title.TextColor3 = Color3.new(1, 1, 0)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Parent = MainFrame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 30, 0, 35)
ToggleBtn.Position = UDim2.new(1, -30, 0, 0)
ToggleBtn.Text = "<"
ToggleBtn.Parent = MainFrame

local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, 0, 1, -35)
Container.Position = UDim2.new(0, 0, 0, 35)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 0, 350)
Container.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Parent = Container
UIList.Padding = UDim.new(0, 5)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

local autoSlapEnabled = false

local function CreateButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
    btn.TextColor3 = Color3.new(0, 0, 0)
    btn.Text = name
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = Container
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- slap
local SLAP_VECTOR = vector.create(-32.43278121948242, 0.0000051553715820773505, -50.47885513305664)
local KILL_VECTOR = vector.create(999999, 999999, 999999)

local function attack(target, vec)
    if target and target:FindFirstChild("HumanoidRootPart") and LP.Character and LP.Character:FindFirstChild("OverGlove") then
        local event = LP.Character.OverGlove:FindFirstChild("Event")
        if event then
            event:FireServer("slash", target, vec)
        end
    end
end

-- Lellelrr
CreateButton("Infinity Money", function()
    RS.CratesUtilities.Remotes.GiveReward:FireServer(math.huge)
end)

CreateButton("Give Slap (Overkill)", function()
    RS.Gamepasses_Remotes.PurchaseShop:FireServer(200000, "Overkill")
end)

CreateButton("Slap All", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then attack(p.Character, SLAP_VECTOR) end
    end
end)

CreateButton("Kill All", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then attack(p.Character, KILL_VECTOR) end
    end
end)

local AutoBtn = CreateButton("Auto Slap: OFF", function()
    autoSlapEnabled = not autoSlapEnabled
end)

task.spawn(function()
    while true do
        if autoSlapEnabled then
            AutoBtn.Text = "Auto Slap: ON"
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character then attack(p.Character, SLAP_VECTOR) end
            end
        else
            AutoBtn.Text = "Auto Slap: OFF"
        end
        task.wait(0.1)
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    local collapsed = MainFrame.Size.Y.Offset < 100
    MainFrame.Size = collapsed and UDim2.new(0, 220, 0, 300) or UDim2.new(0, 220, 0, 35)
    Container.Visible = collapsed
    ToggleBtn.Text = collapsed and "<" or ">"
end)
