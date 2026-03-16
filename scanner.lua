--[[
███████╗ ██████╗ █████╗ ███╗   ██╗███╗   ██╗███████╗██████╗ 
██╔════╝██╔════╝██╔══██╗████╗  ██║████╗  ██║██╔════╝██╔══██╗
███████╗██║     ███████║██╔██╗ ██║██╔██╗ ██║█████╗  ██████╔╝
╚════██║██║     ██╔══██║██║╚██╗██║██║╚██╗██║██╔══╝  ██╔══██╗
███████║╚██████╗██║  ██║██║ ╚████║██║ ╚████║███████╗██║  ██║
╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝
                                                                 
██╗   ██╗██╗   ██╗██╗     ███╗   ██╗███████╗██████╗ ███████╗
██║   ██║██║   ██║██║     ████╗  ██║██╔════╝██╔══██╗██╔════╝
██║   ██║██║   ██║██║     ██╔██╗ ██║█████╗  ██████╔╝███████╗
╚██╗ ██╔╝██║   ██║██║     ██║╚██╗██║██╔══╝  ██╔══██╗╚════██║
 ╚████╔╝ ╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║███████║
  ╚═══╝   ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚══════╝
                                                                 
VULNERABILITY SCANNER v2.1 - For Educational Purposes Only
]]

-- Настройки
local SETTINGS = {
    AutoExecute = false, -- Автоматически выполнять найденный код? (опасно!)
    SaveLogs = true,     -- Сохранять лог в файл
    DeepScan = true,      -- Глубокий поиск (может лагать)
    ShowHidden = true     -- Показывать скрытые объекты
}

-- Цвета для консоли
local COLORS = {
    RED = "\27[31m",
    GREEN = "\27[32m",
    YELLOW = "\27[33m",
    BLUE = "\27[34m",
    MAGENTA = "\27[35m",
    CYAN = "\27[36m",
    WHITE = "\27[37m",
    RESET = "\27[0m"
}

-- Сервисы
local Services = {
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    ServerScriptService = game:GetService("ServerScriptService"),
    ServerStorage = game:GetService("ServerStorage"),
    Workspace = game:GetService("Workspace"),
    HttpService = game:GetService("HttpService"),
    TeleportService = game:GetService("TeleportService"),
    InsertService = game:GetService("InsertService"),
    RunService = game:GetService("RunService"),
    MarketplaceService = game:GetService("MarketplaceService")
}

-- Статистика
local Stats = {
    TotalScripts = 0,
    Vulnerabilities = 0,
    Backdoors = 0,
    Admins = 0,
    Loadstrings = 0,
    HiddenObjects = 0,
    Exploits = 0
}

-- Найденные уязвимости и бэкдоры
local FoundVulns = {}
local FoundBackdoors = {}  -- Специально для бэкдоров

-- Функция для безопасного вывода
local function Print(msg, color)
    color = color or COLORS.WHITE
    print(color .. msg .. COLORS.RESET)
end

-- Функция для сохранения лога
local function SaveLog(data)
    if not SETTINGS.SaveLogs then return end
    local logName = "Scanner_Log_" .. Services.HttpService:GenerateGUID(false) .. ".txt"
    writefile(logName, data)
    Print("[+] Лог сохранен: " .. logName, COLORS.GREEN)
end

