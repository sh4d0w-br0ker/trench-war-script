local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer

if Player.PlayerGui:FindFirstChild("RemoteExplorer") then
    Player.PlayerGui.RemoteExplorer:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RemoteExplorer"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 100
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local function ShowNotification(message, isError)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 250, 0, 40)
    notif.Position = UDim2.new(0.5, -125, 0, 10)
    notif.BackgroundColor3 = isError and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(50, 150, 50)
    notif.BackgroundTransparency = 0.1
    notif.BorderSizePixel = 0
    notif.Parent = ScreenGui
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 6)
    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.Text = message
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 12
    txt.TextColor3 = Color3.new(1,1,1)
    txt.BackgroundTransparency = 1
    txt.Parent = notif
    task.spawn(function()
        task.wait(2)
        notif:TweenSize(UDim2.new(0,250,0,0),"Out","Quad",0.3,true)
        task.wait(0.3)
        notif:Destroy()
    end)
end

local function CopyToClipboard(text)
    pcall(function() setclipboard(text) end)
    ShowNotification("Copied!", false)
end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 450)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,8)

local StarsContainer = Instance.new("Frame")
StarsContainer.Size = UDim2.new(1,0,1,0)
StarsContainer.BackgroundTransparency = 1
StarsContainer.Parent = MainFrame
local stars = {}
for i = 1, 100 do
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, math.random(1,2), 0, math.random(1,2))
    star.Position = UDim2.new(math.random(),0,math.random(),0)
    star.BackgroundColor3 = Color3.fromRGB(255,255,255)
    star.BackgroundTransparency = 0.5
    star.BorderSizePixel = 0
    star.Visible = false
    star.Parent = StarsContainer
    table.insert(stars, star)
end

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,35)
Header.BackgroundColor3 = Color3.fromRGB(35,35,35)
Header.BorderSizePixel = 0
Header.Parent = MainFrame
Instance.new("UICorner", Header).CornerRadius = UDim.new(0,8)

local Title = Instance.new("TextLabel")
Title.Text = "  REMOTE EXPLORER"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Size = UDim2.new(0.5,0,1,0)
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1
Title.TextXAlignment = "Left"
Title.Parent = Header

local ExitBtn = Instance.new("TextButton")
ExitBtn.Text = "✕"
ExitBtn.Size = UDim2.new(0,35,1,0)
ExitBtn.Position = UDim2.new(1,-35,0,0)
ExitBtn.TextColor3 = Color3.fromRGB(255,80,80)
ExitBtn.BackgroundTransparency = 1
ExitBtn.Parent = Header
ExitBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Text = "—"
MinimizeBtn.Size = UDim2.new(0,35,1,0)
MinimizeBtn.Position = UDim2.new(1,-70,0,0)
MinimizeBtn.TextColor3 = Color3.new(0.8,0.8,0.8)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Parent = Header

local Side = Instance.new("Frame")
Side.Size = UDim2.new(0,90,1,-35)
Side.Position = UDim2.new(0,0,0,35)
Side.BackgroundColor3 = Color3.fromRGB(30,30,30)
Side.BorderSizePixel = 0
Side.Parent = MainFrame

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1,-100,1,-45)
Container.Position = UDim2.new(0,95,0,40)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    Side.Visible = not isMinimized
    Container.Visible = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0,350,0,35),"Out","Quad",0.2,true)
        MinimizeBtn.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0,350,0,450),"Out","Quad",0.2,true)
        MinimizeBtn.Text = "—"
    end
end)

local allTabs = {}

local function CreateTab(name)
    local f = Instance.new("ScrollingFrame")
    f.Size = UDim2.new(1,0,1,0)
    f.BackgroundTransparency = 1
    f.ScrollBarThickness = 2
    f.Visible = false
    f.CanvasSize = UDim2.new(0,0,0,0)
    f.AutomaticCanvasSize = Enum.AutomaticSize.Y
    f.Parent = Container
    local layout = Instance.new("UIListLayout", f)
    layout.Padding = UDim.new(0,5)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-10,0,30)
    b.Text = name
    b.Font = Enum.Font.Gotham
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    b.TextColor3 = Color3.new(1,1,1)
    b.Parent = Side
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,4)
    b.MouseButton1Click:Connect(function()
        for _, t in pairs(allTabs) do t.Visible = false end
        f.Visible = true
    end)
    allTabs[name] = f
    return f
end

