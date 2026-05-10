local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner_Main = Instance.new("UICorner")
local UIGradient_Main = Instance.new("UIGradient")
local TitleBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local MinimizeBtn = Instance.new("TextButton")
local Content = Instance.new("Frame")
local Tabs = Instance.new("Frame")
local BuyTabBtn = Instance.new("TextButton")
local OthersTabBtn = Instance.new("TextButton")
local Pages = Instance.new("Frame")
local BuyPage = Instance.new("ScrollingFrame")
local OthersPage = Instance.new("ScrollingFrame")

-- Кнопка открытия
local OpenBtn = Instance.new("TextButton")
OpenBtn.Name = "OpenBtn"
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 80, 0, 30)
OpenBtn.Position = UDim2.new(1, -90, 0, 10)
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.Text = "Open GUI"
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 12
OpenBtn.Visible = false
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 5)

-- Настройка UI
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "VoidHub_Black"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner_Main.CornerRadius = UDim.new(0, 10)
UICorner_Main.Parent = MainFrame

UIGradient_Main.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 10, 30))
}
UIGradient_Main.Rotation = 45
UIGradient_Main.Parent = MainFrame

TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TitleBar.BackgroundTransparency = 0.2
TitleBar.Size = UDim2.new(1, 0, 0, 35)

local UICorner_Title = Instance.new("UICorner", TitleBar)
UICorner_Title.CornerRadius = UDim.new(0, 10)

