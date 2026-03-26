--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local remote = ReplicatedStorage:WaitForChild("RE"):WaitForChild("FireMissile")

-- Staroe hehee
if CoreGui:FindFirstChild("NukeSystem") then CoreGui.NukeSystem:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NukeSystem"
screenGui.Parent = CoreGui
screenGui.IgnoreGuiInset = true

-- Settings artillery
local ammoTypes = {"Nuke", "Artillery Barrage", "Light Artillery", "Heavy Artillery"}
local currentAmmoIndex = 1

-- Основной контейнер (BUBAAA)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 150)
mainFrame.Position = UDim2.new(0.5, -100, 0.2, 0)
mainFrame.BackgroundTransparency = 1
mainFrame.Parent = screenGui

-- Кнопка АТАКИ
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, 0, 0, 60)
button.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
button.BorderSizePixel = 2
button.Text = "АРТА: ВЫКЛ"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.RobotoMono
button.TextSize = 20
button.Parent = mainFrame

-- Кнопка ВЫБОРА СНАРЯДА
local selectButton = Instance.new("TextButton")
selectButton.Size = UDim2.new(1, 0, 0, 40)
selectButton.Position = UDim2.new(0, 0, 0, 65)
selectButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
selectButton.Text = "change artillery"
selectButton.TextColor3 = Color3.fromRGB(255, 255, 0)
selectButton.Font = Enum.Font.RobotoMono
selectButton.TextSize = 16
selectButton.Parent = mainFrame

-- Текст с ТЕКУЩИМ СНАРЯДОМ
local ammoLabel = Instance.new("TextLabel")
ammoLabel.Size = UDim2.new(1, 0, 0, 30)
ammoLabel.Position = UDim2.new(0, 0, 0, 110)
ammoLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ammoLabel.BackgroundTransparency = 0.3
ammoLabel.Text = "Type: " .. ammoTypes[currentAmmoIndex]
ammoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ammoLabel.Font = Enum.Font.RobotoMono
ammoLabel.TextSize = 14
ammoLabel.Parent = mainFrame

--- Логика перетаскивания (теперь за mainFrame) ---
local dragging, dragInput, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)

--- Логика выбора artillery ---
selectButton.MouseButton1Click:Connect(function()
    currentAmmoIndex = currentAmmoIndex + 1
    if currentAmmoIndex > #ammoTypes then currentAmmoIndex = 1 end
    ammoLabel.Text = "Type: " .. ammoTypes[currentAmmoIndex]
end)

--- Логика artillery ---
local isNuking = false
local lp = Players.LocalPlayer

button.MouseButton1Click:Connect(function()
    isNuking = not isNuking
    if isNuking then
        button.Text = "АРТА: on"
        button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        
        task.spawn(function()
            while isNuking do
                local char = lp.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if root then
                    local p = root.Position
                    for i = 1, 30 do 
                        if not isNuking then break end
                        local targetPos = vector.create(
                            p.X + math.random(-150, 150),
                            p.Y - 5, 
                            p.Z + math.random(-150, 150)
                        )
                        -- Используем выбранный тип снаряда
                        remote:FireServer(ammoTypes[currentAmmoIndex], targetPos)
                    end
                end
                task.wait(0.05)
            end
        end)
    else
        button.Text = "АРТА: off"
        button.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end
end)
