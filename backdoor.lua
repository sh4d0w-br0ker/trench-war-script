-- V5 ULTRA BRUTE FORCE SCANNER
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ProgressText = Instance.new("TextLabel")
local ScanBtn = Instance.new("TextButton")
local LogsBtn = Instance.new("TextButton")
local LogsFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Name = "UltraBrute_V5"
ScreenGui.Parent = game:GetService("CoreGui")

MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.02, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 140)
MainFrame.Active = true
MainFrame.Draggable = true

ProgressText.Parent = MainFrame
ProgressText.Size = UDim2.new(1, 0, 0, 25)
ProgressText.Text = "READY TO RIP"
ProgressText.TextColor3 = Color3.new(1, 1, 1)
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

ScanBtn = createBtn("TOTAL SCAN", UDim2.new(0, 5, 0, 30), Color3.fromRGB(200, 0, 0))
LogsBtn = createBtn("LOGS (0)", UDim2.new(0, 5, 0, 80), Color3.fromRGB(40, 40, 40))

LogsFrame.Parent = ScreenGui
LogsFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
LogsFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
LogsFrame.Size = UDim2.new(0, 650, 0, 500)
LogsFrame.Visible = false
LogsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
UIListLayout.Parent = LogsFrame

local count = 0
local function addLog(txt, col)
    count = count + 1
    local l = Instance.new("TextLabel")
    l.Parent = LogsFrame
    l.Size = UDim2.new(1, -10, 0, 40)
    l.BackgroundColor3 = col
    l.BackgroundTransparency = 0.2
    l.Text = " ["..count.."] "..txt
    l.TextColor3 = Color3.new(1, 1, 1)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Font = Enum.Font.Code
    l.TextSize = 12
    l.TextWrapped = true
    LogsBtn.Text = "LOGS (" .. count .. ")"
end

ScanBtn.MouseButton1Click:Connect(function()
    count = 0
    LogsBtn.Text = "LOGS (0)"
    for _, v in pairs(LogsFrame:GetChildren()) do if v:IsA("TextLabel") then v:Destroy() end end
    
    local all = game:GetDescendants()
    for i, obj in ipairs(all) do
        if i % 200 == 0 then 
            ProgressText.Text = "SCANNING: "..i.."/"..#all 
            task.wait() 
        end
        
        pcall(function()
            if obj:IsA("ModuleScript") then
                -- Разбиваем код на строки
                local lines = string.split(obj.Source, "\n")
                for num, line in pairs(lines) do
                    -- Ищем слово 'require' в любом регистре
                    if line:lower():find("require") then
                        -- Очищаем строку от лишних пробелов по бокам
                        local cleanLine = line:match("^%s*(.-)%s*$")
                        addLog(obj.Name.." (Line "..num.."): "..cleanLine, Color3.fromRGB(150, 0, 0))
                    end
                end
                
                -- Заодно чекаем грязную обфускацию
                if obj.Source:lower():find("getfenv") or obj.Source:lower():find("loadstring") then
                    addLog("DANGER ["..obj.Name.."]: Contains getfenv/loadstring", Color3.fromRGB(100, 0, 150))
                end
            end
        end)
    end
    ProgressText.Text = "FINISHED! FOUND: "..count
end)

LogsBtn.MouseButton1Click:Connect(function() LogsFrame.Visible = not LogsFrame.Visible end)