Title.Parent = TitleBar
Title.Text = "  VOID HUB"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(180, 100, 255)
Title.TextSize = 16
Title.Size = UDim2.new(0, 120, 1, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseBtn.Parent = TitleBar
CloseBtn.Text = "×"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

MinimizeBtn.Parent = TitleBar
MinimizeBtn.Text = "<"
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextColor3 = Color3.new(1,1,1)
MinimizeBtn.Position = UDim2.new(1, -65, 0, 5)
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(1, 0)

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

Content.Name = "Content"
Content.Parent = MainFrame
Content.Size = UDim2.new(1, 0, 1, -35)
Content.Position = UDim2.new(0, 0, 0, 35)
Content.BackgroundTransparency = 1

Tabs.Parent = Content
Tabs.Size = UDim2.new(0, 90, 1, -10)
Tabs.Position = UDim2.new(0, 5, 0, 5)
Tabs.BackgroundTransparency = 1

local function StyleButton(btn)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
end

BuyTabBtn.Parent = Tabs
BuyTabBtn.Size = UDim2.new(1, 0, 0, 35)
BuyTabBtn.Text = "SHOP"
StyleButton(BuyTabBtn)

OthersTabBtn.Parent = Tabs
OthersTabBtn.Position = UDim2.new(0, 0, 0, 45)
OthersTabBtn.Size = UDim2.new(1, 0, 0, 35)
OthersTabBtn.Text = "OTHERS"
StyleButton(OthersTabBtn)

Pages.Parent = Content
Pages.Position = UDim2.new(0, 100, 0, 5)
Pages.Size = UDim2.new(1, -105, 1, -10)
Pages.BackgroundTransparency = 1

BuyPage.Parent = Pages
BuyPage.Size = UDim2.new(1, 0, 1, 0)
BuyPage.BackgroundTransparency = 1
BuyPage.CanvasSize = UDim2.new(0, 0, 0, 0)
BuyPage.ScrollBarThickness = 2
BuyPage.Visible = true
local UIList = Instance.new("UIListLayout", BuyPage)
UIList.Padding = UDim.new(0, 5)

OthersPage.Parent = Pages
OthersPage.Size = UDim2.new(1, 0, 1, 0)
OthersPage.BackgroundTransparency = 1
OthersPage.ScrollBarThickness = 2
OthersPage.Visible = false
local UIListOthers = Instance.new("UIListLayout", OthersPage)
UIListOthers.Padding = UDim.new(0, 5)

BuyTabBtn.MouseButton1Click:Connect(function() BuyPage.Visible = true OthersPage.Visible = false end)
OthersTabBtn.MouseButton1Click:Connect(function() BuyPage.Visible = false OthersPage.Visible = true end)

-- SHOP LOGIC
task.spawn(function()
    local shopFolder = workspace:WaitForChild("shopTouchPrompts", 5)
    if shopFolder then
        for _, item in pairs(shopFolder:GetChildren()) do
            if item:IsA("BasePart") then
                local btn = Instance.new("TextButton", BuyPage)
                btn.Size = UDim2.new(1, -10, 0, 35)
                btn.Text = item.Name
                StyleButton(btn)
                btn.MouseButton1Click:Connect(function()
                    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then 
                        hrp.CFrame = item.CFrame * CFrame.new(0, 5, 0)
                    end
                end)
            end
        end
        BuyPage.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
    end
end)

--- ESP LOGIC - ИСПРАВЛЕН ---
local EspBtn = Instance.new("TextButton", OthersPage)
EspBtn.Size = UDim2.new(1, -10, 0, 35)
EspBtn.Text = "ESP: OFF"
StyleButton(EspBtn)
EspBtn.BackgroundColor3 = Color3.fromRGB(100, 30, 30)

local espActive = false

local function createEspTag(object)
    if object:FindFirstChild("ESP_Tag_High") then return end
    
    local name = object.Name
    local parentName = (object.Parent and object.Parent.Name) or ""
    if name == "Pennywise22" or name == "Jeff The Killer" or parentName == "Pennywise22" or parentName == "Jeff The Killer" then
        return
    end

    local bg = Instance.new("BillboardGui")
    bg.Name = "ESP_Tag_High"
    bg.Parent = object
    bg.Size = UDim2.new(0, 200, 0, 50)
    bg.AlwaysOnTop = true
    bg.ExtentsOffset = Vector3.new(0, 3, 0) -- ВЫШЕ УРОВНЕМ
    bg.ZIndexBehavior = Enum.ZIndexBehavior.Global
    bg.Enabled = true
    bg.ClipsDescendants = false
    
    local tl = Instance.new("TextLabel", bg)
    tl.Name = "ESP_Label"
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.BackgroundTransparency = 1
    tl.TextColor3 = Color3.fromRGB(255, 0, 0)
    tl.Font = Enum.Font.GothamBold
    tl.TextSize = 14
    tl.TextStrokeTransparency = 0.3
    tl.Text = "Killer"
    tl.TextScaled = false
    
    task.spawn(function()
        while object and object:IsDescendantOf(workspace) and bg.Parent do
            if espActive then
                bg.Enabled = true
                local char = game.Players.LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                
                local targetPart = object:IsA("BasePart") and object or (object:FindFirstChild("HumanoidRootPart") or object.PrimaryPart or object:FindFirstChildWhichIsA("BasePart"))
                
                if hrp and targetPart then
                    local dist = math.floor((hrp.Position - targetPart.Position).Magnitude)
                    -- ЕБАНУТЫЙ ОТПРАВИТЕЛЬ - ДИСТАНЦИЯ ВСЕГДА ПОКАЗЫВАЕТСЯ, НИКАКИХ else
                    tl.Text = "Killer\n[" .. dist .. " studs]"
                else
                    -- ДАЖЕ ЕСЛИ HRP НЕТ, ВСЕ РАВНО ПИШЕМ ХОТЬ КАКОЙ ТЕКСТ С ДИСТАНЦИЕЙ
                    tl.Text = "Killer\n[? studs]"
                end
            else
                bg.Enabled = false
            end
            task.wait(0.05) -- БЫСТРОЕ ОБНОВЛЕНИЕ ДЛЯ ПЛАВНОСТИ
        end
        if bg then bg:Destroy() end
    end)
end

local function checkAndAdd(v)
    if v.Name == "Animatronic" then
        createEspTag(v)
    elseif v.Name == "ColdBloodedKiller" then
        local monster = v.Parent
        if monster and monster:IsA("Model") then
            createEspTag(monster)
        end
    end
end

EspBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    EspBtn.Text = "ESP: " .. (espActive and "ON" or "OFF")
    EspBtn.BackgroundColor3 = espActive and Color3.fromRGB(30, 100, 30) or Color3.fromRGB(100, 30, 30)
    
    if espActive then
        for _, v in pairs(workspace:GetDescendants()) do
            task.wait()
            checkAndAdd(v)
        end
    end
end)

workspace.DescendantAdded:Connect(function(descendant)
    if espActive then
        task.wait(0.1)
        checkAndAdd(descendant)
    end
end)

--- OTHERS ---

local StartElevatorBtn = Instance.new("TextButton", OthersPage)
StartElevatorBtn.Size = UDim2.new(1, -10, 0, 35)
StartElevatorBtn.Text = "Start Elevator"
StyleButton(StartElevatorBtn)

StartElevatorBtn.MouseButton1Click:Connect(function()
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CFrame.new(8.16834068, 3.99998641, -15.4028015, -0.371262282, -2.06789252e-08, 0.928528011, -5.99545444e-08, 1, -1.7015499e-09, -0.928528011, -5.63011966e-08, -0.371262282)
    end
end)

OthersPage.CanvasSize = UDim2.new(0, 0, 0, UIListOthers.AbsoluteContentSize.Y + 10)
