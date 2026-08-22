-- TP-Location GUI (Teleport with Return)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Удаляем старый GUI
if CoreGui:FindFirstChild("TPLocationGUI") then
    CoreGui.TPLocationGUI:Destroy()
end

-- Локации
local Locations = {
    {Name = "big-Rock", CFrame = CFrame.new(5.18374825, 654.189697, -342.462616, -0.952184498, 0.0223610066, -0.304704309, 6.55604193e-09, 0.997318089, 0.0731890872, 0.305523694, 0.0696895123, -0.949630797)},
    {Name = "Atoms", CFrame = CFrame.new(-177.176712, 1620.16943, 25011.75, -0.213201091, -0.0875564814, 0.973077178, 1.36434075e-09, 0.995976329, 0.0896169245, -0.977008343, 0.0191064272, -0.212343231)},
    {Name = "Atomic", CFrame = CFrame.new(-59.9984245, 1593.18457, 25239.918, -0.427960843, 0.0883001238, -0.899473488, 4.03321837e-06, 0.995216191, 0.0976971313, 0.903797269, 0.0418069176, -0.4259139)},
    {Name = "platform-white", CFrame = CFrame.new(-7.09985161, 1469.36914, 25125.875, 0.289010257, -0.0649206564, 0.955122173, -3.55032975e-10, 0.997697949, 0.0678145736, -0.957325995, -0.019599108, 0.28834492)},
    {Name = "Death counter", CFrame = CFrame.new(-68.4570389, 35.9346085, 20336.9219, -0.311435789, -0.0953385904, 0.945472538, 3.40940054e-09, 0.994954407, 0.100328192, -0.950267196, 0.0312457923, -0.309864402)},
    {Name = "trava-platform", CFrame = CFrame.new(657.496338, 655.943909, -41.0596085, -0.0102237305, -0.0596988313, 0.998164058, -1.00002306e-09, 0.998216271, 0.0597019531, -0.999947727, 0.00061037566, -0.0102054942)},
    {Name = "dummy-spawn", CFrame = CFrame.new(144.413055, 440.752686, 35.9145241, 0.865861416, 2.83381052e-08, 0.500283897, -4.07678442e-08, 1, 1.39144971e-08, -0.500283897, -3.24435234e-08, 0.865861416)}
}

local selectedLocation = nil
local selectedName = "None"

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TPLocationGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Главное окно
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 260, 0, 160)
Main.Position = UDim2.new(0.5, -130, 0.5, -80)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)

-- Верхняя панель
local Top = Instance.new("Frame")
Top.Parent = Main
Top.Size = UDim2.new(1, 0, 0, 28)
Top.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Top.BorderSizePixel = 0
Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 6)

-- Название
local Title = Instance.new("TextLabel")
Title.Parent = Top
Title.Size = UDim2.new(1, -55, 1, 0)
Title.Position = UDim2.new(0, 8, 0, 0)
Title.Text = "TP-Location Gui"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

-- Кнопка сворачивания
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = Top
MinBtn.Size = UDim2.new(0, 26, 0, 26)
MinBtn.Position = UDim2.new(1, -52, 0, 1)
MinBtn.Text = "<"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 14
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinBtn.BorderSizePixel = 0
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 4)

-- Кнопка закрытия
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Top
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -28, 0, 1)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CloseBtn.BorderSizePixel = 0
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 4)

-- Контент
local Content = Instance.new("Frame")
Content.Parent = Main
Content.Size = UDim2.new(1, -10, 1, -38)
Content.Position = UDim2.new(0, 5, 0, 33)
Content.BackgroundTransparency = 1

-- Кнопка выбора локации
local LocationBtn = Instance.new("TextButton")
LocationBtn.Parent = Content
LocationBtn.Size = UDim2.new(1, 0, 0, 28)
LocationBtn.Position = UDim2.new(0, 0, 0, 0)
LocationBtn.Text = "Location: None"
LocationBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LocationBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
LocationBtn.Font = Enum.Font.SourceSansBold
LocationBtn.TextSize = 13
LocationBtn.BorderSizePixel = 0
Instance.new("UICorner", LocationBtn).CornerRadius = UDim.new(0, 4)

-- Кнопка TP-Back
local TpBackBtn = Instance.new("TextButton")
TpBackBtn.Parent = Content
TpBackBtn.Size = UDim2.new(0.48, -3, 0, 32)
TpBackBtn.Position = UDim2.new(0, 0, 0, 34)
TpBackBtn.Text = "TP-Back"
TpBackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TpBackBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
TpBackBtn.Font = Enum.Font.SourceSansBold
TpBackBtn.TextSize = 13
TpBackBtn.BorderSizePixel = 0
Instance.new("UICorner", TpBackBtn).CornerRadius = UDim.new(0, 4)

-- Кнопка Just-TP
local JustTpBtn = Instance.new("TextButton")
JustTpBtn.Parent = Content
JustTpBtn.Size = UDim2.new(0.48, -3, 0, 32)
JustTpBtn.Position = UDim2.new(0.52, 0, 0, 34)
JustTpBtn.Text = "Just-TP"
JustTpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JustTpBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
JustTpBtn.Font = Enum.Font.SourceSansBold
JustTpBtn.TextSize = 13
JustTpBtn.BorderSizePixel = 0
Instance.new("UICorner", JustTpBtn).CornerRadius = UDim.new(0, 4)

-- Окно выбора локации
local SelectionFrame = Instance.new("Frame")
SelectionFrame.Parent = ScreenGui
SelectionFrame.Size = UDim2.new(0, 220, 0, 260)
SelectionFrame.Position = UDim2.new(0.5, -110, 0.5, -130)
SelectionFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SelectionFrame.BorderSizePixel = 0
SelectionFrame.Visible = false
SelectionFrame.Active = true
SelectionFrame.Draggable = true
Instance.new("UICorner", SelectionFrame).CornerRadius = UDim.new(0, 6)

