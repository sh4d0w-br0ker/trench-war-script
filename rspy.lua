-- SPYNOTE-EVENT V1.0
-- Credits: Intrer#0421 (original TurtleSpy), modified by spynote

local colorSettings = {
    ["Main"] = {
        ["HeaderColor"] = Color3.fromRGB(200, 40, 40),
        ["HeaderShadingColor"] = Color3.fromRGB(170, 30, 30),
        ["HeaderTextColor"] = Color3.fromRGB(255, 255, 255),
        ["MainBackgroundColor"] = Color3.fromRGB(40, 40, 45),
        ["InfoScrollingFrameBgColor"] = Color3.fromRGB(40, 40, 45),
        ["ScrollBarImageColor"] = Color3.fromRGB(100, 100, 120)
    },
    ["RemoteButtons"] = {
        ["BorderColor"] = Color3.fromRGB(80, 80, 90),
        ["BackgroundColor"] = Color3.fromRGB(50, 50, 55),
        ["TextColor"] = Color3.fromRGB(220, 220, 220),
        ["NumberTextColor"] = Color3.fromRGB(200, 200, 200)
    },
    ["MainButtons"] = { 
        ["BorderColor"] = Color3.fromRGB(80, 80, 90),
        ["BackgroundColor"] = Color3.fromRGB(50, 50, 55),
        ["TextColor"] = Color3.fromRGB(220, 220, 220)
    },
    ['Code'] = {
        ['BackgroundColor'] = Color3.fromRGB(30, 30, 35),
        ['TextColor'] = Color3.fromRGB(200, 200, 200),
        ['CreditsColor'] = Color3.fromRGB(108, 108, 108)
    },
}

local settings = {["Keybind"] = "P"}

local HttpService = game:GetService("HttpService")
if not isfile("SpyNoteEventSettings.json") then
    writefile("SpyNoteEventSettings.json", HttpService:JSONEncode(settings))
else
    settings = HttpService:JSONDecode(readfile("SpyNoteEventSettings.json"))
end

function Parent(GUI)
    if syn and syn.protect_gui then
        syn.protect_gui(GUI)
        GUI.Parent = game:GetService("CoreGui")
    elseif PROTOSMASHER_LOADED then
        GUI.Parent = get_hidden_gui()
    else
        GUI.Parent = game:GetService("CoreGui")
    end
end

local client = game.Players.LocalPlayer

local function toUnicode(str)
    local codepoints = "utf8.char("
    for _, v in utf8.codes(str) do codepoints = codepoints .. v .. ', ' end
    return codepoints:sub(1, -3) .. ')'
end

