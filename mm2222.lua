--[[
	VOID HUB ULTRA - FINAL
]]

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local VirtualInput = game:GetService("VirtualInputManager")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VoidHub_Ultra"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Size = UDim2.new(0, 400, 0, 430)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 8)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "Void Hub Ultra"
Title.Size = UDim2.new(0, 150, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.TextXAlignment = "Left"
Title.Font = Enum.Font.GothamBold

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Text = "×"
CloseBtn.Size = UDim2.new(0, 30, 1, 0)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Text = "<"
MinBtn.Size = UDim2.new(0, 30, 1, 0)
MinBtn.Position = UDim2.new(1, -65, 0, 0)
MinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinBtn.TextColor3 = Color3.new(1, 1, 1)

local LeftPanel = Instance.new("Frame", MainFrame)
LeftPanel.Size = UDim2.new(0, 80, 1, -30)
LeftPanel.Position = UDim2.new(0, 0, 0, 30)
LeftPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, -90, 1, -40)
ContentFrame.Position = UDim2.new(0, 85, 0, 35)
ContentFrame.BackgroundTransparency = 1

-- Логика сворачивания
local isMin = false
MinBtn.MouseButton1Click:Connect(function()
    isMin = not isMin
    LeftPanel.Visible = not isMin
    ContentFrame.Visible = not isMin
    MainFrame:TweenSize(isMin and UDim2.new(0, 400, 0, 30) or UDim2.new(0, 400, 0, 430), "Out", "Quad", 0.1, true)
    MinBtn.Text = isMin and ">" or "<"
end)

-- Страницы
local InfoPage = Instance.new("ScrollingFrame", ContentFrame)
InfoPage.Size = UDim2.new(1, 0, 1, 0)
InfoPage.BackgroundTransparency = 1
InfoPage.CanvasSize = UDim2.new(0, 0, 0, 0)
InfoPage.ScrollBarThickness = 4

local EspPage = Instance.new("ScrollingFrame", ContentFrame)
EspPage.Size = UDim2.new(1, 0, 1, 0)
EspPage.BackgroundTransparency = 1
EspPage.Visible = false
EspPage.CanvasSize = UDim2.new(0, 0, 0, 0)
EspPage.ScrollBarThickness = 4

local AutoPage = Instance.new("ScrollingFrame", ContentFrame)
AutoPage.Size = UDim2.new(1, 0, 1, 0)
AutoPage.BackgroundTransparency = 1
AutoPage.Visible = false
AutoPage.CanvasSize = UDim2.new(0, 0, 0, 0)
AutoPage.ScrollBarThickness = 4

local TeleportPage = Instance.new("ScrollingFrame", ContentFrame)
TeleportPage.Size = UDim2.new(1, 0, 1, 0)
TeleportPage.BackgroundTransparency = 1
TeleportPage.Visible = false
TeleportPage.CanvasSize = UDim2.new(0, 0, 0, 0)
TeleportPage.ScrollBarThickness = 4

local InfinityPage = Instance.new("ScrollingFrame", ContentFrame)
InfinityPage.Size = UDim2.new(1, 0, 1, 0)
InfinityPage.BackgroundTransparency = 1
InfinityPage.Visible = false
InfinityPage.CanvasSize = UDim2.new(0, 0, 0, 0)
InfinityPage.ScrollBarThickness = 4

local ScriptsPage = Instance.new("ScrollingFrame", ContentFrame)
ScriptsPage.Size = UDim2.new(1, 0, 1, 0)
ScriptsPage.BackgroundTransparency = 1
ScriptsPage.Visible = false
ScriptsPage.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptsPage.ScrollBarThickness = 4

local SettingsPage = Instance.new("ScrollingFrame", ContentFrame)
SettingsPage.Size = UDim2.new(1, 0, 1, 0)
SettingsPage.BackgroundTransparency = 1
SettingsPage.Visible = false
SettingsPage.CanvasSize = UDim2.new(0, 0, 0, 0)
SettingsPage.ScrollBarThickness = 4

