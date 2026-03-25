-- Master Spy
-- Перехватывает loadstring (HttpsSpy) И ЛЮБОЙ ИСПОЛНЯЕМЫЙ КОД (Code Spy)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MasterSpyGui"
screenGui.Parent = game:GetService("CoreGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Логи
local logs = {
    https = {},
    code = {}
}
local logCounters = { https = 1, code = 1 }

-- Звездный фон
local function createStars()
    local starsContainer = Instance.new("Frame")
    starsContainer.Name = "StarsContainer"
    starsContainer.Size = UDim2.new(1, 0, 1, 0)
    starsContainer.BackgroundTransparency = 1
    starsContainer.Parent = screenGui

    for i = 1, 150 do
        local star = Instance.new("Frame")
        star.Size = UDim2.new(0, math.random(1, 3), 0, math.random(1, 3))
        star.Position = UDim2.new(math.random(), 0, math.random(), 0)
        star.BackgroundColor3 = Color3.new(1, 1, 1)
        star.BackgroundTransparency = math.random(30, 80) / 100
        star.BorderSizePixel = 0
        star.Parent = starsContainer
        
        spawn(function()
            while star and star.Parent do
                wait(math.random(2, 8))
                if star then
                    star.BackgroundTransparency = math.random(30, 90) / 100
                end
            end
        end)
    end
end

-- Основное окно
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 750, 0, 550)
mainFrame.Position = UDim2.new(0.5, -375, 0.5, -275)
mainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "MASTER SPY"
title.TextColor3 = Color3.fromRGB(180, 180, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = mainFrame

-- Кнопка закрытия
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -42, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.Parent = mainFrame
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 16)
closeCorner.Parent = closeBtn
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Вкладки
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 45)
tabBar.Position = UDim2.new(0, 0, 0, 40)
tabBar.BackgroundTransparency = 1
tabBar.Parent = mainFrame

local httpsTabBtn = Instance.new("TextButton")
httpsTabBtn.Size = UDim2.new(0, 160, 1, -8)
httpsTabBtn.Position = UDim2.new(0, 12, 0, 4)
httpsTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
httpsTabBtn.Text = "🔗 HttpsSpy"
httpsTabBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
httpsTabBtn.Font = Enum.Font.GothamSemibold
httpsTabBtn.TextSize = 14
httpsTabBtn.Parent = tabBar
local httpsTabCorner = Instance.new("UICorner")
httpsTabCorner.CornerRadius = UDim.new(0, 8)
httpsTabCorner.Parent = httpsTabBtn

local codeTabBtn = Instance.new("TextButton")
codeTabBtn.Size = UDim2.new(0, 160, 1, -8)
codeTabBtn.Position = UDim2.new(0, 182, 0, 4)
codeTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
codeTabBtn.Text = "💻 Code Spy"
codeTabBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
codeTabBtn.Font = Enum.Font.GothamSemibold
codeTabBtn.TextSize = 14
codeTabBtn.Parent = tabBar
local codeTabCorner = Instance.new("UICorner")
codeTabCorner.CornerRadius = UDim.new(0, 8)
codeTabCorner.Parent = codeTabBtn

-- Контейнеры
local httpsContainer = Instance.new("Frame")
httpsContainer.Size = UDim2.new(1, 0, 1, -90)
httpsContainer.Position = UDim2.new(0, 0, 0, 85)
httpsContainer.BackgroundTransparency = 1
httpsContainer.Parent = mainFrame
httpsContainer.Visible = true

local codeContainer = Instance.new("Frame")
codeContainer.Size = UDim2.new(1, 0, 1, -90)
codeContainer.Position = UDim2.new(0, 0, 0, 85)
codeContainer.BackgroundTransparency = 1
codeContainer.Parent = mainFrame
codeContainer.Visible = false

-- Функция создания левой панели (список логов)
local function createLogList(parent)
    local leftPanel = Instance.new("ScrollingFrame")
    leftPanel.Size = UDim2.new(0, 280, 1, 0)
    leftPanel.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    leftPanel.BackgroundTransparency = 0.4
    leftPanel.BorderSizePixel = 0
    leftPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
    leftPanel.ScrollBarThickness = 6
    leftPanel.Parent = parent
    local leftCorner = Instance.new("UICorner")
    leftCorner.CornerRadius = UDim.new(0, 10)
    leftCorner.Parent = leftPanel
    return leftPanel