local function GetFullPathOfAnInstance(inst)
    if not inst then return "nil" end
    local name = inst.Name
    local head = (#name > 0 and '.' .. name) or "['']"
    if not inst.Parent and inst ~= game then return head .. " --[[ NO PARENT ]]" end
    if inst == game then return "game"
    elseif inst == workspace then return "workspace"
    else
        local suc, res = pcall(game.GetService, game, inst.ClassName)
        if res then head = ':GetService("' .. inst.ClassName .. '")'
        elseif inst == client then head = '.LocalPlayer'
        else
            local nonAlphaNum = name:gsub('[%w_]', '')
            local noPunct = nonAlphaNum:gsub('[%s%p]', '')
            if tonumber(name:sub(1,1)) or (#nonAlphaNum ~= 0 and #noPunct == 0) then
                head = '["' .. name:gsub('"', '\\"') .. '"]'
            elseif #nonAlphaNum ~= 0 and #noPunct > 0 then
                head = '[' .. toUnicode(name) .. ']'
            end
        end
    end
    return GetFullPathOfAnInstance(inst.Parent) .. head
end

local isA = game.IsA
local clone = game.Clone
local TextService = game:GetService("TextService")
local getTextSize = TextService.GetTextSize
game.StarterGui.ResetPlayerGuiOnSpawn = false
local mouse = game.Players.LocalPlayer:GetMouse()

if game.CoreGui:FindFirstChild("SpyNoteEventGUI") then
    game.CoreGui.SpyNoteEventGUI:Destroy()
end

local buttonOffset = -25
local scrollSizeOffset = 287
local functionImage = "http://www.roblox.com/asset/?id=413369623"
local eventImage = "http://www.roblox.com/asset/?id=413369506"
local remotes = {}
local remoteArgs = {}
local remoteButtons = {}
local remoteScripts = {}
local IgnoreList = {}
local BlockList = {}
local connections = {}
local unstacked = {}

local SpyNoteGUI = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local Header = Instance.new("Frame")
local HeaderShading = Instance.new("Frame")
local HeaderTextLabel = Instance.new("TextLabel")
local RemoteScrollFrame = Instance.new("ScrollingFrame")
local RemoteButton = Instance.new("TextButton")
local Number = Instance.new("TextLabel")
local RemoteName = Instance.new("TextLabel")
local RemoteIcon = Instance.new("ImageLabel")
local InfoFrame = Instance.new("Frame")
local InfoFrameHeader = Instance.new("Frame")
local InfoTitleShading = Instance.new("Frame")
local CodeFrame = Instance.new("ScrollingFrame")
local Code = Instance.new("TextLabel")
local CodeComment = Instance.new("TextLabel")
local InfoHeaderText = Instance.new("TextLabel")
local InfoButtonsScroll = Instance.new("ScrollingFrame")
local CopyCode = Instance.new("TextButton")
local RunCode = Instance.new("TextButton")
local CopyScriptPath = Instance.new("TextButton")
local IgnoreRemote = Instance.new("TextButton")
local BlockRemote = Instance.new("TextButton")
local WhileLoop = Instance.new("TextButton")
local Clear = Instance.new("TextButton")
local FrameDivider = Instance.new("Frame")
local CloseInfoFrame = Instance.new("TextButton")
local OpenInfoFrame = Instance.new("TextButton")
local Minimize = Instance.new("TextButton")
local ImageButton = Instance.new("ImageButton")

-- Remote browser
local BrowserHeader = Instance.new("Frame")
local BrowserHeaderFrame = Instance.new("Frame")
local BrowserHeaderText = Instance.new("TextLabel")
local CloseInfoFrame2 = Instance.new("TextButton")
local RemoteBrowserFrame = Instance.new("ScrollingFrame")
local RemoteButton2 = Instance.new("TextButton")
local RemoteName2 = Instance.new("TextLabel")
local RemoteIcon2 = Instance.new("ImageLabel")

SpyNoteGUI.Name = "SpyNoteEventGUI"
Parent(SpyNoteGUI)

mainFrame.Name = "mainFrame"
mainFrame.Parent = SpyNoteGUI
mainFrame.BackgroundColor3 = Color3.fromRGB(53, 59, 72)
mainFrame.BorderColor3 = Color3.fromRGB(53, 59, 72)
mainFrame.Position = UDim2.new(0.1, 0, 0.24, 0)
mainFrame.Size = UDim2.new(0, 207, 0, 35)
mainFrame.ZIndex = 8
mainFrame.Active = true
mainFrame.Draggable = true

-- Remote browser
BrowserHeader.Name = "BrowserHeader"
BrowserHeader.Parent = SpyNoteGUI
BrowserHeader.BackgroundColor3 = colorSettings["Main"]["HeaderShadingColor"]
BrowserHeader.BorderColor3 = colorSettings["Main"]["HeaderShadingColor"]
BrowserHeader.Position = UDim2.new(0.712, 0, 0.339, 0)
BrowserHeader.Size = UDim2.new(0, 207, 0, 33)
BrowserHeader.ZIndex = 20
BrowserHeader.Active = true
BrowserHeader.Draggable = true
BrowserHeader.Visible = false

BrowserHeaderFrame.Name = "BrowserHeaderFrame"
BrowserHeaderFrame.Parent = BrowserHeader
BrowserHeaderFrame.BackgroundColor3 = colorSettings["Main"]["HeaderColor"]
BrowserHeaderFrame.BorderColor3 = colorSettings["Main"]["HeaderColor"]
BrowserHeaderFrame.Position = UDim2.new(0, 0, -0.02, 0)
BrowserHeaderFrame.Size = UDim2.new(0, 207, 0, 26)
BrowserHeaderFrame.ZIndex = 21

BrowserHeaderText.Name = "BrowserHeaderText"
BrowserHeaderText.Parent = BrowserHeaderFrame
BrowserHeaderText.BackgroundTransparency = 1
BrowserHeaderText.Position = UDim2.new(0, 0, -0.002, 0)
BrowserHeaderText.Size = UDim2.new(0, 206, 0, 33)
BrowserHeaderText.ZIndex = 22
BrowserHeaderText.Font = Enum.Font.SourceSans
BrowserHeaderText.Text = "Remote Browser"
BrowserHeaderText.TextColor3 = colorSettings["Main"]["HeaderTextColor"]
BrowserHeaderText.TextSize = 17

CloseInfoFrame2.Name = "CloseInfoFrame2"
CloseInfoFrame2.Parent = BrowserHeaderFrame
CloseInfoFrame2.BackgroundColor3 = colorSettings["Main"]["HeaderColor"]
CloseInfoFrame2.BorderColor3 = colorSettings["Main"]["HeaderColor"]
CloseInfoFrame2.Position = UDim2.new(0, 185, 0, 2)
CloseInfoFrame2.Size = UDim2.new(0, 22, 0, 22)
CloseInfoFrame2.ZIndex = 38
CloseInfoFrame2.Font = Enum.Font.SourceSansLight
CloseInfoFrame2.Text = "X"
CloseInfoFrame2.TextColor3 = Color3.fromRGB(0, 0, 0)
CloseInfoFrame2.TextSize = 20
CloseInfoFrame2.MouseButton1Click:Connect(function()
    BrowserHeader.Visible = not BrowserHeader.Visible
end)

RemoteBrowserFrame.Name = "RemoteBrowserFrame"
RemoteBrowserFrame.Parent = BrowserHeader
RemoteBrowserFrame.Active = true
RemoteBrowserFrame.BackgroundColor3 = colorSettings["Main"]["MainBackgroundColor"]
RemoteBrowserFrame.BorderColor3 = colorSettings["Main"]["MainBackgroundColor"]
RemoteBrowserFrame.Position = UDim2.new(-0.0045, 0, 1.035, 0)
RemoteBrowserFrame.Size = UDim2.new(0, 207, 0, 286)
RemoteBrowserFrame.ZIndex = 19
RemoteBrowserFrame.CanvasSize = UDim2.new(0, 0, 0, 287)
RemoteBrowserFrame.ScrollBarThickness = 8
RemoteBrowserFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
RemoteBrowserFrame.ScrollBarImageColor3 = colorSettings["Main"]["ScrollBarImageColor"]

RemoteButton2.Name = "RemoteButton2"
RemoteButton2.Parent = RemoteBrowserFrame
RemoteButton2.BackgroundColor3 = colorSettings["RemoteButtons"]["BackgroundColor"]
RemoteButton2.BorderColor3 = colorSettings["RemoteButtons"]["BorderColor"]
RemoteButton2.Position = UDim2.new(0, 17, 0, 10)
RemoteButton2.Size = UDim2.new(0, 182, 0, 26)
RemoteButton2.ZIndex = 20
RemoteButton2.Selected = true
RemoteButton2.Font = Enum.Font.SourceSans
RemoteButton2.Text = ""
RemoteButton2.TextSize = 18
RemoteButton2.TextWrapped = true
RemoteButton2.TextXAlignment = Enum.TextXAlignment.Left
RemoteButton2.Visible = false

RemoteName2.Name = "RemoteName2"
RemoteName2.Parent = RemoteButton2
RemoteName2.BackgroundTransparency = 1
RemoteName2.Position = UDim2.new(0, 5, 0, 0)
RemoteName2.Size = UDim2.new(0, 155, 0, 26)
RemoteName2.ZIndex = 21
RemoteName2.Font = Enum.Font.SourceSans
RemoteName2.Text = "RemoteEvent"
RemoteName2.TextColor3 = colorSettings["RemoteButtons"]["TextColor"]
RemoteName2.TextSize = 16
RemoteName2.TextXAlignment = Enum.TextXAlignment.Left
RemoteName2.TextTruncate = 1

RemoteIcon2.Name = "RemoteIcon2"
RemoteIcon2.Parent = RemoteButton2
RemoteIcon2.BackgroundTransparency = 1
RemoteIcon2.Position = UDim2.new(0.84, 0, 0.0225, 0)
RemoteIcon2.Size = UDim2.new(0, 24, 0, 24)
RemoteIcon2.ZIndex = 21
RemoteIcon2.Image = functionImage

local browsedConnections = {}
local browsedButtonOffset = 10
local browserCanvasSize = 286

ImageButton.Parent = Header
ImageButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
ImageButton.BackgroundTransparency = 1
ImageButton.Position = UDim2.new(0, 8, 0, 8)
ImageButton.Size = UDim2.new(0, 18, 0, 18)
ImageButton.ZIndex = 9
ImageButton.Image = "rbxassetid://169476802"
ImageButton.ImageColor3 = Color3.fromRGB(53,53,53)
ImageButton.MouseButton1Click:Connect(function()
    BrowserHeader.Visible = not BrowserHeader.Visible
    for _, v in pairs(game:GetDescendants()) do
        if isA(v, "RemoteEvent") or isA(v, "RemoteFunction") then
            local bButton = clone(RemoteButton2)
            bButton.Parent = RemoteBrowserFrame
            bButton.Visible = true
            bButton.Position = UDim2.new(0, 17, 0, browsedButtonOffset)
            local fireFunction = ""
            if isA(v, "RemoteEvent") then
                fireFunction = ":FireServer()"
                bButton.RemoteIcon2.Image = eventImage
            else
                fireFunction = ":InvokeServer()"
            end
            bButton.RemoteName2.Text = v.Name
            local conn = bButton.MouseButton1Click:Connect(function()
                setclipboard(GetFullPathOfAnInstance(v)..fireFunction)
            end)
            table.insert(browsedConnections, conn)
            browsedButtonOffset = browsedButtonOffset + 35
            if #browsedConnections > 8 then
                browserCanvasSize = browserCanvasSize + 35
                RemoteBrowserFrame.CanvasSize = UDim2.new(0,0,0,browserCanvasSize)
            end
        end
    end
end)

mouse.KeyDown:Connect(function(key)
    if key:lower() == settings["Keybind"]:lower() then
        SpyNoteGUI.Enabled = not SpyNoteGUI.Enabled
    end
end)

Header.Name = "Header"
Header.Parent = mainFrame
Header.BackgroundColor3 = colorSettings["Main"]["HeaderColor"]
Header.BorderColor3 = colorSettings["Main"]["HeaderColor"]
Header.Size = UDim2.new(0, 207, 0, 26)
Header.ZIndex = 9

HeaderShading.Name = "HeaderShading"
HeaderShading.Parent = Header
HeaderShading.BackgroundColor3 = colorSettings["Main"]["HeaderShadingColor"]
HeaderShading.BorderColor3 = colorSettings["Main"]["HeaderShadingColor"]
HeaderShading.Position = UDim2.new(0, 0, 0.2857, 0)
HeaderShading.Size = UDim2.new(0, 207, 0, 27)
HeaderShading.ZIndex = 8

HeaderTextLabel.Name = "HeaderTextLabel"
HeaderTextLabel.Parent = HeaderShading
HeaderTextLabel.BackgroundTransparency = 1
HeaderTextLabel.Position = UDim2.new(-0.005, 0, -0.2028, 0)
HeaderTextLabel.Size = UDim2.new(0, 215, 0, 29)
HeaderTextLabel.ZIndex = 10
HeaderTextLabel.Font = Enum.Font.SourceSans
HeaderTextLabel.Text = "SPYNOTE-EVENT"
HeaderTextLabel.TextColor3 = colorSettings["Main"]["HeaderTextColor"]
HeaderTextLabel.TextSize = 17

RemoteScrollFrame.Name = "RemoteScrollFrame"
RemoteScrollFrame.Parent = mainFrame
RemoteScrollFrame.Active = true
RemoteScrollFrame.BackgroundColor3 = colorSettings["Main"]["MainBackgroundColor"]
RemoteScrollFrame.BorderColor3 = colorSettings["Main"]["MainBackgroundColor"]
RemoteScrollFrame.Position = UDim2.new(0, 0, 1.0229, 0)
RemoteScrollFrame.Size = UDim2.new(0, 207, 0, 286)
RemoteScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 287)
RemoteScrollFrame.ScrollBarThickness = 8
RemoteScrollFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
RemoteScrollFrame.ScrollBarImageColor3 = colorSettings["Main"]["ScrollBarImageColor"]

RemoteButton.Name = "RemoteButton"
RemoteButton.Parent = RemoteScrollFrame
RemoteButton.BackgroundColor3 = colorSettings["RemoteButtons"]["BackgroundColor"]
RemoteButton.BorderColor3 = colorSettings["RemoteButtons"]["BorderColor"]
RemoteButton.Position = UDim2.new(0, 17, 0, 10)
RemoteButton.Size = UDim2.new(0, 182, 0, 26)
RemoteButton.Selected = true
RemoteButton.Font = Enum.Font.SourceSans
RemoteButton.Text = ""
RemoteButton.TextColor3 = Color3.fromRGB(220,221,225)
RemoteButton.TextSize = 18
RemoteButton.TextWrapped = true
RemoteButton.TextXAlignment = Enum.TextXAlignment.Left
RemoteButton.Visible = false

Number.Name = "Number"
Number.Parent = RemoteButton
Number.BackgroundTransparency = 1
Number.Position = UDim2.new(0, 5, 0, 0)
Number.Size = UDim2.new(0, 300, 0, 26)
Number.ZIndex = 2
Number.Font = Enum.Font.SourceSans
Number.Text = "1"
Number.TextColor3 = colorSettings["RemoteButtons"]["NumberTextColor"]
Number.TextSize = 16
Number.TextWrapped = true
Number.TextXAlignment = Enum.TextXAlignment.Left

RemoteName.Name = "RemoteName"
RemoteName.Parent = RemoteButton
RemoteName.BackgroundTransparency = 1
RemoteName.Position = UDim2.new(0, 20, 0, 0)
RemoteName.Size = UDim2.new(0, 134, 0, 26)
RemoteName.Font = Enum.Font.SourceSans
RemoteName.Text = "RemoteEvent"
RemoteName.TextColor3 = colorSettings["RemoteButtons"]["TextColor"]
RemoteName.TextSize = 16
RemoteName.TextXAlignment = Enum.TextXAlignment.Left
RemoteName.TextTruncate = 1

RemoteIcon.Name = "RemoteIcon"
RemoteIcon.Parent = RemoteButton
RemoteIcon.BackgroundTransparency = 1
RemoteIcon.Position = UDim2.new(0.84, 0, 0.0225, 0)
RemoteIcon.Size = UDim2.new(0, 24, 0, 24)
RemoteIcon.Image = eventImage

InfoFrame.Name = "InfoFrame"
InfoFrame.Parent = mainFrame
InfoFrame.BackgroundColor3 = colorSettings["Main"]["MainBackgroundColor"]
InfoFrame.BorderColor3 = colorSettings["Main"]["MainBackgroundColor"]
InfoFrame.Position = UDim2.new(0.368, 0, -0.0000558, 0)
InfoFrame.Size = UDim2.new(0, 357, 0, 322)
InfoFrame.Visible = false
InfoFrame.ZIndex = 6

InfoFrameHeader.Name = "InfoFrameHeader"
InfoFrameHeader.Parent = InfoFrame
InfoFrameHeader.BackgroundColor3 = colorSettings["Main"]["HeaderColor"]
InfoFrameHeader.BorderColor3 = colorSettings["Main"]["HeaderColor"]
InfoFrameHeader.Size = UDim2.new(0, 357, 0, 26)
InfoFrameHeader.ZIndex = 14

InfoTitleShading.Name = "InfoTitleShading"
InfoTitleShading.Parent = InfoFrame
InfoTitleShading.BackgroundColor3 = colorSettings["Main"]["HeaderShadingColor"]
InfoTitleShading.BorderColor3 = colorSettings["Main"]["HeaderShadingColor"]
InfoTitleShading.Position = UDim2.new(-0.0028, 0, 0, 0)
InfoTitleShading.Size = UDim2.new(0, 358, 0, 34)
InfoTitleShading.ZIndex = 13

CodeFrame.Name = "CodeFrame"
CodeFrame.Parent = InfoFrame
CodeFrame.Active = true
CodeFrame.BackgroundColor3 = colorSettings["Code"]["BackgroundColor"]
CodeFrame.BorderColor3 = colorSettings["Code"]["BackgroundColor"]
CodeFrame.Position = UDim2.new(0.039, 0, 0.141, 0)
CodeFrame.Size = UDim2.new(0, 329, 0, 63)
CodeFrame.ZIndex = 16
CodeFrame.CanvasSize = UDim2.new(0, 670, 2, 0)
CodeFrame.ScrollBarThickness = 8
CodeFrame.ScrollingDirection = 1
CodeFrame.ScrollBarImageColor3 = colorSettings["Main"]["ScrollBarImageColor"]

Code.Name = "Code"
Code.Parent = CodeFrame
Code.BackgroundTransparency = 1
Code.Position = UDim2.new(0.0089, 0, 0.0395, 0)
Code.Size = UDim2.new(0, 100000, 0, 25)
Code.ZIndex = 18
Code.Font = Enum.Font.SourceSans
Code.Text = "SPYNOTE-EVENT loaded! :D"
Code.TextColor3 = colorSettings["Code"]["TextColor"]
Code.TextSize = 14
Code.TextWrapped = true
Code.TextXAlignment = Enum.TextXAlignment.Left

CodeComment.Name = "CodeComment"
CodeComment.Parent = CodeFrame
CodeComment.BackgroundTransparency = 1
CodeComment.Position = UDim2.new(0.0119, 0, -0.00197, 0)
CodeComment.Size = UDim2.new(0, 1000, 0, 25)
CodeComment.ZIndex = 18
CodeComment.Font = Enum.Font.SourceSans
CodeComment.Text = "-- SPYNOTE-EVENT by spynote (based on TurtleSpy)"
CodeComment.TextColor3 = colorSettings["Code"]["CreditsColor"]
CodeComment.TextSize = 14
CodeComment.TextXAlignment = Enum.TextXAlignment.Left

InfoHeaderText.Name = "InfoHeaderText"
InfoHeaderText.Parent = InfoFrame
InfoHeaderText.BackgroundTransparency = 1
InfoHeaderText.Position = UDim2.new(0.039, 0, -0.00207, 0)
InfoHeaderText.Size = UDim2.new(0, 342, 0, 35)
InfoHeaderText.ZIndex = 18
InfoHeaderText.Font = Enum.Font.SourceSans
InfoHeaderText.Text = "Info: RemoteEvent"
InfoHeaderText.TextColor3 = colorSettings["Main"]["HeaderTextColor"]
InfoHeaderText.TextSize = 17

InfoButtonsScroll.Name = "InfoButtonsScroll"
InfoButtonsScroll.Parent = InfoFrame
InfoButtonsScroll.Active = true
InfoButtonsScroll.BackgroundColor3 = colorSettings["Main"]["MainBackgroundColor"]
InfoButtonsScroll.BorderColor3 = colorSettings["Main"]["MainBackgroundColor"]
InfoButtonsScroll.Position = UDim2.new(0.039, 0, 0.3558, 0)
InfoButtonsScroll.Size = UDim2.new(0, 329, 0, 199)
InfoButtonsScroll.ZIndex = 11
InfoButtonsScroll.CanvasSize = UDim2.new(0, 0, 1, 0)
InfoButtonsScroll.ScrollBarThickness = 8
InfoButtonsScroll.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
InfoButtonsScroll.ScrollBarImageColor3 = colorSettings["Main"]["ScrollBarImageColor"]

CopyCode.Name = "CopyCode"
CopyCode.Parent = InfoButtonsScroll
CopyCode.BackgroundColor3 = colorSettings["MainButtons"]["BackgroundColor"]
CopyCode.BorderColor3 = colorSettings["MainButtons"]["BorderColor"]
CopyCode.Position = UDim2.new(0.0645, 0, 0, 10)
CopyCode.Size = UDim2.new(0, 294, 0, 26)
CopyCode.ZIndex = 15
CopyCode.Font = Enum.Font.SourceSans
CopyCode.Text = "Copy code"
CopyCode.TextColor3 = Color3.fromRGB(250,251,255)
CopyCode.TextSize = 16

RunCode.Name = "RunCode"
RunCode.Parent = InfoButtonsScroll
RunCode.BackgroundColor3 = colorSettings["MainButtons"]["BackgroundColor"]
RunCode.BorderColor3 = colorSettings["MainButtons"]["BorderColor"]
RunCode.Position = UDim2.new(0.0645, 0, 0, 45)
RunCode.Size = UDim2.new(0, 294, 0, 26)
RunCode.ZIndex = 15
RunCode.Font = Enum.Font.SourceSans
RunCode.Text = "Execute"
RunCode.TextColor3 = Color3.fromRGB(250,251,255)
RunCode.TextSize = 16

CopyScriptPath.Name = "CopyScriptPath"
CopyScriptPath.Parent = InfoButtonsScroll
CopyScriptPath.BackgroundColor3 = colorSettings["MainButtons"]["BackgroundColor"]
CopyScriptPath.BorderColor3 = colorSettings["MainButtons"]["BorderColor"]
CopyScriptPath.Position = UDim2.new(0.0645, 0, 0, 80)
CopyScriptPath.Size = UDim2.new(0, 294, 0, 26)
CopyScriptPath.ZIndex = 15
CopyScriptPath.Font = Enum.Font.SourceSans
CopyScriptPath.Text = "Copy script path"
CopyScriptPath.TextColor3 = Color3.fromRGB(250,251,255)
CopyScriptPath.TextSize = 16

IgnoreRemote.Name = "IgnoreRemote"
IgnoreRemote.Parent = InfoButtonsScroll
IgnoreRemote.BackgroundColor3 = colorSettings["MainButtons"]["BackgroundColor"]
IgnoreRemote.BorderColor3 = colorSettings["MainButtons"]["BorderColor"]
IgnoreRemote.Position = UDim2.new(0.0645, 0, 0, 150)
IgnoreRemote.Size = UDim2.new(0, 294, 0, 26)
IgnoreRemote.ZIndex = 15
IgnoreRemote.Font = Enum.Font.SourceSans
IgnoreRemote.Text = "Ignore remote"
IgnoreRemote.TextColor3 = Color3.fromRGB(250,251,255)
IgnoreRemote.TextSize = 16

BlockRemote.Name = "BlockRemote"
BlockRemote.Parent = InfoButtonsScroll
BlockRemote.BackgroundColor3 = colorSettings["MainButtons"]["BackgroundColor"]
BlockRemote.BorderColor3 = colorSettings["MainButtons"]["BorderColor"]
BlockRemote.Position = UDim2.new(0.0645, 0, 0, 185)
BlockRemote.Size = UDim2.new(0, 294, 0, 26)
BlockRemote.ZIndex = 15
BlockRemote.Font = Enum.Font.SourceSans
BlockRemote.Text = "Block remote from firing"
BlockRemote.TextColor3 = Color3.fromRGB(250,251,255)
BlockRemote.TextSize = 16

WhileLoop.Name = "WhileLoop"
WhileLoop.Parent = InfoButtonsScroll
WhileLoop.BackgroundColor3 = colorSettings["MainButtons"]["BackgroundColor"]
WhileLoop.BorderColor3 = colorSettings["MainButtons"]["BorderColor"]
WhileLoop.Position = UDim2.new(0.0645, 0, 0, 255)
WhileLoop.Size = UDim2.new(0, 294, 0, 26)
WhileLoop.ZIndex = 15
WhileLoop.Font = Enum.Font.SourceSans
WhileLoop.Text = "Generate while loop script"
WhileLoop.TextColor3 = Color3.fromRGB(250,251,255)
WhileLoop.TextSize = 16

Clear.Name = "Clear"
Clear.Parent = InfoButtonsScroll
Clear.BackgroundColor3 = colorSettings["MainButtons"]["BackgroundColor"]
Clear.BorderColor3 = colorSettings["MainButtons"]["BorderColor"]
Clear.Position = UDim2.new(0.0645, 0, 0, 220)
Clear.Size = UDim2.new(0, 294, 0, 26)
Clear.ZIndex = 15
Clear.Font = Enum.Font.SourceSans
Clear.Text = "Clear logs"
Clear.TextColor3 = Color3.fromRGB(250,251,255)
Clear.TextSize = 16

FrameDivider.Name = "FrameDivider"
FrameDivider.Parent = InfoFrame
FrameDivider.BackgroundColor3 = Color3.fromRGB(53,59,72)
FrameDivider.BorderColor3 = Color3.fromRGB(53,59,72)
FrameDivider.Position = UDim2.new(0, 3, 0, 0)
FrameDivider.Size = UDim2.new(0, 4, 0, 322)
FrameDivider.ZIndex = 7

local InfoFrameOpen = false
CloseInfoFrame.Name = "CloseInfoFrame"
CloseInfoFrame.Parent = InfoFrame
CloseInfoFrame.BackgroundColor3 = colorSettings["Main"]["HeaderColor"]
CloseInfoFrame.BorderColor3 = colorSettings["Main"]["HeaderColor"]
CloseInfoFrame.Position = UDim2.new(0, 333, 0, 2)
CloseInfoFrame.Size = UDim2.new(0, 22, 0, 22)
CloseInfoFrame.ZIndex = 18
CloseInfoFrame.Font = Enum.Font.SourceSansLight
CloseInfoFrame.Text = "X"
CloseInfoFrame.TextColor3 = Color3.fromRGB(0,0,0)
CloseInfoFrame.TextSize = 20
CloseInfoFrame.MouseButton1Click:Connect(function()
    InfoFrame.Visible = false
    InfoFrameOpen = false
    mainFrame.Size = UDim2.new(0, 207, 0, 35)
end)

OpenInfoFrame.Name = "OpenInfoFrame"
OpenInfoFrame.Parent = mainFrame
OpenInfoFrame.BackgroundColor3 = colorSettings["Main"]["HeaderColor"]
OpenInfoFrame.BorderColor3 = colorSettings["Main"]["HeaderColor"]
OpenInfoFrame.Position = UDim2.new(0, 185, 0, 2)
OpenInfoFrame.Size = UDim2.new(0, 22, 0, 22)
OpenInfoFrame.ZIndex = 18
OpenInfoFrame.Font = Enum.Font.SourceSans
OpenInfoFrame.Text = ">"
OpenInfoFrame.TextColor3 = Color3.fromRGB(0,0,0)
OpenInfoFrame.TextSize = 16
OpenInfoFrame.MouseButton1Click:Connect(function()
    if not InfoFrame.Visible then
        mainFrame.Size = UDim2.new(0, 565, 0, 35)
        OpenInfoFrame.Text = "<"
    elseif RemoteScrollFrame.Visible then
        mainFrame.Size = UDim2.new(0, 207, 0, 35)
        OpenInfoFrame.Text = ">"
    end
    InfoFrame.Visible = not InfoFrame.Visible
    InfoFrameOpen = not InfoFrameOpen
end)

Minimize.Name = "Minimize"
Minimize.Parent = mainFrame
Minimize.BackgroundColor3 = colorSettings["Main"]["HeaderColor"]
Minimize.BorderColor3 = colorSettings["Main"]["HeaderColor"]
Minimize.Position = UDim2.new(0, 164, 0, 2)
Minimize.Size = UDim2.new(0, 22, 0, 22)
Minimize.ZIndex = 18
Minimize.Font = Enum.Font.SourceSans
Minimize.Text = "_"
Minimize.TextColor3 = Color3.fromRGB(0,0,0)
Minimize.TextSize = 16
Minimize.MouseButton1Click:Connect(function()
    if RemoteScrollFrame.Visible then
        mainFrame.Size = UDim2.new(0, 207, 0, 35)
        OpenInfoFrame.Text = "<"
        InfoFrame.Visible = false
    else
        if InfoFrameOpen then
            mainFrame.Size = UDim2.new(0, 565, 0, 35)
            OpenInfoFrame.Text = "<"
            InfoFrame.Visible = true
        else
            mainFrame.Size = UDim2.new(0, 207, 0, 35)
            OpenInfoFrame.Text = ">"
            InfoFrame.Visible = false
        end
    end
    RemoteScrollFrame.Visible = not RemoteScrollFrame.Visible
end)

local function FindRemote(remote, args)
    local currentId = (get_thread_context or syn.get_thread_identity)()
    (set_thread_context or syn.set_thread_identity)(7)
    local i
    if table.find(unstacked, remote) then
        for b, v in pairs(remotes) do
            if v == remote then
                for i2, v2 in pairs(remoteArgs) do
                    if table.unpack(remoteArgs[b]) == table.unpack(args) then
                        i = b
                    end
                end
            end
        end
    else
        i = table.find(remotes, remote)
    end
    (set_thread_context or syn.set_thread_identity)(currentId)
    return i
end

local function ButtonEffect(textlabel, text)
    if not text then text = "Copied!" end
    local orgText = textlabel.Text
    local orgColor = textlabel.TextColor3
    textlabel.Text = text
    textlabel.TextColor3 = Color3.fromRGB(76,209,55)
    wait(0.8)
    textlabel.Text = orgText
    textlabel.TextColor3 = orgColor
end

local lookingAt
local lookingAtArgs
local lookingAtButton

CopyCode.MouseButton1Click:Connect(function()
    if not lookingAt then return end
    setclipboard(CodeComment.Text.. "\n\n"..Code.Text)
    ButtonEffect(CopyCode)
end)

RunCode.MouseButton1Click:Connect(function()
    if lookingAt then
        if isA(lookingAt, "RemoteFunction") then
            lookingAt:InvokeServer(unpack(lookingAtArgs))
        elseif isA(lookingAt, "RemoteEvent") then
            lookingAt:FireServer(unpack(lookingAtArgs))
        end
    end
end)

CopyScriptPath.MouseButton1Click:Connect(function()
    local remote = FindRemote(lookingAt, lookingAtArgs)
    if remote and lookingAt then
        setclipboard(GetFullPathOfAnInstance(remoteScripts[remote]))
        ButtonEffect(CopyScriptPath)
    end
end)

BlockRemote.MouseButton1Click:Connect(function()
    local bRemote = table.find(BlockList, lookingAt)
    if lookingAt and not bRemote then
        table.insert(BlockList, lookingAt)
        BlockRemote.Text = "Unblock remote"
        BlockRemote.TextColor3 = Color3.fromRGB(251,197,49)
        local remote = table.find(remotes, lookingAt)
        if remote then
            remoteButtons[remote].Parent.RemoteName.TextColor3 = Color3.fromRGB(225,177,44)
        end
    elseif lookingAt and bRemote then
        table.remove(BlockList, bRemote)
        BlockRemote.Text = "Block remote from firing"
        BlockRemote.TextColor3 = Color3.fromRGB(250,251,255)
        local remote = table.find(remotes, lookingAt)
        if remote then
            remoteButtons[remote].Parent.RemoteName.TextColor3 = Color3.fromRGB(245,246,250)
        end
    end
end)

IgnoreRemote.MouseButton1Click:Connect(function()
    local iRemote = table.find(IgnoreList, lookingAt)
    if lookingAt and not iRemote then
        table.insert(IgnoreList, lookingAt)
        IgnoreRemote.Text = "Stop ignoring remote"
        IgnoreRemote.TextColor3 = Color3.fromRGB(127,143,166)
        local remote = table.find(remotes, lookingAt)
        if remote then
            remoteButtons[remote].Parent.RemoteName.TextColor3 = Color3.fromRGB(127,143,166)
        end
    elseif lookingAt and iRemote then
        table.remove(IgnoreList, iRemote)
        IgnoreRemote.Text = "Ignore remote"
        IgnoreRemote.TextColor3 = Color3.fromRGB(250,251,255)
        local remote = table.find(remotes, lookingAt)
        if remote then
            remoteButtons[remote].Parent.RemoteName.TextColor3 = Color3.fromRGB(245,246,250)
        end
    end
end)

WhileLoop.MouseButton1Click:Connect(function()
    if not lookingAt then return end
    setclipboard("while wait() do\n   "..Code.Text.."\nend")
    ButtonEffect(WhileLoop)
end)

Clear.MouseButton1Click:Connect(function()
    for i, v in pairs(RemoteScrollFrame:GetChildren()) do
        if i > 1 then v:Destroy() end
    end
    for _, v in pairs(connections) do
        v:Disconnect()
    end
    buttonOffset = -25
    scrollSizeOffset = 0
    remotes = {}
    remoteArgs = {}
    remoteButtons = {}
    remoteScripts = {}
    IgnoreList = {}
    BlockList = {}
    RemoteScrollFrame.CanvasSize = UDim2.new(0,0,0,287)
    unstacked = {}
    connections = {}
    ButtonEffect(Clear, "Cleared!")
end)

local function len(t)
    local n = 0
    for _ in pairs(t) do n = n + 1 end
    return n
end

local function convertTableToString(args)
    local str = ""
    local idx = 1
    for i, v in pairs(args) do
        if type(i) == "string" then
            str = str .. '["' .. tostring(i) .. '"] = '
        elseif type(i) == "userdata" and typeof(i) ~= "Instance" then
            str = str .. "[" .. typeof(i) .. ".new(" .. tostring(i) .. ")] = "
        elseif type(i) == "userdata" then
            str = str .. "[" .. GetFullPathOfAnInstance(i) .. "] = "
        end
        if v == nil then
            str = str .. "nil"
        elseif typeof(v) == "Instance" then
            str = str .. GetFullPathOfAnInstance(v)
        elseif type(v) == "number" or type(v) == "function" then
            str = str .. tostring(v)
        elseif type(v) == "userdata" then
            str = str .. typeof(v) .. ".new(" .. tostring(v) .. ")"
        elseif type(v) == "string" then
            str = str .. '"' .. v .. '"'
        elseif type(v) == "table" then
            str = str .. "{" .. convertTableToString(v) .. "}"
        elseif type(v) == 'boolean' then
            str = str .. (v and 'true' or 'false')
        end
        if len(args) > 1 and idx < len(args) then
            str = str .. ", "
        end
        idx = idx + 1
    end
    return str
end

-- Функция показа окна со списком уникальных аргументов
local function showArgsListWindow(remote, uniqueArgsList)
    local listWindow = Instance.new("Frame")
    listWindow.Size = UDim2.new(0, 350, 0, 300)
    listWindow.Position = UDim2.new(0.5, -175, 0.5, -150)
    listWindow.BackgroundColor3 = colorSettings["Main"]["MainBackgroundColor"]
    listWindow.BorderSizePixel = 0
    listWindow.Parent = SpyNoteGUI
    Instance.new("UICorner", listWindow).CornerRadius = UDim.new(0, 8)
    
    local winHeader = Instance.new("Frame")
    winHeader.Size = UDim2.new(1, 0, 0, 30)
    winHeader.BackgroundColor3 = colorSettings["Main"]["HeaderColor"]
    winHeader.Parent = listWindow
    Instance.new("UICorner", winHeader).CornerRadius = UDim.new(0, 8)
    
    local winTitle = Instance.new("TextLabel")
    winTitle.Size = UDim2.new(1, -60, 1, 0)
    winTitle.Position = UDim2.new(0, 10, 0, 0)
    winTitle.Text = "Select Arguments: " .. remote.Name
    winTitle.TextColor3 = colorSettings["Main"]["HeaderTextColor"]
    winTitle.BackgroundTransparency = 1
    winTitle.Font = Enum.Font.GothamBold
    winTitle.TextXAlignment = Enum.TextXAlignment.Left
    winTitle.Parent = winHeader
    
    local winClose = Instance.new("TextButton")
    winClose.Size = UDim2.new(0, 30, 1, 0)
    winClose.Position = UDim2.new(1, -30, 0, 0)
    winClose.Text = "✕"
    winClose.TextColor3 = Color3.new(1,1,1)
    winClose.BackgroundTransparency = 1
    winClose.Parent = winHeader
    winClose.MouseButton1Click:Connect(function() listWindow:Destroy() end)
    
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -40)
    scroll.Position = UDim2.new(0, 5, 0, 35)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ScrollBarThickness = 6
    scroll.Parent = listWindow
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 2)
    
    for idx, args in pairs(uniqueArgsList) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 35)
        btn.Text = convertTableToString(args)
        btn.TextSize = 11
        btn.BackgroundColor3 = colorSettings["RemoteButtons"]["BackgroundColor"]
        btn.TextColor3 = colorSettings["RemoteButtons"]["TextColor"]
        btn.Parent = scroll
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        
        btn.MouseButton1Click:Connect(function()
            listWindow:Destroy()
            -- Показываем инфо окно с выбранными аргументами
            local fireFunction = remote:IsA("RemoteEvent") and ":FireServer(" or ":InvokeServer("
            Code.Text = GetFullPathOfAnInstance(remote) .. fireFunction .. convertTableToString(args) .. ")"
            local textsize = getTextSize(TextService, Code.Text, Code.TextSize, Code.Font, Vector2.new(math.huge, math.huge))
            CodeFrame.CanvasSize = UDim2.new(0, textsize.X + 11, 2, 0)
            lookingAt = remote
            lookingAtArgs = args
            
            local blocked = table.find(BlockList, remote)
            if blocked then
                BlockRemote.Text = "Unblock remote"
                BlockRemote.TextColor3 = Color3.fromRGB(251,197,49)
            else
                BlockRemote.Text = "Block remote from firing"
                BlockRemote.TextColor3 = Color3.fromRGB(250,251,255)
            end
            local iRemote = table.find(IgnoreList, remote)
            if iRemote then
                IgnoreRemote.Text = "Stop ignoring remote"
                IgnoreRemote.TextColor3 = Color3.fromRGB(127,143,166)
            else
                IgnoreRemote.Text = "Ignore remote"
                IgnoreRemote.TextColor3 = Color3.fromRGB(250,251,255)
            end
            
            mainFrame.Size = UDim2.new(0, 565, 0, 35)
            OpenInfoFrame.Text = ">"
            InfoFrame.Visible = true
            InfoFrameOpen = true
        end)
    end