-- Layout для страниц
local function setupLayout(page)
    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 5)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)
end
setupLayout(InfoPage)
setupLayout(EspPage)
setupLayout(AutoPage)
setupLayout(TeleportPage)
setupLayout(InfinityPage)
setupLayout(ScriptsPage)
setupLayout(SettingsPage)

-- Переключение вкладок
local function showPage(p)
    InfoPage.Visible = (p == "info")
    EspPage.Visible = (p == "esp")
    AutoPage.Visible = (p == "auto")
    TeleportPage.Visible = (p == "teleport")
    InfinityPage.Visible = (p == "infinity")
    ScriptsPage.Visible = (p == "scripts")
    SettingsPage.Visible = (p == "settings")
end

local b1 = Instance.new("TextButton", LeftPanel)
b1.Size = UDim2.new(1,0,0,30); b1.Text = "Info"
b1.MouseButton1Click:Connect(function() showPage("info") end)

local b2 = Instance.new("TextButton", LeftPanel)
b2.Size = UDim2.new(1,0,0,30); b2.Position = UDim2.new(0,0,0,35); b2.Text = "Esp"
b2.MouseButton1Click:Connect(function() showPage("esp") end)

local b3 = Instance.new("TextButton", LeftPanel)
b3.Size = UDim2.new(1,0,0,30); b3.Position = UDim2.new(0,0,0,70); b3.Text = "Auto"
b3.MouseButton1Click:Connect(function() showPage("auto") end)

local b4 = Instance.new("TextButton", LeftPanel)
b4.Size = UDim2.new(1,0,0,30); b4.Position = UDim2.new(0,0,0,105); b4.Text = "Teleport"
b4.MouseButton1Click:Connect(function() showPage("teleport") end)

local b5 = Instance.new("TextButton", LeftPanel)
b5.Size = UDim2.new(1,0,0,30); b5.Position = UDim2.new(0,0,0,140); b5.Text = "Infinity"
b5.MouseButton1Click:Connect(function() showPage("infinity") end)

local b6 = Instance.new("TextButton", LeftPanel)
b6.Size = UDim2.new(1,0,0,30); b6.Position = UDim2.new(0,0,0,175); b6.Text = "Scripts"
b6.MouseButton1Click:Connect(function() showPage("scripts") end)

local b7 = Instance.new("TextButton", LeftPanel)
b7.Size = UDim2.new(1,0,0,30); b7.Position = UDim2.new(0,0,0,210); b7.Text = "Settings"
b7.MouseButton1Click:Connect(function() showPage("settings") end)

-- Функция создания кнопки
local function createBtn(txt, parent, callback, color)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -10, 0, 35)
    b.Text = txt
    b.BackgroundColor3 = color or Color3.fromRGB(45, 45, 45)
    b.TextColor3 = Color3.new(1, 1, 1)
    local corner = Instance.new("UICorner", b)
    corner.CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(callback)
    return b
end

-- Функция создания кнопки-переключателя
local function createToggle(txt, parent, callback, colorOn)
    local state = false
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -10, 0, 35)
    b.Text = txt .. " OFF"
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    b.TextColor3 = Color3.new(1, 1, 1)
    local corner = Instance.new("UICorner", b)
    corner.CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = txt .. (state and " ON" or " OFF")
        b.BackgroundColor3 = state and (colorOn or Color3.fromRGB(0, 150, 0)) or Color3.fromRGB(45, 45, 45)
        callback(state)
    end)
    return b
end

-- INFO PAGE
local infoText = Instance.new("TextLabel", InfoPage)
infoText.Size = UDim2.new(1, -10, 0, 80)
infoText.Text = "VOID HUB ULTRA\n\nCreated by xXram000dieXx\nVersion 3.8 FINAL"
infoText.TextColor3 = Color3.new(1, 1, 1)
infoText.BackgroundTransparency = 1
infoText.TextWrapped = true
infoText.Font = Enum.Font.GothamBold