-- Заголовок окна выбора
local SelTop = Instance.new("Frame")
SelTop.Parent = SelectionFrame
SelTop.Size = UDim2.new(1, 0, 0, 28)
SelTop.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SelTop.BorderSizePixel = 0
Instance.new("UICorner", SelTop).CornerRadius = UDim.new(0, 6)

local SelTitle = Instance.new("TextLabel")
SelTitle.Parent = SelTop
SelTitle.Size = UDim2.new(1, -35, 1, 0)
SelTitle.Position = UDim2.new(0, 8, 0, 0)
SelTitle.Text = "Select Location"
SelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SelTitle.TextSize = 13
SelTitle.Font = Enum.Font.SourceSansBold
SelTitle.TextXAlignment = Enum.TextXAlignment.Left
SelTitle.BackgroundTransparency = 1

local SelClose = Instance.new("TextButton")
SelClose.Parent = SelTop
SelClose.Size = UDim2.new(0, 26, 0, 26)
SelClose.Position = UDim2.new(1, -28, 0, 1)
SelClose.Text = "×"
SelClose.TextColor3 = Color3.fromRGB(255, 100, 100)
SelClose.TextSize = 16
SelClose.Font = Enum.Font.SourceSansBold
SelClose.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SelClose.BorderSizePixel = 0
Instance.new("UICorner", SelClose).CornerRadius = UDim.new(0, 4)

-- Список локаций (ScrollingFrame)
local ListFrame = Instance.new("ScrollingFrame")
ListFrame.Parent = SelectionFrame
ListFrame.Size = UDim2.new(1, -10, 1, -38)
ListFrame.Position = UDim2.new(0, 5, 0, 33)
ListFrame.BackgroundTransparency = 1
ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ListFrame.ScrollBarThickness = 4
ListFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = ListFrame
ListLayout.Padding = UDim.new(0, 4)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Создание кнопок локаций
for i, loc in ipairs(Locations) do
    local btn = Instance.new("TextButton")
    btn.Parent = ListFrame
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Text = loc.Name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 13
    btn.BorderSizePixel = 0
    btn.LayoutOrder = i
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    
    btn.MouseButton1Click:Connect(function()
        selectedLocation = loc.CFrame
        selectedName = loc.Name
        LocationBtn.Text = "Location: " .. loc.Name
        SelectionFrame.Visible = false
    end)
end

-- Обновление CanvasSize
ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ListFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
end)

-- Функция телепортации
local function TeleportTo(cf)
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        root.CFrame = cf
        return true
    end
    return false
end

-- Анти-спам
local isProcessing = false

-- TP-Back
TpBackBtn.MouseButton1Click:Connect(function()
    if isProcessing then return end
    if not selectedLocation then
        TpBackBtn.Text = "Select Location!"
        task.wait(1)
        TpBackBtn.Text = "TP-Back"
        return
    end
    
    isProcessing = true
    TpBackBtn.Text = "Teleporting..."
    TpBackBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
    
    task.spawn(function()
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if not root then
            TpBackBtn.Text = "TP-Back"
            TpBackBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
            isProcessing = false
            return
        end
        
        -- Запоминаем позицию
        local oldCF = root.CFrame
        
        -- Телепорт на локацию
        root.CFrame = selectedLocation
        
        -- Ждем 2 секунды
        task.wait(2)
        
        -- Телепорт обратно
        root.CFrame = oldCF
        
        TpBackBtn.Text = "TP-Back"
        TpBackBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
        isProcessing = false
    end)
end)

-- Just-TP
JustTpBtn.MouseButton1Click:Connect(function()
    if isProcessing then return end
    if not selectedLocation then
        JustTpBtn.Text = "Select Location!"
        task.wait(1)
        JustTpBtn.Text = "Just-TP"
        return
    end
    
    isProcessing = true
    JustTpBtn.Text = "Teleporting..."
    JustTpBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
    
    task.spawn(function()
        if TeleportTo(selectedLocation) then
            task.wait(0.5)
        end
        
        JustTpBtn.Text = "Just-TP"
        JustTpBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
        isProcessing = false
    end)
end)

-- Открытие окна выбора локации
LocationBtn.MouseButton1Click:Connect(function()
    SelectionFrame.Visible = true
end)

-- Закрытие окна выбора локации
SelClose.MouseButton1Click:Connect(function()
    SelectionFrame.Visible = false
end)

-- Закрытие при клике вне окна
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if SelectionFrame.Visible then
            local mousePos = UserInputService:GetMouseLocation()
            local absPos = SelectionFrame.AbsolutePosition
            local absSize = SelectionFrame.AbsoluteSize
            
            if not (mousePos.X >= absPos.X and mousePos.X <= absPos.X + absSize.X and
                    mousePos.Y >= absPos.Y and mousePos.Y <= absPos.Y + absSize.Y) then
                SelectionFrame.Visible = false
            end
        end
    end
end)

-- Сворачивание
local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        Main:TweenSize(UDim2.new(0, 260, 0, 28), "Out", "Quad", 0.2, true)
        Content.Visible = false
        MinBtn.Text = ">"
    else
        Main:TweenSize(UDim2.new(0, 260, 0, 160), "Out", "Quad", 0.2, true)
        Content.Visible = true
        MinBtn.Text = "<"
    end
end)

-- Закрытие
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

print("TP-Location GUI Loaded! Select location and use TP-Back or Just-TP.")
