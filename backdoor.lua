-- V6 NUCLEAR SCANNER (Использует функции эксплойта для чтения кода)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ProgressText = Instance.new("TextLabel")
local ScanBtn = Instance.new("TextButton")
local LogsBtn = Instance.new("TextButton")
local LogsFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Name = "NuclearScanner_V6"
ScreenGui.Parent = game:GetService("CoreGui")

MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Position = UDim2.new(0.02, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 140)
MainFrame.Active = true
MainFrame.Draggable = true

ProgressText.Parent = MainFrame
ProgressText.Size = UDim2.new(1, 0, 0, 25)
ProgressText.Text = "READY TO EXTRACT"
ProgressText.TextColor3 = Color3.new(0, 1, 0)
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
    btn.TextSize = 18
    return btn
end

ScanBtn = createBtn("FORCE SCAN", UDim2.new(0, 5, 0, 30), Color3.fromRGB(255, 100, 0))
LogsBtn = createBtn("LOGS (0)", UDim2.new(0, 5, 0, 80), Color3.fromRGB(40, 40, 40))

LogsFrame.Parent = ScreenGui
LogsFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
LogsFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
LogsFrame.Size = UDim2.new(0, 700, 0, 500)
LogsFrame.Visible = false
LogsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
UIListLayout.Parent = LogsFrame

local count = 0
local function addLog(txt, col)
    count = count + 1
    local l = Instance.new("TextLabel")
    l.Parent = LogsFrame
    l.Size = UDim2.new(1, -10, 0, 45)
    l.BackgroundColor3 = col
    l.BackgroundTransparency = 0.1
    l.Text = " ["..count.."] "..txt
    l.TextColor3 = Color3.new(1, 1, 1)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Font = Enum.Font.Code
    l.TextSize = 11
    l.TextWrapped = true
    LogsBtn.Text = "LOGS (" .. count .. ")"
end

-- Функция для принудительного получения кода
local function getSource(obj)
    local s = ""
    local success, err = pcall(function()
        -- Пробуем все способы, которые есть в разных эксплойтах
        s = obj.Source or ""
        if s == "" and decompile then s = decompile(obj) end
        if s == "" and getscriptsource then s = getscriptsource(obj) end
    end)
    return s or ""
end

ScanBtn.MouseButton1Click:Connect(function()
    count = 0
    LogsBtn.Text = "LOGS (0)"
    for _, v in pairs(LogsFrame:GetChildren()) do if v:IsA("TextLabel") then v:Destroy() end end
    
    local all = game:GetDescendants()
    for i, obj in ipairs(all) do
        if i % 100 == 0 then 
            ProgressText.Text = "EXTRACTING: "..i.."/"..#all 
            task.wait() 
        end
        
        if obj:IsA("LuaSourceContainer") then -- Чекаем и скрипты, и модули
            local source = getSource(obj)
            if source ~= "" then
                local lines = string.split(source, "\n")
                for num, line in pairs(lines) do
                    if line:lower():find("require") then
                        addLog(obj.Name.." L"..num..": "..line:match("^%s*(.-)%s*$"), Color3.fromRGB(180, 0, 0))
                    end
                end
            end
        end
    end
    ProgressText.Text = "DONE! FOUND: "..count
end)

LogsBtn.MouseButton1Click:Connect(function() LogsFrame.Visible = not LogsFrame.Visible end)