-- Конфиг и переменные
local cfg = {Murder = false, Sheriff = false, Innocent = false, GunEsp = false, NameEsp = false}
local autoGunState = false
local murderKillState = false
local killAllState = false
local oldPos = nil
local isTeleporting = false
local originalPos = nil
local rainbowConnection = nil
local noclipConnection = nil

-- Функция для создания Name ESP
local function updateNameEsp()
    for _, p in pairs(Players:GetPlayers()) do
        if p == Players.LocalPlayer then continue end
        local char = p.Character
        if char and char:FindFirstChild("Head") then
            local head = char.Head
            local billboard = head:FindFirstChild("NameEsp")
            
            if cfg.NameEsp then
                if not billboard then
                    billboard = Instance.new("BillboardGui")
                    billboard.Name = "NameEsp"
                    billboard.Size = UDim2.new(0, 200, 0, 40)
                    billboard.StudsOffset = Vector3.new(0, 2, 0)
                    billboard.AlwaysOnTop = true
                    billboard.Parent = head
                    
                    local text = Instance.new("TextLabel")
                    text.Name = "Text"
                    text.Size = UDim2.new(1, 0, 1, 0)
                    text.BackgroundTransparency = 1
                    text.TextColor3 = Color3.fromRGB(255, 255, 255)
                    text.TextStrokeTransparency = 0.5
                    text.Font = Enum.Font.GothamBold
                    text.TextSize = 14
                    text.Text = p.Name
                    text.Parent = billboard
                    
                    local hasK = char:FindFirstChild("Knife") or (p.Backpack and p.Backpack:FindFirstChild("Knife"))
                    local hasG = char:FindFirstChild("Gun") or (p.Backpack and p.Backpack:FindFirstChild("Gun"))
                    
                    if hasK then
                        text.TextColor3 = Color3.fromRGB(255, 0, 0)
                    elseif hasG then
                        text.TextColor3 = Color3.fromRGB(0, 100, 255)
                    else
                        text.TextColor3 = Color3.fromRGB(0, 255, 0)
                    end
                else
                    local text = billboard:FindFirstChild("Text")
                    if text then
                        local hasK = char:FindFirstChild("Knife") or (p.Backpack and p.Backpack:FindFirstChild("Knife"))
                        local hasG = char:FindFirstChild("Gun") or (p.Backpack and p.Backpack:FindFirstChild("Gun"))
                        
                        if hasK then
                            text.TextColor3 = Color3.fromRGB(255, 0, 0)
                        elseif hasG then
                            text.TextColor3 = Color3.fromRGB(0, 100, 255)
                        else
                            text.TextColor3 = Color3.fromRGB(0, 255, 0)
                        end
                        text.Text = p.Name
                    end
                end
            else
                if billboard then
                    billboard:Destroy()
                end
            end
        end
    end
end

-- ESP PAGE
createToggle("Esp Murder", EspPage, function(s) cfg.Murder = s end, Color3.fromRGB(200, 0, 0))
createToggle("Esp Sheriff", EspPage, function(s) cfg.Sheriff = s end, Color3.fromRGB(0, 100, 255))
createToggle("Esp Innocent", EspPage, function(s) cfg.Innocent = s end, Color3.fromRGB(0, 200, 0))
createToggle("Esp GunDrop", EspPage, function(s) cfg.GunEsp = s end, Color3.fromRGB(200, 0, 255))
createToggle("Esp Name Items", EspPage, function(s) 
    cfg.NameEsp = s
    if not s then
        for _, p in pairs(Players:GetPlayers()) do
            local char = p.Character
            if char and char:FindFirstChild("Head") then
                local bill = char.Head:FindFirstChild("NameEsp")
                if bill then bill:Destroy() end
            end
        end
    end
end, Color3.fromRGB(255, 200, 0))

