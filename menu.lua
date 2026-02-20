local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("Final_Menu") then CoreGui.Final_Menu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Final_Menu"

-- Главный контейнер (самый верхний Menu)
local Root = Instance.new("Frame", ScreenGui)
Root.Size = UDim2.new(0, 220, 0, 35)
Root.Position = UDim2.new(0.5, -110, 0.1, 0)
Root.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Root.BorderSizePixel = 0
Root.Active = true
Root.Draggable = true
Instance.new("UICorner", Root)

local RootTitle = Instance.new("TextLabel", Root)
RootTitle.Size = UDim2.new(1, -40, 0, 35)
RootTitle.Position = UDim2.new(0, 10, 0, 0)
RootTitle.Text = "Menu"
RootTitle.TextColor3 = Color3.new(1, 1, 1)
RootTitle.BackgroundTransparency = 1
RootTitle.Font = Enum.Font.SourceSansBold
RootTitle.TextSize = 18
RootTitle.TextXAlignment = Enum.TextXAlignment.Left

local RootToggle = Instance.new("TextButton", Root)
RootToggle.Size = UDim2.new(0, 30, 0, 30)
RootToggle.Position = UDim2.new(1, -35, 0, 2)
RootToggle.Text = "<"
RootToggle.TextColor3 = Color3.new(1, 1, 1)
RootToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Instance.new("UICorner", RootToggle)

-- Контейнер для вкладок (появляется под Menu)
local Holder = Instance.new("Frame", Root)
Holder.Size = UDim2.new(1, 0, 0, 0)
Holder.Position = UDim2.new(0, 0, 0, 40)
Holder.BackgroundTransparency = 1
Holder.Visible = false
local HolderList = Instance.new("UIListLayout", Holder)
HolderList.Padding = UDim.new(0, 5)

-- Функция создания вложенных меню (Kill Gui / Esp Gui)
local function CreateSubMenu(name)
    local Frame = Instance.new("Frame", Holder)
    Frame.Size = UDim2.new(1, 0, 0, 35)
    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Frame.BorderSizePixel = 0
    Frame.ClipsDescendants = true
    Instance.new("UICorner", Frame)

    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Text = name .. "          <"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundTransparency = 1
    btn.Font = Enum.Font.SourceSansBold

    local Content = Instance.new("Frame", Frame)
    Content.Size = UDim2.new(1, 0, 0, 250)
    Content.Position = UDim2.new(0, 0, 0, 35)
    Content.BackgroundTransparency = 1
    local CL = Instance.new("UIListLayout", Content)
    CL.Padding = UDim.new(0, 5)
    CL.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local subOpen = false
    btn.MouseButton1Click:Connect(function()
        subOpen = not subOpen
        Frame.Size = subOpen and UDim2.new(1, 0, 0, 285) or UDim2.new(1, 0, 0, 35)
        btn.Text = name .. (subOpen and "          v" or "          <")
        -- Подгоняем размер Holder под открытые саб-меню
        local totalHeight = 0
        for _, child in pairs(Holder:GetChildren()) do
            if child:IsA("Frame") then totalHeight = totalHeight + child.Size.Y.Offset + 5 end
        end
        Holder.Size = UDim2.new(1, 0, 0, totalHeight)
    end)
    return Content
end

-- Создаем саб-меню
local KillContent = CreateSubMenu("kill Gui")
local EspContent = CreateSubMenu("Esp Gui")

-- [ ЭЛЕМЕНТЫ KILL ]
local TargetInput = Instance.new("TextBox", KillContent)
TargetInput.Size = UDim2.new(0.9, 0, 0, 30)
TargetInput.PlaceholderText = "Target..."
TargetInput.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
TargetInput.TextColor3 = Color3.new(1,1,1)

local KillBtn = Instance.new("TextButton", KillContent)
KillBtn.Size = UDim2.new(0.9, 0, 0, 35)
KillBtn.Text = "Kill Player"
KillBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
KillBtn.TextColor3 = Color3.new(1,1,1)

local AuraBtn = Instance.new("TextButton", KillContent)
AuraBtn.Size = UDim2.new(0.9, 0, 0, 35)
AuraBtn.Text = "Aura: OFF"
AuraBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AuraBtn.TextColor3 = Color3.new(1,1,1)

-- [ ЭЛЕМЕНТЫ ESP ]
local EspAllBtn = Instance.new("TextButton", EspContent)
EspAllBtn.Size = UDim2.new(0.9, 0, 0, 35)
EspAllBtn.Text = "ESP All: OFF"
EspAllBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
EspAllBtn.TextColor3 = Color3.new(1,1,1)

local PlayerScroll = Instance.new("ScrollingFrame", EspContent)
PlayerScroll.Size = UDim2.new(0.9, 0, 0, 100)
PlayerScroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PlayerScroll.CanvasSize = UDim2.new(0,0,4,0)
Instance.new("UIListLayout", PlayerScroll)

-- Логика раскрытия основного Menu
local rootOpen = false
RootToggle.MouseButton1Click:Connect(function()
    rootOpen = not rootOpen
    Holder.Visible = rootOpen
    RootToggle.Text = rootOpen and "v" or "<"
    Root.ClipsDescendants = not rootOpen
    Root.Size = rootOpen and UDim2.new(0, 220, 0, 600) or UDim2.new(0, 220, 0, 35)
end)

-- РАБОТА СКРИПТА (Kill/Esp)
local function fire(h, r)
    local t = LocalPlayer.Character:FindFirstChild("Pistol")
    if t and t:FindFirstChild("RemoteEvent") then t.RemoteEvent:FireServer(h, 100, {9.17, r.CFrame}) end
end

KillBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #TargetInput.Text) == TargetInput.Text:lower() and p.Character then
            fire(p.Character:FindFirstChild("Humanoid"), p.Character:FindFirstChild("HumanoidRootPart"))
        end
    end
end)

local AuraOn = false
AuraBtn.MouseButton1Click:Connect(function()
    AuraOn = not AuraOn
    AuraBtn.Text = AuraOn and "Aura: ON" or "Aura: OFF"
    AuraBtn.BackgroundColor3 = AuraOn and Color3.fromRGB(130, 0, 255) or Color3.fromRGB(60,60,60)
end)

RunService.Heartbeat:Connect(function()
    if AuraOn then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local h = p.Character:FindFirstChild("Humanoid")
                if h and h.Health > 0 then fire(h, p.Character.HumanoidRootPart) end
            end
        end
    end
end)

local EspOn = false
EspAllBtn.MouseButton1Click:Connect(function()
    EspOn = not EspOn
    EspAllBtn.Text = EspOn and "ESP All: ON" or "ESP All: OFF"
    EspAllBtn.BackgroundColor3 = EspOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60,60,60)
end)

RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local high = p.Character:FindFirstChild("Highlight")
            if EspOn or (TargetInput.Text ~= "" and p.Name:lower():sub(1, #TargetInput.Text) == TargetInput.Text:lower()) then
                if not high then high = Instance.new("Highlight", p.Character) end
                high.FillColor = p.TeamColor.Color
            elseif high then high:Destroy() end
        end
    end
end)

-- Обновление списка игроков
local function refresh()
    for _, c in pairs(PlayerScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local b = Instance.new("TextButton", PlayerScroll)
            b.Size = UDim2.new(1,0,0,20)
            b.Text = p.Name
            b.BackgroundColor3 = Color3.fromRGB(45,45,45)
            b.TextColor3 = Color3.new(1,1,1)
            b.MouseButton1Click:Connect(function() TargetInput.Text = p.Name end)
        end
    end
end
spawn(function() while wait(5) do refresh() end end)
refresh()