end

-- Функция создания правой панели (просмотр кода)
local function createCodeViewer(parent)
    local rightPanel = Instance.new("Frame")
    rightPanel.Size = UDim2.new(1, -290, 1, 0)
    rightPanel.Position = UDim2.new(0, 290, 0, 0)
    rightPanel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    rightPanel.BackgroundTransparency = 0.65
    rightPanel.BorderSizePixel = 0
    rightPanel.Parent = parent
    local rightCorner = Instance.new("UICorner")
    rightCorner.CornerRadius = UDim.new(0, 10)
    rightCorner.Parent = rightPanel
    
    local textBox = Instance.new("ScrollingFrame")
    textBox.Size = UDim2.new(1, -20, 1, -20)
    textBox.Position = UDim2.new(0, 10, 0, 10)
    textBox.BackgroundTransparency = 1
    textBox.BorderSizePixel = 0
    textBox.CanvasSize = UDim2.new(0, 0, 0, 0)
    textBox.ScrollBarThickness = 6
    textBox.Parent = rightPanel
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "Select a log to view code..."
    textLabel.TextColor3 = Color3.fromRGB(170, 170, 200)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.TextWrapped = true
    textLabel.TextSize = 12
    textLabel.Font = Enum.Font.Code
    textLabel.Parent = textBox
    
    return { panel = rightPanel, textBox = textBox, textLabel = textLabel }
end

-- Обновление UI логов
local function updateLogUI(container, logType)
    local leftList = container:FindFirstChild("LogList")
    local rightView = container:FindFirstChild("CodeViewer")
    
    if not leftList or not rightView then return end
    
    for _, child in pairs(leftList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local logsTable = logs[logType]
    local yOffset = 0
    local buttonHeight = 42
    
    for index, logEntry in ipairs(logsTable) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -12, 0, buttonHeight)
        btn.Position = UDim2.new(0, 6, 0, yOffset)
        btn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
        btn.Text = logEntry.name
        btn.TextColor3 = Color3.fromRGB(210, 210, 230)
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.TextSize = 12
        btn.Font = Enum.Font.Gotham
        btn.Parent = leftList
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            rightView.textLabel.Text = logEntry.code
            rightView.textLabel.Size = UDim2.new(1, 0, 0, rightView.textLabel.TextBounds.Y + 20)
            rightView.textBox.CanvasSize = UDim2.new(0, 0, 0, rightView.textLabel.TextBounds.Y + 30)
        end)
        
        -- Кнопка Delete
        local deleteBtn = Instance.new("TextButton")
        deleteBtn.Size = UDim2.new(0, 55, 1, -8)
        deleteBtn.Position = UDim2.new(1, -61, 0, 4)
        deleteBtn.BackgroundColor3 = Color3.fromRGB(170, 40, 40)
        deleteBtn.Text = "🗑"
        deleteBtn.TextColor3 = Color3.new(1, 1, 1)
        deleteBtn.TextSize = 14
        deleteBtn.Font = Enum.Font.GothamBold
        deleteBtn.Parent = btn
        local delCorner = Instance.new("UICorner")
        delCorner.CornerRadius = UDim.new(0, 5)
        delCorner.Parent = deleteBtn
        
        deleteBtn.MouseButton1Click:Connect(function()
            table.remove(logsTable, index)
            updateLogUI(container, logType)
            if rightView.textLabel.Text == logEntry.code then
                rightView.textLabel.Text = "Select a log to view code..."
                rightView.textLabel.Size = UDim2.new(1, 0, 0, 30)
                rightView.textBox.CanvasSize = UDim2.new(0, 0, 0, 30)
            end
        end)
        
        -- Кнопка Copy
        local copyBtn = Instance.new("TextButton")
        copyBtn.Size = UDim2.new(0, 55, 1, -8)
        copyBtn.Position = UDim2.new(1, -122, 0, 4)
        copyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 120)
        copyBtn.Text = "📋"
        copyBtn.TextColor3 = Color3.new(1, 1, 1)
        copyBtn.TextSize = 14
        copyBtn.Font = Enum.Font.GothamBold
        copyBtn.Parent = btn
        local copyCorner = Instance.new("UICorner")
        copyCorner.CornerRadius = UDim.new(0, 5)
        copyCorner.Parent = copyBtn
        
        copyBtn.MouseButton1Click:Connect(function()
            if setclipboard then
                setclipboard(logEntry.code)
            elseif toclipboard then
                toclipboard(logEntry.code)
            end
            copyBtn.Text = "✓"
            wait(0.8)
            copyBtn.Text = "📋"
        end)
        
        yOffset = yOffset + buttonHeight + 5
    end
    
    leftList.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