-- AUTO PAGE
createToggle("Auto GunDrop", AutoPage, function(s) autoGunState = s end, Color3.fromRGB(150, 100, 0))

-- Auto murder kill (с проверкой жив ли мурдер)
createToggle("Auto murder kill", AutoPage, function(s)
    murderKillState = s
    if s then
        task.spawn(function()
            local gunTaken = false
            local gunTool = nil
            
            while murderKillState do
                local lp = Players.LocalPlayer
                local char = lp.Character
                if not char then task.wait(1) continue end
                
                -- Берем пистолет ОДИН РАЗ
                if not gunTaken then
                    if lp.Backpack then
                        for _, tool in pairs(lp.Backpack:GetChildren()) do
                            if tool.Name:lower():find("gun") or tool.Name:lower():find("pistol") or tool.Name:lower():find("revolver") then
                                gunTool = tool
                                break
                            end
                        end
                    end
                    
                    if gunTool then
                        gunTool.Parent = char
                        gunTaken = true
                        task.wait(0.5)
                    else
                        task.wait(1)
                        continue
                    end
                end
                
                -- Ищем живого Murder
                local murder = nil
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= lp and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                        local hasKnife = p.Character:FindFirstChild("Knife") or (p.Backpack and p.Backpack:FindFirstChild("Knife"))
                        if hasKnife then
                            murder = p
                            break
                        end
                    end
                end
                
                if murder and murder.Character and murder.Character:FindFirstChild("HumanoidRootPart") then
                    local murderHrp = murder.Character.HumanoidRootPart
                    local myHrp = char:FindFirstChild("HumanoidRootPart")
                    if myHrp then
                        -- Сохраняем позицию
                        originalPos = myHrp.CFrame
                        
                        -- Телепорт сзади мурдера
                        local behindPos = murderHrp.CFrame * CFrame.new(0, 0, 5)
                        myHrp.CFrame = behindPos
                        task.wait(0.3)
                        
                        -- Стреляем
                        local gun = char:FindFirstChildWhichIsA("Tool")
                        if gun and gun:FindFirstChild("Shoot") then
                            local shootEvent = gun:FindFirstChild("Shoot")
                            if shootEvent:IsA("RemoteEvent") then
                                -- Стреляем пока мурдер жив
                                local shootCount = 0
                                while murderKillState and murder and murder.Character and murder.Character:FindFirstChild("Humanoid") and murder.Character.Humanoid.Health > 0 and shootCount < 10 do
                                    local targetPos = murder.Character.HumanoidRootPart.CFrame
                                    local myPos = myHrp.CFrame
                                    local args = { targetPos, myPos }
                                    shootEvent:FireServer(unpack(args))
                                    shootCount = shootCount + 1
                                    task.wait(0.5)
                                end
                            end
                        end
                        
                        task.wait(0.5)
                        
                        -- Возвращаемся на место
                        if originalPos and char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = originalPos
                        end
                    end
                end
                task.wait(1)
            end
        end)
    end
end, Color3.fromRGB(200, 50, 50))

