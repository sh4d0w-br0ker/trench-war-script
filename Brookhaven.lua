local Players = game:GetService("Players")
local LPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- test
if CoreGui:FindFirstChild("KillGui_Fixed") then
    CoreGui.KillGui_Fixed:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KillGui_Fixed"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Input = Instance.new("TextBox")
Input.Size = UDim2.new(0, 180, 0, 40)
Input.Position = UDim2.new(0, 10, 0, 10)
Input.PlaceholderText = "user player"
Input.Text = ""
Input.Parent = MainFrame

local KillBtn = Instance.new("TextButton")
KillBtn.Size = UDim2.new(0, 180, 0, 40)
KillBtn.Position = UDim2.new(0, 10, 0, 60)
KillBtn.Text = "kill"
KillBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
KillBtn.TextColor3 = Color3.new(1, 1, 1)
KillBtn.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Position = UDim2.new(1, -25, 0, 5)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.Parent = MainFrame

local TargetPos = CFrame.new(12.5321894, -272.947388, 291.137085)

local function findTarget(name)
    for _, v in pairs(Players:GetPlayers()) do
        if v.Name:lower():sub(1, #name) == name:lower() or (v.DisplayName and v.DisplayName:lower():sub(1, #name) == name:lower()) then
            return v
        end
    end
    return nil
end

KillBtn.MouseButton1Click:Connect(function()
    local char = LPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local target = findTarget(Input.Text)
    
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and hrp then
        local oldPos = hrp.CFrame
        local tool = LPlayer.Backpack:FindFirstChildOfClass("Tool") or char:FindFirstChildOfClass("Tool")
        
        if tool then
            -- 1. test2
            tool.Parent = char
            
            -- 2. test3
            hrp.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
            
            -- test4
            task.wait(2)
            
            -- 3. test5
            hrp.CFrame = TargetPos
            task.wait(0.3)
            
            -- 4. test6
            tool.Parent = LPlayer.Backpack
            
            -- 5. test7
            task.wait(0.1)
            hrp.CFrame = oldPos
        else
            warn("Диван возьми сам знаешь где")
        end
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
