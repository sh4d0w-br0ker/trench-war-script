local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local Enabled = false
local Connection = nil

-- Создаем интерфейс
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "PistolAura"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 200, 0, 130)
Main.Position = UDim2.new(0.5, -100, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25,  25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

local UICorner = Instance.new("UICorner", Main)
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "PISTOL KILLER"
Title.TextColor3 = Color3.new(1, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", Title)

-- Кнопка ВКЛ/ВЫКЛ
local Toggle = Instance.new("TextButton", Main)
Toggle.Size =  UDim2.new(0.9, 0, 0, 40)
Toggle.Position = UDim2.new(0.05, 0, 0.35, 0)
Toggle.Text = "STATUS: OFF"
Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Toggle.TextColor3 = Color3.new(1, 1, 1)
Toggle.Font = Enum.Font.SourceSansSemibold
Instance.new("UICorner", Toggle)

-- Кнопка ВЫХОД
local Exit = Instance.new("TextButton", Main)
Exit.Size = UDim2.new(0.9, 0, 0, 30)
Exit.Position = UDim2.new(0.05, 0, 0.72,  0)
Exit.Text = "❌ CLOSE & STOP"
Exit.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
Exit.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", Exit)

-- Логика убийства
local function doKill()
    local tool = LocalPlayer.Character:FindFirstChild("Pistol")
    if not tool then return end
    local remote = tool:FindFirstChild("RemoteEvent")
    if not remote then return end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") then
            local hum =  p.Character.Humanoid
             local root = p.Character:FindFirstChild("HumanoidRootPart")
             if hum.Health > 0 and root then
                 -- Отправляем пачку урона 
                 remote:FireServer(hum, 100, {9.17, root.CFrame})
             end
         end
     end
 end

 -- Переключатель
 Toggle.MouseButton1Click:Connect(function()
     Enabled = not Enabled
     if Enabled then
         Toggle.Text = "STATUS: ON"
         Toggle.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
         -- Запускаем цикл
         Connection = RunService.Heartbeat:Connect(function()
             doKill()
         end)
     else
         Toggle.Text = "STATUS: OFF"
         Toggle.BackgroundColor3 =  Color3.fromRGB(50, 50, 50)
        if Connection then Connection:Disconnect() end
    end
end)

-- Выход
Exit.MouseButton1Click:Connect(function()
    if Connection then Connection:Disconnect() end
    ScreenGui:Destroy()
end)

print("Killer GUI Loaded. Enjoy!")