-- Auto kill all (только bring, без кликов)
createToggle("Auto kill all", AutoPage, function(s)
    killAllState = s
    if s then
        noclipConnection = RunService.Stepped:Connect(function()
            local char = Players.LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        
        task.spawn(function()
            while killAllState do
                local lp = Players.LocalPlayer
                local char = lp.Character
                if not char then task.wait(1) continue end
                
                local myHrp = char:FindFirstChild("HumanoidRootPart")
                if not myHrp then task.wait(1) continue end
                
                -- Притягиваем всех прямо перед собой
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= lp and p.Character then
                        local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            hrp.CFrame = myHrp.CFrame * CFrame.new(0, 0, 2)
                        end
                    end
                end
                
                task.wait(2)
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        local char = Players.LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end, Color3.fromRGB(150, 0, 0))

-- TELEPORT PAGE
createBtn("TP Random Innocent", TeleportPage, function()
    local lp = Players.LocalPlayer
    local innocents = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local hasK = p.Character:FindFirstChild("Knife") or (p.Backpack and p.Backpack:FindFirstChild("Knife"))
            local hasG = p.Character:FindFirstChild("Gun") or (p.Backpack and p.Backpack:FindFirstChild("Gun"))
            if not hasK and not hasG then
                table.insert(innocents, p)
            end
        end
    end
    if #innocents > 0 then
        local target = innocents[math.random(1, #innocents)]
        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            lp.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 3)
        end
    end
end, Color3.fromRGB(0, 150, 0))

createBtn("TP Murder", TeleportPage, function()
    local lp = Players.LocalPlayer
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local hasKnife = p.Character:FindFirstChild("Knife") or (p.Backpack and p.Backpack:FindFirstChild("Knife"))
            if hasKnife then
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    lp.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 3)
                end
                break
            end
        end
    end
end, Color3.fromRGB(200, 0, 0))

createBtn("TP Sheriff", TeleportPage, function()
    local lp = Players.LocalPlayer
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local hasGun = p.Character:FindFirstChild("Gun") or (p.Backpack and p.Backpack:FindFirstChild("Gun"))
            if hasGun then
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    lp.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 3)
                end
                break
            end
        end
    end
end, Color3.fromRGB(0, 100, 255))

-- INFINITY PAGE
createBtn("Kill Murder", InfinityPage, function()
    local lp = Players.LocalPlayer
    local char = lp.Character
    if not char then return end
    
    -- Берем пистолет один раз
    local gunTool = nil
    if lp.Backpack then
        for _, tool in pairs(lp.Backpack:GetChildren()) do
            if tool.Name:lower():find("gun") or tool.Name:lower():find("pistol") or tool.Name:lower():find("revolver") then
                gunTool = tool
                break
            end
        end
    end
    
    if not gunTool then return end
    
    if gunTool.Parent == lp.Backpack then
        gunTool.Parent = char
        task.wait(0.3)
    end
    
    -- Ищем Murder
    local murder = nil
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local hasKnife = p.Character:FindFirstChild("Knife") or (p.Backpack and p.Backpack:FindFirstChild("Knife"))
            if hasKnife then
                murder = p
                break
            end
        end
    end
    
    if murder and murder.Character and murder.Character:FindFirstChild("HumanoidRootPart") then
        local murderHrp = murder.Character.HumanoidRootPart
        local myHrp = char:FindFirstChild("HumanoidRootPart")
        if myHrp then
            -- Сохраняем позицию
            local myPos = myHrp.CFrame
            
            -- Телепорт сзади мурдера (в живот)
            local behindPos = murderHrp.CFrame * CFrame.new(0, -1, 3)
            myHrp.CFrame = behindPos
            task.wait(0.3)
            
            -- Стреляем 3 раза в живот
            local gun = char:FindFirstChildWhichIsA("Tool")
            if gun and gun:FindFirstChild("Shoot") then
                local shootEvent = gun:FindFirstChild("Shoot")
                if shootEvent:IsA("RemoteEvent") then
                    for i = 1, 3 do
                        if not murder or not murder.Character or not murder.Character:FindFirstChild("HumanoidRootPart") then break end
                        local targetPos = murder.Character.HumanoidRootPart.CFrame
                        local args = { targetPos, targetPos }
                        shootEvent:FireServer(unpack(args))
                        task.wait(0.3)
                    end
                end
            end
            
            task.wait(0.5)
            
            -- Возвращаемся
            if myPos and char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = myPos
            end
        end
    end
end, Color3.fromRGB(255, 100, 0))

createBtn("Kill All", InfinityPage, function()
    local lp = Players.LocalPlayer
    local char = lp.Character
    if not char then return
    
    local myHrp = char:FindFirstChild("HumanoidRootPart")
    if not myHrp then return end
    
    -- Притягиваем всех прямо перед собой
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = myHrp.CFrame * CFrame.new(0, 0, 2)
            end
        end
    end
end, Color3.fromRGB(200, 50, 0))

-- SCRIPTS PAGE
createBtn("Invisible Script", ScriptsPage, function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-invisible-script-138580"))()
end, Color3.fromRGB(100, 50, 200))

-- SETTINGS PAGE
local colorFrame = Instance.new("Frame", SettingsPage)
colorFrame.Size = UDim2.new(1, -10, 0, 100)
colorFrame.BackgroundTransparency = 1

local colorTitle = Instance.new("TextLabel", colorFrame)
colorTitle.Size = UDim2.new(1, 0, 0, 25)
colorTitle.Text = "Цвета GUI"
colorTitle.TextColor3 = Color3.new(1, 1, 1)
colorTitle.BackgroundTransparency = 1
colorTitle.Font = Enum.Font.GothamBold

local function changeGuiColor(color)
    if rainbowConnection then
        rainbowConnection:Disconnect()
        rainbowConnection = nil
    end
    MainFrame.BackgroundColor3 = color
    TopBar.BackgroundColor3 = color:lerp(Color3.new(0, 0, 0), 0.2)
    LeftPanel.BackgroundColor3 = color:lerp(Color3.new(0, 0, 0), 0.3)
end

local colors = {
    {"Standard", Color3.fromRGB(20, 20, 20)},
    {"Red", Color3.fromRGB(100, 30, 30)},
    {"Green", Color3.fromRGB(30, 80, 40)},
    {"Black", Color3.fromRGB(5, 5, 5)},
    {"Yellow", Color3.fromRGB(100, 100, 30)},
    {"Purple", Color3.fromRGB(70, 30, 100)},
    {"Blue", Color3.fromRGB(30, 30, 100)},
    {"LightBlue", Color3.fromRGB(30, 100, 120)}
}

local function createColorButton(name, color, x, y)
    local btn = Instance.new("TextButton", colorFrame)
    btn.Size = UDim2.new(0.23, -2, 0, 30)
    btn.Position = UDim2.new(x, 0, y, 0)
    btn.Text = name
    btn.BackgroundColor3 = color
    btn.TextColor3 = (name == "Yellow") and Color3.fromRGB(0, 0, 0) or Color3.new(1, 1, 1)
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function() changeGuiColor(color) end)
end

