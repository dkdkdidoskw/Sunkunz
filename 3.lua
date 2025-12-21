-- 最后一个😂脚本
-- 常常更新这里不再添加4丶5丶6丶7丶8丶9等等

-- 初始化服务
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Chat = game:GetService("Chat")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- 获取本地玩家
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 配置设置
local CONFIG = {
    Messages = {
        "祝福孙坤万亿岁！🤑😎",
        "qq🐧927072454加入我们😎"
    },
    MusicId = 6868100434,
    TitleColor = Color3.fromRGB(128, 0, 128), -- 紫色
    TextColor = Color3.fromRGB(255, 0, 0), -- 红色
    FireColor = Color3.new(1, 0.5, 0),
    FloodTransparency = 0.7,
    FloodColor = Color3.fromRGB(0, 100, 255)
}

-- 存储创建对象的表
local createdObjects = {
    shapes = {},
    effects = {},
    texts = {},
    highlights = {},
    boxes = {},
    healthbars = {},
    floodParts = {},
    sounds = {},
    guis = {}
}

-- 1. 聊天框刷屏功能
local function setupChatSpam()
    spawn(function()
        while true do
            for _, message in ipairs(CONFIG.Messages) do
                local chatEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                if chatEvent then
                    local sayMessage = chatEvent:FindFirstChild("SayMessageRequest")
                    if sayMessage then
                        sayMessage:FireServer(message, "All")
                    end
                end
                wait(0.1)
            end
        end
    end)
end