-- Функция активации бэкдора
local function ActivateBackdoor(backdoorInfo)
    Print("\n[!] АКТИВАЦИЯ БЭКДОРА: " .. backdoorInfo.path, COLORS.RED)
    
    local success = false
    
    -- Пробуем разные методы активации
    if backdoorInfo.type == "REMOTE" then
        -- Для RemoteEvents/RemoteFunctions
        local obj = backdoorInfo.object
        if obj and obj:IsA("RemoteEvent") then
            pcall(function()
                obj:FireServer("execute", "print('Backdoor activated!')")
                obj:FireServer("load", "print('Hello from backdoor')")
                obj:FireServer("admin", "me")
                obj:FireServer("cmd", "print")
                Print("[+] Отправлены сигналы в RemoteEvent", COLORS.GREEN)
                success = true
            end)
        elseif obj and obj:IsA("RemoteFunction") then
            pcall(function()
                obj:InvokeServer("execute", "print('Backdoor activated!')")
                Print("[+] Вызван RemoteFunction", COLORS.GREEN)
                success = true
            end)
        end
    elseif backdoorInfo.type == "SCRIPT" then
        -- Для скриптов с loadstring
        local obj = backdoorInfo.object
        if obj and obj:IsA("Script") then
            pcall(function()
                local source = obj.Source or ""
                -- Ищем loadstring и пробуем выполнить
                local loadstringMatch = source:match("loadstring%(([^)]+)%)")
                if loadstringMatch then
                    local func = loadstring("return " .. loadstringMatch)()
                    if func then
                        func("print('Backdoor activated!')")
                        Print("[+] Выполнен loadstring из скрипта", COLORS.GREEN)
                        success = true
                    end
                end
            end)
        elseif obj and obj:IsA("LocalScript") then
            pcall(function()
                local source = obj.Source or ""
                -- Пробуем выполнить код локально
                local func = loadstring(source)
                if func then
                    func()
                    Print("[+] Выполнен LocalScript", COLORS.GREEN)
                    success = true
                end
            end)
        end
    elseif backdoorInfo.type == "FUNCTION" then
        -- Для функций в таблицах
        pcall(function()
            local env = getfenv()
            for name, value in pairs(env) do
                if type(value) == "function" and name:lower():find("admin") then
                    value("print('Backdoor test')")
                    Print("[+] Найдена и вызвана функция: " .. name, COLORS.GREEN)
                    success = true
                end
            end
        end)
    end
    
    -- Пробуем стандартные бэкдор-команды
    pcall(function()
        local commands = {
            "print('BACKDOOR TEST')",
            "game:GetService('Players').LocalPlayer:Kick('Backdoor test')",
            "game:GetService('TeleportService'):Teleport(game.PlaceId)",
            "loadstring('print(\\'Hello from backdoor\\')')()"
        }
        
        for _, cmd in ipairs(commands) do
            local func = loadstring(cmd)
            if func then
                func()
                Print("[+] Выполнена команда: " .. cmd, COLORS.GREEN)
                success = true
            end
        end
    end)
    
    if success then
        Print("[✓] Бэкдор успешно активирован!", COLORS.GREEN)
        backdoorInfo.activated = true
    else
        Print("[✗] Не удалось активировать бэкдор", COLORS.RED)
    end
    
    return success
end

