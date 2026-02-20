local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("Ultimate_Menu") then CoreGui.Ultimate_Menu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Ultimate_Menu"

-- Главный контейнер (Menu)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 220, 0, 35) -- Начальный размер только для шапки
Main.Position = UDim2.new(0.5, -110, 0.1, 0)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true -- Чтобы скрывать содержимое

local MainCorner = Instance.new("UICorner", Main)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -40, 0, 35)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Menu"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

local ToggleBtn = Instance.new("TextButton", Main)
ToggleBtn.Size = UDim2.new(0, 30, 0, 30)
ToggleBtn.Position = UDim2.new(1, -35, 0, 2)
ToggleBtn.Text = "<"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ToggleBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", ToggleBtn)

-- Контент (всё что внутри Menu)
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, 0, 0, 500)
Content.Position = UDim2.new(0, 0, 0, 40)
Content.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", Content)
UIList.Padding = UDim.new(0, 10)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- ФУНКЦИЯ ДЛЯ СЕКЦИЙ (Kill Gui / Esp Gui)
local function AddLabel(text)
    local lbl = Instance.new("TextLabel", Content)
    lbl.Size = UDim2.new(0.9, 0, 0, 20)
    lbl.Text = "--- " .. text .. " ---"
    lbl.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.SourceSansItalic
    lbl.TextSize = 14
end

-- [ СЕКЦИЯ KILL ]
AddLabel("Kill Gui")
local TargetInput = Instance.new("TextBox", Content)
TargetInput.Size = UDim2.new(0.9, 0, 0, 30)
TargetInput.PlaceholderText = "Username..."
TargetInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TargetInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", TargetInput)

local KillBtn = Instance.new("TextButton", Content)
KillBtn.Size = UDim2.new(0.9, 0, 0, 35)
KillBtn.Text = "Kill Player"
KillBtn.BackgroundColor3 = Color3.fromRGB(130, 0, 0)
KillBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", KillBtn)

local AuraBtn = Instance.new("TextButton", Content)
AuraBtn.Size = UDim2.new(0.9, 0, 0, 35)
AuraBtn.Text = "Aura: OFF"
AuraBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AuraBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", AuraBtn)

-- [ СЕКЦИЯ ESP ]
AddLabel("Esp Gui")
local EspAllBtn = Instance.new("TextButton", Content)
EspAllBtn.Size = UDim2.new(0.9, 0, 0, 35)
EspAllBtn.Text = "ESP All: OFF"
EspAllBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
EspAllBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", EspAllBtn)

-- Список игроков (скролл)
local PlayerList = Instance.new("ScrollingFrame", Content)
PlayerList.Size = UDim2.new(0.9, 0, 0, 100)
PlayerList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PlayerList.CanvasSize = UDim2.new(0, 0, 5, 0)
Instance.new("UIListLayout", PlayerList)

-- ЛОГИКА ОТКРЫТИЯ МЕНЮ
local Open = false
ToggleBtn.MouseButton1Click:Connect(function()
    Open = not Open
    ToggleBtn.Text = Open and "v" or "<"
    Main.Size = Open and UDim2.new(0, 220, 0, 400) or UDim2.new(0, 220, 0, 35)
end)

-- ЛОГИКА ОРУЖИЯ
local function getTool() return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Pistol") end
local function fire(hum, root)
    local t = getTool()
    if t and t:FindFirstChild("RemoteEvent") then t.RemoteEvent:FireServer(hum, 100, {9.17, root.CFrame}) end
end

-- КНОПКИ
KillBtn.MouseButton1Click:Connect(function()
    local name = TargetInput.Text:lower()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #name) == name and p.Character then
            fire(p.Character:FindFirstChild("Humanoid"), p.Character:FindFirstChild("HumanoidRootPart"))
        end
    end
end)

local AuraConn = nil
AuraBtn.MouseButton1Click:Connect(function()
    local enabled = not AuraConn
    AuraBtn.Text = enabled and "Aura: ON" or "Aura: OFF"
    AuraBtn.BackgroundColor3 = enabled and Color3.fromRGB(100, 0, 200) or Color3.fromRGB(60, 60, 60)
    if enabled then
        AuraConn = RunService.Heartbeat:Connect(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local h, r = p.Character:FindFirstChild("Humanoid"), p.Character:FindFirstChild("HumanoidRootPart")
                    if h and r and h.Health > 0 then fire(h, r) end
                end
            end
        end)
    else
        AuraConn:Disconnect()
        AuraConn = nil
    end
end)

local EspActive = false
EspAllBtn.MouseButton1Click:Connect(function()
    EspActive = not EspActive
    EspAllBtn.Text = EspActive and "ESP All: ON" or "ESP All: OFF"
    EspAllBtn.BackgroundColor3 = EspActive and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(60, 60, 60)
end)

-- ESP Цвета команд + Список игроков
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local high = p.Character:FindFirstChild("Highlight")
            if EspActive or (TargetInput.Text ~= "" and p.Name:lower():sub(1, #TargetInput.Text) == TargetInput.Text:lower()) then
                if not high then high = Instance.new("Highlight", p.Character) end
                high.FillColor = p.TeamColor.Color
                high.FillTransparency = 0.5
            elseif high then
                high:Destroy()
            end
        end
    end
end)

local function refreshList()
    for _, c in pairs(PlayerList:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local b = Instance.new("TextButton", PlayerList)
            b.Size = UDim2.new(1, 0, 0, 20)
            b.Text = p.Name
            b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            b.TextColor3 = Color3.new(1, 1, 1)
            b.MouseButton1Click:Connect(function() TargetInput.Text = p.Name end)
        end
    end
end
spawn(function() while wait(5) do refreshList() end end)
refreshList()

print("Menu V3 Ready.")
