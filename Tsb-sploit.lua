-- Spynote Tsb-sploit (Multi-Ult-Logger, Sunset-All, Twin Fangs in Skill-Bring & Invisible Give)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("SpynoteTsb") then
    CoreGui.SpynoteTsb:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local LeftPanel = Instance.new("Frame")
local RightPanel = Instance.new("Frame")
local LeftButtonContainer = Instance.new("Frame")
local LeftButtonList = Instance.new("UIListLayout")
local RightContent = Instance.new("Frame")

ScreenGui.Name = "SpynoteTsb"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -180)
MainFrame.Size = UDim2.new(0, 400, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TitleLabel.BorderSizePixel = 0
TitleLabel.Size = UDim2.new(0, 340, 0, 30)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = " Spynote Tsb-sploit"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.TextSize = 15
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = MainFrame
MinimizeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(0, 340, 0, 0)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Text = "<"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16

CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(0, 370, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16

LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
LeftPanel.BorderSizePixel = 0
LeftPanel.Size = UDim2.new(0, 80, 1, -30)
LeftPanel.Position = UDim2.new(0, 0, 0, 30)

RightPanel.Name = "RightPanel"
RightPanel.Parent = MainFrame
RightPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
RightPanel.BorderSizePixel = 0
RightPanel.Size = UDim2.new(1, -85, 1, -35)
RightPanel.Position = UDim2.new(0, 85, 0, 35)

LeftButtonContainer.Name = "LeftButtonContainer"
LeftButtonContainer.Parent = LeftPanel
LeftButtonContainer.BackgroundTransparency = 1
LeftButtonContainer.Size = UDim2.new(1, -8, 1, -8)
LeftButtonContainer.Position = UDim2.new(0, 4, 0, 4)

LeftButtonList.Name = "LeftButtonList"
LeftButtonList.Parent = LeftButtonContainer
LeftButtonList.Padding = UDim.new(0, 4)
LeftButtonList.SortOrder = Enum.SortOrder.LayoutOrder

RightContent.Name = "RightContent"
RightContent.Parent = RightPanel
RightContent.BackgroundTransparency = 1
RightContent.Size = UDim2.new(1, 0, 1, 0)

local function createTab(tabName, displayName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 26)
    btn.Text = displayName or tabName
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 11
    btn.BorderSizePixel = 0
    btn.Parent = LeftButtonContainer
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, -6, 1, -6)
    content.Position = UDim2.new(0, 3, 0, 3)
    content.BackgroundTransparency = 1
    content.Visible = false
    content.ScrollBarThickness = 3
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.Parent = RightPanel
    Instance.new("UIListLayout", content).Padding = UDim.new(0, 4)

    btn.MouseButton1Click:Connect(function()
        for _, child in pairs(RightPanel:GetChildren()) do
            if child:IsA("ScrollingFrame") then
                child.Visible = false
            end
        end
        content.Visible = true
    end)

    return btn, content
end

local infoBtn, infoTab = createTab("Info", "Info")
local exploitBtn, exploitTab = createTab("Exploit", "Exploit")
local farmBtn, farmTab = createTab("Farm", "Farm")
local saitamaBtn, saitamaTab = createTab("Saitama", "Saitama")
local playerBtn, playerTab = createTab("Player", "Player")
local trollBtn, trollTab = createTab("Troll", "Troll")
local espBtn, espTab = createTab("Esp", "ESP")

infoTab.Visible = true

-- ==================== INFO ====================
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 1, 0)
infoLabel.Text = "Tab-Info: information\nTab-Exploit: Exploit scripts & Skill-Bring\nTab-farm: farm Ult and more\nTab-Saitama: Saitama combos\nTab-Player: Multi-Ult-Logger & Invisible Give\nTab-Troll: Trolled Functions & Sunset-All\nTab-Esp: Player ESP highlights"
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextSize = 14
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.BackgroundTransparency = 1
infoLabel.Parent = infoTab

-- ==================== EXPLOIT & SKILL-BRING ====================
local exploitLabel = Instance.new("TextLabel")
exploitLabel.Size = UDim2.new(1, 0, 0, 45)
exploitLabel.Text = "worked: Garou, Brutal beat, trinity, Hudoshnik, immortal"
exploitLabel.TextColor3 = Color3.new(1, 1, 1)
exploitLabel.TextSize = 13
exploitLabel.Font = Enum.Font.SourceSansBold
exploitLabel.TextYAlignment = Enum.TextYAlignment.Top
exploitLabel.TextWrapped = true
exploitLabel.BackgroundTransparency = 1
exploitLabel.Parent = exploitTab

local isSkillBring = false
local TARGET_CFRAME = CFrame.new(100.728096, -489.499664, 47.9694824, -0.0552487373, 0, -0.998472571, 0, 1, 0, 0.998472571, 0, -0.0552487373)
local WAIT_BEFORE = 1
local WAIT_THERE = 4
local PLAT_SIZE = 150

local skillBringBtn = Instance.new("TextButton")
skillBringBtn.Size = UDim2.new(1, 0, 0, 32)
skillBringBtn.Text = "Skill-Bring OFF"
skillBringBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
skillBringBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
skillBringBtn.Font = Enum.Font.SourceSansBold
skillBringBtn.TextSize = 13
skillBringBtn.BorderSizePixel = 0
skillBringBtn.Parent = exploitTab
Instance.new("UICorner", skillBringBtn).CornerRadius = UDim.new(0, 4)

skillBringBtn.MouseButton1Click:Connect(function()
    isSkillBring = not isSkillBring
    if isSkillBring then
        skillBringBtn.Text = "Skill-Bring ON"
        skillBringBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        skillBringBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    else
        skillBringBtn.Text = "Skill-Bring OFF"
        skillBringBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        skillBringBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
    end
end)