end

RemoteScrollFrame.ChildAdded:Connect(function(child)
    local remote = remotes[#remotes]
    local args = remoteArgs[#remotes]
    local event = true
    local fireFunction = ":FireServer("
    if isA(remote, "RemoteFunction") then
        event = false
        fireFunction = ":InvokeServer("
    end
    local connection = child.MouseButton1Click:Connect(function()
        -- Собираем уникальные аргументы для этого ремувента
        local uniqueArgs = {}
        local seen = {}
        for i, r in pairs(remotes) do
            if r == remote then
                local argsKey = HttpService:JSONEncode(remoteArgs[i])
                if not seen[argsKey] then
                    seen[argsKey] = true
                    table.insert(uniqueArgs, remoteArgs[i])
                end
            end
        end
        if #uniqueArgs > 1 then
            showArgsListWindow(remote, uniqueArgs)
        else
            InfoHeaderText.Text = "Info: "..remote.Name
            if event then 
                InfoButtonsScroll.CanvasSize = UDim2.new(0,0,1,0)
            else
                InfoButtonsScroll.CanvasSize = UDim2.new(0,0,1.1,0)
            end
            mainFrame.Size = UDim2.new(0, 565, 0, 35)
            OpenInfoFrame.Text = ">"
            InfoFrame.Visible = true
            Code.Text = GetFullPathOfAnInstance(remote)..fireFunction..convertTableToString(args)..")"
            local textsize = getTextSize(TextService, Code.Text, Code.TextSize, Code.Font, Vector2.new(math.huge, math.huge))
            CodeFrame.CanvasSize = UDim2.new(0, textsize.X + 11, 2, 0)
            lookingAt = remote
            lookingAtArgs = args
            lookingAtButton = child.Number
            
            local blocked = table.find(BlockList, remote)
            if blocked then
                BlockRemote.Text = "Unblock remote"
                BlockRemote.TextColor3 = Color3.fromRGB(251,197,49)
            else
                BlockRemote.Text = "Block remote from firing"
                BlockRemote.TextColor3 = Color3.fromRGB(250,251,255)
            end
            local iRemote = table.find(IgnoreList, lookingAt)
            if iRemote then
                IgnoreRemote.Text = "Stop ignoring remote"
                IgnoreRemote.TextColor3 = Color3.fromRGB(127,143,166)
            else
                IgnoreRemote.Text = "Ignore remote"
                IgnoreRemote.TextColor3 = Color3.fromRGB(250,251,255)
            end
            InfoFrameOpen = true
        end
    end)
    table.insert(connections, connection)
end)

function addToList(event, remote, ...)
    local currentId = (get_thread_context or syn.get_thread_identity)()
    (set_thread_context or syn.set_thread_identity)(7)
    if not remote then return end
    
    local name = remote.Name
    local args = {...}
    local i = FindRemote(remote, args)
    
    if not i then
        table.insert(remotes, remote)
        local rButton = clone(RemoteButton)
        remoteButtons[#remotes] = rButton.Number
        remoteArgs[#remotes] = args
        remoteScripts[#remotes] = (isSynapse and isSynapse() and getcallingscript() or rawget(getfenv(0), "script"))
        
        rButton.Parent = RemoteScrollFrame
        rButton.Visible = true
        local numberTextsize = getTextSize(TextService, rButton.Number.Text, rButton.Number.TextSize, rButton.Number.Font, Vector2.new(math.huge, math.huge))
        rButton.RemoteName.Position = UDim2.new(0, numberTextsize.X + 10, 0, 0)
        if name then
            rButton.RemoteName.Text = name
        end
        if not event then
            rButton.RemoteIcon.Image = functionImage
        end
        buttonOffset = buttonOffset + 35
        rButton.Position = UDim2.new(0.0912, 0, 0, buttonOffset)
        if #remotes > 8 then
            scrollSizeOffset = scrollSizeOffset + 35
            RemoteScrollFrame.CanvasSize = UDim2.new(0, 0, 0, scrollSizeOffset)
        end
    else
        remoteButtons[i].Text = tostring(tonumber(remoteButtons[i].Text) + 1)
        local numberTextsize = getTextSize(TextService, remoteButtons[i].Text, remoteButtons[i].TextSize, remoteButtons[i].Font, Vector2.new(math.huge, math.huge))
        remoteButtons[i].Parent.RemoteName.Position = UDim2.new(0, numberTextsize.X + 10, 0, 0)
        remoteButtons[i].Parent.RemoteName.Size = UDim2.new(0, 149 - numberTextsize.X, 0, 26)
        remoteArgs[i] = args
        
        if lookingAt and lookingAt == remote and lookingAtButton == remoteButtons[i] and InfoFrame.Visible then
            local fireFunction = ":FireServer("
            if isA(remote, "RemoteFunction") then
                fireFunction = ":InvokeServer("
            end
            Code.Text = GetFullPathOfAnInstance(remote)..fireFunction..convertTableToString(remoteArgs[i])..")"
            local textsize = getTextSize(TextService, Code.Text, Code.TextSize, Code.Font, Vector2.new(math.huge, math.huge))
            CodeFrame.CanvasSize = UDim2.new(0, textsize.X + 11, 2, 0)
        end
    end
    (set_thread_context or syn.set_thread_identity)(currentId)
end

local OldEvent
OldEvent = hookfunction(Instance.new("RemoteEvent").FireServer, function(Self, ...)
    if not checkcaller() and table.find(BlockList, Self) then
        return
    elseif table.find(IgnoreList, Self) then
        return OldEvent(Self, ...)
    end
    addToList(true, Self, ...)
    return OldEvent(Self, ...)
end)

local OldFunction
OldFunction = hookfunction(Instance.new("RemoteFunction").InvokeServer, function(Self, ...)
    if not checkcaller() and table.find(BlockList, Self) then
        return
    elseif table.find(IgnoreList, Self) then
        return OldFunction(Self, ...)
    end
    addToList(false, Self, ...)
    return OldFunction(Self, ...)
end)

local OldNamecall
OldNamecall = hookmetamethod(game,"__namecall",function(...)
    local args = {...}
    local Self = args[1]
    local method = (getnamecallmethod or get_namecall_method)()
    if method == "FireServer" and isA(Self, "RemoteEvent") then
        if not checkcaller() and table.find(BlockList, Self) then
            return
        elseif table.find(IgnoreList, Self) then
            return OldNamecall(...)
        end
        addToList(true, ...)
    elseif method == "InvokeServer" and isA(Self, 'RemoteFunction') then
        if not checkcaller() and table.find(BlockList, Self) then
            return
        elseif table.find(IgnoreList, Self) then
            return OldNamecall(...)
        end
        addToList(false, ...)
    end
    return OldNamecall(...)
end)
