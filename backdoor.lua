-- V8 GHOST (Optimized for No-Lag)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ProgressText = Instance.new("TextLabel")
local ScanBtn = Instance.new("TextButton")
local LogsBtn = Instance.new("TextButton")
local LogsFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Name = "GhostScanner_V8"
ScreenGui.Parent = game:GetService("CoreGui")

MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.02, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 140)
MainFrame.Active = true
MainFrame.Draggable = true

ProgressText.Parent = MainFrame
ProgressText.Size = UDim2.new(1, 0, 0, 25)
ProgressText.Text = "ENGINE: READY"
ProgressText.TextColor3 = Color3.new(0.5, 1, 0.5)
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

ScanBtn = createBtn("SMOOTH SCAN", UDim2.new(0, 5, 0, 30), Color3.fromRGB(0, 120, 255))
LogsBtn = createBtn("LOGS (0)", UDim2.new(0, 5, 0, 80), Color3.fromRGB(45, 45, 45))

LogsFrame.Parent = ScreenGui
LogsFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
LogsFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
LogsFrame.Size = UDim2.new(0, 600, 0, 400)
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
    l.Size = UDim2.new(1, -10, 0, 35)
    l.BackgroundColor3 = col
    l.BackgroundTransparency = 0.4
    l.Text = " " .. txt
    l.TextColor3 = Color3.new(1, 1, 1)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Font = Enum.Font.Code
    l.TextSize = 12
    l.TextWrapped = true
    LogsBtn.Text = "LOGS (" .. logsCount .. ")"
end

local function getSource(obj)
    local s = ""
    pcall(function()
        s = obj.Source or ""
        if (s == "" or s == nil) then
            if decompile then s = decompile(obj)
            elseif getscriptsource then s = getscriptsource(obj) end
        end
    end)
    return s or ""
end

ScanBtn.MouseButton1Click:Connect(function()
    logsCount = 0
    LogsBtn.Text = "LOGS (0)"
    for _, v in pairs(LogsFrame:GetChildren()) do if v:IsA("TextLabel") then v:Destroy() end end
    
    -- Собираем только скрипты, чтобы не перебирать тысячи партсов и мешей
    local targets = {}
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("LuaSourceContainer") then table.insert(targets, v) end
    end
    
    local total = #targets
    addLog("--- SCANNING " .. total .. " SCRIPTS ---", Color3.fromRGB(80, 80, 80))

    for i, obj in ipairs(targets) do
        if logsCount >= MAX_LOGS then break end
        
        -- Плавность: каждые 10 скриптов даем игре отдохнуть
        if i % 10 == 0 then
            ProgressText.Text = "OBJ: " .. i .. " / " .. total
            task.wait()
        end

        local src = getSource(obj)
        if src ~= "" then
            -- Ищем require с цифрами (Этап 1)
            local reqId = src:match("require%s*%(%s*(%d+)%s*%)")
            if reqId then
                addLog("CRIT ["..obj.Name.."]: require("..reqId..")", Color3.fromRGB(150, 0, 0))
            else
                -- Ищем любой другой require (Этап 2)
                local anyReq = src:match("require%s*%b()")
                if anyReq then
                    addLog("SUS ["..obj.Name.."]: "..anyReq, Color3.fromRGB(120, 120, 0))
                end
            end
        end
    end

    ProgressText.Text = "SCAN COMPLETE"
    addLog("--- DONE ---", Color3.fromRGB(80, 80, 80))
end)

LogsBtn.MouseButton1Click:Connect(function() LogsFrame.Visible = not LogsFrame.Visible end)
