local oldUI = game:GetService("CoreGui"):FindFirstChild("VoidHubCustom")
if oldUI then oldUI:Destroy() end

local VoidHub = Instance.new("ScreenGui")
VoidHub.Name = "VoidHubCustom"
VoidHub.Parent = game:GetService("CoreGui")
VoidHub.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 320)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = VoidHub

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "void Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -65, 0, 2.5)
MinimizeBtn.Text = "<"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeBtn.TextSize = 18
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 2.5)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 75, 75)
CloseBtn.TextSize = 22
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.BackgroundTransparency = 1
CloseBtn.Parent = TopBar

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 100, 1, -35)
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -100, 1, -35)
ContentFrame.Position = UDim2.new(0, 100, 0, 35)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 4
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 520)
ContentFrame.Parent = MainFrame

-- Pages
local InfoPage = Instance.new("Frame")
InfoPage.Size = UDim2.new(1, 0, 1, 0)
InfoPage.BackgroundTransparency = 1
InfoPage.Visible = true
InfoPage.Parent = ContentFrame

local EspPage = Instance.new("Frame")
EspPage.Size = UDim2.new(1, 0, 1, 0)
EspPage.BackgroundTransparency = 1
EspPage.Visible = false
EspPage.Parent = ContentFrame

local MonsterPage = Instance.new("Frame")
MonsterPage.Size = UDim2.new(1, 0, 1, 0)
MonsterPage.BackgroundTransparency = 1
MonsterPage.Visible = false
MonsterPage.Parent = ContentFrame

local PlayerPage = Instance.new("Frame")
PlayerPage.Size = UDim2.new(1, 0, 1, 0)
PlayerPage.BackgroundTransparency = 1
PlayerPage.Visible = false
PlayerPage.Parent = ContentFrame

local CreatedByText = Instance.new("TextLabel")
CreatedByText.Size = UDim2.new(1, -20, 0, 30)
CreatedByText.Position = UDim2.new(0, 10, 0, 10)
CreatedByText.Text = "created by spynote"
CreatedByText.TextColor3 = Color3.fromRGB(150, 150, 150)
CreatedByText.TextSize = 16
CreatedByText.Font = Enum.Font.SourceSans
CreatedByText.TextXAlignment = Enum.TextXAlignment.Right
CreatedByText.BackgroundTransparency = 1
CreatedByText.Parent = InfoPage

-- Sidebar Buttons
local InfoTabBtn = Instance.new("TextButton")
InfoTabBtn.Size = UDim2.new(1, 0, 0, 40)
InfoTabBtn.Position = UDim2.new(0, 0, 0, 0)
InfoTabBtn.Text = "info"
InfoTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoTabBtn.Font = Enum.Font.SourceSansBold
InfoTabBtn.TextSize = 16
InfoTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
InfoTabBtn.BorderSizePixel = 0
InfoTabBtn.Parent = Sidebar

local EspTabBtn = Instance.new("TextButton")
EspTabBtn.Size = UDim2.new(1, 0, 0, 40)
EspTabBtn.Position = UDim2.new(0, 0, 0, 40)
EspTabBtn.Text = "esp"
EspTabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
EspTabBtn.Font = Enum.Font.SourceSansBold
EspTabBtn.TextSize = 16
EspTabBtn.BackgroundTransparency = 1
EspTabBtn.BorderSizePixel = 0
EspTabBtn.Parent = Sidebar

local MonsterTabBtn = Instance.new("TextButton")
MonsterTabBtn.Size = UDim2.new(1, 0, 0, 40)
MonsterTabBtn.Position = UDim2.new(0, 0, 0, 80)
MonsterTabBtn.Text = "monster"
MonsterTabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
MonsterTabBtn.Font = Enum.Font.SourceSansBold
MonsterTabBtn.TextSize = 16
MonsterTabBtn.BackgroundTransparency = 1
MonsterTabBtn.BorderSizePixel = 0
MonsterTabBtn.Parent = Sidebar