-- ==================== ESP TAB ====================
local isEspEnabled = false
local espHighlights = {}
local espBillboards = {}

local espToggleBtn = Instance.new("TextButton")
espToggleBtn.Size = UDim2.new(1, 0, 0, 32)
espToggleBtn.Text = "Esp Player OFF"
espToggleBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
espToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espToggleBtn.Font = Enum.Font.SourceSansBold
espToggleBtn.TextSize = 13
espToggleBtn.BorderSizePixel = 0
espToggleBtn.Parent = espTab
Instance.new("UICorner", espToggleBtn).CornerRadius = UDim.new(0, 4)

local function clearEsp()
    for _, item in pairs(espHighlights) do if item then item:Destroy() end end
    espHighlights = {}
    for _, bill in pairs(espBillboards) do if bill then bill:Destroy() end end
    espBillboards = {}
end

espToggleBtn.MouseButton1Click:Connect(function()
    isEspEnabled = not isEspEnabled
    if isEspEnabled then
        espToggleBtn.Text = "Esp Player ON"
        espToggleBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        espToggleBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    else
        espToggleBtn.Text = "Esp Player OFF"
        espToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        espToggleBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        clearEsp()
    end
end)

RunService.Heartbeat:Connect(function()
    if not isEspEnabled then return end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local char = plr.Character
            local root = char.HumanoidRootPart

            local highlight = char:FindFirstChild("SpynoteESP")
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.Name = "SpynoteESP"
                highlight.Adornee = char
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.FillTransparency = 0.5
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.OutlineTransparency = 0
                highlight.Parent = char
                table.insert(espHighlights, highlight)
            end

            local bill = root:FindFirstChild("SpynoteESPText")
            if not bill then
                bill = Instance.new("BillboardGui")
                bill.Name = "SpynoteESPText"
                bill.Size = UDim2.new(0, 100, 0, 30)
                bill.StudsOffset = Vector3.new(0, 3, 0)
                bill.AlwaysOnTop = true

                local txt = Instance.new("TextLabel")
                txt.Name = "Distance"
                txt.Size = UDim2.new(1, 0, 1, 0)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = Color3.fromRGB(255, 255, 255)
                txt.TextSize = 11
                txt.Font = Enum.Font.SourceSansBold
                txt.TextStrokeTransparency = 0
                txt.Parent = bill
                bill.Parent = root
                table.insert(espBillboards, bill)
            end

            local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if localRoot and bill:FindFirstChild("Distance") then
                local dist = math.floor((root.Position - localRoot.Position).Magnitude)
                bill.Distance.Text = "Studs: " .. dist
            end
        end
    end
end)

-- ==================== SAITAMA-ULT ESP (В ESP TAB) ====================
local isSaitamaEspEnabled = false
local saitamaEspHighlights = {}
local saitamaEspBillboards = {}

local function clearSaitamaEsp()
    for _, item in pairs(saitamaEspHighlights) do
        if item then item:Destroy() end
    end
    saitamaEspHighlights = {}
    for _, bill in pairs(saitamaEspBillboards) do
        if bill then bill:Destroy() end
    end
    saitamaEspBillboards = {}
end

local function isSaitamaPlayer(plr)
    if not plr then return false end
    local bp = plr:FindFirstChild("Backpack")
    local char = plr.Character
    local function checkContainer(container)
        if container then
            if container:FindFirstChild("Table Flip") or
               container:FindFirstChild("Serious Punch") or
               container:FindFirstChild("Omni Directional Punch") or
               container:FindFirstChild("Death Counter") then
                return true
            end
        end
        return false
    end
    return checkContainer(bp) or checkContainer(char)
end

local function updateSaitamaEsp()
    if not isSaitamaEspEnabled then
        clearSaitamaEsp()
        return
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and isSaitamaPlayer(plr) and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local char = plr.Character
            local root = char.HumanoidRootPart

            -- Подсветка
            local highlight = char:FindFirstChild("SaitamaESP")
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.Name = "SaitamaESP"
                highlight.Adornee = char
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
                highlight.FillTransparency = 0.5
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.OutlineTransparency = 0
                highlight.Parent = char
                table.insert(saitamaEspHighlights, highlight)
            end

            -- Billboard с расстоянием
            local bill = root:FindFirstChild("SaitamaESPText")
            if not bill then
                bill = Instance.new("BillboardGui")
                bill.Name = "SaitamaESPText"
                bill.Size = UDim2.new(0, 100, 0, 30)
                bill.StudsOffset = Vector3.new(0, 3, 0)
                bill.AlwaysOnTop = true

                local txt = Instance.new("TextLabel")
                txt.Name = "Distance"
                txt.Size = UDim2.new(1, 0, 1, 0)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = Color3.fromRGB(0, 255, 0)
                txt.TextSize = 11
                txt.Font = Enum.Font.SourceSansBold
                txt.TextStrokeTransparency = 0
                txt.Parent = bill
                bill.Parent = root
                table.insert(saitamaEspBillboards, bill)
            end

            local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if localRoot and bill:FindFirstChild("Distance") then
                local dist = math.floor((root.Position - localRoot.Position).Magnitude)
                bill.Distance.Text = "Saitama: " .. dist .. " studs"
            end
        else
            -- Удаляем ESP у игроков, у которых больше нет ульты
            if plr.Character then
                local highlight = plr.Character:FindFirstChild("SaitamaESP")
                if highlight then
                    highlight:Destroy()
                    for i, item in pairs(saitamaEspHighlights) do
                        if item == highlight then
                            table.remove(saitamaEspHighlights, i)
                            break
                        end
                    end
                end
                local root = plr.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local bill = root:FindFirstChild("SaitamaESPText")
                    if bill then
                        bill:Destroy()
                        for i, item in pairs(saitamaEspBillboards) do
                            if item == bill then
                                table.remove(saitamaEspBillboards, i)
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end