-- Функция для проверки скрипта
local function ScanScript(script, path)
    Stats.TotalScripts = Stats.TotalScripts + 1
    local source = script.Source or ""
    
    -- Паттерны для поиска
    local patterns = {
        -- Критические (прямые угрозы)
        {pattern = "loadstring", type = "LOADSTRING", desc = "Динамическая загрузка кода", color = COLORS.RED, backdoor = true},
        {pattern = "require%((%d+)%)", type = "BACKDOOR", desc = "require с ID (возможный бэкдор)", color = COLORS.RED, backdoor = true},
        {pattern = "game:GetService%(\"TeleportService\"%)", type = "TELEPORT", desc = "Телепортация", color = COLORS.YELLOW},
        {pattern = "HttpService:.*PostAsync", type = "HTTP", desc = "Внешние запросы", color = COLORS.YELLOW},
        {pattern = "game:GetService%(\"InsertService\"%)", type = "INSERT", desc = "Загрузка ассетов", color = COLORS.YELLOW},
        
        -- Доступ к окружению
        {pattern = "getfenv", type = "ENV", desc = "Доступ к окружению", color = COLORS.MAGENTA},
        {pattern = "setfenv", type = "ENV", desc = "Изменение окружения", color = COLORS.MAGENTA},
        {pattern = "getrenv", type = "ENV", desc = "Доступ к глобальному окружению", color = COLORS.MAGENTA},
        
        -- Обфускация
        {pattern = "string%.char%(", type = "OBFUSCATION", desc = "Обфускация через char", color = COLORS.CYAN},
        {pattern = "string%.sub%(.+,.+,.+)", type = "OBFUSCATION", desc = "Строковые манипуляции", color = COLORS.CYAN},
        {pattern = "table%.concat%(", type = "OBFUSCATION", desc = "Конкатенация таблиц", color = COLORS.CYAN},
        
        -- Специфичные бэкдор паттерны
        {pattern = "game%.Players%.LocalPlayer%.Character%.Humanoid%.Health", type = "EXPLOIT", desc = "Изменение здоровья", color = COLORS.RED},
        {pattern = "fireclickdetector", type = "EXPLOIT", desc = "Клик-детектор эксплоит", color = COLORS.RED},
        {pattern = "GetObjects", type = "INSERT", desc = "Загрузка объектов", color = COLORS.YELLOW},
    }
    
    -- Проверяем паттерны
    for _, p in ipairs(patterns) do
        if source:find(p.pattern) then
            local vuln = string.format("[%s] %s: %s", p.type, path, p.desc)
            table.insert(FoundVulns, vuln)
            Stats.Vulnerabilities = Stats.Vulnerabilities + 1
            
            if p.type == "LOADSTRING" then 
                Stats.Loadstrings = Stats.Loadstrings + 1 
            end
            
            -- Сохраняем информацию о бэкдорах отдельно
            if p.backdoor then
                local backdoorInfo = {
                    path = path,
                    type = "SCRIPT",
                    pattern = p.pattern,
                    desc = p.desc,
                    object = script,
                    source = source,
                    activated = false
                }
                table.insert(FoundBackdoors, backdoorInfo)
                Stats.Backdoors = Stats.Backdoors + 1
                Stats.Exploits = Stats.Exploits + 1
            end
            
            Print(vuln, p.color)
            
            -- Показываем строку с кодом
            local lines = source:split("\n")
            for i, line in ipairs(lines) do
                if line:find(p.pattern) then
                    Print("  └─ Строка " .. i .. ": " .. line:sub(1, 100), COLORS.WHITE)
                end
            end
        end
    end
    
    -- Проверка на скрытые функции
    if source:find("Admin") or source:find("admin") then
        Stats.Admins = Stats.Admins + 1
        Print("[ADMIN] Возможная админка: " .. path, COLORS.YELLOW)
    end
end

-- Поиск скрытых объектов
local function FindHidden()
    if not SETTINGS.ShowHidden then return end
    
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Transparency > 0.9 then
            Stats.HiddenObjects = Stats.HiddenObjects + 1
            Print("[HIDDEN] Скрытый объект: " .. obj:GetFullName(), COLORS.CYAN)
        end
        
        if obj:IsA("Script") or obj:IsA("LocalScript") then
            local parent = obj.Parent
            local suspiciousParents = {"MaterialService", "VRService", "TextChatService", "JointsService", "Debris"}
            for _, sp in ipairs(suspiciousParents) do
                if parent and (parent.Name == sp or parent.ClassName == sp) then
                    Print("[SUSPICIOUS] Скрипт в необычном месте: " .. obj:GetFullName(), COLORS.RED)
                    
                    local backdoorInfo = {
                        path = obj:GetFullName(),
                        type = "SCRIPT",
                        pattern = "SUSPICIOUS_LOCATION",
                        desc = "Скрипт в подозрительном месте",
                        object = obj,
                        source = obj.Source or "",
                        activated = false
                    }
                    table.insert(FoundBackdoors, backdoorInfo)
                    Stats.Backdoors = Stats.Backdoors + 1
                end
            end
        end
    end
end