local PlayerTabBtn = Instance.new("TextButton")
PlayerTabBtn.Size = UDim2.new(1, 0, 0, 40)
PlayerTabBtn.Position = UDim2.new(0, 0, 0, 120)
PlayerTabBtn.Text = "player"
PlayerTabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
PlayerTabBtn.Font = Enum.Font.SourceSansBold
PlayerTabBtn.TextSize = 16
PlayerTabBtn.BackgroundTransparency = 1
PlayerTabBtn.BorderSizePixel = 0
PlayerTabBtn.Parent = Sidebar

local function switchTab(activePage, activeBtn)
    InfoPage.Visible = (activePage == InfoPage)
    EspPage.Visible = (activePage == EspPage)
    MonsterPage.Visible = (activePage == MonsterPage)
    PlayerPage.Visible = (activePage == PlayerPage)

    local buttons = {InfoTabBtn, EspTabBtn, MonsterTabBtn, PlayerTabBtn}
    for _, btn in pairs(buttons) do
        if btn == activeBtn then
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            btn.BackgroundTransparency = 0
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            btn.BackgroundTransparency = 1
            btn.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
    end
end

InfoTabBtn.MouseButton1Click:Connect(function() switchTab(InfoPage, InfoTabBtn) end)
EspTabBtn.MouseButton1Click:Connect(function() switchTab(EspPage, EspTabBtn) end)
MonsterTabBtn.MouseButton1Click:Connect(function() switchTab(MonsterPage, MonsterTabBtn) end)
PlayerTabBtn.MouseButton1Click:Connect(function() switchTab(PlayerPage, PlayerTabBtn) end)

CloseBtn.MouseButton1Click:Connect(function()
    VoidHub:Destroy()
end)

local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 450, 0, 35), "Out", "Quad", 0.2, true)
        Sidebar.Visible = false
        ContentFrame.Visible = false
        MinimizeBtn.Text = ">"
    else
        MainFrame:TweenSize(UDim2.new(0, 450, 0, 320), "Out", "Quad", 0.2, true)
        Sidebar.Visible = true
        ContentFrame.Visible = true
        MinimizeBtn.Text = "<"
    end
end)

local EspStates = {Rush = false, Eyes = false, Door = false, Key = false, Item = false, LockBox = false, UnLockBox = false, Chest = false, Book = false, Lever = false, PlayerEsp = false, SpeedBoost = false, Figura = false}
local activeHighlights = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local function createToggle(name, pos, stateKey, parentPage)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -40, 0, 40)
    btn.Position = pos
    btn.Text = name .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 75, 75)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.BorderSizePixel = 0
    btn.Parent = parentPage

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        EspStates[stateKey] = not EspStates[stateKey]
        if EspStates[stateKey] then
            btn.Text = name .. " [ON]"
            btn.TextColor3 = Color3.fromRGB(75, 255, 75)
        else
            btn.Text = name .. " [OFF]"
            btn.TextColor3 = Color3.fromRGB(255, 75, 75)
        end
    end)
end

-- Toggles Setup (Вкладка ESP)
createToggle("Esp Door off/on", UDim2.new(0, 20, 0, 20), "Door", EspPage)
createToggle("Esp Key off/on", UDim2.new(0, 20, 0, 70), "Key", EspPage)
createToggle("Esp item off/on", UDim2.new(0, 20, 0, 120), "Item", EspPage)
createToggle("Esp LockBox off/on", UDim2.new(0, 20, 0, 170), "LockBox", EspPage)
createToggle("Esp UnLockbox off/on", UDim2.new(0, 20, 0, 220), "UnLockBox", EspPage)
createToggle("Esp chest off/on", UDim2.new(0, 20, 0, 270), "Chest", EspPage)
createToggle("Esp book off/on", UDim2.new(0, 20, 0, 320), "Book", EspPage)
createToggle("Esp Lever off/on", UDim2.new(0, 20, 0, 370), "Lever", EspPage)

-- Вкладка Monster
createToggle("Esp Rush off/on", UDim2.new(0, 20, 0, 20), "Rush", MonsterPage)
createToggle("Esp Eyes off/on", UDim2.new(0, 20, 0, 70), "Eyes", MonsterPage)
createToggle("Esp Figura off/on", UDim2.new(0, 20, 0, 120), "Figura", MonsterPage)

-- Вкладка Player
createToggle("Esp all off/on", UDim2.new(0, 20, 0, 20), "PlayerEsp", PlayerPage)
createToggle("21 speedbost off/on", UDim2.new(0, 20, 0, 70), "SpeedBoost", PlayerPage)

