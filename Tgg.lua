-- Trash Giver (Маленькое GUI для Give Trash)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Удаляем старый GUI
if CoreGui:FindFirstChild("TrashGiver") then
    CoreGui.TrashGiver:Destroy()
end

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TrashGiver"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Главное окно
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 200, 0, 90)
Main.Position = UDim2.new(0.5, -100, 0.5, -45)
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
Title.Text = "Trash Giver"
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

-- Кнопка Give Trash
local GiveBtn = Instance.new("TextButton")
GiveBtn.Parent = Content
GiveBtn.Size = UDim2.new(1, 0, 1, -8)
GiveBtn.Position = UDim2.new(0, 0, 0, 4)
GiveBtn.Text = "Give Trash"
GiveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GiveBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
GiveBtn.Font = Enum.Font.SourceSansBold
GiveBtn.TextSize = 14
GiveBtn.BorderSizePixel = 0
Instance.new("UICorner", GiveBtn).CornerRadius = UDim.new(0, 4)

-- Анти-спам
local isProcessing = false

GiveBtn.MouseButton1Click:Connect(function()
    if isProcessing then return end
    isProcessing = true
    
    GiveBtn.Text = "Getting Trash..."
    GiveBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
    
    task.spawn(function()
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local event = char and char:FindFirstChild("Communicate")
        
        if not root or not event then
            GiveBtn.Text = "Give Trash"
            GiveBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
            isProcessing = false
            return
        end

        local trashParts = {}
        local trashFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Trash")
        
        if trashFolder then
            for _, desc in ipairs(trashFolder:GetDescendants()) do
                if desc.Name == "Trashcan" and desc:IsA("BasePart") then
                    table.insert(trashParts, desc)
                end
            end
        end
        
        if #trashParts == 0 then
            GiveBtn.Text = "No Trashcan Found"
            task.wait(1)
            GiveBtn.Text = "Give Trash"
            GiveBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
            isProcessing = false
            return
        end

        local randomTrash = trashParts[math.random(1, #trashParts)]
        
        -- 1. Запоминаем старое место
        local oldCF = root.CFrame
        
        -- 2. Телепортируемся К МУСОРКЕ
        root.CFrame = randomTrash.CFrame * CFrame.new(0, 0, 3)
        
        -- Микро-пауза для прогрузки позиции
        task.wait(0.1)

        -- 3. ОТПРАВЛЯЕМ 2 КЛИКА ПОДРЯД (Берем текущие координаты возле мусорки)
        local clickData = {
            Mobile = true,
            Goal = "LeftClick",
            MousePos = root.CFrame
        }
        
        pcall(function() event:FireServer(clickData) end)
        pcall(function() event:FireServer(clickData) end)
        
        -- 4. ЗАДЕРЖКА ПЕРЕД ОТПУСКАНИЕМ КЛИКА (0.7 сек)
        task.wait(0.7)

        -- 5. ОТПУСКАЕМ КЛИК (RELEASE)
        pcall(function()
            event:FireServer({
                Goal = "LeftClickRelease",
                Mobile = true
            })
        end)

        -- 6. ЗАДЕРЖКА ПЕРЕД ТЕЛЕПОРТОМ НАЗАД (1.5 сек)
        task.wait(1.5)

        -- 7. ТЕЛЕПОРТИРУЕМСЯ НАЗАД НА СТАРОЕ МЕСТО
        root.CFrame = oldCF
        
        GiveBtn.Text = "Give Trash"
        GiveBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
        
        isProcessing = false
    end)
end)

-- Сворачивание
local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        Main:TweenSize(UDim2.new(0, 200, 0, 28), "Out", "Quad", 0.2, true)
        Content.Visible = false
        MinBtn.Text = ">"
    else
        Main:TweenSize(UDim2.new(0, 200, 0, 90), "Out", "Quad", 0.2, true)
        Content.Visible = true
        MinBtn.Text = "<"
    end
end)

-- Закрытие
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

print("Trash Giver Fixed! 2 Clicks -> 0.7s wait -> Release -> 1.5s wait -> TP Back.")