-- Поиск бэкдоров в RemoteEvents
local function FindRemotes()
    Print("\n[+] Проверка RemoteEvents...", COLORS.BLUE)
    
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local name = obj.Name:lower()
            
            -- Подозрительные названия
            if name:find("admin") or name:find("kick") or name:find("ban") or 
               name:find("exploit") or name:find("backdoor") or name:find("execute") or
               name:find("load") or name:find("run") or name:find("cmd") then
                
                Print("[REMOTE] Подозрительный Remote: " .. obj:GetFullName(), COLORS.YELLOW)
                Stats.Vulnerabilities = Stats.Vulnerabilities + 1
                
                local backdoorInfo = {
                    path = obj:GetFullName(),
                    type = "REMOTE",
                    pattern = "REMOTE_NAME",
                    desc = "Remote с подозрительным названием",
                    object = obj,
                    name = name,
                    activated = false
                }
                table.insert(FoundBackdoors, backdoorInfo)
                Stats.Backdoors = Stats.Backdoors + 1
                Stats.Exploits = Stats.Exploits + 1
            end
            
            -- Проверяем родителей
            local parent = obj.Parent
            if parent and (parent.Name:lower():find("admin") or parent.Name:lower():find("backdoor")) then
                Print("[REMOTE] Remote в подозрительном контейнере: " .. obj:GetFullName(), COLORS.YELLOW)
                
                local backdoorInfo = {
                    path = obj:GetFullName(),
                    type = "REMOTE",
                    pattern = "REMOTE_CONTAINER",
                    desc = "Remote в подозрительном контейнере",
                    object = obj,
                    activated = false
                }
                table.insert(FoundBackdoors, backdoorInfo)
            end
        end
    end
end

-- Поиск админов в игре
local function FindAdmins()
    Print("\n[+] Проверка администраторов...", COLORS.BLUE)
    
    for _, player in ipairs(Services.Players:GetPlayers()) do
        local rank = player:GetRankInGroup(1)
        if rank and rank > 0 then
            Print("[RANK] " .. player.Name .. " имеет ранг " .. rank .. " в группе", COLORS.GREEN)
            Stats.Admins = Stats.Admins + 1
        end
        
        local coreGui = player:FindFirstChild("PlayerGui")
        if coreGui then
            for _, obj in ipairs(coreGui:GetDescendants()) do
                if obj:IsA("ScreenGui") and obj.Name:find("Admin") then
                    Print("[ADMIN GUI] " .. player.Name .. " имеет админку: " .. obj.Name, COLORS.YELLOW)
                    
                    local backdoorInfo = {
                        path = obj:GetFullName(),
                        type = "GUI",
                        pattern = "ADMIN_GUI",
                        desc = "Админское GUI",
                        object = obj,
                        player = player,
                        activated = false
                    }
                    table.insert(FoundBackdoors, backdoorInfo)
                end
            end
        end
    end
end

-- Функция дампа кода
local function DumpCode()
    local dump = ""
    dump = dump .. "===== SCANNER RESULTS =====\n"
    dump = dump .. "Time: " .. os.date() .. "\n"
    dump = dump .. "Game: " .. (Services.MarketplaceService:GetProductInfo(game.PlaceId).Name or "Unknown") .. "\n"
    dump = dump .. "Place ID: " .. game.PlaceId .. "\n"
    dump = dump .. "Job ID: " .. game.JobId .. "\n\n"
    
    dump = dump .. "📊 СТАТИСТИКА:\n"
    dump = dump .. "Всего скриптов: " .. Stats.TotalScripts .. "\n"
    dump = dump .. "Уязвимостей: " .. Stats.Vulnerabilities .. "\n"
    dump = dump .. "Бэкдоров: " .. Stats.Backdoors .. "\n"
    dump = dump .. "Эксплоитов: " .. Stats.Exploits .. "\n"
    dump = dump .. "Админов/Рангов: " .. Stats.Admins .. "\n"
    dump = dump .. "loadstring вызовов: " .. Stats.Loadstrings .. "\n"
    dump = dump .. "Скрытых объектов: " .. Stats.HiddenObjects .. "\n\n"
    
    dump = dump .. "🔍 НАЙДЕННЫЕ УЯЗВИМОСТИ:\n"
    for i, vuln in ipairs(FoundVulns) do
        dump = dump .. i .. ". " .. vuln .. "\n"
    end
    
    dump = dump .. "\n🔥 НАЙДЕННЫЕ БЭКДОРЫ (ДЛЯ АКТИВАЦИИ):\n"
    for i, backdoor in ipairs(FoundBackdoors) do
        dump = dump .. i .. ". [" .. backdoor.type .. "] " .. backdoor.path .. " - " .. backdoor.desc .. "\n"
    end
    
    return dump
