--[[ 
  V4 BUTCHER EDITION
  Ищет даже самые кривые require
]]

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ProgressText = Instance.new("TextLabel")
local ScanBtn = Instance.new("TextButton")
local LogsBtn = Instance.new("TextButton")
local LogsFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Name = "ButcherScanner_V4"
ScreenGui.Parent = game:GetService("CoreGui")

MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.02, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 140)
MainFrame.Active = true
MainFrame.Draggable = true

ProgressText.Parent = MainFrame
ProgressText.Size = UDim2.new(1, 0, 0, 20)
ProgressText.Text = "READY TO KILL"
ProgressText.TextColor3 = Color3.new(1, 0, 0)
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

ScanBtn = createBtn("ПОЛНЫЙ СКАН", UDim2.new(0, 5, 0, 25), Color3.fromRGB(150, 0, 0))
LogsBtn = createBtn("ЛОГИ (0)", UDim2.new(0, 5, 0, 75), Color3.fromRGB(50, 50, 50))

LogsFrame.Parent = ScreenGui
LogsFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
LogsFrame.Position = UDim2.new(0.2, 0, 0.3, 0)
LogsFrame.Size = UDim2.new(0, 550, 0, 450)
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
    l.BackgroundTransparency = 0.4
    l.Text = " " .. txt
    l.TextColor3 = Color3.new(1, 1, 1)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Font = Enum.Font.Code
    l.TextScaled = true
    LogsBtn.Text = "ЛОГИ (" .. count .. ")"
end

ScanBtn.MouseButton1Click:Connect(function()
    count = 0
    for _, v in pairs(LogsFrame:GetChildren()) do if v:IsA("TextLabel") then v:Destroy() end end
    
    local obs = game:GetDescendants()
    for i, v in ipairs(obs) do
        if i % 100 == 0 then 
            ProgressText.Text = "SCANNING: "..math.floor((i/#obs)*100).."%" 
            task.wait() 
        end
        
        pcall(function()
            if v:IsA("ModuleScript") then
                local s = v.Source
                -- Ищем ВООБЩЕ любой require, игнорируя пробелы и регистр
                local found = s:lower():match("require%s*%b()") or s:lower():match("require%s*%(.-%)")
                
                if found then
                    -- Если внутри есть цифры - КРАСНЫЙ
                    if found:match("%d+") then
                        addLog("КРИТ ["..v.Name.."]: "..found, Color3.fromRGB(255, 0, 0))
                    else
                        -- Если там переменные или дичь - ЖЕЛТЫЙ
                        addLog("ПОДОЗРЕНИЕ ["..v.Name.."]: "..found, Color3.fromRGB(200, 200, 0))
                    end
                end
                
                -- Доп. проверка на loadstring и getfenv
                if s:lower():find("loadstring") or s:lower():find("getfenv") then
                    addLog("HIDDEN CODE в "..v.Name, Color3.fromRGB(100, 0, 150))
                end
            end
        end)
    end
    ProgressText.Text = "DONE! FOUND: "..count
end)

LogsBtn.MouseButton1Click:Connect(function() LogsFrame.Visible = not LogsFrame.Visible end)