local saitamaEspBtn = Instance.new("TextButton")
saitamaEspBtn.Size = UDim2.new(1, 0, 0, 32)
saitamaEspBtn.Text = "Saitama-Ult Esp OFF"
saitamaEspBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
saitamaEspBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
saitamaEspBtn.Font = Enum.Font.SourceSansBold
saitamaEspBtn.TextSize = 13
saitamaEspBtn.BorderSizePixel = 0
saitamaEspBtn.Parent = espTab
Instance.new("UICorner", saitamaEspBtn).CornerRadius = UDim.new(0, 4)

saitamaEspBtn.MouseButton1Click:Connect(function()
    isSaitamaEspEnabled = not isSaitamaEspEnabled
    if isSaitamaEspEnabled then
        saitamaEspBtn.Text = "Saitama-Ult Esp ON"
        saitamaEspBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        saitamaEspBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        -- Запускаем обновление в цикле
        task.spawn(function()
            while isSaitamaEspEnabled do
                updateSaitamaEsp()
                task.wait(0.5)
            end
        end)
    else
        saitamaEspBtn.Text = "Saitama-Ult Esp OFF"
        saitamaEspBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        saitamaEspBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        clearSaitamaEsp()
    end
end)

-- ==================== PLAYER TAB ====================
local isUltLogger = false
local ultLoggerConnection = nil
local notifiedPlayers = {}

local function showUltNotification(msg)
    local alert = Instance.new("TextLabel")
    alert.Size = UDim2.new(0, 340, 0, 35)
    alert.Position = UDim2.new(0.5, -170, 0, 10)
    alert.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
    alert.TextColor3 = Color3.fromRGB(255, 255, 255)
    alert.TextSize = 13
    alert.Font = Enum.Font.SourceSansBold
    alert.Text = msg
    alert.ZIndex = 10
    alert.Parent = ScreenGui
    Instance.new("UICorner", alert).CornerRadius = UDim.new(0, 6)

    task.delay(3, function() if alert then alert:Destroy() end end)
end

local function startUltLogger()
    if ultLoggerConnection then ultLoggerConnection:Disconnect() end
    notifiedPlayers = {}

    ultLoggerConnection = RunService.Heartbeat:Connect(function()
        if not isUltLogger then
            ultLoggerConnection:Disconnect()
            ultLoggerConnection = nil
            return
        end

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local bp = plr:FindFirstChild("Backpack")
                local char = plr.Character
                local detectedStyle = nil

                local function checkContainer(container)
                    if container then
                        if container:FindFirstChild("Table Flip") or container:FindFirstChild("Serious Punch") or container:FindFirstChild("Omni Directional Punch") or container:FindFirstChild("Death Counter") then
                            detectedStyle = "Saitama"
                        elseif container:FindFirstChild("The Final Hunt") or container:FindFirstChild("Crushed Rock") or container:FindFirstChild("Rock Splitting Fist") then
                            detectedStyle = "Garou"
                        elseif container:FindFirstChild("Speedblitz Dropkick") or container:FindFirstChild("Incinerate") or container:FindFirstChild("Flamewave Cannon") then
                            detectedStyle = "Kiborg"
                        elseif container:FindFirstChild("Straight On") or container:FindFirstChild("Fourfold Flashstrike") or container:FindFirstChild("Carnage") then
                            detectedStyle = "Ninja"
                        elseif container:FindFirstChild("Savage Tornado") or container:FindFirstChild("Death Blow") or container:FindFirstChild("Brutal Beatdown") then
                            detectedStyle = "Beat-brutal"
                        elseif container:FindFirstChild("Sunrise") or container:FindFirstChild("Solar Cleave") or container:FindFirstChild("Atomic Slash") then
                            detectedStyle = "Samurai-Atomic"
                        end
                    end
                end

                checkContainer(bp)
                checkContainer(char)

                if detectedStyle then
                    if not notifiedPlayers[plr] then
                        notifiedPlayers[plr] = true
                        showUltNotification("<" .. plr.Name .. "> " .. detectedStyle .. " Ultimate Detected")
                    end
                else
                    notifiedPlayers[plr] = nil
                end
            end
        end
    end)
end

local ultLoggerBtn = Instance.new("TextButton")
ultLoggerBtn.Size = UDim2.new(1, 0, 0, 32)
ultLoggerBtn.Text = "Ult-Logger OFF"
ultLoggerBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
ultLoggerBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ultLoggerBtn.Font = Enum.Font.SourceSansBold
ultLoggerBtn.TextSize = 13
ultLoggerBtn.BorderSizePixel = 0
ultLoggerBtn.Parent = playerTab
Instance.new("UICorner", ultLoggerBtn).CornerRadius = UDim.new(0, 4)

ultLoggerBtn.MouseButton1Click:Connect(function()
    isUltLogger = not isUltLogger
    if isUltLogger then
        ultLoggerBtn.Text = "Ult-Logger ON"
        ultLoggerBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        ultLoggerBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        startUltLogger()
    else
        ultLoggerBtn.Text = "Ult-Logger OFF"
        ultLoggerBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        ultLoggerBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if ultLoggerConnection then ultLoggerConnection:Disconnect() ultLoggerConnection = nil end
    end
end)

local invisibleGiveBtn = Instance.new("TextButton")
invisibleGiveBtn.Size = UDim2.new(1, 0, 0, 32)
invisibleGiveBtn.Text = "Invisible Give"
invisibleGiveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
invisibleGiveBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
invisibleGiveBtn.Font = Enum.Font.SourceSansBold
invisibleGiveBtn.TextSize = 13
invisibleGiveBtn.BorderSizePixel = 0
invisibleGiveBtn.Parent = playerTab
Instance.new("UICorner", invisibleGiveBtn).CornerRadius = UDim.new(0, 4)