end

-- Функция создания GUI
local function CreateGUI()
    local logData = DumpCode()
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ScannerGUI"
    screenGui.Parent = game:GetService("CoreGui")
    screenGui.ResetOnSpawn = false
    
    -- Основное окно
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 800, 0, 600)
    frame.Position = UDim2.new(0.5, -400, 0.5, -300)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    title.Text = "VULNERABILITY SCANNER v2.1 - RESULTS"
    title.TextColor3 = Color3.new(1, 0, 0)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 20
    title.Parent = frame
    
    -- Кнопка закрытия
    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 40, 0, 40)
    close.Position = UDim2.new(1, -40, 0, 0)
    close.Text = "X"
    close.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    close.TextColor3 = Color3.new(1, 1, 1)
    close.Font = Enum.Font.SourceSansBold
    close.TextSize = 20
    close.Parent = title
    close.MouseButton1Click:Connect(function() screenGui:Destroy() end)
    
    -- Вкладки
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, 0, 0, 40)
    tabFrame.Position = UDim2.new(0, 0, 0, 40)
    tabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tabFrame.Parent = frame
    
    -- Кнопки вкладок
    local tabs = {"📊 Статистика", "🔍 Уязвимости", "🔥 Бэкдоры"}
    local tabButtons = {}
    
    for i, tabName in ipairs(tabs) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 150, 0, 30)
        btn.Position = UDim2.new(0, (i-1) * 155 + 10, 0, 5)
        btn.Text = tabName
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.SourceSans
        btn.TextSize = 16
        btn.Parent = tabFrame
        table.insert(tabButtons, btn)
    end
    
    -- Область контента
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -20, 1, -120)
    contentFrame.Position = UDim2.new(0, 10, 0, 90)
    contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    contentFrame.Parent = frame
    
    -- Текстовое поле
    local textBox = Instance.new("TextLabel")
    textBox.Size = UDim2.new(1, -20, 1, -20)
    textBox.Position = UDim2.new(0, 10, 0, 10)
    textBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    textBox.TextColor3 = Color3.new(0, 1, 0)
    textBox.Text = logData
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.TextYAlignment = Enum.TextYAlignment.Top
    textBox.TextWrapped = true
    textBox.TextSize = 14
    textBox.Font = Enum.Font.Code
    textBox.Parent = contentFrame
    
    -- Скролл
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, textBox.TextBounds.Y + 20)
    scroll.ScrollBarThickness = 8
    scroll.Parent = textBox
    
    textBox.Parent = scroll
    
    -- Кнопка активации бэкдоров
    activateBtn.MouseButton1Click:Connect(function()
        Print("\n[!] АКТИВАЦИЯ ВСЕХ НАЙДЕННЫХ БЭКДОРОВ!", COLORS.RED)
        
        for i, backdoor in ipairs(FoundBackdoors) do
            if not backdoor.activated then
                task.wait(0.5) -- Небольшая задержка
                ActivateBackdoor(backdoor)
            end
        end
        
        Print("[+] Все бэкдоры обработаны!", COLORS.GREEN)
    end)
    
    -- Показываем первую вкладку
    ShowTab(1)
    
    return screenGui
end

