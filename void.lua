--[[
    Void Hub GUI Library
    Красивое черное GUI с анимированными звездами и падающими звездами
]]

local library = {}
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Создание главного GUI
function library:Create(title, size, position)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VoidHubLib"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    
    -- Главное окно
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = size or UDim2.new(0, 450, 0, 500)
    MainFrame.Position = position or UDim2.new(0.5, -225, 0.5, -250)
    MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    MainFrame.BackgroundTransparency = 0.05
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    
    -- Свечение по краям
    local Glow = Instance.new("Frame")
    Glow.Size = UDim2.new(1, 20, 1, 20)
    Glow.Position = UDim2.new(0, -10, 0, -10)
    Glow.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
    Glow.BackgroundTransparency = 0.9
    Glow.BorderSizePixel = 0
    Glow.Parent = MainFrame
    
    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = UDim.new(0, 12)
    
    local GlowCorner = Instance.new("UICorner", Glow)
    GlowCorner.CornerRadius = UDim.new(0, 16)
    
    -- Контейнер для звезд
    local StarsContainer = Instance.new("Frame")
    StarsContainer.Size = UDim2.new(1, 0, 1, 0)
    StarsContainer.BackgroundTransparency = 1
    StarsContainer.Parent = MainFrame
    
    -- Хедер
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 45)
    Header.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
    Header.BackgroundTransparency = 0.3
    Header.BorderSizePixel = 0
    Header.Parent = MainFrame
    
    local HeaderCorner = Instance.new("UICorner", Header)
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Text = title or "VOID HUB"
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 18
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Size = UDim2.new(1, -50, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Header
    
    -- Кнопка закрытия
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Text = "✕"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 16
    CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Size = UDim2.new(0, 35, 1, 0)
    CloseBtn.Position = UDim2.new(1, -35, 0, 0)
    CloseBtn.Parent = Header
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
    
    -- Кнопка минимизации
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Text = "—"
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.TextSize = 16
    MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    MinimizeBtn.BackgroundTransparency = 1
    MinimizeBtn.Size = UDim2.new(0, 35, 1, 0)
    MinimizeBtn.Position = UDim2.new(1, -70, 0, 0)
    MinimizeBtn.Parent = Header
    
    -- Сайдбар
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 120, 1, -45)
    Sidebar.Position = UDim2.new(0, 0, 0, 45)
    Sidebar.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
    Sidebar.BackgroundTransparency = 0.2
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame
    
    -- Контейнер для вкладок
    local TabsContainer = Instance.new("Frame")
    TabsContainer.Size = UDim2.new(1, -130, 1, -55)
    TabsContainer.Position = UDim2.new(0, 125, 0, 50)
    TabsContainer.BackgroundTransparency = 1
    TabsContainer.Parent = MainFrame
    
    -- Создание звезд
    local stars = {}
    local fallingStars = {}
    
    for i = 1, 80 do
        local star = Instance.new("Frame")
        star.Size = UDim2.new(0, math.random(1, 2), 0, math.random(1, 2))
        star.Position = UDim2.new(math.random(), 0, math.random(), 0)
        star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        star.BackgroundTransparency = math.random(30, 70) / 100
        star.BorderSizePixel = 0
        star.Parent = StarsContainer
        
        local speedX = (math.random(5, 20) / 10000) * (math.random(0, 1) == 0 and -1 or 1)
        local speedY = (math.random(2, 10) / 10000)
        
        table.insert(stars, {star, speedX, speedY})
    end
    
    -- Анимация звезд
    RunService.RenderStepped:Connect(function(dt)
        for _, starData in pairs(stars) do
            local star = starData[1]
            local speedX = starData[2]
            local speedY = starData[3]
            
            local newX = star.Position.X.Scale + speedX
            local newY = star.Position.Y.Scale + speedY
            
            if newX > 1 then newX = -0.01 end
            if newX < -0.01 then newX = 1 end
            if newY > 1 then newY = -0.01 end
            if newY < -0.01 then newY = 1 end
            
            star.Position = UDim2.new(newX, 0, newY, 0)
        end
    end)
    
    -- Создание падающих звезд
    local function CreateFallingStar()
        local star = Instance.new("Frame")
        star.Size = UDim2.new(0, 2, 0, 2)
        star.Position = UDim2.new(math.random(), 0, -0.05, 0)
        star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        star.BackgroundTransparency = 0.1
        star.BorderSizePixel = 0
        star.Parent = StarsContainer
        
        local trail = Instance.new("Frame")
        trail.Size = UDim2.new(0, 15, 0, 2)
        trail.Position = UDim2.new(0, -13, 0, 0)
        trail.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        trail.BackgroundTransparency = 0.6
        trail.BorderSizePixel = 0
        trail.Parent = star
        
        local trail2 = Instance.new("Frame")
        trail2.Size = UDim2.new(0, 25, 0, 1)
        trail2.Position = UDim2.new(0, -23, 0, 0.5)
        trail2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        trail2.BackgroundTransparency = 0.8
        trail2.BorderSizePixel = 0
        trail2.Parent = star
        
        local speedY = 0.003 + math.random() * 0.005
        local speedX = (math.random(-3, 3) / 1000)
        
        local function animate()
            while star and star.Parent do
                local newY = star.Position.Y.Scale + speedY
                local newX = star.Position.X.Scale + speedX
                
                if newY > 1.1 then
                    star:Destroy()
                    break
                end
                
                star.Position = UDim2.new(newX, 0, newY, 0)
                
                local alpha = 1 - (newY * 0.8)
                star.BackgroundTransparency = 0.1 + (1 - alpha) * 0.7
                trail.BackgroundTransparency = 0.5 + (1 - alpha) * 0.4
                trail2.BackgroundTransparency = 0.7 + (1 - alpha) * 0.2
                
                task.wait()
            end
        end
        
        task.spawn(animate)
    end
    
    -- Спавн падающих звезд
    task.spawn(function()
        while ScreenGui and ScreenGui.Parent do
            task.wait(math.random(8, 20))
            if StarsContainer and StarsContainer.Parent then
                CreateFallingStar()
            end
        end
    end)
    
    -- Создание вкладки
    local tabs = {}
    
    function library:CreateTab(tabName)
        local tabButton = Instance.new("TextButton")
        tabButton.Text = tabName
        tabButton.Font = Enum.Font.GothamSemibold
        tabButton.TextSize = 12
        tabButton.TextColor3 = Color3.fromRGB(180, 180, 180)
        tabButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        tabButton.BackgroundTransparency = 0.5
        tabButton.Size = UDim2.new(1, -10, 0, 35)
        tabButton.Position = UDim2.new(0, 5, 0, (#tabs) * 40 + 5)
        tabButton.BorderSizePixel = 0
        tabButton.Parent = Sidebar
        
        local tabCorner = Instance.new("UICorner", tabButton)
        tabCorner.CornerRadius = UDim.new(0, 6)
        
        local tabFrame = Instance.new("ScrollingFrame")
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.ScrollBarThickness = 4
        tabFrame.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 70)
        tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        tabFrame.Visible = false
        tabFrame.Parent = TabsContainer
        
        local listLayout = Instance.new("UIListLayout", tabFrame)
        listLayout.Padding = UDim.new(0, 8)
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        
        table.insert(tabs, {tabButton, tabFrame})
        
        if #tabs == 1 then
            tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            tabButton.BackgroundColor3 = Color3.fromRGB(35, 25, 55)
            tabButton.BackgroundTransparency = 0.3
            tabFrame.Visible = true
        end
        
        tabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(tabs) do
                t[1].TextColor3 = Color3.fromRGB(180, 180, 180)
                t[1].BackgroundColor3 = Color3.fromRGB(15, 15, 20)
                t[1].BackgroundTransparency = 0.5
                t[2].Visible = false
            end
            tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            tabButton.BackgroundColor3 = Color3.fromRGB(35, 25, 55)
            tabButton.BackgroundTransparency = 0.3
            tabFrame.Visible = true
        end)
        
        local sectionList = {}
        
        function tabFrame:CreateSection(sectionName)
            local sectionFrame = Instance.new("Frame")
            sectionFrame.Size = UDim2.new(1, -10, 0, 40)
            sectionFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
            sectionFrame.BackgroundTransparency = 0.3
            sectionFrame.BorderSizePixel = 0
            sectionFrame.Parent = tabFrame
            
            local sectionCorner = Instance.new("UICorner", sectionFrame)
            sectionCorner.CornerRadius = UDim.new(0, 8)
            
            local sectionTitle = Instance.new("TextLabel")
            sectionTitle.Text = sectionName
            sectionTitle.Font = Enum.Font.GothamBold
            sectionTitle.TextSize = 13
            sectionTitle.TextColor3 = Color3.fromRGB(200, 200, 220)
            sectionTitle.BackgroundTransparency = 1
            sectionTitle.Size = UDim2.new(1, -15, 1, 0)
            sectionTitle.Position = UDim2.new(0, 10, 0, 0)
            sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            sectionTitle.Parent = sectionFrame
            
            local sectionContainer = Instance.new("Frame")
            sectionContainer.Size = UDim2.new(1, 0, 0, 0)
            sectionContainer.BackgroundTransparency = 1
            sectionContainer.Parent = tabFrame
            
            local containerLayout = Instance.new("UIListLayout", sectionContainer)
            containerLayout.Padding = UDim.new(0, 5)
            
            local function UpdateHeight()
                local count = #sectionContainer:GetChildren() - 1
                sectionFrame.Size = UDim2.new(1, -10, 0, 35 + count * 40)
                sectionContainer.Position = UDim2.new(0, 5, 0, 45)
            end
            
            function sectionContainer:AddButton(text, color, callback)
                local btn = Instance.new("TextButton")
                btn.Text = text
                btn.Font = Enum.Font.GothamSemibold
                btn.TextSize = 13
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.BackgroundColor3 = color or Color3.fromRGB(30, 30, 40)
                btn.Size = UDim2.new(1, -10, 0, 35)
                btn.BorderSizePixel = 0
                btn.Parent = sectionContainer
                
                local btnCorner = Instance.new("UICorner", btn)
                btnCorner.CornerRadius = UDim.new(0, 6)
                
                btn.MouseButton1Click:Connect(callback)
                UpdateHeight()
                return btn
            end
            
            function sectionContainer:AddToggle(text, color, default, callback)
                local toggleFrame = Instance.new("Frame")
                toggleFrame.Size = UDim2.new(1, -10, 0, 35)
                toggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                toggleFrame.BorderSizePixel = 0
                toggleFrame.Parent = sectionContainer
                
                local toggleCorner = Instance.new("UICorner", toggleFrame)
                toggleCorner.CornerRadius = UDim.new(0, 6)
                
                local label = Instance.new("TextLabel")
                label.Text = text
                label.Font = Enum.Font.Gotham
                label.TextSize = 13
                label.TextColor3 = Color3.fromRGB(220, 220, 220)
                label.BackgroundTransparency = 1
                label.Size = UDim2.new(1, -60, 1, 0)
                label.Position = UDim2.new(0, 10, 0, 0)
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = toggleFrame
                
                local toggleBtn = Instance.new("TextButton")
                toggleBtn.Text = default and "ON" or "OFF"
                toggleBtn.Font = Enum.Font.GothamBold
                toggleBtn.TextSize = 12
                toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                toggleBtn.BackgroundColor3 = default and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(60, 60, 70)
                toggleBtn.Size = UDim2.new(0, 50, 0, 25)
                toggleBtn.Position = UDim2.new(1, -60, 0.5, -12.5)
                toggleBtn.BorderSizePixel = 0
                toggleBtn.Parent = toggleFrame
                
                local toggleCorner2 = Instance.new("UICorner", toggleBtn)
                toggleCorner2.CornerRadius = UDim.new(0, 4)
                
                local state = default or false
                toggleBtn.MouseButton1Click:Connect(function()
                    state = not state
                    toggleBtn.Text = state and "ON" or "OFF"
                    toggleBtn.BackgroundColor3 = state and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(60, 60, 70)
                    callback(state)
                end)
                
                callback(state)
                UpdateHeight()
                
                return {Set = function(v)
                    state = v
                    toggleBtn.Text = state and "ON" or "OFF"
                    toggleBtn.BackgroundColor3 = state and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(60, 60, 70)
                    callback(state)
                end}
            end
            
            function sectionContainer:AddTextBox(text, placeholder, callback)
                local boxFrame = Instance.new("Frame")
                boxFrame.Size = UDim2.new(1, -10, 0, 35)
                boxFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                boxFrame.BorderSizePixel = 0
                boxFrame.Parent = sectionContainer
                
                local boxCorner = Instance.new("UICorner", boxFrame)
                boxCorner.CornerRadius = UDim.new(0, 6)
                
                local label = Instance.new("TextLabel")
                label.Text = text
                label.Font = Enum.Font.Gotham
                label.TextSize = 12
                label.TextColor3 = Color3.fromRGB(180, 180, 180)
                label.BackgroundTransparency = 1
                label.Size = UDim2.new(0, 80, 1, 0)
                label.Position = UDim2.new(0, 10, 0, 0)
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = boxFrame
                
                local box = Instance.new("TextBox")
                box.Size = UDim2.new(1, -100, 0, 25)
                box.Position = UDim2.new(0, 90, 0.5, -12.5)
                box.PlaceholderText = placeholder
                box.Text = ""
                box.Font = Enum.Font.Gotham
                box.TextSize = 12
                box.TextColor3 = Color3.fromRGB(255, 255, 255)
                box.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
                box.BorderSizePixel = 0
                box.Parent = boxFrame
                
                local boxCorner2 = Instance.new("UICorner", box)
                boxCorner2.CornerRadius = UDim.new(0, 4)
                
                box.FocusLost:Connect(function()
                    callback(box.Text)
                end)
                
                UpdateHeight()
                return box
            end
            
            UpdateHeight()
            return sectionContainer
        end
        
        return tabFrame
    end
    
    -- Анимация сворачивания
    local minimized = false
    MinimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 450, 0, 45)}):Play()
            Sidebar.Visible = false
            TabsContainer.Visible = false
            MinimizeBtn.Text = "+"
        else
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 450, 0, 500)}):Play()
            Sidebar.Visible = true
            TabsContainer.Visible = true
            MinimizeBtn.Text = "—"
        end
    end)
    
    -- Перетаскивание окна
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    Header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    return ScreenGui, MainFrame
end

return library
