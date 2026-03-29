loadstring(game:HttpGet("https://raw.githubusercontent.com/sh4d0w-br0ker/trench-war-script/refs/heads/main/void.lua", true))()

local gui, main = library:Create("VOID HUB", UDim2.new(0, 250, 0, 150), UDim2.new(0.5, -125, 0.5, -75))

-- Вкладка для настроек скорости
local speedTab = gui:CreateTab("Speed")
local speedSection = speedTab:CreateSection("Настройки")

-- Поле ввода скорости
local speedBox = speedSection:AddTextBox("Speed:", "16", function(text) end)

-- Кнопка применить
speedSection:AddButton("Apply", Color3.fromRGB(50, 150, 200), function()
    local speedValue = tonumber(speedBox.Text)
    if speedValue then
        local player = game.Players.LocalPlayer
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = speedValue
        end
    end
end)

-- Кнопка сброса
speedSection:AddButton("Reset (16)", Color3.fromRGB(100, 100, 100), function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 16
        speedBox.Text = "16"
    end
end)

-- Вкладка для прыжка
local jumpTab = gui:CreateTab("Jump")
local jumpSection = jumpTab:CreateSection("Настройки")

local jumpBox = jumpSection:AddTextBox("Jump:", "50", function(text) end)

jumpSection:AddButton("Apply", Color3.fromRGB(50, 150, 200), function()
    local jumpValue = tonumber(jumpBox.Text)
    if jumpValue then
        local player = game.Players.LocalPlayer
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = jumpValue
        end
    end
end)

jumpSection:AddButton("Reset (50)", Color3.fromRGB(100, 100, 100), function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = 50
        jumpBox.Text = "50"
    end
end)

print("GUI загружен! Можно двигать за верхнюю панель")
