
-- Void Hub Fixed + Auto-Refresh (UI Fix)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

if CoreGui:FindFirstChild("VoidHub") then CoreGui.VoidHub:Destroy() end

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "VoidHub"

-- Hauptfenster
local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 400, 0, 280)
Main.Position = UDim2.new(0.5, -200, 0.5, -140)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true

-- Obere Leiste
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1, 0, 0, 25)
Top.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Top.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Top)
Title.Text = "  Void Hub"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

local Close = Instance.new("TextButton", Top)
Close.Text = "×"
Close.Size = UDim2.new(0, 25, 0, 25)
Close.Position = UDim2.new(1, -25, 0, 0)
Close.BackgroundTransparency = 1
Close.TextColor3 = Color3.fromRGB(255, 50, 50)
Close.TextSize = 20
Close.MouseButton1Click:Connect(function() Screen:Destroy() end)

local Minimize = Instance.new("TextButton", Top)
Minimize.Text = "<"
Minimize.Size = UDim2.new(0, 25, 0, 25)
Minimize.Position = UDim2.new(1, -50, 0, 0)
Minimize.BackgroundTransparency = 1
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.TextSize = 18

-- Sidebar & Container
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 100, 1, -25)
Sidebar.Position = UDim2.new(0, 0, 0, 25)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Sidebar.BorderSizePixel = 0

local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -100, 1, -25)
Container.Position = UDim2.new(0, 100, 0, 25)
Container.BackgroundTransparency = 1

local Minimized = false
Minimize.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    if Minimized then
        Main:TweenSize(UDim2.new(0, 400, 0, 25), "Out", "Quad", 0.2, true)
        Minimize.Text = ">"
    else
        Main:TweenSize(UDim2.new(0, 400, 0, 280), "Out", "Quad", 0.2, true)
        Minimize.Text = "<"
    end
end)

local Pages = {}
local Buttons = {}