createColorButton("Standard", Color3.fromRGB(20, 20, 20), 0, 0.35)
createColorButton("Red", Color3.fromRGB(100, 30, 30), 0.26, 0.35)
createColorButton("Green", Color3.fromRGB(30, 80, 40), 0.52, 0.35)
createColorButton("Black", Color3.fromRGB(5, 5, 5), 0.78, 0.35)
createColorButton("Yellow", Color3.fromRGB(100, 100, 30), 0, 0.7)
createColorButton("Purple", Color3.fromRGB(70, 30, 100), 0.26, 0.7)
createColorButton("Blue", Color3.fromRGB(30, 30, 100), 0.52, 0.7)
createColorButton("LBlue", Color3.fromRGB(30, 100, 120), 0.78, 0.7)

createBtn("RAINBOW MODE", SettingsPage, function()
    if rainbowConnection then
        rainbowConnection:Disconnect()
        rainbowConnection = nil
        changeGuiColor(Color3.fromRGB(20, 20, 20))
    else
        rainbowConnection = RunService.RenderStepped:Connect(function()
            local hue = tick() % 5 / 5
            local color = Color3.fromHSV(hue, 0.7, 0.6)
            MainFrame.BackgroundColor3 = color
            TopBar.BackgroundColor3 = color:lerp(Color3.new(0, 0, 0), 0.2)
            LeftPanel.BackgroundColor3 = color:lerp(Color3.new(0, 0, 0), 0.3)
        end)
    end
end, Color3.fromRGB(150, 50, 150))