-- Создание интерфейсов
local httpsLeft = createLogList(httpsContainer)
local httpsRight = createCodeViewer(httpsContainer)
httpsLeft.Name = "LogList"
httpsRight.panel.Name = "CodeViewer"

local codeLeft = createLogList(codeContainer)
local codeRight = createCodeViewer(codeContainer)
codeLeft.Name = "LogList"
codeRight.panel.Name = "CodeViewer"

-- Функция добавления лога
function AddLog(logType, codeContent, sourceInfo)
    local logName = logType == "https" and "🌐 Loadstring " or "📜 Code "
    local index = logCounters[logType]
    logCounters[logType] = index + 1
    logName = logName .. index .. (sourceInfo and " [" .. sourceInfo .. "]" or "")
    
    table.insert(logs[logType], {
        name = logName,
        code = codeContent,
        timestamp = os.time()
    })
    
    if logType == "https" then
        updateLogUI(httpsContainer, "https")
    else
        updateLogUI(codeContainer, "code")
    end
end

-- ============================================
-- HttpsSpy: перехват loadstring с http ссылками
-- ============================================
local oldLoadstring = loadstring
local function newLoadstring(str, chunkname)
    if type(str) == "string" and (str:match("game:HttpGet") or str:match("syn%.request") or str:match("HttpGet") or str:match("https?://")) then
        AddLog("https", str, "Loadstring Intercept")
    end
    return oldLoadstring(str, chunkname)
end
loadstring = newLoadstring

-- ============================================
-- CODE SPY: перехват ЛЮБОГО выполняемого Lua кода
-- ============================================

-- 1. Перехват load (аналог loadstring)
local oldLoad = load
local function newLoad(chunk, chunkname, mode, env)
    if type(chunk) == "string" and chunk ~= "" then
        AddLog("code", chunk, "load()")
    end
    return oldLoad(chunk, chunkname, mode, env)
end
load = newLoad

-- 2. Перехват loadfile
local oldLoadfile = loadfile
local function newLoadfile(file, mode, env)
    local success, result = pcall(oldLoadfile, file, mode, env)
    if success and type(result) == "function" then
        AddLog("code", "-- loadfile: " .. tostring(file) .. "\n-- [Function loaded]", "loadfile")
    end
    return success and result or error(result)
end
loadfile = newLoadfile

-- 3. ПЕРЕХВАТ ВСЕХ НОВЫХ СКРИПТОВ (Любой код, который выполняется в игре)
-- Отслеживаем добавление новых Script, LocalScript, ModuleScript
local originalNewIndex = nil
local function hookScripts()
    -- Перехватываем создание новых скриптов через Instance.new
    local oldInstanceNew = Instance.new
    Instance.new = function(className, parent)
        local instance = oldInstanceNew(className, parent)
        if className:lower():match("script") and instance:IsA("BaseScript") then
            -- Ждем пока у скрипта появится Source
            spawn(function()
                local waitCount = 0
                while waitCount < 50 and instance and instance.Parent do
                    local success, source = pcall(function()
                        return instance.Source
                    end)
                    if success and source and source ~= "" then
                        AddLog("code", source, "New " .. className .. ": " .. (instance.Name or "unnamed"))
                        break
                    end
                    wait(0.1)
                    waitCount = waitCount + 1
                end
            end)
        end
        return instance
    end
    
    -- Перехватываем установку Source в существующих скриптах
    local scriptMetatable = {}
    local originalSourceSetter = nil
    
    for _, scriptType in pairs({"Script", "LocalScript", "ModuleScript"}) do
        local class = game:GetService(scriptType) or Instance.new(scriptType)
        if class then
            local metatable = debug.getmetatable(class)
            if metatable and metatable.__index then
                local original = metatable.__index
                metatable.__index = function(t, k)
                    if k == "Source" then
                        -- Возвращаем реальный Source
                        return original(t, k)
                    end
                    return original(t, k)
                end
                
                -- Перехватываем изменение Source
                if not originalSourceSetter then
                    local oldNewIndex = metatable.__newindex
                    metatable.__newindex = function(t, k, v)
                        if k == "Source" and type(v) == "string" and v ~= "" then
                            AddLog("code", v, "Script Source Changed: " .. tostring(t.Name))
                        end
                        if oldNewIndex then
                            return oldNewIndex(t, k, v)
                        else
                            return rawset(t, k, v)
                        end
                    end
                    originalSourceSetter = oldNewIndex
                end
            end
        end
    end