local function CreateTab(name, color)
    local p = Instance.new("ScrollingFrame", Container)
    p.Size = UDim2.new(1, -10, 1, -10)
    p.Position = UDim2.new(0, 5, 0, 5)
    p.Visible = false
    p.BackgroundTransparency = 1
    p.ScrollBarThickness = 2
    p.CanvasSize = UDim2.new(0,0,0,0)

    local layout = Instance.new("UIListLayout", p)
    layout.Padding = UDim.new(0, 5)

    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Position = UDim2.new(0, 0, 0, #Buttons * 35)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 11

    btn.MouseButton1Click:Connect(function()
        for _, pg in pairs(Pages) do pg.Visible = false end
        for _, b in pairs(Buttons) do
            b.TextColor3 = Color3.fromRGB(150, 150, 150)
            b.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        end
        p.Visible = true
        btn.TextColor3 = Color3.new(1,1,1)
        btn.BackgroundColor3 = color
    end)

    table.insert(Pages, p)
    table.insert(Buttons, btn)
    return p
end

-- Tabs erstellen
local TabEsp = CreateTab("Esp", Color3.fromRGB(40, 40, 100))
local TabKeys = CreateTab("Grab Keys", Color3.fromRGB(100, 40, 40))
local TabDoors = CreateTab("Door TP", Color3.fromRGB(40, 100, 40))
local TabItems = CreateTab("Items Grab", Color3.fromRGB(100, 100, 40))
local TabPapers = CreateTab("Grab Papers", Color3.fromRGB(100, 50, 150))
local TabFaul = CreateTab("Faul_Grab", Color3.fromRGB(50, 100, 150))

-- ESP Logik
local espState = {items = false, keys = false, locust = false, papers = false, faul = false}

local function ApplyEsp(obj, customName)
    if not obj or obj:FindFirstChild("VoidTag") then return end
    local bg = Instance.new("BillboardGui", obj)
    bg.Name = "VoidTag"
    bg.AlwaysOnTop = true
    bg.Size = UDim2.new(0, 100, 0, 30)
    bg.Enabled = false

    local txt = Instance.new("TextLabel", bg)
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.TextColor3 = Color3.new(1,1,1)
    txt.TextStrokeTransparency = 0
    txt.TextSize = 12

    local displayName = customName or obj.Name

    local conn
    conn = RunService.Stepped:Connect(function()
        if not obj.Parent then conn:Disconnect() return end
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            local pos = obj:IsA("Model") and (obj.PrimaryPart and obj.PrimaryPart.Position or obj:GetModelCFrame().p) or (obj:IsA("BasePart") and obj.Position or Vector3.new(0,0,0))
            local dist = math.floor((LP.Character.HumanoidRootPart.Position - pos).Magnitude)
            txt.Text = displayName .. "\n[studs: " .. dist .. "]"
        end
    end)
    return bg
end

local function SetupEspFolder(folderName, stateKey)
    task.spawn(function()
        local folder = workspace:WaitForChild(folderName, 5)
        if folder then
            folder.ChildAdded:Connect(function(child)
                local tag = ApplyEsp(child)
                if tag then tag.Enabled = espState[stateKey] end
            end)
            for _, x in pairs(folder:GetChildren()) do ApplyEsp(x) end
        end
    end)
end

SetupEspFolder("ActiveEquipments", "items")
SetupEspFolder("ActiveKeys", "keys")
SetupEspFolder("ActivePapers", "papers")
SetupEspFolder("ActiveFuel", "faul")

-- Locust ESP Setup (Modified to include PlayerBlackLocust)
task.spawn(function()
    while task.wait(2) do
        local targets = {"BlackLocust", "PlayerBlackLocust"}
        for _, name in pairs(targets) do
            local locust = workspace:FindFirstChild(name)
            if locust then
                local tag = ApplyEsp(locust, name == "BlackLocust" and "Locust" or "Player Locust")
                if tag then tag.Enabled = espState.locust end
            end
        end
    end
end)

local function CreateToggle(parent, text, type)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, 0, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.TextColor3 = Color3.new(1,0,0)
    b.Text = text .. ": OFF"
    b.BorderSizePixel = 0

    b.MouseButton1Click:Connect(function()
        espState[type] = not espState[type]
        b.Text = text .. (espState[type] and ": ON" or ": OFF")
        b.TextColor3 = espState[type] and Color3.new(0,1,0) or Color3.new(1,0,0)

        if type == "locust" then
            local targets = {"BlackLocust", "PlayerBlackLocust"}
            for _, name in pairs(targets) do
                local locust = workspace:FindFirstChild(name)
                if locust and locust:FindFirstChild("VoidTag") then
                    locust.VoidTag.Enabled = espState.locust
                end
            end
        else
            local fName = (type == "items" and "ActiveEquipments") or (type == "keys" and "ActiveKeys") or (type == "papers" and "ActivePapers") or (type == "faul" and "ActiveFuel")
            local folder = workspace:FindFirstChild(fName)
            if folder then
                for _, x in pairs(folder:GetChildren()) do
                    local tag = x:FindFirstChild("VoidTag")
                    if tag then tag.Enabled = espState[type] end
                end
            end
        end
    end)
end

CreateToggle(TabEsp, "ESP Items", "items")
CreateToggle(TabEsp, "ESP Keys", "keys")
CreateToggle(TabEsp, "ESP Papers", "papers")
CreateToggle(TabEsp, "ESP Locust", "locust")
CreateToggle(TabEsp, "Esp Faul", "faul")

-- Auto-Refresh Listen
local function RefreshList(folder, page)
    for _, child in pairs(page:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    -- Bloxy Cola Check
    local cola = workspace:FindFirstChild("BloxyCola")
    if cola and page == TabItems then
        local b = Instance.new("TextButton", page)
        b.Size = UDim2.new(1, -5, 0, 25)
        b.BackgroundColor3 = Color3.fromRGB(40, 25, 25)
        b.TextColor3 = Color3.fromRGB(255, 200, 0)
        b.Text = "TP: Bloxy Cola 🥤"
        b.Font = Enum.Font.GothamBold
        b.BorderSizePixel = 0
        b.MouseButton1Click:Connect(function()
            if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                local pos = cola:IsA("Model") and (cola.PrimaryPart and cola.PrimaryPart.CFrame or cola:GetModelCFrame()) or (cola:IsA("BasePart") and cola.CFrame)
                LP.Character.HumanoidRootPart.CFrame = pos + Vector3.new(0, 3, 0)
            end
        end)
    end

    if not folder then return end

    local children = folder:GetChildren()
    for _, obj in pairs(children) do
        local b = Instance.new("TextButton", page)
        b.Size = UDim2.new(1, -5, 0, 25)
        b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        b.TextColor3 = Color3.new(0.8, 0.8, 0.8)
        b.Text = "TP: " .. obj.Name
        b.Font = Enum.Font.Gotham
        b.TextSize = 11
        b.BorderSizePixel = 0

        b.MouseButton1Click:Connect(function()
            if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                local pos = obj:IsA("Model") and (obj.PrimaryPart and obj.PrimaryPart.CFrame or obj:GetModelCFrame()) or (obj:IsA("BasePart") and obj.CFrame)
                if pos then
                    LP.Character.HumanoidRootPart.CFrame = pos + Vector3.new(0, 3, 0)
                end
            end
        end)
    end
    page.CanvasSize = UDim2.new(0, 0, 0, (#children + (cola and 1 or 0)) * 30)
end

local function BindUpdate(folderName, page)
    task.spawn(function()
        local folder = workspace:WaitForChild(folderName, 5)

        -- Специальная проверка для BloxyCola в Items
        if page == TabItems then
            workspace.ChildAdded:Connect(function(child) if child.Name == "BloxyCola" then RefreshList(folder, page) end end)
            workspace.ChildRemoved:Connect(function(child) if child.Name == "BloxyCola" then RefreshList(folder, page) end end)
        end

        if folder then
            folder.ChildAdded:Connect(function() RefreshList(folder, page) end)
            folder.ChildRemoved:Connect(function() RefreshList(folder, page) end)
            RefreshList(folder, page)
        else
            RefreshList(nil, page)
        end
    end)
end

BindUpdate("ActiveKeys", TabKeys)
BindUpdate("LockedDoors", TabDoors)
BindUpdate("ActiveEquipments", TabItems)
BindUpdate("ActivePapers", TabPapers)
BindUpdate("ActiveFuel", TabFaul)

-- Init
Buttons[1].BackgroundColor3 = Color3.fromRGB(40, 40, 100)
Buttons[1].TextColor3 = Color3.new(1,1,1)
Pages[1].Visible = true