invisibleGiveBtn.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invisible-open-source-114247"))()
    end)
end)

-- ==================== КНОПКА GIVE TRASH-GIVER В PLAYER TAB ====================
local giveTrashGiverBtn = Instance.new("TextButton")
giveTrashGiverBtn.Size = UDim2.new(1, 0, 0, 32)
giveTrashGiverBtn.Text = "Give Trash-Giver"
giveTrashGiverBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
giveTrashGiverBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
giveTrashGiverBtn.Font = Enum.Font.SourceSansBold
giveTrashGiverBtn.TextSize = 13
giveTrashGiverBtn.BorderSizePixel = 0
giveTrashGiverBtn.Parent = playerTab
Instance.new("UICorner", giveTrashGiverBtn).CornerRadius = UDim.new(0, 4)

giveTrashGiverBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sh4d0w-br0ker/trench-war-script/refs/heads/main/Tgg.lua", true))()
end)

-- ==================== INSTANT RESET (В PLAYER TAB) ====================
local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(1, 0, 0, 32)
resetBtn.Text = "Instant Reset"
resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resetBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
resetBtn.Font = Enum.Font.SourceSansBold
resetBtn.TextSize = 13
resetBtn.BorderSizePixel = 0
resetBtn.Parent = playerTab
Instance.new("UICorner", resetBtn).CornerRadius = UDim.new(0, 4)

resetBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(-237.64711, -505.199341, -519.572815, -0.779444277, -0.163655505, 0.604717672, 0.0116138598, 0.961334944, 0.275136828, -0.626363873, 0.221476942, -0.747406363)
    end
end)

-- ==================== GIVE LOCATE-CONTROL (В PLAYER TAB) ====================
local locateControlBtn = Instance.new("TextButton")
locateControlBtn.Size = UDim2.new(1, 0, 0, 32)
locateControlBtn.Text = "Give Locate-Control"
locateControlBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
locateControlBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
locateControlBtn.Font = Enum.Font.SourceSansBold
locateControlBtn.TextSize = 13
locateControlBtn.BorderSizePixel = 0
locateControlBtn.Parent = playerTab
Instance.new("UICorner", locateControlBtn).CornerRadius = UDim.new(0, 4)

locateControlBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sh4d0w-br0ker/trench-war-script/refs/heads/main/LC.lua", true))()
end)


-- ==================== TROLL TAB ====================
local isSunsetAll = false
local isSunsetRunning = false
local isSavageTornadoAll = false
local isTornadoRunning = false
local isDeathBlowHit = false
local isDeathBlowRunning = false
local selectedDeathBlowTarget = nil

local isEvilTwinsAll = false
local isEvilTwinsRunning = false
local EVIL_TARGET_CFRAME = CFrame.new(100.728096, -489.499664, 47.9694824, -0.0552487373, 0, -0.998472571, 0, 1, 0, 0.998472571, 0, -0.0552487373)
local EVIL_PLAT_SIZE = 200

local deathBlowPlayerLabel = Instance.new("TextLabel")
deathBlowPlayerLabel.Size = UDim2.new(1, 0, 0, 20)
deathBlowPlayerLabel.Text = "Player: None"
deathBlowPlayerLabel.TextColor3 = Color3.new(1, 1, 1)
deathBlowPlayerLabel.TextSize = 13
deathBlowPlayerLabel.Font = Enum.Font.SourceSans
deathBlowPlayerLabel.BackgroundTransparency = 1
deathBlowPlayerLabel.TextXAlignment = Enum.TextXAlignment.Left
deathBlowPlayerLabel.Parent = trollTab

local selectDeathBlowPlayerBtn = Instance.new("TextButton")
selectDeathBlowPlayerBtn.Size = UDim2.new(1, 0, 0, 30)
selectDeathBlowPlayerBtn.Text = "Select Target"
selectDeathBlowPlayerBtn.TextColor3 = Color3.new(1, 1, 1)
selectDeathBlowPlayerBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
selectDeathBlowPlayerBtn.Font = Enum.Font.SourceSansBold
selectDeathBlowPlayerBtn.TextSize = 13
selectDeathBlowPlayerBtn.BorderSizePixel = 0
selectDeathBlowPlayerBtn.Parent = trollTab
Instance.new("UICorner", selectDeathBlowPlayerBtn).CornerRadius = UDim.new(0, 4)

selectDeathBlowPlayerBtn.MouseButton1Click:Connect(function()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 300)
    frame.Position = UDim2.new(0.5, -100, 0.5, -150)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    frame.Parent = ScreenGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 30, 0, 30)
    close.Position = UDim2.new(1, -30, 0, 0)
    close.Text = "X"
    close.TextColor3 = Color3.fromRGB(255, 80, 80)
    close.BackgroundTransparency = 1
    close.Parent = frame
    close.MouseButton1Click:Connect(function() frame:Destroy() end)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -40)
    scroll.Position = UDim2.new(0, 5, 0, 35)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = frame
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 3)

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.Text = plr.Name
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Parent = scroll
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            btn.MouseButton1Click:Connect(function()
                selectedDeathBlowTarget = plr
                deathBlowPlayerLabel.Text = "Player: " .. plr.Name
                frame:Destroy()
            end)
        end
    end
end)

local deathBlowBtn = Instance.new("TextButton")
deathBlowBtn.Size = UDim2.new(1, 0, 0, 32)
deathBlowBtn.Text = "Death-Blow Hit OFF"
deathBlowBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
deathBlowBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
deathBlowBtn.Font = Enum.Font.SourceSansBold
deathBlowBtn.TextSize = 13
deathBlowBtn.BorderSizePixel = 0
deathBlowBtn.Parent = trollTab
Instance.new("UICorner", deathBlowBtn).CornerRadius = UDim.new(0, 4)

