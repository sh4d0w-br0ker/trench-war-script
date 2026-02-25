local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ScanBtn = Instance.new("TextButton")
local LogsBtn = Instance.new("TextButton")
local LogsFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Name = "Advanced_Scanner_V2"
ScreenGui.Parent = game:GetService("CoreGui")

-- Главная панелька
MainFrame.Name = "ControlPanel"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.02, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 160, 0, 110)
MainFrame.Active = true
MainFrame.Draggable = true

local function createBtn(name, text, pos, color)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = MainFrame
    btn.Text = text
    btn.Size = UDim2.new(1, -10, 0, 45)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    return btn
end

ScanBtn = createBtn("ScanBtn", "ЗАПУСТИТЬ ПОИСК", UDim2.new(0, 5, 0, 5), Color3.fromRGB(46, 204, 113))
LogsBtn = createBtn("LogsBtn", "ЛОГИ (0)", UDim2.new(0, 5, 0, 55), Color3.fromRGB(52, 152, 219))

-- Окно Логов
LogsFrame.Name = "LogsFrame"
LogsFrame.Parent = ScreenGui
LogsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LogsFrame.Position = UDim2.new(0.15, 0, 0.3, 0)
LogsFrame.Size = UDim2.new(0, 450, 0, 350)
LogsFrame.Visible = false
LogsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
LogsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

UIListLayout.Parent = LogsFrame
UIListLayout.Padding = UDim.new(0, 2)

local logsCount = 0

local function addLog(text, color)
    logsCount = logsCount + 1
    local logLabel = Instance.new("TextButton") -- Сделал кнопкой, чтоб потом можно было кликать
    logLabel.Parent = LogsFrame
    logLabel.Size = UDim2.new(1, -10, 0, 35)
    logLabel.BackgroundColor3 = color
    logLabel.Text = " [" .. os.date("%X") .. "] " .. text
    logLabel.TextColor3 = Color3.new(1, 1, 1)
    logLabel.TextXAlignment = Enum.TextXAlignment.Left
    logLabel.TextWrapped = true
    logLabel.Font = Enum.Font.Code
    logLabel.TextSize = 14
    LogsBtn.Text = "ЛОГИ (" .. logsCount .. ")"
end

ScanBtn.MouseButton1Click:Connect(function()
    logsCount = 0
    for _, v in pairs(LogsFrame:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    addLog("--- СКАНИРОВАНИЕ ЗАПУЩЕНО ---", Color3.fromRGB(80, 80, 80))

    for _, obj in pairs(game:GetDescendants()) do
        pcall(function()
            if obj:IsA("ModuleScript") then
                local src = obj.Source
                
                -- Ищем четкий require с цифрами (КРАСНЫЙ)
                local reqMatch = src:match("require%s*%(%s*%d+%s*%)")
                if reqMatch then
                    addLog("КРИТ: " .. reqMatch .. " в " .. obj.Name, Color3.fromRGB(150, 0, 0))
                
                -- Ищем подозрительный require с переменными (ЖЕЛТЫЙ)
                elseif src:match("require%s*%(%s*[^%d]") then
                    local piece = src:match("require%s*%b()") or "require(...)"
                    addLog("ПОДОЗРИТЕЛЬНО: " .. piece, Color3.fromRGB(150, 150, 0))
                
                -- Ищем обфускацию (ЖЕЛТЫЙ)
                elseif src:match("getfenv") or src:match("loadstring") or src:match("\\%d%d%d") then
                    addLog("ОБФУСКАЦИЯ: " .. obj.Name, Color3.fromRGB(100, 100, 0))
                end
            end
        end)
    end
    addLog("--- СКАНИРОВАНИЕ ЗАВЕРШЕНО ---", Color3.fromRGB(80, 80, 80))
end)

LogsBtn.MouseButton1Click:Connect(function()
    LogsFrame.Visible = not LogsFrame.Visible
end)
