local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

local autoSlap = false
local minimized = false

-- bubby
local function attack(target, vec)
    if target and target.Character and LP.Character:FindFirstChild("Skull_Glove") then
        local args = {"slash", target.Character, vec}
        LP.Character.Skull_Glove.Event:FireServer(unpack(args))
    end
end

-- create gui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JDHS_Menu"
ScreenGui.Parent = LP:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 360) -- Немного увеличил размер под новую кнопку
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Text = "  VOID HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left

-- button <
local CollapseBtn = Instance.new("TextButton")
CollapseBtn.Parent = Title
CollapseBtn.Size = UDim2.new(0, 30, 0, 30)
CollapseBtn.Position = UDim2.new(1, -35, 0.5, -15)
CollapseBtn.Text = "<"
CollapseBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CollapseBtn.TextColor3 = Color3.new(1, 1, 1)

CollapseBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 220, 0, 40), "Out", "Quad", 0.3, true)
        CollapseBtn.Text = ">"
    else
        MainFrame:TweenSize(UDim2.new(0, 220, 0, 360), "Out", "Quad", 0.3, true)
        CollapseBtn.Text = "<"
    end
end)

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 0, 0, 40)
Content.Size = UDim2.new(1, 0, 1, -40)
Content.ClipsDescendants = true

-- SLAP ALL
local SlapAllBtn = Instance.new("TextButton")
SlapAllBtn.Parent = Content
SlapAllBtn.Position = UDim2.new(0.05, 0, 0.03, 0)
SlapAllBtn.Size = UDim2.new(0.9, 0, 0, 35)
SlapAllBtn.Text = "SLAP ALL"
SlapAllBtn.BackgroundColor3 = Color3.fromRGB(45, 100, 45)
SlapAllBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then attack(p, Vector3.new(-3.492, -4.429, -4.145)) end
    end
end)

-- TELEPORT TO SLAP
local TpBtn = Instance.new("TextButton")
TpBtn.Parent = Content
TpBtn.Position = UDim2.new(0.05, 0, 0.16, 0)
TpBtn.Size = UDim2.new(0.9, 0, 0, 35)
TpBtn.Text = "TP TO SLAP"
TpBtn.BackgroundColor3 = Color3.fromRGB(45, 80, 150)
TpBtn.MouseButton1Click:Connect(function()
    if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(-12.2545881, -49.0006561, 420.262054, -0.994758785, 9.099411e-09, -0.102249712, 1.14825776e-08, 1, -2.27187229e-08, 0.102249712, -2.37737385e-08, -0.994758785)
    end
end)

-- KILL ALL
local KillAllBtn = Instance.new("TextButton")
KillAllBtn.Parent = Content
KillAllBtn.Position = UDim2.new(0.05, 0, 0.29, 0)
KillAllBtn.Size = UDim2.new(0.9, 0, 0, 35)
KillAllBtn.Text = "KILL ALL"
KillAllBtn.BackgroundColor3 = Color3.fromRGB(150, 45, 45)
KillAllBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then attack(p, Vector3.new(999999, 999999, 999999)) end
    end
end)

-- AUTO SLAP
local AutoSlapBtn = Instance.new("TextButton")
AutoSlapBtn.Parent = Content
AutoSlapBtn.Position = UDim2.new(0.05, 0, 0.42, 0)
AutoSlapBtn.Size = UDim2.new(0.9, 0, 0, 35)
AutoSlapBtn.Text = "AUTO SLAP: OFF"
AutoSlapBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

AutoSlapBtn.MouseButton1Click:Connect(function()
    autoSlap = not autoSlap
    AutoSlapBtn.Text = autoSlap and "AUTO SLAP: ON" or "AUTO SLAP: OFF"
    AutoSlapBtn.BackgroundColor3 = autoSlap and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 60, 60)
end)

-- GIVE INFINITY MONEY
local InfMoneyBtn = Instance.new("TextButton")
InfMoneyBtn.Parent = Content
InfMoneyBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
InfMoneyBtn.Size = UDim2.new(0.9, 0, 0, 35)
InfMoneyBtn.Text = "INF MONEY"
InfMoneyBtn.BackgroundColor3 = Color3.fromRGB(200, 160, 0)
InfMoneyBtn.TextColor3 = Color3.new(0, 0, 0)

InfMoneyBtn.MouseButton1Click:Connect(function()
    local args = {
        math.huge
    }
    game:GetService("ReplicatedStorage"):WaitForChild("CratesUtilities"):WaitForChild("Remotes"):WaitForChild("GiveReward"):FireServer(unpack(args))
end)

task.spawn(function()
    while task.wait(0.1) do
        if autoSlap then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP then attack(p, Vector3.new(-3.492, -4.429, -4.145)) end
            end
        end
    end
end)

print(" бубабуба")