deathBlowBtn.MouseButton1Click:Connect(function()
    isDeathBlowHit = not isDeathBlowHit
    if isDeathBlowHit then
        deathBlowBtn.Text = "Death-Blow Hit ON"
        deathBlowBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        deathBlowBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    else
        deathBlowBtn.Text = "Death-Blow Hit OFF"
        deathBlowBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        deathBlowBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        isDeathBlowRunning = false
    end
end)

local savageBtn = Instance.new("TextButton")
savageBtn.Size = UDim2.new(1, 0, 0, 32)
savageBtn.Text = "Savage-Tornado-all OFF"
savageBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
savageBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
savageBtn.Font = Enum.Font.SourceSansBold
savageBtn.TextSize = 13
savageBtn.BorderSizePixel = 0
savageBtn.Parent = trollTab
Instance.new("UICorner", savageBtn).CornerRadius = UDim.new(0, 4)

savageBtn.MouseButton1Click:Connect(function()
    isSavageTornadoAll = not isSavageTornadoAll
    if isSavageTornadoAll then
        savageBtn.Text = "Savage-Tornado-all ON"
        savageBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        savageBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    else
        savageBtn.Text = "Savage-Tornado-all OFF"
        savageBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        savageBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        isTornadoRunning = false
    end
end)

local sunsetBtn = Instance.new("TextButton")
sunsetBtn.Size = UDim2.new(1, 0, 0, 32)
sunsetBtn.Text = "Sunset-All OFF"
sunsetBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
sunsetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
sunsetBtn.Font = Enum.Font.SourceSansBold
sunsetBtn.TextSize = 13
sunsetBtn.BorderSizePixel = 0
sunsetBtn.Parent = trollTab
Instance.new("UICorner", sunsetBtn).CornerRadius = UDim.new(0, 4)

sunsetBtn.MouseButton1Click:Connect(function()
    isSunsetAll = not isSunsetAll
    if isSunsetAll then
        sunsetBtn.Text = "Sunset-All ON"
        sunsetBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        sunsetBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    else
        sunsetBtn.Text = "Sunset-All OFF"
        sunsetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        sunsetBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        isSunsetRunning = false
    end
end)

local evilTwinsBtn = Instance.new("TextButton")
evilTwinsBtn.Size = UDim2.new(1, 0, 0, 32)
evilTwinsBtn.Text = "Evil-Twins-All OFF"
evilTwinsBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
evilTwinsBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
evilTwinsBtn.Font = Enum.Font.SourceSansBold
evilTwinsBtn.TextSize = 13
evilTwinsBtn.BorderSizePixel = 0
evilTwinsBtn.Parent = trollTab
Instance.new("UICorner", evilTwinsBtn).CornerRadius = UDim.new(0, 4)

evilTwinsBtn.MouseButton1Click:Connect(function()
    isEvilTwinsAll = not isEvilTwinsAll
    if isEvilTwinsAll then
        evilTwinsBtn.Text = "Evil-Twins-All ON"
        evilTwinsBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        evilTwinsBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    else
        evilTwinsBtn.Text = "Evil-Twins-All OFF"
        evilTwinsBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        evilTwinsBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        isEvilTwinsRunning = false
    end
end)


