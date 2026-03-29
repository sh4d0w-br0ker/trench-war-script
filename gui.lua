local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/sh4d0w-br0ker/trench-war-script/refs/heads/main/void.lua", true))()

local gui, main = library:Create("VOID HUB", UDim2.new(0, 450, 0, 500), UDim2.new(0.5, -225, 0.5, -250))

local mainTab = gui:CreateTab("Главная")
local section = mainTab:CreateSection("Основное")

local speed = 16

-- ввод скорости
section:AddTextBox("Скорость", "Введите число", function(text)
    local num = tonumber(text)
    if num then
        speed = num
        print("Скорость сохранена:", speed)
    else
        warn("Это не число. Сюрприз.")
    end
end)

-- кнопка применить
section:AddButton("Применить", Color3.fromRGB(50, 120, 200), function()
    local plr = game.Players.LocalPlayer
    local char = plr.Character or plr.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")

    if hum then
        hum.WalkSpeed = speed
        print("Применено:", speed)
    else
        warn("Humanoid не найден. Печально.")
    end
end)