-- 2. 生成3D形状
local function createRandomShape()
    local shapeTypes = {"Ball", "Block", "Wedge", "Cylinder"}
    local colors = {
        Color3.new(1, 0, 0),
        Color3.new(0, 1, 0),
        Color3.new(0, 0, 1),
        Color3.new(1, 1, 0),
        Color3.new(1, 0, 1),
        Color3.new(0, 1, 1)
    }
    
    local shapeType = shapeTypes[math.random(1, #shapeTypes)]
    local shape
    
    if shapeType == "Ball" then
        shape = Instance.new("Part")
        shape.Shape = Enum.PartType.Ball
    elseif shapeType == "Block" then
        shape = Instance.new("Part")
    elseif shapeType == "Wedge" then
        shape = Instance.new("WedgePart")
    elseif shapeType == "Cylinder" then
        shape = Instance.new("Part")
        shape.Shape = Enum.PartType.Cylinder
    end
    
    shape.Size = Vector3.new(
        math.random(5, 20),
        math.random(5, 20),
        math.random(5, 20)
    )
    shape.Color = colors[math.random(1, #colors)]
    shape.Material = Enum.Material.Neon
    shape.Anchored = true
    shape.CanCollide = false
    shape.Transparency = 0.3
    
    shape.Position = Vector3.new(
        math.random(-200, 200),
        math.random(50, 200),
        math.random(-200, 200)
    )
    
    -- 添加标题
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.StudsOffset = Vector3.new(0, shape.Size.Y/2 + 5, 0)
    billboard.Adornee = shape
    billboard.AlwaysOnTop = true
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Text = "sunkun"
    textLabel.TextColor3 = CONFIG.TitleColor
    textLabel.TextScaled = true
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Parent = billboard
    billboard.Parent = shape
    
    shape.Parent = Workspace
    table.insert(createdObjects.shapes, shape)
    
    spawn(function()
        while shape and shape.Parent do
            shape.CFrame = shape.CFrame * CFrame.Angles(0, math.rad(1), 0)
            wait()
        end
    end)
end

-- 3. 播放音乐（带错误处理）
local function playMusic()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. tostring(CONFIG.MusicId)
    sound.Looped = true
    sound.Volume = 0.5
    sound.Parent = Workspace
    
    local success, err = pcall(function()
        sound:Play()
    end)
    
    if success then
        table.insert(createdObjects.sounds, sound)
    else
        -- 使用备用音乐
        sound:Destroy()
        local backupSound = Instance.new("Sound")
        backupSound.SoundId = "rbxassetid://9126706502"
        backupSound.Looped = true
        backupSound.Volume = 0.5
        backupSound.Parent = Workspace
        backupSound:Play()
        table.insert(createdObjects.sounds, backupSound)
    end
end

-- 4. 添加火焰效果到所有对象
local function addFireToAllObjects()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:FindFirstChild("ClientFire") then
            local fire = Instance.new("Fire")
            fire.Name = "ClientFire"
            fire.Color = CONFIG.FireColor
            fire.SecondaryColor = Color3.new(1, 1, 0)
            fire.Size = 5
            fire.Heat = 10
            fire.Parent = obj
            table.insert(createdObjects.effects, fire)
        end
    end
end

-- 5. 边缘闪烁效果
local function addEdgeGlow()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:FindFirstChild("ClientHighlight") then
            local highlight = Instance.new("Highlight")
            highlight.Name = "ClientHighlight"
            highlight.Adornee = obj
            highlight.FillTransparency = 1
            highlight.OutlineColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
            highlight.Parent = obj
            
            spawn(function()
                while highlight and highlight.Parent do
                    highlight.OutlineColor = Color3.fromHSV((tick() % 3) / 3, 1, 1)
                    highlight.OutlineTransparency = math.sin(tick() * 5) * 0.3
                    wait()
                end
            end)
            
            table.insert(createdObjects.highlights, highlight)
        end
    end
end

-- 6. 白色方块框架
local function addWhiteFrames()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:FindFirstChild("ClientBox") then
            local box = Instance.new("SelectionBox")
            box.Name = "ClientBox"
            box.Adornee = obj
            box.Color3 = Color3.new(1, 1, 1)
            box.LineThickness = 0.05
            box.Parent = obj
            table.insert(createdObjects.boxes, box)
        end
    end
end

-- 7. 显示文本标签
local function addTextLabels()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:FindFirstChild("ClientText") then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ClientText"
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.StudsOffset = Vector3.new(0, obj.Size.Y/2 + 2, 0)
            billboard.Adornee = obj
            billboard.AlwaysOnTop = true
            billboard.MaxDistance = 1000
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.Text = "sunkun的后门服务器😎"
            textLabel.TextColor3 = CONFIG.TextColor
            textLabel.TextTransparency = 0.3
            textLabel.TextSize = 18  -- 固定字体大小，避免约束错误
            textLabel.TextWrapped = true
            textLabel.BackgroundTransparency = 1
            textLabel.Font = Enum.Font.GothamBold
            textLabel.Parent = billboard
            billboard.Parent = obj
            
            table.insert(createdObjects.texts, billboard)
        end
    end
end

-- 8. 血条系统
local function setupHealthBars()
    local function addHealthBar(humanoid, character)
        if character and not character:FindFirstChild("ClientHealthBar") then
            local head = character:FindFirstChild("Head")
            if not head then return end
            
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ClientHealthBar"
            billboard.Size = UDim2.new(0, 100, 0, 20)
            billboard.StudsOffset = Vector3.new(0, 5, 0)
            billboard.Adornee = head
            billboard.AlwaysOnTop = true
            
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.BackgroundColor3 = Color3.new(0, 0, 0)
            frame.BackgroundTransparency = 0.3
            frame.BorderSizePixel = 2
            frame.BorderColor3 = Color3.new(1, 1, 1)
            
            local healthBar = Instance.new("Frame")
            healthBar.Name = "HealthBar"
            healthBar.Size = UDim2.new(1, 0, 1, 0)
            healthBar.BackgroundColor3 = Color3.new(0, 1, 0)
            healthBar.BorderSizePixel = 0
            healthBar.Parent = frame
            
            frame.Parent = billboard
            billboard.Parent = character
            
            spawn(function()
                while humanoid and humanoid.Parent and healthBar and healthBar.Parent do
                    local healthPercent = humanoid.Health / humanoid.MaxHealth
                    healthBar.Size = UDim2.new(healthPercent, 0, 1, 0)
                    
                    if healthPercent > 0.5 then
                        healthBar.BackgroundColor3 = Color3.new(0, 1, 0)
                    elseif healthPercent > 0.2 then
                        healthBar.BackgroundColor3 = Color3.new(1, 1, 0)
                    else
                        healthBar.BackgroundColor3 = Color3.new(1, 0, 0)
                    end
                    
                    wait(0.1)
                end
            end)
            
            table.insert(createdObjects.healthbars, billboard)
        end
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then
                addHealthBar(humanoid, player.Character)
            end
        end
    end
    
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            wait(1)
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                addHealthBar(humanoid, character)
            end
        end)
    end)
    
    Workspace.ChildAdded:Connect(function(child)
        wait(1)
        local humanoid = child:FindFirstChild("Humanoid")
        if humanoid then
            addHealthBar(humanoid, child)
        end
    end)
end

-- 9. 洪水生成
local function createFlood()
    local floodSize = 1000
    local partSize = 50
    
    for x = -floodSize, floodSize, partSize do
        for z = -floodSize, floodSize, partSize do
            local waterPart = Instance.new("Part")
            waterPart.Name = "ClientFlood"
            waterPart.Size = Vector3.new(partSize, 1, partSize)
            waterPart.Position = Vector3.new(x, 5, z)
            waterPart.Color = CONFIG.FloodColor
            waterPart.Material = Enum.Material.Water
            waterPart.Transparency = CONFIG.FloodTransparency
            waterPart.Anchored = true
            waterPart.CanCollide = false
            waterPart.Parent = Workspace
            
            spawn(function()
                while waterPart and waterPart.Parent do
                    waterPart.Position = Vector3.new(
                        waterPart.Position.X,
                        5 + math.sin(tick() + x/100) * 2,
                        waterPart.Position.Z
                    )
                    wait(0.1)
                end
            end)
            
            table.insert(createdObjects.floodParts, waterPart)
        end
    end
end

-- 10. 清理函数
local function cleanup()
    for category, objectList in pairs(createdObjects) do
        if type(objectList) == "table" then
            for _, obj in ipairs(objectList) do
                if obj and obj.Parent then
                    pcall(function()
                        obj:Destroy()
                    end)
                end
            end
        end
    end
    
    -- 重新初始化表格
    createdObjects = {
        shapes = {},
        effects = {},
        texts = {},
        highlights = {},
        boxes = {},
        healthbars = {},
        floodParts = {},
        sounds = {},
        guis = {}
    }
end

-- 主循环
local function mainLoop()
    -- 启动所有功能
    setupChatSpam()
    playMusic()
    setupHealthBars()
    createFlood()
    
    -- 定期生成形状
    spawn(function()
        while true do
            createRandomShape()
            wait(0.5)
        end
    end)
    
    -- 定期添加效果
    spawn(function()
        while true do
            addFireToAllObjects()
            addEdgeGlow()
            addWhiteFrames()
            addTextLabels()
            wait(2)
        end
    end)
end

-- 安全执行
local success, err = pcall(function()
    -- 清理之前的实例
    cleanup()
    
    -- 启动主循环
    mainLoop()
    
    print("sunkun效果脚本已成功启动！")
end)

if not success then
    warn("脚本执行错误:", err)
end

-- 游戏退出时清理
game:GetService("UserInputService").WindowFocusReleased:Connect(function()
    -- 仅在窗口失去焦点时不清理，保持效果
end)

-- 玩家离开时清理
LocalPlayer.CharacterRemoving:Connect(function()
    cleanup()
end)