-- Communicate hook
task.spawn(function()
    pcall(function()
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local args = {...}
            local method = getnamecallmethod()

            if method == "FireServer" and tostring(self) == "Communicate" then
                local data = args[1]
                if type(data) == "table" then
                    -- SKILL-BRING
                    if isSkillBring then
                        if data.Goal == "PingCheck" or data.Goal == "delete bv" then
                            return nil 
                        end
                        if data.Goal == "Auto Use End" or data.Goal == "Console Move" then
                            local t = data.Tool
                            if t and (t.Name == "Lethal Whirlwind Stream" or t.Name == "Flowing Water" or t.Name == "Beatdown" or t.Name == "Head First" or t.Name == "Trinity Tear" or t.Name == "Grave Maker") then
                                task.spawn(function()
                                    local char = LocalPlayer.Character
                                    local root = char and char:FindFirstChild("HumanoidRootPart")
                                    if root then
                                        local oldCF = root.CFrame
                                        task.wait(WAIT_BEFORE)

                                        local p = Instance.new("Part", workspace)
                                        p.Size = Vector3.new(PLAT_SIZE, 2, PLAT_SIZE)
                                        p.CFrame = TARGET_CFRAME * CFrame.new(0, -4, 0)
                                        p.Anchored = true
                                        p.CanCollide = true
                                        p.Transparency = 0.5
                                        p.Color = Color3.fromRGB(255, 0, 0)

                                        root.CFrame = TARGET_CFRAME
                                        task.wait(WAIT_THERE)
                                        root.CFrame = oldCF
                                        p:Destroy()
                                    end
                                end)
                            end
                        end
                    end

                    -- SUNSET-ALL
                    if isSunsetAll and not isSunsetRunning then
                        local t = data.Tool
                        if t and t.Name == "Sunset" then
                            isSunsetRunning = true
                            task.spawn(function()
                                task.wait(1.0)
                                local char = LocalPlayer.Character
                                local root = char and char:FindFirstChild("HumanoidRootPart")

                                if root then
                                    local oldCF = root.CFrame
                                    for _, plr in ipairs(Players:GetPlayers()) do
                                        if plr ~= LocalPlayer and plr.Character then
                                            local targetRoot = plr.Character:FindFirstChild("HumanoidRootPart")
                                            if targetRoot then
                                                root.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 2)
                                                task.wait(1.2)
                                            end
                                        end
                                    end
                                    root.CFrame = oldCF
                                end
                                task.wait(0.5)
                                isSunsetRunning = false
                            end)
                        end
                    end

                    -- SAVAGE-TORNADO-ALL
                    if isSavageTornadoAll and not isTornadoRunning then
                        local t = data.Tool
                        if t and t.Name == "Savage Tornado" then
                            isTornadoRunning = true
                            task.spawn(function()
                                task.wait(1.2)
                                local char = LocalPlayer.Character
                                local root = char and char:FindFirstChild("HumanoidRootPart")

                                if root then
                                    local oldCF = root.CFrame
                                    for _, plr in ipairs(Players:GetPlayers()) do
                                        if plr ~= LocalPlayer and plr.Character then
                                            local targetRoot = plr.Character:FindFirstChild("HumanoidRootPart")
                                            if targetRoot then
                                                root.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 2)
                                                task.wait(0.7)
                                            end
                                        end
                                    end
                                    root.CFrame = oldCF
                                end
                                task.wait(0.5)
                                isTornadoRunning = false
                            end)
                        end
                    end

                    -- DEATH-BLOW HIT
                    if isDeathBlowHit and not isDeathBlowRunning and selectedDeathBlowTarget then
                        local t = data.Tool
                        if t and t.Name == "Death Blow" then
                            isDeathBlowRunning = true
                            task.spawn(function()
                                task.wait(2.0)
                                local char = LocalPlayer.Character
                                local root = char and char:FindFirstChild("HumanoidRootPart")

                                if root and selectedDeathBlowTarget.Character then
                                    local targetRoot = selectedDeathBlowTarget.Character:FindFirstChild("HumanoidRootPart")
                                    if targetRoot then
                                        root.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 2)
                                    end
                                end
                                task.wait(0.5)
                                isDeathBlowRunning = false
                            end)
                        end
                    end

                    -- EVIL-TWINS-ALL
                    if isEvilTwinsAll and not isEvilTwinsRunning then
                        local t = data.Tool
                        if t and t.Name == "Twin Fangs" then
                            isEvilTwinsRunning = true
                            task.spawn(function()
                                local char = LocalPlayer.Character
                                local root = char and char:FindFirstChild("HumanoidRootPart")
                                if not root then
                                    isEvilTwinsRunning = false
                                    return
                                end

                                local oldCF = root.CFrame
                                local playersList = {}

                                for _, plr in ipairs(Players:GetPlayers()) do
                                    if plr ~= LocalPlayer and plr.Character then
                                        local targetRoot = plr.Character:FindFirstChild("HumanoidRootPart")
                                        if targetRoot then
                                            table.insert(playersList, targetRoot)
                                        end
                                    end
                                end

                                if #playersList == 0 then
                                    isEvilTwinsRunning = false
                                    return
                                end

                                -- Шаг 1: Быстро телепортируемся к 10 случайным игрокам
                                local shuffled = {}
                                for i, v in ipairs(playersList) do shuffled[i] = v end
                                for i = #shuffled, 2, -1 do
                                    local j = math.random(1, i)
                                    shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
                                end

                                local count = math.min(10, #shuffled)
                                for i = 1, count do
                                    if not isEvilTwinsAll then break end
                                    root.CFrame = shuffled[i].CFrame * CFrame.new(0, 0, 1.5)
                                    task.wait(0.8)
                                end

                                -- Шаг 2: Создаём платформу и телепортируемся на неё
                                local p = Instance.new("Part", workspace)
                                p.Size = Vector3.new(EVIL_PLAT_SIZE, 2, EVIL_PLAT_SIZE)
                                p.CFrame = EVIL_TARGET_CFRAME * CFrame.new(0, -4, 0)
                                p.Anchored = true
                                p.CanCollide = true
                                p.Transparency = 0.5
                                p.Color = Color3.fromRGB(150, 0, 255)

                                root.CFrame = EVIL_TARGET_CFRAME

                                -- Ждём 5 секунд на платформе
                                task.wait(5)

                                -- Возврат
                                root.CFrame = oldCF
                                p:Destroy()

                                task.wait(0.5)
                                isEvilTwinsRunning = false
                            end)
                        end
                    end
                end
            end
            return oldNamecall(self, ...)
        end)
    end)
end)

-- ==================== FARM TAB ====================
local isFarming = false
local isAutoUlt = false
local farmConnection = nil
local ultConnection = nil

local function getCommunicate()
    local char = LocalPlayer.Character
    if not char then return nil end
    return char:FindFirstChild("Communicate")
end

local function getDummyPosition()
    local live = workspace:FindFirstChild("Live")
    if not live then return nil end
    local dummy = live:FindFirstChild("Weakest Dummy")
    if not dummy then return nil end
    local root = dummy:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    return root.Position, root.CFrame
end

local function teleportToDummy()
    local pos, cframe = getDummyPosition()
    if not pos then return false end
    local char = LocalPlayer.Character
    if not char then return false end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    root.CFrame = cframe * CFrame.new(0, 0, 3)
    return true
end

local function sendLeftClick()
    local event = getCommunicate()
    if not event then return end
    local dummyPos = getDummyPosition()
    if not dummyPos then return end
    local mousePos = CFrame.new(dummyPos.X, dummyPos.Y + 2, dummyPos.Z)
    local args = { Mobile = true, Goal = "LeftClick", MousePos = mousePos }
    pcall(function() event:FireServer(args) end)
end

local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(1, 0, 0, 32)
tpBtn.Text = "TP to Dummy"
tpBtn.TextColor3 = Color3.new(1, 1, 1)
tpBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
tpBtn.Font = Enum.Font.SourceSansBold
tpBtn.TextSize = 14
tpBtn.BorderSizePixel = 0
tpBtn.Parent = farmTab
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 4)
tpBtn.MouseButton1Click:Connect(function() teleportToDummy() end)

