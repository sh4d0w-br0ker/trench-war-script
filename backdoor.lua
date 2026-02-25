local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ProgressFrame = Instance.new("Frame")
local ProgressBar = Instance.new("Frame")
local ProgressText = Instance.new("TextLabel")
local ScanBtn = Instance.new("TextButton")
local LogsBtn = Instance.new("TextButton")
local LogsFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Name = "Scanner_Pro_V3"
ScreenGui.Parent = game:GetService("CoreGui")

-- Главное меню
MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.02, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 160)
MainFrame.Active = true
MainFrame.Draggable = true

-- Полоска прогресса
ProgressFrame.Name = "ProgressFrame"
ProgressFrame.Parent = MainFrame
ProgressFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ProgressFrame.Position = UDim2.new(0, 5, 0, 5)
ProgressFrame.Size = UDim2.new(1, -10, 0, 20)

ProgressBar.Name = "Bar"
ProgressBar.Parent = ProgressFrame
ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BorderSizePixel = 0

ProgressText.Parent = ProgressFrame
ProgressText.Size = UDim2.new(1, 0, 1, 0)
ProgressText.BackgroundTransparency = 1
ProgressText.Text = "WAITING..."
ProgressText.TextColor3 = Color3.new(1, 1, 1)
ProgressText.TextSize = 12

local function createBtn(name, text, pos, color)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = MainFrame
    btn.Text = text
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    return btn
end

ScanBtn = createBtn("ScanBtn", "START SCAN", UDim2.new(0, 5, 0, 35), Color3.fromRGB(46, 204, 113))
LogsBtn = createBtn("LogsBtn", "LOGS (0)", UDim2.new(0, 5, 0, 85), Color3.fromRGB(52, 152, 219))

-- Окно Логов
LogsFrame.Name = "LogsFrame"
LogsFrame.Parent = ScreenGui
LogsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LogsFrame.Position = UDim2.new(0.2, 0, 0.3, 0)
LogsFrame.Size = UDim2.new(0, 500, 0, 400)
LogsFrame.Visible = false
LogsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
LogsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

UIListLayout.Parent = LogsFrame
UIListLayout.Padding = UDim.new(0, 2)

local logsCount = 0

local function addLog(text, color)
    logsCount = logsCount + 1
    local logLabel = Instance.new("TextLabel")
    logLabel.Parent = LogsFrame
    logLabel.Size = UDim2.new(1, -10, 0, 30)
    logLabel.BackgroundColor3 = color
    logLabel.BackgroundTransparency = 0.3
    logLabel.Text = " " .. text
    logLabel.TextColor3 = Color3.new(1, 1, 1)
    logLabel.TextXAlignment = Enum.TextXAlignment.Left
    logLabel.Font = Enum.Font.Code
    logLabel.TextSize = 14
    LogsBtn.Text = "LOGS (" .. logsCount .. ")"
    LogsFrame.CanvasPosition = Vector2.new(0, LogsFrame.AbsoluteCanvasSize.Y)
end

ScanBtn.MouseButton1Click:Connect(function()
    logsCount = 0
    LogsBtn.Text = "LOGS (0)"
    for _, v in pairs(LogsFrame:GetChildren()) do if v:IsA("TextLabel") then v:Destroy() end end
    
    local allObjects = game:GetDescendants()
    local total = #allObjects
    addLog("--- SCANNING " .. total .. " OBJECTS ---", Color3.fromRGB(100, 100, 100))

    for i, obj in ipairs(allObjects) do
        -- Обновление прогресс-бара каждые 50 объектов (чтоб не лагало)
        if i % 50 == 0 or i == total then
            local percent = i / total
            ProgressBar.Size = UDim2.new(percent, 0, 1, 0)
            ProgressText.Text = i .. " / " .. total
            task.wait() -- Даем игре "подышать"
        end

        pcall(function()
            -- Ищем в ModuleScripts
            if obj:IsA("ModuleScript") then
                local src = obj.Source
                local reqMatch = src:match("require%s*%(%s*%d+%s*%)")
                
                if reqMatch then
                    addLog("CRITICAL: " .. reqMatch .. " in " .. obj.Name, Color3.fromRGB(200, 0, 0))
                elseif src:match("require%s*%b()") then
                    addLog("SUS: require(...) in " .. obj.Name, Color3.fromRGB(200, 150, 0))
                elseif src:match("getfenv") or src:match("loadstring") then
                    addLog("HIDDEN: " .. obj.Name, Color3.fromRGB(150, 150, 0))
                end
            -- Ищем подозрительные объекты (Remotes)
            elseif obj:IsA("RemoteEvent") and (#obj.Name <= 2 or obj.Name:lower():find("backdoor")) then
                addLog("REMOTE: " .. obj.Name, Color3.fromRGB(0, 100, 200))
            end
        end)
    end
    addLog("--- SCAN FINISHED ---", Color3.fromRGB(100, 100, 100))
    ProgressText.Text = "DONE!"
end)

LogsBtn.MouseButton1Click:Connect(function()
    LogsFrame.Visible = not LogsFrame.Visible
end)