local function getDistance(object)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return 0 end
    if not object or not object:IsA("BasePart") then return 0 end
    return math.round((LocalPlayer.Character.HumanoidRootPart.Position - object.Position).Magnitude)
end

local function updateESP(tag, object, text, color, enabled)
    if not enabled or not object then
        if activeHighlights[tag] then
            activeHighlights[tag]:Destroy()
            activeHighlights[tag] = nil
        end
        return
    end

    local targetPart = object:IsA("BasePart") and object or object:FindFirstChildWithClass("BasePart")
    if not targetPart then return end

    if not activeHighlights[tag] or activeHighlights[tag].Parent ~= targetPart then
        if activeHighlights[tag] then activeHighlights[tag]:Destroy() end

        local folder = Instance.new("Folder")
        folder.Name = "CustomESP_" .. tag

        local highlight = Instance.new("Highlight")
        highlight.FillColor = color
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.OutlineTransparency = 0
        highlight.Adornee = object
        highlight.Parent = folder

        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.AlwaysOnTop = true
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.Adornee = targetPart
        billboard.Parent = folder

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = color
        label.TextStrokeTransparency = 0
        label.TextStrokeColor3 = Color3.new(0, 0, 0)
        label.Font = Enum.Font.SourceSansBold
        label.TextSize = 18
        label.Parent = billboard

        folder.Parent = targetPart
        activeHighlights[tag] = folder
    end

    local distance = getDistance(targetPart)
    local folder = activeHighlights[tag]
    if folder then
        local bGui = folder:FindFirstChildOfClass("BillboardGui")
        if bGui then
            local label = bGui:FindFirstChildOfClass("TextLabel")
            if label then
                label.Text = text .. "\n[studs: " .. tostring(distance) .. "]"
            end
        end
    end
end