-- Изменение названия GUI
local nameFrame = Instance.new("Frame", SettingsPage)
nameFrame.Size = UDim2.new(1, -10, 0, 70)
nameFrame.BackgroundTransparency = 1

local nameTitle = Instance.new("TextLabel", nameFrame)
nameTitle.Size = UDim2.new(1, 0, 0, 25)
nameTitle.Text = "Название GUI"
nameTitle.TextColor3 = Color3.new(1, 1, 1)
nameTitle.BackgroundTransparency = 1
nameTitle.Font = Enum.Font.GothamBold

local nameBox = Instance.new("TextBox", nameFrame)
nameBox.Size = UDim2.new(0.7, 0, 0, 30)
nameBox.Position = UDim2.new(0, 0, 0, 30)
nameBox.PlaceholderText = "Void Hub Ultra"
nameBox.Text = "Void Hub Ultra"
nameBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
nameBox.TextColor3 = Color3.new(1, 1, 1)
local boxCorner = Instance.new("UICorner", nameBox)
boxCorner.CornerRadius = UDim.new(0, 6)

local applyBtn = Instance.new("TextButton", nameFrame)
applyBtn.Size = UDim2.new(0.25, -5, 0, 30)
applyBtn.Position = UDim2.new(0.75, 0, 0, 30)
applyBtn.Text = "Применить"
applyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
applyBtn.TextColor3 = Color3.new(1, 1, 1)
local btnCorner = Instance.new("UICorner", applyBtn)
btnCorner.CornerRadius = UDim.new(0, 6)

applyBtn.MouseButton1Click:Connect(function()
    local newName = nameBox.Text
    if newName ~= "" then
        Title.Text = newName
    end
end)

-- Главный цикл
RunService.RenderStepped:Connect(function()
    local lp = Players.LocalPlayer
    local char = lp.Character
    
    for _, p in pairs(Players:GetPlayers()) do
        if p == lp then continue end
        local pChar = p.Character
        if pChar and pChar:FindFirstChild("HumanoidRootPart") then
            local high = pChar:FindFirstChild("VoidEsp") or Instance.new("Highlight", pChar)
            high.Name = "VoidEsp"
            
            local hasK = pChar:FindFirstChild("Knife") or (p.Backpack and p.Backpack:FindFirstChild("Knife"))
            local hasG = pChar:FindFirstChild("Gun") or (p.Backpack and p.Backpack:FindFirstChild("Gun"))
            
            local color = nil
            if cfg.Murder and hasK then color = Color3.fromRGB(255, 0, 0)
            elseif cfg.Sheriff and hasG then color = Color3.fromRGB(0, 100, 255)
            elseif cfg.Innocent and not hasK and not hasG then color = Color3.fromRGB(0, 255, 0) end
            
            high.Enabled = (color ~= nil)
            if color then high.FillColor = color end
        end
    end
    
    updateNameEsp()

    local gun = workspace:FindFirstChild("GunDrop", true)
    if gun and gun:IsA("BasePart") then
        local gHigh = gun:FindFirstChild("GunHigh") or Instance.new("Highlight", gun)
        gHigh.Name = "GunHigh"
        gHigh.FillColor = Color3.fromRGB(200, 0, 255)
        gHigh.Enabled = cfg.GunEsp
        
        if autoGunState and char and char:FindFirstChild("HumanoidRootPart") then
            if not isTeleporting then
                oldPos = char.HumanoidRootPart.CFrame
                isTeleporting = true
            end
            char.HumanoidRootPart.CFrame = gun.CFrame
        end
    else
        if isTeleporting and oldPos and char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = oldPos
            isTeleporting = false
            oldPos = nil
        end
    end
end)

print("Void Hub Ultra Loaded!")
