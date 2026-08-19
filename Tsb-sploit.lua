-- Spynote Tsb-sploit (Full Version with Savage Tornado All)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Удаляем старый GUI
if CoreGui:FindFirstChild("SpynoteTsb") then
    CoreGui.SpynoteTsb:Destroy()
end

-- GUI Создание
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
local ScrollContainer = Instance.new("ScrollingFrame")

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

ScrollContainer.Name = "ScrollContainer"
ScrollContainer.Parent = RightContent
ScrollContainer.Size = UDim2.new(1, 0, 1, 0)
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollContainer.ScrollBarThickness = 6
ScrollContainer.BorderSizePixel = 0

-- ==================== ФУНКЦИЯ СОЗДАНИЯ ВКЛАДОК ====================
local function createTab(tabName, displayName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 28)
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

-- ==================== СОЗДАНИЕ ВКЛАДОК ====================
local infoBtn, infoTab = createTab("Info", "Info")
local exploitBtn, exploitTab = createTab("Exploit", "Exploit")
local farmBtn, farmTab = createTab("Farm", "Farm")
local saitamaBtn, saitamaTab = createTab("Saitama", "Saitama")
local trollBtn, trollTab = createTab("Troll", "Troll")

infoTab.Visible = true

-- ==================== INFO ====================
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 1, 0)
infoLabel.Text = "Tab-Info: information\nTab-Exploit: Exploit scripts\nTab-farm: farm Ult and more\nTab-Saitama: Saitama combos\nTab-Troll: Trolled Functions"
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextSize = 16
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.BackgroundTransparency = 1
infoLabel.Parent = infoTab

-- ==================== EXPLOIT ====================
local exploitLabel = Instance.new("TextLabel")
exploitLabel.Size = UDim2.new(1, 0, 0, 20)
exploitLabel.Text = "Worked: Garou"
exploitLabel.TextColor3 = Color3.new(1, 1, 1)
exploitLabel.TextSize = 14
exploitLabel.Font = Enum.Font.SourceSans
exploitLabel.TextYAlignment = Enum.TextYAlignment.Top
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

-- ==================== TROLL (Savage Tornado All) ====================
local isSavageTornadoAll = false
local isTornadoRunning = false

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

-- Общий хук метаметода для перехвата событий Communicate
task.spawn(function()
    pcall(function()
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local args = {...}
            local method = getnamecallmethod()
            
            if method == "FireServer" and tostring(self) == "Communicate" then
                local data = args[1]
                if type(data) == "table" then
                    -- Логика Skill-Bring
                    if isSkillBring then
                        if data.Goal == "PingCheck" or data.Goal == "delete bv" then
                            return nil 
                        end
                        if data.Goal == "Auto Use End" then
                            local t = data.Tool
                            if t and (t.Name == "Lethal Whirlwind Stream" or t.Name == "Flowing Water") then
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

                    -- Логика Savage-Tornado-all
                    if isSavageTornadoAll and not isTornadoRunning then
                        local t = data.Tool
                        if t and t.Name == "Savage Tornado" then
                            isTornadoRunning = true
                            task.spawn(function()
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
                end
            end
            return oldNamecall(self, ...)
        end)
    end)
end)

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

-- ==================== FARM ====================
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
    local behind = cframe * CFrame.new(0, 0, 3)
    root.CFrame = behind
    return true
end

local function sendLeftClick()
    local event = getCommunicate()
    if not event then return end
    local dummyPos = getDummyPosition()
    if not dummyPos then return end
    local pos = dummyPos
    local mousePos = CFrame.new(pos.X, pos.Y + 2, pos.Z)
    local args = { Mobile = true, Goal = "LeftClick", MousePos = mousePos }
    pcall(function() event:FireServer(args) end)
end

local function startFarm()
    if farmConnection then farmConnection:Disconnect() end
    farmConnection = RunService.Heartbeat:Connect(function()
        if not isFarming then
            farmConnection:Disconnect()
            farmConnection = nil
            return
        end
        local dummyPos = getDummyPosition()
        if not dummyPos then return end
        local char = LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local dist = (root.Position - dummyPos).Magnitude
        if dist > 4 then
            teleportToDummy()
        else
            sendLeftClick()
        end
    end)
end

local function startAutoUlt()
    if ultConnection then ultConnection:Disconnect() end
    ultConnection = RunService.Heartbeat:Connect(function()
        if not isAutoUlt then
            ultConnection:Disconnect()
            ultConnection = nil
            return
        end
        local event = getCommunicate()
        if not event then return end
        local args = { MoveDirection = Vector3.new(0, 0, 0), Goal = "KeyPress", Key = Enum.KeyCode.G }
        pcall(function() event:FireServer(args) end)
    end)
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
        startFarm()
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
        startAutoUlt()
    else
        ultBtnToggle.Text = "Auto Ultimate-start OFF"
        ultBtnToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        ultBtnToggle.TextColor3 = Color3.fromRGB(255, 85, 85)
        if ultConnection then ultConnection:Disconnect() ultConnection = nil end
    end
end)

-- ==================== SAITAMA ====================
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
    local pos = isDummy and getDummyPosition() or getTargetPosition(target)
    if not pos then return end

    local args = {
        Tool = LocalPlayer.Backpack:FindFirstChild(skillName),
        Goal = "Console Move",
        IsAutoActivate = true
    }
    pcall(function() event:FireServer(args) end)
end

local function startSaitamaTarget()
    if saitamaTargetConnection then saitamaTargetConnection:Disconnect() end
    local skillIndex = 1
    local lastTime = os.time()

    saitamaTargetConnection = RunService.Heartbeat:Connect(function()
        if not isSaitamaTarget or not selectedTarget then
            saitamaTargetConnection:Disconnect()
            saitamaTargetConnection = nil
            return
        end
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
end

local function startSaitamaDummy()
    if saitamaDummyConnection then saitamaDummyConnection:Disconnect() end
    local skillIndex = 1
    local lastTime = os.time()

    saitamaDummyConnection = RunService.Heartbeat:Connect(function()
        if not isSaitamaDummy then
            saitamaDummyConnection:Disconnect()
            saitamaDummyConnection = nil
            return
        end
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
        startSaitamaTarget()
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
        startSaitamaDummy()
    else
        saitamaDummyBtn.Text = "Dummy-farm OFF"
        saitamaDummyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        saitamaDummyBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if saitamaDummyConnection then saitamaDummyConnection:Disconnect() saitamaDummyConnection = nil end
    end
end)

-- ==================== УПРАВЛЕНИЕ ОКНОМ ====================
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
    if farmConnection then farmConnection:Disconnect() end
    if ultConnection then ultConnection:Disconnect() end
    if saitamaTargetConnection then saitamaTargetConnection:Disconnect() end
    if saitamaDummyConnection then saitamaDummyConnection:Disconnect() end
    ScreenGui:Destroy()
end)

infoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
infoBtn.TextColor3 = Color3.new(1, 1, 1)

print("Spynote Tsb-sploit loaded successfully!")