local farmBtnToggle = Instance.new("TextButton")
farmBtnToggle.Size = UDim2.new(1, 0, 0, 32)
farmBtnToggle.Text = "Dummy Farm OFF"
farmBtnToggle.TextColor3 = Color3.fromRGB(255, 85, 85)
farmBtnToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
farmBtnToggle.Font = Enum.Font.SourceSansBold
farmBtnToggle.TextSize = 14
farmBtnToggle.BorderSizePixel = 0
farmBtnToggle.Parent = farmTab
Instance.new("UICorner", farmBtnToggle).CornerRadius = UDim.new(0, 4)
farmBtnToggle.MouseButton1Click:Connect(function()
    isFarming = not isFarming
    if isFarming then
        farmBtnToggle.Text = "Dummy Farm ON"
        farmBtnToggle.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        farmBtnToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
        if farmConnection then farmConnection:Disconnect() end
        farmConnection = RunService.Heartbeat:Connect(function()
            if not isFarming then farmConnection:Disconnect() return end
            local dummyPos = getDummyPosition()
            if not dummyPos then return end
            local char = LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            if (root.Position - dummyPos).Magnitude > 4 then
                teleportToDummy()
            else
                sendLeftClick()
            end
        end)
    else
        farmBtnToggle.Text = "Dummy Farm OFF"
        farmBtnToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        farmBtnToggle.TextColor3 = Color3.fromRGB(255, 85, 85)
        if farmConnection then farmConnection:Disconnect() farmConnection = nil end
    end
end)

local ultBtnToggle = Instance.new("TextButton")
ultBtnToggle.Size = UDim2.new(1, 0, 0, 32)
ultBtnToggle.Text = "Auto Ultimate-start OFF"
ultBtnToggle.TextColor3 = Color3.fromRGB(255, 85, 85)
ultBtnToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ultBtnToggle.Font = Enum.Font.SourceSansBold
ultBtnToggle.TextSize = 14
ultBtnToggle.BorderSizePixel = 0
ultBtnToggle.Parent = farmTab
Instance.new("UICorner", ultBtnToggle).CornerRadius = UDim.new(0, 4)
ultBtnToggle.MouseButton1Click:Connect(function()
    isAutoUlt = not isAutoUlt
    if isAutoUlt then
        ultBtnToggle.Text = "Auto Ultimate-start ON"
        ultBtnToggle.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        ultBtnToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
        if ultConnection then ultConnection:Disconnect() end
        ultConnection = RunService.Heartbeat:Connect(function()
            if not isAutoUlt then ultConnection:Disconnect() return end
            local event = getCommunicate()
            if not event then return end
            local args = { MoveDirection = Vector3.new(0, 0, 0), Goal = "KeyPress", Key = Enum.KeyCode.G }
            pcall(function() event:FireServer(args) end)
        end)
    else
        ultBtnToggle.Text = "Auto Ultimate-start OFF"
        ultBtnToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        ultBtnToggle.TextColor3 = Color3.fromRGB(255, 85, 85)
        if ultConnection then ultConnection:Disconnect() ultConnection = nil end
    end
end)

-- ==================== SAITAMA TAB ====================
local saitamaSkills = {
    {name = "Consecutive Punches", delay = 1.5},
    {name = "Uppercut", delay = 1.5},
    {name = "Shove", delay = 1.5},
    {name = "Normal Punch", delay = 1.5}
}

local selectedTarget = nil
local isSaitamaTarget = false
local isSaitamaDummy = false
local saitamaTargetConnection = nil
local saitamaDummyConnection = nil

local function getTargetPosition(target)
    if not target then return nil end
    local char = target.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    return root.Position, root.CFrame
end

local function teleportToTarget(target)
    if not target then return false end
    local pos, cframe = getTargetPosition(target)
    if not pos then return false end
    local char = LocalPlayer.Character
    if not char then return false end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    root.CFrame = cframe * CFrame.new(0, 0, 3)
    return true
end

local function sendSkill(target, skillName, isDummy)
    local event = getCommunicate()
    if not event then return end
    local args = {
        Tool = LocalPlayer.Backpack:FindFirstChild(skillName),
        Goal = "Console Move",
        IsAutoActivate = true
    }
    pcall(function() event:FireServer(args) end)
end

local selectedPlayerLabel = Instance.new("TextLabel")
selectedPlayerLabel.Size = UDim2.new(1, 0, 0, 20)
selectedPlayerLabel.Text = "Player: None"
selectedPlayerLabel.TextColor3 = Color3.new(1, 1, 1)
selectedPlayerLabel.TextSize = 13
selectedPlayerLabel.Font = Enum.Font.SourceSans
selectedPlayerLabel.BackgroundTransparency = 1
selectedPlayerLabel.TextXAlignment = Enum.TextXAlignment.Left
selectedPlayerLabel.Parent = saitamaTab

local selectPlayerBtn = Instance.new("TextButton")
selectPlayerBtn.Size = UDim2.new(1, 0, 0, 30)
selectPlayerBtn.Text = "Select Player"
selectPlayerBtn.TextColor3 = Color3.new(1, 1, 1)
selectPlayerBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
selectPlayerBtn.Font = Enum.Font.SourceSansBold
selectPlayerBtn.TextSize = 13
selectPlayerBtn.BorderSizePixel = 0
selectPlayerBtn.Parent = saitamaTab
Instance.new("UICorner", selectPlayerBtn).CornerRadius = UDim.new(0, 4)