local function CreateButton(parent, text, color, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-5,0,35)
    b.Text = text
    b.BackgroundColor3 = color
    b.Font = Enum.Font.GothamSemibold
    b.TextColor3 = Color3.new(1,1,1)
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
    b.MouseButton1Click:Connect(callback)
    return b
end

Instance.new("UIListLayout", Side).Padding = UDim.new(0,5)
Instance.new("UIPadding", Side).PaddingLeft = UDim.new(0,5)

local function GenerateArgsFromName(remoteName)
    local name = remoteName:lower()
    if name:find("item") or name:find("tool") or name:find("give") then
        return {"DefaultTool"}
    elseif name:find("door") then
        return {"Front"}
    elseif name:find("energy") then
        return {100}
    elseif name:find("teleport") or name:find("tp") then
        return {CFrame.new(0,10,0)}
    elseif name:find("kill") or name:find("damage") or name:find("drown") then
        return {Player, 100}
    elseif name:find("message") or name:find("chat") or name:find("say") then
        return {"Hello World"}
    elseif name:find("key") then
        return {"Key"}
    elseif name:find("ladder") then
        return {1}
    elseif name:find("cat") then
        return {}
    elseif name:find("bed") then
        return {}
    elseif name:find("safe") then
        return {"0000"}
    elseif name:find("mission") or name:find("basement") then
        return {}
    elseif name:find("unlock") then
        return {}
    else
        return {true}
    end
end

local function FindRemoteInGame(remoteName, remoteType)
    local services = {game.ReplicatedStorage, game.Workspace, game.Lighting}
    local function search(parent)
        if not parent then return nil end
        for _, child in pairs(parent:GetChildren()) do
            if remoteType == "Event" and child:IsA("RemoteEvent") and child.Name == remoteName then
                return child
            elseif remoteType == "Function" and child:IsA("RemoteFunction") and child.Name == remoteName then
                return child
            elseif child:IsA("Folder") or child:IsA("Model") then
                local found = search(child)
                if found then return found end
            end
        end
        return nil
    end
    for _, service in pairs(services) do
        if service then
            local found = search(service)
            if found then return found end
        end
    end
    return nil
end