local function getRooms()
    local currentRooms = workspace:FindFirstChild("CurrentRooms")
    if not currentRooms then return nil, nil end

    local rooms = {}
    for _, room in pairs(currentRooms:GetChildren()) do
        local roomNum = tonumber(room.Name)
        if roomNum then table.insert(rooms, {num = roomNum, obj = room}) end
    end

    table.sort(rooms, function(a, b) return a.num < b.num end)
    return rooms[#rooms], rooms[#rooms - 1]
end

local activeItems = {}
local activeLockBoxes = {}
local activeUnLockBoxes = {}
local activeChests = {}
local activeBooks = {}
local activePlayers = {}

local function clearCache(cache)
    for k, folder in pairs(cache) do
        if folder then folder:Destroy() end
        cache[k] = nil
    end
end

local lastBookCheck = 0
local lastSpeedCheck = 0

RunService.Heartbeat:Connect(function()
    local lastRoom, pLastRoom = getRooms()
    local currentRooms = workspace:FindFirstChild("CurrentRooms")

    -- Speed Boost
    if EspStates.SpeedBoost then
        if tick() - lastSpeedCheck >= 0.5 then
            lastSpeedCheck = tick()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 21
            end
        end
    end

    -- ESP Player
    if EspStates.PlayerEsp then
        local currentValidPlayers = {}
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local root = p.Character.HumanoidRootPart
                local uniqueKey = p.UserId
                currentValidPlayers[uniqueKey] = true

                if not activePlayers[uniqueKey] then
                    local folder = Instance.new("Folder")
                    folder.Name = "PlayerESP_" .. p.Name

                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.FillTransparency = 0.6
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Adornee = p.Character
                    highlight.Parent = folder

                    local bb = Instance.new("BillboardGui")
                    bb.Size = UDim2.new(0, 200, 0, 50)
                    bb.AlwaysOnTop = true
                    bb.StudsOffset = Vector3.new(0, 4, 0)
                    bb.Adornee = root
                    bb.Parent = folder

                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.TextColor3 = Color3.fromRGB(255, 75, 75)
                    lbl.TextStrokeTransparency = 0
                    lbl.Font = Enum.Font.SourceSansBold
                    lbl.TextSize = 16
                    lbl.Parent = bb

                    folder.Parent = root
                    activePlayers[uniqueKey] = folder
                end

                local f = activePlayers[uniqueKey]
                local label = f:FindFirstChildOfClass("BillboardGui"):FindFirstChildOfClass("TextLabel")
                if label then
                    label.Text = p.DisplayName .. "\n[studs: " .. tostring(getDistance(root)) .. "]"
                end
            end
        end
        for k, f in pairs(activePlayers) do
            if not currentValidPlayers[k] then f:Destroy() activePlayers[k] = nil end
        end
    else
        clearCache(activePlayers)
    end

    -- ESP Rush
    if EspStates.Rush then
        local rush = workspace:FindFirstChild("RushMoving") and workspace.RushMoving:FindFirstChild("RushNew")
        if rush then
            updateESP("Rush", rush, "Rush", Color3.fromRGB(255, 0, 0), true)
        else
            updateESP("Rush", nil, "", Color3.fromRGB(255, 0, 0), false)
        end
    else
        updateESP("Rush", nil, "", Color3.fromRGB(255, 0, 0), false)
    end

    -- ESP Eyes
    if EspStates.Eyes then
        local eyes = workspace:FindFirstChild("Eyes") and workspace.Eyes:FindFirstChild("Core")
        if eyes then
            updateESP("Eyes", eyes, "eyes", Color3.fromRGB(150, 0, 255), true)
        else
            updateESP("Eyes", nil, "", Color3.fromRGB(150, 0, 255), false)
        end
    else
        updateESP("Eyes", nil, "", Color3.fromRGB(150, 0, 255), false)
    end

    -- ESP Figura
    if EspStates.Figura then
        local currentRooms = workspace:FindFirstChild("CurrentRooms")
        if currentRooms then
            local room50 = currentRooms:FindFirstChild("50")
            if room50 then
                local figureRig = room50:FindFirstChild("FigureSetup")
                if figureRig then
                    local figuraObject = figureRig:FindFirstChild("FigureRig")
                    if figuraObject then
                        updateESP("Figura", figuraObject, "Figure", Color3.fromRGB(255, 0, 0), true)
                    else
                        updateESP("Figura", nil, "", Color3.fromRGB(255, 0, 0), false)
                    end
                else
                    updateESP("Figura", nil, "", Color3.fromRGB(255, 0, 0), false)
                end
            else
                updateESP("Figura", nil, "", Color3.fromRGB(255, 0, 0), false)
            end
        else
            updateESP("Figura", nil, "", Color3.fromRGB(255, 0, 0), false)
        end
    else
        updateESP("Figura", nil, "", Color3.fromRGB(255, 0, 0), false)
    end

    -- ESP Door
    if EspStates.Door and pLastRoom then
        local realDoor = pLastRoom.obj:FindFirstChild("Door") and pLastRoom.obj.Door:FindFirstChild("Door")
        if realDoor then
            updateESP("Door", realDoor, "Door: " .. tostring(pLastRoom.num), Color3.fromRGB(0, 255, 0), true)
        else
            local doorObject = pLastRoom.obj:FindFirstChild("Door") or pLastRoom.obj
            updateESP("Door", doorObject, "Door: " .. tostring(pLastRoom.num), Color3.fromRGB(0, 255, 0), true)
        end
    else
        updateESP("Door", nil, "", Color3.fromRGB(0, 255, 0), false)
    end

    -- ESP Key
    if EspStates.Key and pLastRoom then
        local keyObject = nil
        local assets = pLastRoom.obj:FindFirstChild("Assets")
        if assets then
            local children1 = assets:GetChildren()
            if children1 and children1[108] then
                local children2 = children1[108]:GetChildren()
                if children2 and children2[2] then
                    local ko = children2[2]:FindFirstChild("KeyObtain")
                    if ko and ko:FindFirstChild("Hitbox") then
                        keyObject = ko.Hitbox:FindFirstChild("Key")
                    end
                end
            end
        end
        if not keyObject then
            keyObject = pLastRoom.obj:FindFirstChild("Key", true) or pLastRoom.obj:FindFirstChild("KeyObtain", true)
        end
        if keyObject then
            updateESP("Key", keyObject, "Key", Color3.fromRGB(255, 255, 0), true)
        else
            updateESP("Key", nil, "", Color3.fromRGB(255, 255, 0), false)
        end
    else
        updateESP("Key", nil, "", Color3.fromRGB(255, 255, 0), false)
    end

    -- ESP Lever
    if EspStates.Lever and currentRooms then
        local leverFound = nil
        for _, room in pairs(currentRooms:GetChildren()) do
            local assets = room:FindFirstChild("Assets")
            if assets then
                local lfg = assets:FindFirstChild("LeverForGate")
                if lfg and lfg:FindFirstChild("Main") then
                    leverFound = lfg.Main
                    break
                end
            end
        end
        if leverFound then
            updateESP("Lever", leverFound, "Lever", Color3.fromRGB(135, 206, 250), true)
        else
            updateESP("Lever", nil, "", Color3.fromRGB(135, 206, 250), false)
        end
    else
        updateESP("Lever", nil, "", Color3.fromRGB(135, 206, 250), false)
    end

    -- ESP Item
    if EspStates.Item and currentRooms then
        local currentValid = {}
        for _, room in pairs(currentRooms:GetChildren()) do
            local assets = room:FindFirstChild("Assets") or room:FindFirstChildOfClass("Folder")
            if assets then
                for _, obj in pairs(assets:GetDescendants()) do
                    if obj.Name == "Handle" and obj:IsA("BasePart") and obj.Parent then
                        local itemName = obj.Parent.Name
                        if itemName == "Lockpick" or itemName == "SpawnPile" or obj.Parent:FindFirstChild("KeyObtain") or obj.Parent.Parent:IsA("Model") then
                            local uniqueKey = obj:GetDebugId()
                            currentValid[uniqueKey] = true

                            if not activeItems[uniqueKey] then
                                local folder = Instance.new("Folder")
                                folder.Name = "ItemESP_" .. itemName

                                local highlight = Instance.new("Highlight")
                                highlight.FillColor = Color3.fromRGB(0, 255, 0)
                                highlight.FillTransparency = 0.5
                                highlight.OutlineColor = Color3.new(1, 1, 1)
                                highlight.Adornee = obj.Parent
                                highlight.Parent = folder

                                local bb = Instance.new("BillboardGui")
                                bb.Size = UDim2.new(0, 200, 0, 50)
                                bb.AlwaysOnTop = true
                                bb.StudsOffset = Vector3.new(0, 2, 0)
                                bb.Adornee = obj
                                bb.Parent = folder

                                local lbl = Instance.new("TextLabel")
                                lbl.Size = UDim2.new(1, 0, 1, 0)
                                lbl.BackgroundTransparency = 1
                                lbl.TextColor3 = Color3.fromRGB(0, 255, 0)
                                lbl.TextStrokeTransparency = 0
                                lbl.Font = Enum.Font.SourceSansBold
                                lbl.TextSize = 18
                                lbl.Parent = bb

                                folder.Parent = obj
                                activeItems[uniqueKey] = folder
                            end

                            local f = activeItems[uniqueKey]
                            local label = f:FindFirstChildOfClass("BillboardGui"):FindFirstChildOfClass("TextLabel")
                            label.Text = itemName .. "\n[studs: " .. tostring(getDistance(obj)) .. "]"
                        end
                    end
                end
            end
        end
        for k, f in pairs(activeItems) do
            if not currentValid[k] then f:Destroy() activeItems[k] = nil end
        end
    else
        clearCache(activeItems)
    end

    -- ESP LockBox
    if EspStates.LockBox and currentRooms then
        local currentValid = {}
        for _, room in pairs(currentRooms:GetChildren()) do
            for _, obj in pairs(room:GetDescendants()) do
                if obj.Name == "ChestBoxLocked" then
                    local targetPart = obj:FindFirstChild("Main") or obj:IsA("BasePart") and obj or obj:FindFirstChildWithClass("BasePart")
                    if targetPart then
                        local uniqueKey = obj:GetDebugId()
                        currentValid[uniqueKey] = true

                        if not activeLockBoxes[uniqueKey] then
                            local folder = Instance.new("Folder")

                            local highlight = Instance.new("Highlight")
                            highlight.FillColor = Color3.fromRGB(255, 150, 0)
                            highlight.FillTransparency = 0.5
                            highlight.Adornee = obj
                            highlight.Parent = folder

                            local bb = Instance.new("BillboardGui")
                            bb.Size = UDim2.new(0, 200, 0, 50)
                            bb.AlwaysOnTop = true
                            bb.StudsOffset = Vector3.new(0, 2, 0)
                            bb.Adornee = targetPart
                            bb.Parent = folder

                            local lbl = Instance.new("TextLabel")
                            lbl.Size = UDim2.new(1, 0, 1, 0)
                            lbl.BackgroundTransparency = 1
                            lbl.TextColor3 = Color3.fromRGB(255, 150, 0)
                            lbl.TextStrokeTransparency = 0
                            lbl.Font = Enum.Font.SourceSansBold
                            lbl.TextSize = 18
                            lbl.Parent = bb

                            folder.Parent = targetPart
                            activeLockBoxes[uniqueKey] = folder
                        end

                        local f = activeLockBoxes[uniqueKey]
                        local label = f:FindFirstChildOfClass("BillboardGui"):FindFirstChildOfClass("TextLabel")
                        label.Text = "LockBox\n[studs: " .. tostring(getDistance(targetPart)) .. "]"
                    end
                end
            end
        end
        for k, f in pairs(activeLockBoxes) do
            if not currentValid[k] then f:Destroy() activeLockBoxes[k] = nil end
        end
    else
        clearCache(activeLockBoxes)
    end

    -- ESP UnLockBox
    if EspStates.UnLockBox and currentRooms then
        local currentValid = {}
        for _, room in pairs(currentRooms:GetChildren()) do
            for _, obj in pairs(room:GetDescendants()) do
                if obj.Name == "ChestBox" then
                    local targetPart = obj:FindFirstChild("Main") or obj:IsA("BasePart") and obj or obj:FindFirstChildWithClass("BasePart")
                    if targetPart then
                        local uniqueKey = obj:GetDebugId()
                        currentValid[uniqueKey] = true

                        if not activeUnLockBoxes[uniqueKey] then
                            local folder = Instance.new("Folder")

                            local highlight = Instance.new("Highlight")
                            highlight.FillColor = Color3.fromRGB(0, 200, 255)
                            highlight.FillTransparency = 0.5
                            highlight.Adornee = obj
                            highlight.Parent = folder

                            local bb = Instance.new("BillboardGui")
                            bb.Size = UDim2.new(0, 200, 0, 50)
                            bb.AlwaysOnTop = true
                            bb.StudsOffset = Vector3.new(0, 2, 0)
                            bb.Adornee = targetPart
                            bb.Parent = folder

                            local lbl = Instance.new("TextLabel")
                            lbl.Size = UDim2.new(1, 0, 1, 0)
                            lbl.BackgroundTransparency = 1
                            lbl.TextColor3 = Color3.fromRGB(0, 200, 255)
                            lbl.TextStrokeTransparency = 0
                            lbl.Font = Enum.Font.SourceSansBold
                            lbl.TextSize = 18
                            lbl.Parent = bb

                            folder.Parent = targetPart
                            activeUnLockBoxes[uniqueKey] = folder
                        end

                        local f = activeUnLockBoxes[uniqueKey]
                        local label = f:FindFirstChildOfClass("BillboardGui"):FindFirstChildOfClass("TextLabel")
                        label.Text = "OpenBox\n[studs: " .. tostring(getDistance(targetPart)) .. "]"
                    end
                end
            end
        end
        for k, f in pairs(activeUnLockBoxes) do
            if not currentValid[k] then f:Destroy() activeUnLockBoxes[k] = nil end
        end
    else
        clearCache(activeUnLockBoxes)
    end

    -- ESP Chest
    if EspStates.Chest and currentRooms then
        local currentValid = {}
        for _, room in pairs(currentRooms:GetChildren()) do
            for _, obj in pairs(room:GetDescendants()) do
                if obj.Name == "GoldPile" then
                    local targetPart = obj:FindFirstChild("Hitbox") or obj:IsA("BasePart") and obj or obj:FindFirstChildWithClass("BasePart")
                    if targetPart then
                        local uniqueKey = obj:GetDebugId()
                        currentValid[uniqueKey] = true

                        if not activeChests[uniqueKey] then
                            local folder = Instance.new("Folder")

                            local highlight = Instance.new("Highlight")
                            highlight.FillColor = Color3.fromRGB(255, 235, 0)
                            highlight.FillTransparency = 0.5
                            highlight.Adornee = obj
                            highlight.Parent = folder

                            local bb = Instance.new("BillboardGui")
                            bb.Size = UDim2.new(0, 200, 0, 50)
                            bb.AlwaysOnTop = true
                            bb.StudsOffset = Vector3.new(0, 2, 0)
                            bb.Adornee = targetPart
                            bb.Parent = folder

                            local lbl = Instance.new("TextLabel")
                            lbl.Size = UDim2.new(1, 0, 1, 0)
                            lbl.BackgroundTransparency = 1
                            lbl.TextColor3 = Color3.fromRGB(255, 235, 0)
                            lbl.TextStrokeTransparency = 0
                            lbl.Font = Enum.Font.SourceSansBold
                            lbl.TextSize = 18
                            lbl.Parent = bb

                            folder.Parent = targetPart
                            activeChests[uniqueKey] = folder
                        end

                        local f = activeChests[uniqueKey]
                        local label = f:FindFirstChildOfClass("BillboardGui"):FindFirstChildOfClass("TextLabel")
                        label.Text = "Chest\n[studs: " .. tostring(getDistance(targetPart)) .. "]"
                    end
                end
            end
        end
        for k, f in pairs(activeChests) do
            if not currentValid[k] then f:Destroy() activeChests[k] = nil end
        end
    else
        clearCache(activeChests)
    end

    -- ESP Book
    if EspStates.Book and currentRooms then
        if tick() - lastBookCheck >= 2 then
            lastBookCheck = tick()
            local room50 = currentRooms:FindFirstChild("50")
            local currentValid = {}

            if room50 then
                for _, obj in pairs(room50:GetDescendants()) do
                    if obj.Name == "LiveHintBook" and obj:FindFirstChild("Base") then
                        local bookBase = obj.Base
                        if bookBase:IsA("BasePart") then
                            local uniqueKey = bookBase:GetDebugId()
                            currentValid[uniqueKey] = true

                            if not activeBooks[uniqueKey] then
                                local folder = Instance.new("Folder")

                                local highlight = Instance.new("Highlight")
                                highlight.FillColor = Color3.fromRGB(0, 255, 255)
                                highlight.FillTransparency = 0.5
                                highlight.Adornee = obj
                                highlight.Parent = folder

                                local bb = Instance.new("BillboardGui")
                                bb.Size = UDim2.new(0, 200, 0, 50)
                                bb.AlwaysOnTop = true
                                bb.StudsOffset = Vector3.new(0, 2, 0)
                                bb.Adornee = bookBase
                                bb.Parent = folder

                                local lbl = Instance.new("TextLabel")
                                lbl.Size = UDim2.new(1, 0, 1, 0)
                                lbl.BackgroundTransparency = 1
                                lbl.TextColor3 = Color3.fromRGB(0, 255, 255)
                                lbl.TextStrokeTransparency = 0
                                lbl.Font = Enum.Font.SourceSansBold
                                lbl.TextSize = 18
                                lbl.Parent = bb

                                folder.Parent = bookBase
                                activeBooks[uniqueKey] = folder
                            end

                            local f = activeBooks[uniqueKey]
                            local label = f:FindFirstChildOfClass("BillboardGui"):FindFirstChildOfClass("TextLabel")
                            label.Text = "book\n[studs: " .. tostring(getDistance(bookBase)) .. "]"
                        end
                    end
                end
            end

            for k, f in pairs(activeBooks) do
                if not currentValid[k] then f:Destroy() activeBooks[k] = nil end
            end
        else
            for _, f in pairs(activeBooks) do
                if f and f.Parent and f.Parent:IsA("BasePart") then
                    local label = f:FindFirstChildOfClass("BillboardGui"):FindFirstChildOfClass("TextLabel")
                    if label then
                        label.Text = "book\n[studs: " .. tostring(getDistance(f.Parent)) .. "]"
                    end
                end
            end
        end
    else
        clearCache(activeBooks)
    end
end)