end

-- 4. Перехват выполнения через pcall/eval (если executor использует)
local oldPcall = pcall
local function newPcall(func, ...)
    if type(func) == "function" then
        -- Пытаемся получить строковое представление функции (если возможно)
        local funcInfo = debug.getinfo(func, "S")
        if funcInfo and funcInfo.source and funcInfo.source:sub(1,1) == "=" then
            -- Это код из строки
            AddLog("code", "-- Anonymous function from: " .. funcInfo.source, "pcall()")
        end
    end
    return oldPcall(func, ...)
end
pcall = newPcall

-- 5. Перехват spawn/task.spawn с функциями
local oldSpawn = spawn
local function newSpawn(func, ...)
    if type(func) == "function" then
        local funcInfo = debug.getinfo(func, "S")
        if funcInfo and funcInfo.source and funcInfo.source:sub(1,1) == "=" then
            AddLog("code", "-- Spawned function from: " .. funcInfo.source, "spawn()")
        end
    end
    return oldSpawn(func, ...)
end
spawn = newSpawn

-- 6. Перехват delay/task.delay
local oldDelay = delay
local function newDelay(delayTime, func, ...)
    if type(func) == "function" then
        local funcInfo = debug.getinfo(func, "S")
        if funcInfo and funcInfo.source and funcInfo.source:sub(1,1) == "=" then
            AddLog("code", "-- Delayed function from: " .. funcInfo.source, "delay()")
        end
    end
    return oldDelay(delayTime, func, ...)
end
delay = newDelay

-- 7. Перехват queue_on_teleport (если есть)
if queue_on_teleport then
    local oldQueue = queue_on_teleport
    queue_on_teleport = function(code)
        if type(code) == "string" then
            AddLog("code", code, "queue_on_teleport")
        elseif type(code) == "function" then
            AddLog("code", "-- Function passed to queue_on_teleport", "queue_on_teleport")
        end
        return oldQueue(code)
    end
end

-- 8. Перехват syn.queue_on_teleport
if syn and syn.queue_on_teleport then
    local oldSynQueue = syn.queue_on_teleport
    syn.queue_on_teleport = function(code)
        if type(code) == "string" then
            AddLog("code", code, "syn.queue_on_teleport")
        end
        return oldSynQueue(code)
    end
end

-- Запускаем перехват скриптов
hookScripts()

-- Создаем звезды
createStars()

-- Обработка вкладок
httpsTabBtn.MouseButton1Click:Connect(function()
    httpsContainer.Visible = true
    codeContainer.Visible = false
    httpsTabBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
    codeTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    updateLogUI(httpsContainer, "https")
end)

codeTabBtn.MouseButton1Click:Connect(function()
    httpsContainer.Visible = false
    codeContainer.Visible = true
    codeTabBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
    httpsTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    updateLogUI(codeContainer, "code")
end)

updateLogUI(httpsContainer, "https")
updateLogUI(codeContainer, "code")
httpsTabBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 75)

-- Drag functionality
local dragging = false
local dragStart = nil
local startPos = nil

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mouse.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

mouse.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

print("✅ Master Spy FULLY LOADED")
print("📡 HttpsSpy: перехватывает loadstring с http ссылками")
print("💻 Code Spy: перехватывает ЛЮБОЙ выполняемый Lua код (скрипты, load, loadfile, новые скрипты и т.д.)")