local function CreateFloatWindow(title, remoteType, fullPath)
    local FloatFrame = Instance.new("Frame")
    FloatFrame.Size = UDim2.new(0, 350, 0, 250)
    FloatFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
    FloatFrame.BackgroundColor3 = Color3.fromRGB(30,30,35)
    FloatFrame.BorderSizePixel = 0
    FloatFrame.BackgroundTransparency = 0.05
    FloatFrame.Active = true
    FloatFrame.Draggable = true
    FloatFrame.Parent = ScreenGui
    Instance.new("UICorner", FloatFrame).CornerRadius = UDim.new(0,8)
    
    local FloatHeader = Instance.new("Frame")
    FloatHeader.Size = UDim2.new(1,0,0,30)
    FloatHeader.BackgroundColor3 = Color3.fromRGB(40,40,45)
    FloatHeader.BorderSizePixel = 0
    FloatHeader.Parent = FloatFrame
    Instance.new("UICorner", FloatHeader).CornerRadius = UDim.new(0,8)
    
    local FloatTitle = Instance.new("TextLabel")
    FloatTitle.Text = title
    FloatTitle.Font = Enum.Font.GothamBold
    FloatTitle.TextSize = 11
    FloatTitle.Size = UDim2.new(1,-90,1,0)
    FloatTitle.Position = UDim2.new(0,10,0,0)
    FloatTitle.TextColor3 = Color3.new(1,1,1)
    FloatTitle.BackgroundTransparency = 1
    FloatTitle.TextXAlignment = "Left"
    FloatTitle.Parent = FloatHeader
    
    local FloatMinimize = Instance.new("TextButton")
    FloatMinimize.Text = "—"
    FloatMinimize.Size = UDim2.new(0,30,1,0)
    FloatMinimize.Position = UDim2.new(1,-60,0,0)
    FloatMinimize.TextColor3 = Color3.new(0.8,0.8,0.8)
    FloatMinimize.BackgroundTransparency = 1
    FloatMinimize.Parent = FloatHeader
    
    local FloatClose = Instance.new("TextButton")
    FloatClose.Text = "✕"
    FloatClose.Size = UDim2.new(0,30,1,0)
    FloatClose.Position = UDim2.new(1,-30,0,0)
    FloatClose.TextColor3 = Color3.fromRGB(255,80,80)
    FloatClose.BackgroundTransparency = 1
    FloatClose.Parent = FloatHeader
    
    local FloatContent = Instance.new("Frame")
    FloatContent.Size = UDim2.new(1,-20,1,-50)
    FloatContent.Position = UDim2.new(0,10,0,40)
    FloatContent.BackgroundTransparency = 1
    FloatContent.Parent = FloatFrame
    
    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(1,0,0,80)
    TextBox.Position = UDim2.new(0,0,0,0)
    TextBox.BackgroundColor3 = Color3.fromRGB(20,20,25)
    TextBox.TextColor3 = Color3.new(1,1,1)
    TextBox.Text = ""
    TextBox.TextWrapped = true
    TextBox.TextXAlignment = "Left"
    TextBox.TextYAlignment = "Top"
    TextBox.ClearTextOnFocus = false
    TextBox.Parent = FloatContent
    Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0,6)
    
    local GenerateBtn = Instance.new("TextButton")
    GenerateBtn.Size = UDim2.new(1,0,0,30)
    GenerateBtn.Position = UDim2.new(0,0,0,90)
    GenerateBtn.Text = "Generate Args"
    GenerateBtn.BackgroundColor3 = Color3.fromRGB(80,100,200)
    GenerateBtn.Font = Enum.Font.GothamSemibold
    GenerateBtn.TextColor3 = Color3.new(1,1,1)
    GenerateBtn.Parent = FloatContent
    Instance.new("UICorner", GenerateBtn).CornerRadius = UDim.new(0,6)
    
    local FireBtn = Instance.new("TextButton")
    FireBtn.Size = UDim2.new(0.48,0,0,35)
    FireBtn.Position = UDim2.new(0,0,0,130)
    FireBtn.Text = remoteType == "Event" and "Fire Event" or "Call Function"
    FireBtn.BackgroundColor3 = Color3.fromRGB(50,150,80)
    FireBtn.Font = Enum.Font.GothamSemibold
    FireBtn.TextColor3 = Color3.new(1,1,1)
    FireBtn.Parent = FloatContent
    Instance.new("UICorner", FireBtn).CornerRadius = UDim.new(0,6)
    
    local CopyBtn = Instance.new("TextButton")
    CopyBtn.Size = UDim2.new(0.48,0,0,35)
    CopyBtn.Position = UDim2.new(0.52,0,0,130)
    CopyBtn.Text = "Copy Path"
    CopyBtn.BackgroundColor3 = Color3.fromRGB(100,100,150)
    CopyBtn.Font = Enum.Font.GothamSemibold
    CopyBtn.TextColor3 = Color3.new(1,1,1)
    CopyBtn.Parent = FloatContent
    Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0,6)
    
    local PathLabel = Instance.new("TextLabel")
    PathLabel.Size = UDim2.new(1,0,0,20)
    PathLabel.Position = UDim2.new(0,0,0,175)
    PathLabel.Text = "Path: " .. fullPath
    PathLabel.Font = Enum.Font.Gotham
    PathLabel.TextSize = 10
    PathLabel.TextColor3 = Color3.fromRGB(150,150,150)
    PathLabel.BackgroundTransparency = 1
    PathLabel.Parent = FloatContent
    
    local isFloatMinimized = false
    FloatMinimize.MouseButton1Click:Connect(function()
        isFloatMinimized = not isFloatMinimized
        if isFloatMinimized then
            FloatContent.Visible = false
            FloatFrame:TweenSize(UDim2.new(0,350,0,30),"Out","Quad",0.2,true)
            FloatMinimize.Text = "+"
        else
            FloatContent.Visible = true
            FloatFrame:TweenSize(UDim2.new(0,350,0,250),"Out","Quad",0.2,true)
            FloatMinimize.Text = "—"
        end
    end)
    
    FloatClose.MouseButton1Click:Connect(function()
        FloatFrame:Destroy()
    end)
    
    GenerateBtn.MouseButton1Click:Connect(function()
        local args = GenerateArgsFromName(title)
        local jsonArgs = {}
        for _, v in ipairs(args) do
            if type(v) == "string" then
                jsonArgs[#jsonArgs + 1] = '"' .. v .. '"'
            elseif type(v) == "number" then
                jsonArgs[#jsonArgs + 1] = tostring(v)
            elseif type(v) == "boolean" then
                jsonArgs[#jsonArgs + 1] = tostring(v)
            else
                jsonArgs[#jsonArgs + 1] = '"' .. tostring(v) .. '"'
            end
        end
        TextBox.Text = "[" .. table.concat(jsonArgs, ", ") .. "]"
        ShowNotification("Generated!", false)
    end)
    
    CopyBtn.MouseButton1Click:Connect(function()
        local copyText = remoteType == "Event" and (fullPath .. ':FireServer()') or (fullPath .. ':InvokeServer()')
        CopyToClipboard(copyText)
    end)
    
    -- FIRE BUTTON - БЕЗ ПРОВЕРКИ НА JSON, ВЫПОЛНЯЕТ ЛЮБУЮ ХУЙНЮ
    FireBtn.MouseButton1Click:Connect(function()
        local args = {}
        local text = TextBox.Text
        
        if text == "" then
            args = {}
        else
            local success, decoded = pcall(function()
                return game:GetService("HttpService"):JSONDecode(text)
            end)
            if success then
                args = decoded
            else
                args = {text}
            end
        end
        
        local target = FindRemoteInGame(title, remoteType)
        if target then
            local ok, err = pcall(function()
                if remoteType == "Event" then
                    target:FireServer(unpack(args))
                else
                    target:InvokeServer(unpack(args))
                end
            end)
            if ok then
                ShowNotification("Success!", false)
            else
                ShowNotification("Error: " .. tostring(err), true)
            end
        else
            ShowNotification("Remote not found!", true)
        end
    end)
    
    return FloatFrame
end

local tInfo = CreateTab("Info")
local itxt = Instance.new("TextLabel", tInfo)
itxt.Size = UDim2.new(1,0,0,120)
itxt.Text = "REMOTE EXPLORER v1\n\nCreated by spynote\nDiscord: @_thefinal_\nRoblox: sedfortip\n\nScans: ReplicatedStorage,\nWorkspace, Lighting"
itxt.TextColor3 = Color3.new(1,1,1)
itxt.BackgroundTransparency = 1
itxt.Font = Enum.Font.Gotham

local tSpy = CreateTab("Spy")
CreateButton(tSpy, "Get Cobalt", Color3.fromRGB(80,150,200), function()
    ShowNotification("Loading Cobalt...", false)
    loadstring(game:HttpGet("https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau"))()
end)
CreateButton(tSpy, "Get Infinite Yield", Color3.fromRGB(200,150,50), function()
    ShowNotification("Loading Infinite Yield...", false)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

local tEvents = CreateTab("Events")
local eventsContainer = Instance.new("ScrollingFrame")
eventsContainer.Size = UDim2.new(1,0,1,0)
eventsContainer.BackgroundTransparency = 1
eventsContainer.ScrollBarThickness = 4
eventsContainer.CanvasSize = UDim2.new(0,0,0,0)
eventsContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
eventsContainer.Parent = tEvents
Instance.new("UIListLayout", eventsContainer).Padding = UDim.new(0,3)

local eventsLabel = Instance.new("TextLabel")
eventsLabel.Size = UDim2.new(1,0,0,25)
eventsLabel.Text = "=== REMOTE EVENTS ==="
eventsLabel.TextColor3 = Color3.fromRGB(200,200,100)
eventsLabel.BackgroundTransparency = 1
eventsLabel.Font = Enum.Font.GothamBold
eventsLabel.Parent = eventsContainer

local function ScanForEvents(parent, path, results)
    if not parent then return end
    for _, child in pairs(parent:GetChildren()) do
        local newPath = path .. "/" .. child.Name
        if child:IsA("RemoteEvent") then
            table.insert(results, {name = child.Name, path = newPath})
        elseif child:IsA("Folder") or child:IsA("Model") then
            ScanForEvents(child, newPath, results)
        end
    end
end

local allEvents = {}
local scanServices = {game.ReplicatedStorage, game.Workspace, game.Lighting}
for _, svc in pairs(scanServices) do
    if svc then
        ScanForEvents(svc, svc.Name, allEvents)
    end
end

if #allEvents > 0 then
    for _, ev in pairs(allEvents) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,-5,0,30)
        btn.Text = ev.name
        btn.BackgroundColor3 = Color3.fromRGB(60,60,70)
        btn.Font = Enum.Font.Gotham
        btn.TextColor3 = Color3.new(1,1,1)
        btn.TextSize = 11
        btn.Parent = eventsContainer
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,4)
        btn.MouseButton1Click:Connect(function()
            CreateFloatWindow(ev.name, "Event", ev.path)
        end)
    end
else
    local nothing = Instance.new("TextLabel")
    nothing.Size = UDim2.new(1,0,0,30)
    nothing.Text = "No RemoteEvents found!"
    nothing.TextColor3 = Color3.fromRGB(255,100,100)
    nothing.BackgroundTransparency = 1
    nothing.Parent = eventsContainer
end

local tFunctions = CreateTab("Functions")
local functionsContainer = Instance.new("ScrollingFrame")
functionsContainer.Size = UDim2.new(1,0,1,0)
functionsContainer.BackgroundTransparency = 1
functionsContainer.ScrollBarThickness = 4
functionsContainer.CanvasSize = UDim2.new(0,0,0,0)
functionsContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
functionsContainer.Parent = tFunctions
Instance.new("UIListLayout", functionsContainer).Padding = UDim.new(0,3)

local functionsLabel = Instance.new("TextLabel")
functionsLabel.Size = UDim2.new(1,0,0,25)
functionsLabel.Text = "=== REMOTE FUNCTIONS ==="
functionsLabel.TextColor3 = Color3.fromRGB(100,200,200)
functionsLabel.BackgroundTransparency = 1
functionsLabel.Font = Enum.Font.GothamBold
functionsLabel.Parent = functionsContainer

local function ScanForFunctions(parent, path, results)
    if not parent then return end
    for _, child in pairs(parent:GetChildren()) do
        local newPath = path .. "/" .. child.Name
        if child:IsA("RemoteFunction") then
            table.insert(results, {name = child.Name, path = newPath})
        elseif child:IsA("Folder") or child:IsA("Model") then
            ScanForFunctions(child, newPath, results)
        end
    end
end

local allFunctions = {}
for _, svc in pairs(scanServices) do
    if svc then
        ScanForFunctions(svc, svc.Name, allFunctions)
    end
end

if #allFunctions > 0 then
    for _, fn in pairs(allFunctions) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,-5,0,30)
        btn.Text = fn.name
        btn.BackgroundColor3 = Color3.fromRGB(60,60,70)
        btn.Font = Enum.Font.Gotham
        btn.TextColor3 = Color3.new(1,1,1)
        btn.TextSize = 11
        btn.Parent = functionsContainer
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,4)
        btn.MouseButton1Click:Connect(function()
            CreateFloatWindow(fn.name, "Function", fn.path)
        end)
    end
else
    local nothing = Instance.new("TextLabel")
    nothing.Size = UDim2.new(1,0,0,30)
    nothing.Text = "No RemoteFunctions found!"
    nothing.TextColor3 = Color3.fromRGB(255,100,100)
    nothing.BackgroundTransparency = 1
    nothing.Parent = functionsContainer
end

local tSettings = CreateTab("Settings")

local function UpdateTheme(color)
    MainFrame.BackgroundColor3 = color
    Header.BackgroundColor3 = color:lerp(Color3.new(0,0,0),0.2)
    Side.BackgroundColor3 = color:lerp(Color3.new(0,0,0),0.3)
    for _, star in pairs(stars) do star.Visible = false end
end

CreateButton(tSettings, "White Theme", Color3.fromRGB(200,200,200), function()
    UpdateTheme(Color3.fromRGB(200,200,200))
    MainFrame.BackgroundColor3 = Color3.fromRGB(200,200,200)
    Header.BackgroundColor3 = Color3.fromRGB(180,180,180)
    Side.BackgroundColor3 = Color3.fromRGB(190,190,190)
end)

CreateButton(tSettings, "Red Theme", Color3.fromRGB(150,50,50), function()
    UpdateTheme(Color3.fromRGB(150,50,50))
end)

CreateButton(tSettings, "Black Theme", Color3.fromRGB(15,15,15), function()
    UpdateTheme(Color3.fromRGB(15,15,15))
end)

CreateButton(tSettings, "Void Theme", Color3.fromRGB(8,8,12), function()
    UpdateTheme(Color3.fromRGB(8,8,12))
    Header.BackgroundColor3 = Color3.fromRGB(12,12,18)
    Side.BackgroundColor3 = Color3.fromRGB(5,5,8)
    for _, star in pairs(stars) do star.Visible = true end
end)

allTabs["Info"].Visible = true
