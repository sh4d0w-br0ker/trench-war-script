-- Master Spy
local gui = Instance.new("ScreenGui")
gui.Name = "MasterSpy"
gui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 600, 0, 450)
frame.Position = UDim2.new(0.5, -300, 0.5, -225)
frame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
frame.BackgroundTransparency = 0.1
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- Звезды
for i = 1, 100 do
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, math.random(1, 2), 0, math.random(1, 2))
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundColor3 = Color3.new(1, 1, 1)
    star.BackgroundTransparency = math.random(30, 80) / 100
    star.BorderSizePixel = 0
    star.Parent = frame
end

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "MASTER SPY"
title.TextColor3 = Color3.fromRGB(200, 200, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

-- Кнопка закрытия
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 3)
close.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.GothamBold
close.Parent = frame
close.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Вкладки
local tab1 = Instance.new("TextButton")
tab1.Size = UDim2.new(0, 120, 0, 30)
tab1.Position = UDim2.new(0, 10, 0, 38)
tab1.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
tab1.Text = "HttpsSpy"
tab1.TextColor3 = Color3.new(1, 1, 1)
tab1.Font = Enum.Font.Gotham
tab1.Parent = frame

local tab2 = Instance.new("TextButton")
tab2.Size = UDim2.new(0, 120, 0, 30)
tab2.Position = UDim2.new(0, 140, 0, 38)
tab2.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
tab2.Text = "Code Spy"
tab2.TextColor3 = Color3.new(1, 1, 1)
tab2.Font = Enum.Font.Gotham
tab2.Parent = frame

-- Контейнеры
local container1 = Instance.new("ScrollingFrame")
container1.Size = UDim2.new(1, -20, 1, -80)
container1.Position = UDim2.new(0, 10, 0, 70)
container1.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
container1.BackgroundTransparency = 0.5
container1.Parent = frame
container1.Visible = true

local container2 = Instance.new("ScrollingFrame")
container2.Size = UDim2.new(1, -20, 1, -80)
container2.Position = UDim2.new(0, 10, 0, 70)
container2.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
container2.BackgroundTransparency = 0.5
container2.Parent = frame
container2.Visible = false

-- Логи
local logs1 = {} -- https
local logs2 = {} -- code
local id1, id2 = 1, 1

-- Функция обновления UI
local function updateUI(container, logs)
    for _, v in pairs(container:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    
    local y = 5
    for i, log in ipairs(logs) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 35)
        btn.Position = UDim2.new(0, 5, 0, y)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        btn.Text = log.name
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.TextSize = 12
        btn.Font = Enum.Font.Gotham
        btn.Parent = container
        
        -- Кнопка Copy
        local copy = Instance.new("TextButton")
        copy.Size = UDim2.new(0, 50, 0, 25)
        copy.Position = UDim2.new(1, -110, 0, 5)
        copy.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
        copy.Text = "Copy"
        copy.TextColor3 = Color3.new(1, 1, 1)
        copy.TextSize = 11
        copy.Parent = btn
        copy.MouseButton1Click:Connect(function()
            if setclipboard then setclipboard(log.code) end
            copy.Text = "✓"
            wait(0.5)
            copy.Text = "Copy"
        end)
        
        -- Кнопка Delete
        local del = Instance.new("TextButton")
        del.Size = UDim2.new(0, 50, 0, 25)
        del.Position = UDim2.new(1, -55, 0, 5)
        del.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
        del.Text = "Del"
        del.TextColor3 = Color3.new(1, 1, 1)
        del.TextSize = 11
        del.Parent = btn
        del.MouseButton1Click:Connect(function()
            table.remove(logs, i)
            updateUI(container, logs)
        end)
        
        -- Показ кода справа
        btn.MouseButton1Click:Connect(function()
            local rightFrame = container.Parent:FindFirstChild("CodeView")
            if not rightFrame then
                rightFrame = Instance.new("Frame")
                rightFrame.Name = "CodeView"
                rightFrame.Size = UDim2.new(0, 250, 1, -80)
                rightFrame.Position = UDim2.new(1, -260, 0, 70)
                rightFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
                rightFrame.BackgroundTransparency = 0.3
                rightFrame.Parent = container.Parent
                local rcorner = Instance.new("UICorner")
                rcorner.CornerRadius = UDim.new(0, 8)
                rcorner.Parent = rightFrame
            end
            
            local text = rightFrame:FindFirstChild("Text")
            if not text then
                text = Instance.new("ScrollingFrame")
                text.Size = UDim2.new(1, -10, 1, -10)
                text.Position = UDim2.new(0, 5, 0, 5)
                text.BackgroundTransparency = 1
                text.Parent = rightFrame
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Size = UDim2.new(1, 0, 0, 0)
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.fromRGB(200, 200, 200)
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextYAlignment = Enum.TextYAlignment.Top
                label.TextWrapped = true
                label.TextSize = 11
                label.Font = Enum.Font.Code
                label.Parent = text
                text.CanvasSize = UDim2.new(0, 0, 0, 0)
            end
            
            text.Label.Text = log.code
            text.Label.Size = UDim2.new(1, 0, 0, text.Label.TextBounds.Y + 10)
            text.CanvasSize = UDim2.new(0, 0, 0, text.Label.TextBounds.Y + 20)
        end)
        
        y = y + 40
    end
    container.CanvasSize = UDim2.new(0, 0, 0, y)
end

-- Переключение вкладок
tab1.MouseButton1Click:Connect(function()
    container1.Visible = true
    container2.Visible = false
    tab1.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    tab2.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
end)

tab2.MouseButton1Click:Connect(function()
    container1.Visible = false
    container2.Visible = true
    tab2.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    tab1.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
end)

-- Функция добавления лога
local function addLog(type, code, source)
    if type == "https" then
        table.insert(logs1, {name = "Loadstring " .. id1 .. (source and " ("..source..")" or ""), code = code})
        id1 = id1 + 1
        updateUI(container1, logs1)
    else
        table.insert(logs2, {name = "Code " .. id2 .. (source and " ("..source..")" or ""), code = code})
        id2 = id2 + 1
        updateUI(container2, logs2)
    end
end

-- ПЕРЕХВАТЫ
-- HttpsSpy: loadstring с http
local oldLS = loadstring
loadstring = function(s, n)
    if type(s) == "string" and s:match("https?://") then
        addLog("https", s, "intercepted")
    end
    return oldLS(s, n)
end

-- Code Spy: перехват ВСЕГО выполняемого кода
-- 1. load (аналог loadstring)
local oldLoad = load
load = function(s, n, m, e)
    if type(s) == "string" and s ~= "" then
        addLog("code", s, "load()")
    end
    return oldLoad(s, n, m, e)
end

-- 2. Перехват новых скриптов
local oldNew = Instance.new
Instance.new = function(c, p)
    local inst = oldNew(c, p)
    if c:lower():match("script") and inst:IsA("BaseScript") then
        task.wait(0.1)
        local suc, src = pcall(function() return inst.Source end)
        if suc and src and src ~= "" then
            addLog("code", src, "new "..c)
        end
    end
    return inst
end

-- 3. Перехват изменения Source
local mt = getrawmetatable and getrawmetatable(game) or debug.getmetatable(game)
if mt then
    local oldIndex = mt.__index
    local oldNewIndex = mt.__newindex
    if oldNewIndex then
        mt.__newindex = function(t, k, v)
            if k == "Source" and type(v) == "string" and v ~= "" then
                addLog("code", v, "script changed")
            end
            return oldNewIndex(t, k, v)
        end
    end
end

print("Master Spy loaded")