-- ГЛАВНАЯ ФУНКЦИЯ
local function Main()
    Print("\n" .. COLORS.CYAN .. string.rep("=", 60) .. COLORS.RESET)
    Print("🔍 VULNERABILITY SCANNER v2.1 ЗАПУЩЕН", COLORS.MAGENTA)
    Print("📁 Game: " .. (Services.MarketplaceService:GetProductInfo(game.PlaceId).Name or "Unknown"), COLORS.CYAN)
    Print("🆔 Place ID: " .. game.PlaceId, COLORS.CYAN)
    Print(string.rep("=", 60) .. "\n")
    
    -- Сканируем все скрипты
    Print("[+] Сканирование скриптов...", COLORS.BLUE)
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("Script") or obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
            ScanScript(obj, obj:GetFullName())
            
            if SETTINGS.DeepScan then
                task.wait()
            end
        end
    end
    
    -- Дополнительные проверки
    FindHidden()
    FindRemotes()
    FindAdmins()
    
    -- Поиск в глобальном окружении
    Print("\n[+] Проверка глобального окружения...", COLORS.BLUE)
    local env = getfenv()
    for name, value in pairs(env) do
        if type(value) == "function" and (name:lower():find("admin") or name:lower():find("backdoor")) then
            Print("[FUNCTION] Найдена подозрительная функция: " .. name, COLORS.YELLOW)
            
            local backdoorInfo = {
                path = "_G." .. name,
                type = "FUNCTION",
                pattern = "GLOBAL_FUNCTION",
                desc = "Глобальная функция: " .. name,
                object = value,
                activated = false
            }
            table.insert(FoundBackdoors, backdoorInfo)
            Stats.Backdoors = Stats.Backdoors + 1
        end
    end
    
    -- Выводим статистику
    Print("\n" .. string.rep("=", 60), COLORS.CYAN)
    Print("📊 ИТОГОВАЯ СТАТИСТИКА:", COLORS.GREEN)
    Print("   Всего скриптов: " .. Stats.TotalScripts, COLORS.WHITE)
    Print("   Уязвимостей: " .. Stats.Vulnerabilities, Stats.Vulnerabilities > 0 and COLORS.RED or COLORS.GREEN)
    Print("   Бэкдоров: " .. Stats.Backdoors, Stats.Backdoors > 0 and COLORS.RED or COLORS.GREEN)
    Print("   Эксплоитов: " .. Stats.Exploits, Stats.Exploits > 0 and COLORS.RED or COLORS.GREEN)
    Print("   loadstring: " .. Stats.Loadstrings, Stats.Loadstrings > 0 and COLORS.YELLOW or COLORS.GREEN)
    Print("   Админы/Ранги: " .. Stats.Admins, Stats.Admins > 0 and COLORS.YELLOW or COLORS.GREEN)
    Print("   Скрытые объекты: " .. Stats.HiddenObjects, Stats.HiddenObjects > 0 and COLORS.YELLOW or COLORS.GREEN)
    Print(string.rep("=", 60) .. "\n")
    
    -- Сохраняем лог
    local logData = DumpCode()
    SaveLog(logData)
    
    -- Создаем GUI
    local gui = CreateGUI()
    
    -- Уведомление если найдены бэкдоры
    if #FoundBackdoors > 0 then
        Print("\n" .. COLORS.RED .. "⚠️  ВНИМАНИЕ! Найдено " .. #FoundBackdoors .. " потенциальных бэкдоров!" .. COLORS.RESET)
        Print("   Используйте кнопку ACTIVATE BACKDOORS в GUI для их активации", COLORS.YELLOW)
        
        -- Показываем список
        for i, backdoor in ipairs(FoundBackdoors) do
            Print("   " .. i .. ". [" .. backdoor.type .. "] " .. backdoor.path, COLORS.RED)
        end
    end
    
    Print("\n[+] Готово! Результаты в GUI и сохранены в файл", COLORS.GREEN)
end

-- Запуск с защитой от ошибок
local success, err = pcall(Main)
if not success then
    Print("[ERROR] " .. tostring(err), COLORS.RED)
    
    -- Создаем простое GUI с ошибкой
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game:GetService("CoreGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 200)
    frame.Position = UDim2.new(0.5, -200, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    frame.Parent = screenGui
    
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, -20, 1, -20)
    text.Position = UDim2.new(0, 10, 0, 10)
    text.Text = "ОШИБКА СКАНЕРА:\n\n" .. tostring(err)
    text.TextColor3 = Color3.new(1, 1, 1)
    text.TextWrapped = true
    text.Font = Enum.Font.SourceSans
    text.TextSize = 16
    text.Parent = frame
    
    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 100, 0, 30)
    close.Position = UDim2.new(0.5, -50, 1, -40)
    close.Text = "Закрыть"
    close.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    close.TextColor3 = Color3.new(1, 1, 1)
    close.Parent = frame
    close.MouseButton1Click:Connect(function() screenGui:Destroy() end)
end
