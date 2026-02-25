-- V7 CENTURION (Limit 100 + Multi-Stage Scan)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ProgressText = Instance.new("TextLabel")
local ScanBtn = Instance.new("TextButton")
local LogsBtn = Instance.new("TextButton")
local LogsFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Name = "Centurion_V7"
ScreenGui.Parent = game:GetService("CoreGui")

MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.02, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 140)
MainFrame.Active = true
MainFrame.Draggable = true

ProgressText.Parent = MainFrame
ProgressText.Size = UDim2.new(1, 0, 0, 25)
ProgressText.Text = "LIMIT: 100 | READY"
ProgressText.TextColor3 = Color3.new(1, 1, 0)
ProgressText.Font = Enum.Font.Code

local function createBtn(text, pos, color)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.Text = text
    btn.Size = UDim2.new(1, -10, 0, 45)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    return btn
end

ScanBtn = createBtn("УЛЬТРА СКАН (MAX 100)", UDim2.new(0, 5, 0, 30), Color3.fromRGB(180, 0, 0))
LogsBtn = createBtn("ЛОГИ (0)", UDim2.new(0, 5, 0, 80), Color3.fromRGB(40, 40, 40))

LogsFrame.Parent = ScreenGui
LogsFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
LogsFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
LogsFrame.Size = UDim2.new(0, 750, 0, 500)
LogsFrame.Visible = false
LogsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
UIListLayout.Parent = LogsFrame

local logsCount = 0
local MAX_LOGS = 100

local function addLog(txt, col)
    if logsCount >= MAX_LOGS then return end
    logsCount = logsCount + 1
    local l = Instance.new("TextLabel")
    l.Parent = LogsFrame
    l.Size = UDim2.new(1, -10, 0, 40)
    l.BackgroundColor3 = col
    l.BackgroundTransparency = 0.2
    l.Text = " ["..logsCount.."] "..txt
    l.TextColor3 = Color3.new(1, 1, 1)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Font = Enum.Font.Code
    l.TextSize = 11
    l.TextWrapped = true
    LogsBtn.Text = "ЛОГИ (" .. logsCount .. ")"
end

local function getSource(obj)
    local s = ""
    pcall(function()
        s = obj.Source or ""
        if (s == "" or s == nil) and decompile then s = decompile(obj) end
        if (s == "" or s == nil) and getscriptsource then s = getscriptsource(obj) end
    end)
    return s or ""
end

ScanBtn.MouseButton1Click:Connect(function()
    logsCount = 0
    LogsBtn.Text = "ЛОГИ (0)"
    for _, v in pairs(LogsFrame:GetChildren()) do if v:IsA("TextLabel") then v:Destroy() end end
    
    local all = game:GetDescendants()
    addLog("--- ЭТАП 1: ПОИСК REQUIRE С ID ---", Color3.fromRGB(100, 100, 0))

    -- Первый проход: ищем только жесткие require(цифры)
    for i, obj in ipairs(all) do
        if logsCount >= MAX_LOGS then break end
        if i % 150 == 0 then ProgressText.Text = "STEP 1: "..i.."/"..#all task.wait() end
        
        if obj:IsA("LuaSourceContainer") then
            local src = getSource(obj)
            if src:lower():find("require%s*%(%s*%d+") then
                local lines = string.split(src, "\n")
                for n, line in pairs(lines) do
                    if line:lower():find("require%s*%(%s*%d+") then
                        addLog("!!! КРИТ ["..obj.Name.."] L"..n..": "..line:match("^%s*(.-)%s*$"), Color3.fromRGB(200, 0, 0))
                    end
                end
            end
        end
    end

    -- Второй проход: ищем всё остальное с require, если лимит не забит
    if logsCount < MAX_LOGS then
        addLog("--- ЭТАП 2: СБОР ОСТАЛЬНЫХ REQUIRE ---", Color3.fromRGB(0, 100, 100))
        for i, obj in ipairs(all) do
            if logsCount >= MAX_LOGS then break end
            if i % 150 == 0 then ProgressText.Text = "STEP 2: "..i.."/"..#all task.wait() end
            
            if obj:IsA("LuaSourceContainer") then
                local src = getSource(obj)
                if src:lower():find("require") then
                    local lines = string.split(src, "\n")
                    for n, line in pairs(lines) do
                        if logsCount >= MAX_LOGS then break end
                        -- Пропускаем, если уже нашли это в первом этапе (с цифрами)
                        if line:lower():find("require") and not line:lower():find("require%s*%(%s*%d+") then
                            addLog("INFO ["..obj.Name.."] L"..n..": "..line:match("^%s*(.-)%s*$"), Color3.fromRGB(50, 50, 50))
                        end
                    end
                end
            end
        end
    end

    ProgressText.Text = "FINISH! FOUND: "..logsCount
end)

LogsBtn.MouseButton1Click:Connect(function() LogsFrame.Visible = not LogsFrame.Visible end)
