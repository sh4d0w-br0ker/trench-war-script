local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("Joined_Killer_ESP") then CoreGui.Joined_Killer_ESP:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Joined_Killer_ESP"

-- ГЛАВНЫЙ КОНТЕЙНЕР (Один на двоих)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 220, 0, 80) -- Начальный размер под два заголовка
Main.Position = UDim2.new(0.5, -110, 0.2, 0)
Main.BackgroundTransparency = 1 -- Прозрачный, так как внутри будут блоки
Main.Active = true
Main.Draggable = true

local MainList = Instance.new("UIListLayout", Main)
MainList.Padding = UDim.new(0, 2) -- Склейка вплотную
MainList.SortOrder = Enum.SortOrder.LayoutOrder

-- Функция для обновления общего размера окна
local function ResizeMain()
    local totalHeight = 0
    for _, child in pairs(Main:GetChildren()) do
        if child:IsA("Frame") then
            totalHeight = totalHeight + child.Size.Y.Offset + 2
        end
    end
    Main.Size = UDim2.new(0, 220, 0, totalHeight)
end

-- ФУНКЦИЯ СОЗДАНИЯ СЕКЦИЙ
local function CreateSection(name, order)
    local Section = Instance.new("Frame", Main)
    Section.Name = name
    Section.Size = UDim2.new(1, 0, 0, 35)
    Section.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Section.BorderSizePixel = 0
    Section.LayoutOrder = order
    Section.ClipsDescendants = true
    Instance.new("UICorner", Section)

    local Title = Instance.new("TextLabel", Section)
    Title.Size = UDim2.new(1, -40, 0, 35)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Text = name
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local Toggle = Instance.new("TextButton", Section)
    Toggle.Size = UDim2.new(0, 30, 0, 30)
    Toggle.Position = UDim2.new(1, -35, 0, 2)
    Toggle.Text = "<"
    Toggle.TextColor3 = Color3.new(1, 1, 1)
    Toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", Toggle)

    local Content = Instance.new("Frame", Section)
    Content.Size = UDim2.new(1, 0, 0, 300)
    Content.Position = UDim2.new(0, 0, 0, 35)
    Content.BackgroundTransparency = 1
    local CL = Instance.new("UIListLayout", Content)
    CL.Padding = UDim.new(0, 5)
    CL.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Instance.new("UIPadding", Content).PaddingTop = UDim.new(0, 5)

    local open = false
    Toggle.MouseButton1Click:Connect(function()
        open = not open
        Section.Size = open and UDim2.new(1, 0, 0, 335) or UDim2.new(1, 0, 0, 35)
        Toggle.Text = open and "v" or "<"
        ResizeMain()
    end)

    return Content
end

-- Создаем Kill и Esp секции
local KillContent = CreateSection("Kill Gui", 1)
local EspContent = CreateSection("Esp Gui", 2)

-- [ НАПОЛНЕНИЕ KILL ]
local TargetInput = Instance.new("TextBox", KillContent)
TargetInput.Size = UDim2.new(0.9, 0, 0, 30)
TargetInput.PlaceholderText = "Username..."
TargetInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TargetInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", TargetInput)

local KillBtn = Instance.new("TextButton", KillContent)
KillBtn.Size = UDim2.new(0.9, 0, 0, 35)
KillBtn.Text = "Kill Player"
KillBtn.BackgroundColor3 = Color3.fromRGB(140, 0, 0)
KillBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", KillBtn)

local AuraBtn = Instance.new("TextButton", KillContent)
AuraBtn.Size = UDim2.new(0.9, 0, 0, 35)
AuraBtn.Text = "Aura: OFF"
AuraBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AuraBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", AuraBtn)

-- [ НАПОЛНЕНИЕ ESP ]
local EspBtn = Instance.new("TextButton", EspContent)
EspBtn.Size = UDim2.new(0.9, 0, 0, 35)
EspBtn.Text = "ESP All: OFF"
EspBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
EspBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", EspBtn)

local Scroll = Instance.new("ScrollingFrame", EspContent)
Scroll.Size = UDim2.new(0.9, 0, 0, 120)
Scroll.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Scroll.CanvasSize = UDim2.new(0, 0, 5, 0)
Instance.new("UIListLayout", Scroll)

-- ЛОГИКА
local function fire(h, r)
    local p = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Pistol")
    if p and p:FindFirstChild("RemoteEvent") then p.RemoteEvent:FireServer(h, 100, {9.17, r.CFrame}) end
end

KillBtn.MouseButton1Click:Connect(function()
    local t = TargetInput.Text:lower()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #t) == t and p.Character then
            fire(p.Character:FindFirstChild("Humanoid"), p.Character:FindFirstChild("HumanoidRootPart"))
        end
    end
end)

local Aura = false
AuraBtn.MouseButton1Click:Connect(function()
    Aura = not Aura
    AuraBtn.Text = Aura and "Aura: ON" or "Aura: OFF"
    AuraBtn.BackgroundColor3 = Aura and Color3.fromRGB(130, 0, 255) or Color3.fromRGB(60, 60, 60)
end)

RunService.Heartbeat:Connect(function()
    if Aura then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local h = p.Character:FindFirstChild("Humanoid")
                if h and h.Health > 0 then fire(h, p.Character.HumanoidRootPart) end
            end
        end
    end
end)

local EspOn = false
EspBtn.MouseButton1Click:Connect(function()
    EspOn = not EspOn
    EspBtn.Text = EspOn and "ESP All: ON" or "ESP All: OFF"
    EspBtn.BackgroundColor3 = EspOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
end)

RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hi = p.Character:FindFirstChild("Highlight")
            if EspOn or (TargetInput.Text ~= "" and p.Name:lower():sub(1, #TargetInput.Text) == TargetInput.Text:lower()) then
                if not hi then hi = Instance.new("Highlight", p.Character) end
                hi.FillColor = p.TeamColor.Color
            elseif hi then hi:Destroy() end
        end
    end
end)

local function updateList()
    for _, c in pairs(Scroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local b = Instance.new("TextButton", Scroll)
            b.Size = UDim2.new(1, 0, 0, 22)
            b.Text = p.Name
            b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            b.TextColor3 = Color3.new(1, 1, 1)
            b.MouseButton1Click:Connect(function() TargetInput.Text = p.Name end)
        end
    end
end
spawn(function() while wait(5) do updateList() end end)
updateList()
