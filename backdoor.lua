local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ScanBtn = Instance.new("TextButton")
local LogsBtn = Instance.new("TextButton")
local LogsFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- Настройка GUI
ScreenGui.Name = "BackdoorScanner_V1"
ScreenGui.Parent = game:GetService("CoreGui")

MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 150, 0, 100)
MainFrame.Active = true
MainFrame.Draggable = true -- Можно двигать мышкой

ScanBtn.Name = "ScanBtn"
ScanBtn.Parent = MainFrame
ScanBtn.Text = "START SCAN"
ScanBtn.Size = UDim2.new(1, -10, 0, 40)
ScanBtn.Position = UDim2.new(0, 5, 0, 5)
ScanBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)

LogsBtn.Name = "LogsBtn"
LogsBtn.Parent = MainFrame
LogsBtn.Text = "LOGS (0)"
LogsBtn.Size = UDim2.new(1, -10, 0, 40)
LogsBtn.Position = UDim2.new(0, 5, 0, 50)
LogsBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 150)

-- Окно Логов
LogsFrame.Name = "LogsFrame"
LogsFrame.Parent = ScreenGui
LogsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
LogsFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
LogsFrame.Size = UDim2.new(0, 300, 0, 400)
LogsFrame.Visible = false
LogsFrame.ScrollBarThickness = 5

UIListLayout.Parent = LogsFrame
UIListLayout.Padding = UDim.new(0, 5)

local foundItems = {}

-- Функция добавления лога
local function addLog(text, color)
    local logLabel = Instance.new("TextLabel")
    logLabel.Parent = LogsFrame
    logLabel.Size = UDim2.new(1, 0, 0, 30)
    logLabel.BackgroundTransparency = 0.5
    logLabel.BackgroundColor3 = color or Color3.fromRGB(40, 40, 40)
    logLabel.TextColor3 = Color3.new(1, 1, 1)
    logLabel.Text = text
    logLabel.TextScaled = true
    LogsBtn.Text = "LOGS (" .. #foundItems .. ")"
end

-- Логика сканирования
ScanBtn.MouseButton1Click:Connect(function()
    foundItems = {}
    for i,v in pairs(LogsFrame:GetChildren()) do if v:IsA("TextLabel") then v:Destroy() end end
    addLog("--- SCANNING ---", Color3.fromRGB(100, 100, 100))
    
    for _, obj in pairs(game:GetDescendants()) do
        pcall(function()
            if obj:IsA("ModuleScript") then
                local s = obj.Source:lower()
                if s:find("require%s*%(%s*%d+%s*%)") then
                    table.insert(foundItems, obj)
                    addLog("ID: " .. s:match("%d+") .. " in " .. obj.Name, Color3.fromRGB(200, 50, 50))
                elseif s:find("getfenv") or s:find("loadstring") then
                    table.insert(foundItems, obj)
                    addLog("Hidden Code: " .. obj.Name, Color3.fromRGB(200, 150, 50))
                end
            elseif obj:IsA("RemoteEvent") and (#obj.Name <= 2 or obj.Name:lower():find("backdoor")) then
                addLog("SUS REMOTE: " .. obj.Name, Color3.fromRGB(50, 100, 200))
            end
        end)
    end
    addLog("--- FINISHED ---", Color3.fromRGB(100, 100, 100))
end)

-- Переключение окна логов
LogsBtn.MouseButton1Click:Connect(function()
    LogsFrame.Visible = not LogsFrame.Visible
end)