selectPlayerBtn.MouseButton1Click:Connect(function()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 300)
    frame.Position = UDim2.new(0.5, -100, 0.5, -150)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    frame.Parent = ScreenGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 30, 0, 30)
    close.Position = UDim2.new(1, -30, 0, 0)
    close.Text = "X"
    close.TextColor3 = Color3.fromRGB(255, 80, 80)
    close.BackgroundTransparency = 1
    close.Parent = frame
    close.MouseButton1Click:Connect(function() frame:Destroy() end)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -40)
    scroll.Position = UDim2.new(0, 5, 0, 35)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = frame
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 3)

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.Text = plr.Name
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Parent = scroll
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            btn.MouseButton1Click:Connect(function()
                selectedTarget = plr
                selectedPlayerLabel.Text = "Player: " .. plr.Name
                frame:Destroy()
            end)
        end
    end
end)

local saitamaTargetBtn = Instance.new("TextButton")
saitamaTargetBtn.Size = UDim2.new(1, 0, 0, 32)
saitamaTargetBtn.Text = "Target OFF"
saitamaTargetBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
saitamaTargetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
saitamaTargetBtn.Font = Enum.Font.SourceSansBold
saitamaTargetBtn.TextSize = 13
saitamaTargetBtn.BorderSizePixel = 0
saitamaTargetBtn.Parent = saitamaTab
Instance.new("UICorner", saitamaTargetBtn).CornerRadius = UDim.new(0, 4)

saitamaTargetBtn.MouseButton1Click:Connect(function()
    if not selectedTarget then return end
    isSaitamaTarget = not isSaitamaTarget
    if isSaitamaTarget then
        saitamaTargetBtn.Text = "Target ON"
        saitamaTargetBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        saitamaTargetBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        if saitamaTargetConnection then saitamaTargetConnection:Disconnect() end
        local skillIndex = 1
        local lastTime = os.time()
        saitamaTargetConnection = RunService.Heartbeat:Connect(function()
            if not isSaitamaTarget or not selectedTarget then saitamaTargetConnection:Disconnect() return end
            local pos = getTargetPosition(selectedTarget)
            if not pos then return end
            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end
            if (root.Position - pos).Magnitude > 4 then
                teleportToTarget(selectedTarget)
            else
                local currentTime = os.time()
                if currentTime - lastTime >= saitamaSkills[skillIndex].delay then
                    sendSkill(selectedTarget, saitamaSkills[skillIndex].name, false)
                    skillIndex = skillIndex % #saitamaSkills + 1
                    lastTime = currentTime
                end
            end
        end)
    else
        saitamaTargetBtn.Text = "Target OFF"
        saitamaTargetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        saitamaTargetBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if saitamaTargetConnection then saitamaTargetConnection:Disconnect() saitamaTargetConnection = nil end
    end
end)

local saitamaDummyBtn = Instance.new("TextButton")
saitamaDummyBtn.Size = UDim2.new(1, 0, 0, 32)
saitamaDummyBtn.Text = "Dummy-farm OFF"
saitamaDummyBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
saitamaDummyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
saitamaDummyBtn.Font = Enum.Font.SourceSansBold
saitamaDummyBtn.TextSize = 13
saitamaDummyBtn.BorderSizePixel = 0
saitamaDummyBtn.Parent = saitamaTab
Instance.new("UICorner", saitamaDummyBtn).CornerRadius = UDim.new(0, 4)

saitamaDummyBtn.MouseButton1Click:Connect(function()
    isSaitamaDummy = not isSaitamaDummy
    if isSaitamaDummy then
        saitamaDummyBtn.Text = "Dummy-farm ON"
        saitamaDummyBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        saitamaDummyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        if saitamaDummyConnection then saitamaDummyConnection:Disconnect() end
        local skillIndex = 1
        local lastTime = os.time()
        saitamaDummyConnection = RunService.Heartbeat:Connect(function()
            if not isSaitamaDummy then saitamaDummyConnection:Disconnect() return end
            local dummyPos = getDummyPosition()
            if not dummyPos then return end
            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end
            if (root.Position - dummyPos).Magnitude > 4 then
                teleportToDummy()
            else
                local currentTime = os.time()
                if currentTime - lastTime >= saitamaSkills[skillIndex].delay then
                    sendSkill(nil, saitamaSkills[skillIndex].name, true)
                    skillIndex = skillIndex % #saitamaSkills + 1
                    lastTime = currentTime
                end
            end
        end)
    else
        saitamaDummyBtn.Text = "Dummy-farm OFF"
        saitamaDummyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        saitamaDummyBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if saitamaDummyConnection then saitamaDummyConnection:Disconnect() saitamaDummyConnection = nil end
    end
end)

-- ==================== WINDOW UI MANAGEMENT ====================
local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 400, 0, 30), "Out", "Quad", 0.2, true)
        LeftPanel.Visible = false
        RightPanel.Visible = false
        MinimizeButton.Text = ">"
    else
        MainFrame:TweenSize(UDim2.new(0, 400, 0, 360), "Out", "Quad", 0.2, true)
        LeftPanel.Visible = true
        RightPanel.Visible = true
        MinimizeButton.Text = "<"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    isFarming = false
    isAutoUlt = false
    isSaitamaTarget = false
    isSaitamaDummy = false
    isSkillBring = false
    isSavageTornadoAll = false
    isSunsetAll = false
    isDeathBlowHit = false
    isUltLogger = false
    isEspEnabled = false
    isEvilTwinsAll = false
    clearEsp()
    if farmConnection then farmConnection:Disconnect() end
    if ultConnection then ultConnection:Disconnect() end
    if saitamaTargetConnection then saitamaTargetConnection:Disconnect() end
    if saitamaDummyConnection then saitamaDummyConnection:Disconnect() end
    if ultLoggerConnection then ultLoggerConnection:Disconnect() end
    ScreenGui:Destroy()
end)

infoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
infoBtn.TextColor3 = Color3.new(1, 1, 1)

print("Spynote Tsb-sploit fully loaded!")
