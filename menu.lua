local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("Fixed_Ultimate_Menu") then CoreGui.Fixed_Ultimate_Menu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Fixed_Ultimate_Menu"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 220, 0, 35)
Main.Position = UDim2.new(0.5, -110, 0.1, 0)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Instance.new("UICorner", Main)

local MainTitle = Instance.new("TextLabel", Main)
MainTitle.Size = UDim2.new(1, -40, 0, 35)
MainTitle.Position = UDim2.new(0, 10, 0, 0)
MainTitle.Text = "Menu"
MainTitle.TextColor3 = Color3.new(1, 1, 1)
MainTitle.BackgroundTransparency = 1
MainTitle.Font = Enum.Font.SourceSansBold
MainTitle.TextSize = 18
MainTitle.TextXAlignment = Enum.TextXAlignment.Left

local MainToggle = Instance.new("TextButton", Main)
MainToggle.Size = UDim2.new(0, 30, 0, 30)
MainToggle.Position = UDim2.new(1, -35, 0, 2)
MainToggle.Text = "<"
MainToggle.TextColor3 = Color3.new(1, 1, 1)
MainToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Instance.new("UICorner", MainToggle)

local Holder = Instance.new("Frame", Main)
Holder.Position = UDim2.new(0, 0, 0, 40)
Holder.Size = UDim2.new(1, 0, 0, 80) -- Дал начальный размер для двух кнопок
Holder.BackgroundTransparency = 1
Holder.Visible = false

local HolderList = Instance.new("UIListLayout", Holder)
HolderList.Padding = UDim.new(0, 5)
HolderList.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function UpdateSizes()
    local h = 0
    for _, v in pairs(Holder:GetChildren()) do
        if v:IsA("Frame") then h = h + v.Size.Y.Offset + 5 end
    end
    Holder.Size = UDim2.new(1, 0, 0, h)
    if Holder.Visible then
        Main.Size = UDim2.new(0, 220, 0, h + 45)
    end
end

local function CreateSub(name)
    local SubFrame = Instance.new("Frame", Holder)
    SubFrame.Size = UDim2.new(0.95, 0, 0, 35)
    SubFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SubFrame.BorderSizePixel = 0
    SubFrame.ClipsDescendants = true
    Instance.new("UICorner", SubFrame)

    local SubBtn = Instance.new("TextButton", SubFrame)
    SubBtn.Size = UDim2.new(1, 0, 0, 35)
    SubBtn.Text = name .. "  <"
    SubBtn.TextColor3 = Color3.new(1, 1, 1)
    SubBtn.BackgroundTransparency = 1
    SubBtn.Font = Enum.Font.SourceSansBold

    local Content = Instance.new("Frame", SubFrame)
    Content.Size = UDim2.new(1, 0, 0, 250)
    Content.Position = UDim2.new(0, 0, 0, 35)
    Content.BackgroundTransparency = 1
    local CL = Instance.new("UIListLayout", Content)
    CL.Padding = UDim.new(0, 5)
    CL.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local subOpen = false
    SubBtn.MouseButton1Click:Connect(function()
        subOpen = not subOpen
        SubFrame.Size = subOpen and UDim2.new(0.95, 0, 0, 285) or UDim2.new(0.95, 0, 0, 35)
        SubBtn.Text = name .. (subOpen and "  v" or "  <")
        UpdateSizes()
    end)
    return Content
end

local KillUI = CreateSub("kill Gui")
local EspUI = CreateSub("Esp Gui")

-- ЭЛЕМЕНТЫ KILL
local TargetInput = Instance.new("TextBox", KillUI)
TargetInput.Size = UDim2.new(0.9, 0, 0, 30)
TargetInput.PlaceholderText = "Username..."
TargetInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TargetInput.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", TargetInput)

local KillBtn = Instance.new("TextButton", KillUI)
KillBtn.Size = UDim2.new(0.9, 0, 0, 35)
KillBtn.Text = "Kill Player"
KillBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
KillBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", KillBtn)

local AuraBtn = Instance.new("TextButton", KillUI)
AuraBtn.Size = UDim2.new(0.9, 0, 0, 35)
AuraBtn.Text = "Aura: OFF"
AuraBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
AuraBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", AuraBtn)

-- ЭЛЕМЕНТЫ ESP
local EspBtn = Instance.new("TextButton", EspUI)
EspBtn.Size = UDim2.new(0.9, 0, 0, 35)
EspBtn.Text = "ESP: OFF"
EspBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
EspBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", EspBtn)

local Scroll = Instance.new("ScrollingFrame", EspUI)
Scroll.Size = UDim2.new(0.9, 0, 0, 120)
Scroll.BackgroundColor3 = Color3.fromRGB(30,30,30)
Scroll.CanvasSize = UDim2.new(0,0,5,0)
Instance.new("UIListLayout", Scroll)

MainToggle.MouseButton1Click:Connect(function()
    Holder.Visible = not Holder.Visible
    MainToggle.Text = Holder.Visible and "v" or "<"
    if not Holder.Visible then 
        Main.Size = UDim2.new(0, 220, 0, 35)
    else
        UpdateSizes()
    end
end)

local function fire(h, r)
    local p = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Pistol")
    if p and p:FindFirstChild("RemoteEvent") then p.RemoteEvent:FireServer(h, 100, {9.17, r.CFrame}) end
end

KillBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #TargetInput.Text) == TargetInput.Text:lower() and p.Character then
            fire(p.Character:FindFirstChild("Humanoid"), p.Character:FindFirstChild("HumanoidRootPart"))
        end
    end
end)

local Aura = false
AuraBtn.MouseButton1Click:Connect(function()
    Aura = not Aura
    AuraBtn.Text = Aura and "Aura: ON" or "Aura: OFF"
    AuraBtn.BackgroundColor3 = Aura and Color3.fromRGB(120, 0, 255) or Color3.fromRGB(60,60,60)
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
    EspBtn.Text = EspOn and "ESP: ON" or "ESP: OFF"
    EspBtn.BackgroundColor3 = EspOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60,60,60)
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

local function up()
    for _, c in pairs(Scroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local b = Instance.new("TextButton", Scroll)
            b.Size = UDim2.new(1, 0, 0, 20)
            b.Text = p.Name
            b.BackgroundColor3 = Color3.fromRGB(45,45,45)
            b.TextColor3 = Color3.new(1,1,1)
            b.MouseButton1Click:Connect(function() TargetInput.Text = p.Name end)
        end
    end
end
spawn(function() while wait(5) do up() end end)
up()
UpdateSizes()
