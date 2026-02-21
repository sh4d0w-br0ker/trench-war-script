--[[ 
   ULTRA SMART COMPACT GUI (Vector/CFrame/Vector3)
]]

local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "UltraSmartTP_V8"

local isOpen = true

-- Главная рамка
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 240, 0, 220)
main.Position = UDim2.new(0.5, -120, 0.5, -110)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)

-- Заголовок
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(0.8, 0, 0, 30)
title.Text = "  Smart Teleport Gui"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.TextXAlignment = "Left"
title.Font = "GothamBold"

-- Кнопка сворачивания <
local toggleBtn = Instance.new("TextButton", main)
toggleBtn.Size = UDim2.new(0, 30, 0, 30)
toggleBtn.Position = UDim2.new(1, -35, 0, 0)
toggleBtn.Text = "<"
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.BackgroundTransparency = 1
toggleBtn.TextSize = 18

-- Контейнер содержимого
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, 0, 1, -30)
content.Position = UDim2.new(0, 0, 0, 30)
content.BackgroundTransparency = 1

local function createBtn(txt, pos, clr)
    local b = Instance.new("TextButton", content)
    b.Size = UDim2.new(0.9, 0, 0, 35)
    b.Position = pos
    b.Text = txt
    b.BackgroundColor3 = clr
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = "Gotham"
    Instance.new("UICorner", b)
    return b
end

-- Поле ввода
local input = Instance.new("TextBox", content)
input.Size = UDim2.new(0.9, 0, 0, 50)
input.Position = UDim2.new(0.05, 0, 0.05, 0)
input.PlaceholderText = "Вставь: vector / CFrame / Vector3"
input.Text = ""
input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
input.TextColor3 = Color3.fromRGB(0, 255, 150)
input.ClearTextOnFocus = false
input.TextWrapped = true
Instance.new("UICorner", input)

-- Кнопки
local getBtn = createBtn("ОПРЕДЕЛИТЬ И КОПИ", UDim2.new(0.05, 0, 0.35, 0), Color3.fromRGB(60, 60, 60))
local tpBtn = createBtn("TELEPORT!", UDim2.new(0.05, 0, 0.58, 0), Color3.fromRGB(0, 120, 200))
local exitBtn = createBtn("ЗАКРЫТЬ", UDim2.new(0.05, 0, 0.81, 0), Color3.fromRGB(45, 45, 45))

-- 1. ЛОГИКА СВОРАЧИВАНИЯ
toggleBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    content.Visible = isOpen
    main:TweenSize(isOpen and UDim2.new(0, 240, 0, 220) or UDim2.new(0, 240, 0, 30), "Out", "Quad", 0.2)
    toggleBtn.Text = isOpen and "<" or ">"
end)

-- 2. ЛОГИКА ОПРЕДЕЛЕНИЯ (ВЫДАЕТ САМОЕ АКТУАЛЬНОЕ)
getBtn.MouseButton1Click:Connect(function()
    local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local cf = hrp.CFrame
        -- Используем CFrame, так как он включает в себя и вектор позиции, и поворот
        local result = "CFrame.new(" .. tostring(cf) .. ")"
        input.Text = result
        if setclipboard then setclipboard(result) end
        getBtn.Text = "СКОПИРОВАНО!"
        task.wait(1)
        getBtn.Text = "ОПРЕДЕЛИТЬ И КОПИ"
    end
end)

-- 3. ЛОГИКА УНИВЕРСАЛЬНОГО ТП (ЧЕРЕЗ LOADSTRING)
tpBtn.MouseButton1Click:Connect(function()
    local val = input.Text
    if val ~= "" then
        -- Эта команда проверяет тип входа (vector, Vector3 или CFrame) и применяет его
        local code = "local data = " .. val .. "; " ..
                     "local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart; " ..
                     "if typeof(data) == 'CFrame' then hrp.CFrame = data " ..
                     "elseif typeof(data) == 'Vector3' or typeof(data) == 'vector' then hrp.CFrame = CFrame.new(data) end"
        
        local success, err = pcall(function()
            loadstring(code)()
        end)
        
        if success then
            tpBtn.Text = "УСПЕХ!"
            tpBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        else
            tpBtn.Text = "ОШИБКА!"
            warn(err)
        end
        task.wait(1)
        tpBtn.Text = "TELEPORT!"
        tpBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
    end
end)

exitBtn.MouseButton1Click:Connect(function() sg:Destroy() end)
