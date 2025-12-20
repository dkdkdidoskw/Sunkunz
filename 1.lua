-- 本地客户端脚本 - 仅对自己可见
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer

-- 进度条显示
local function showProgressBar()
    local progressText = Drawing.new("Text")
    progressText.Visible = true
    progressText.Font = 2
    progressText.Size = 18
    progressText.Color = Color3.fromRGB(255, 255, 255)
    progressText.Outline = true
    progressText.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    for i = 0, 100 do
        progressText.Text = string.format("加载中: %d%%", i)
        progressText.Position = Vector2.new(10, Workspace.CurrentCamera.ViewportSize.Y - 30)
        task.wait(0.05)
    end
    task.wait(1)
    progressText:Remove()
end

-- 闪烁效果
local function flashEffects()
    local originalColors = {}
    local originalMaterials = {}
    
    -- 保存原始状态
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            originalColors[obj] = obj.Color
            originalMaterials[obj] = obj.Material
        end
    end
    
    -- 闪烁循环
    local colors = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255)}
    for _ = 1, 30 do
        for _, color in ipairs(colors) do
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    obj.Color = color
                    obj.Material = Enum.Material.Neon
                end
            end
            task.wait(0.1)
        end
    end
    
    -- 恢复原始状态
    for obj, color in pairs(originalColors) do
        if obj.Parent then
            obj.Color = color
            obj.Material = originalMaterials[obj]
        end
    end
end

-- 播放音效
local function playSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://4702564143"
    sound.Volume = 3
    sound.Parent = Workspace
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

-- 为玩家添加红色框
local function addPlayerBoxes()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            local highlight = Instance.new("Highlight")
            highlight.Name = "RedBox"
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.FillTransparency = 0.7
            highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineTransparency = 0
            highlight.Parent = player.Character
        end
    end
end

-- 移除玩家装饰品
local function removeAccessories()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            for _, accessory in pairs(player.Character:GetChildren()) do
                if accessory:IsA("Accessory") then
                    accessory:Destroy()
                end
            end
            -- 移除衣服
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                for _, clothing in pairs(humanoid:GetChildren()) do
                    if clothing:IsA("Clothing") or clothing:IsA("ShirtGraphic") then
                        clothing:Destroy()
                    end
                end
            end
        end
    end
end

-- 在玩家头上添加文本
local function addPlayerText()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Head") then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "SunkunText"
            billboard.Adornee = player.Character.Head
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Text = "Sunkun已制裁服务器😂"
            textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            textLabel.TextScaled = true
            textLabel.Font = Enum.Font.SourceSansBold
            textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            textLabel.BackgroundTransparency = 0.5
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.Parent = billboard
            
            billboard.Parent = player.Character.Head
        end
    end
end

-- Configuration --
local Message = "一群废物脚本接收孙坤黑客的入侵吧！😂"
local mes2text = "孙坤脚本中心已入侵！纯娱乐 玩家看不见！"

-- Don't touch unless you know what You're doing --

local mes = Instance.new("Hint")
mes.Parent = workspace
mes.Text = Message
game.Lighting:ClearAllChildren()
game.Lighting.FogEnd = 100
game.Lighting.FogColor = Color3.new(0, 0, 0)
local sound = Instance.new("Sound")
sound.Parent = workspace
sound.Looped = true
sound.PlaybackSpeed = 0.3
sound.Volume = 5
sound.SoundId = "rbxassetid://1842908121"
sound:Play()
local mes2 = Instance.new("Message")
mes2.Parent = workspace
mes2.Text = mes2text
for i, v in pairs(workspace:GetDescendants()) do
	if v:IsA("BasePart") and v.Parent:IsA("Model") then
		local outline = Instance.new("SelectionBox")
		v.Name = Message
		outline.Parent = v
		outline.Adornee = v
		outline.Color3 = Color3.new(1, 1, 1)
		v.Color = Color3.new(0, 0, 0)
		local fire = Instance.new("Fire")
		fire.Parent = v
		fire.Size = 100
		fire.Color = Color3.new(1, 1, 1)
		local sky = Instance.new("Sky")
		sky.CelestialBodiesShown = false
		sky.Parent = game.Lighting
		sky.SkyboxUp = "http://www.roblox.com/asset/?id=99915080584370"
		sky.SkyboxBk = "http://www.roblox.com/asset/?id=99915080584370"
		sky.SkyboxDn = "http://www.roblox.com/asset/?id=99915080584370"
		sky.SkyboxRt = "http://www.roblox.com/asset/?id=99915080584370"
		sky.SkyboxLf = "http://www.roblox.com/asset/?id=99915080584370"
		sky.SkyboxFt = "http://www.roblox.com/asset/?id=99915080584370"
		local bill = Instance.new("BillboardGui")
		local Text = Instance.new("TextLabel")
		bill.Parent = v
		bill.Adornee = v
		bill.Size = UDim2.new(0, 200, 0, 200)
		Text.Parent = bill
		Text.Size = UDim2.new(0, 200, 0, 200)
		Text.BackgroundTransparency = 1
		Text.TextScaled = false
		Text.TextSize = 30
		Text.TextColor3 = Color3.new(1, 0, 0.0156863)
		Text.TextTransparency = 0
		Text.Font = Enum.Font.Cartoon
		Text.Text = Message
	end
end

-- 头部变形效果
local function headTransformation()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            head.Color = Color3.fromRGB(255, 255, 255)
            head.Material = Enum.Material.Neon
            
            -- 形状数组
            local shapes = {"Ball", "Block", "Wedge"}
            local shapeIndex = 1
            
            -- 抖动和变形循环
            local connection
            connection = RunService.Heartbeat:Connect(function()
                -- 变形
                if math.random(1, 20) == 1 then
                    shapeIndex = shapeIndex % #shapes + 1
                    head.Shape = Enum.PartType[shapes[shapeIndex]]
                end
                
                -- 抖动
                head.CFrame = head.CFrame * CFrame.new(
                    math.sin(tick() * 10) * 0.1,
                    math.cos(tick() * 8) * 0.1,
                    0
                )
            end)
            
            -- 跳舞动画
            task.wait(2)
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local danceAnimation = Instance.new("Animation")
                danceAnimation.AnimationId = "rbxassetid://181525230" -- 舞蹈动画ID
                local animator = humanoid:FindFirstChildOfClass("Animator")
                if animator then
                    local danceTrack = animator:LoadAnimation(danceAnimation)
                    danceTrack:Play()
                end
            end
            task.wait(1)
        end
    end
end

-- 改变天空盒
local function changeSkybox()
    local sky = Instance.new("Sky")
    sky.SkyboxBk = "rbxassetid://18990118848"
    sky.SkyboxDn = "rbxassetid://18990118848"
    sky.SkyboxFt = "rbxassetid://18990118848"
    sky.SkyboxLf = "rbxassetid://18990118848"
    sky.SkyboxRt = "rbxassetid://18990118848"
    sky.SkyboxUp = "rbxassetid://18990118848"
    sky.Parent = Lighting
    
    -- 设置TextButton_14的文本（模拟UI更新）
    print("TextButton_14.Text = 'Shedletsky'")
    print("TextButton_14.TextColor3 = Color3.fromRGB(255, 255, 255)")
    print("TextButton_14.TextSize = 29.000")
end



-- 时间加速
local function speedUpTime()
    Lighting:SetMinutesAfterMidnight(Lighting:GetMinutesAfterMidnight() + 1000)
    RunService:Set3dRenderingEnabled(false)
    task.wait(0.1)
    RunService:Set3dRenderingEnabled(true)
end

-- 生成洪水
local function createFlood()
    task.wait(5)
    
    local water = Instance.new("Part")
    water.Name = "FloodWater"
    water.Size = Vector3.new(1000, 50, 1000)
    water.Position = Vector3.new(0, 10, 0)
    water.Color = Color3.fromRGB(0, 120, 255)
    water.Material = Enum.Material.Water
    water.Transparency = 0.3
    water.Anchored = true
    water.CanCollide = true
    water.Parent = Workspace
    
    -- 让水上升
    for i = 1, 100 do
        water.Position = water.Position + Vector3.new(0, 1, 0)
        task.wait(0.1)
    end
end

-- 倒计时踢人
local function countdownAndKick()
    local countdownText = Drawing.new("Text")
    countdownText.Visible = true
    countdownText.Font = 3
    countdownText.Size = 48
    countdownText.Color = Color3.fromRGB(255, 0, 0)
    countdownText.Outline = true
    countdownText.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    for i = 10, 0, -1 do
        countdownText.Text = tostring(i)
        countdownText.Position = Vector2.new(
            Workspace.CurrentCamera.ViewportSize.X / 2 - 20,
            Workspace.CurrentCamera.ViewportSize.Y / 2 - 40
        )
        task.wait(1)
    end
    
    countdownText:Remove()
    LocalPlayer:Kick("脚本执行完成")
end

-- 主执行函数
local function main()
    -- 显示进度条
    task.spawn(showProgressBar)
    
    -- 同时执行多个效果
    task.spawn(flashEffects)
    task.spawn(playSound)
    task.spawn(addPlayerBoxes)
    task.spawn(removeAccessories)
    task.spawn(addPlayerText)
    
    -- 头部变形和跳舞
    task.spawn(headTransformation)
    
    -- 运行用户自定义脚本
    print("运行用户自定义脚本...")
    
    -- 改变天空盒
    changeSkybox()
    
    -- 时间加速
    speedUpTime()
    
    -- 生成洪水
    task.spawn(createFlood)
    
end

-- 安全检查
if not LocalPlayer then
    LocalPlayer = Players.PlayerAdded:Wait()
end

-- 延迟执行以确保游戏加载完成
task.wait(3)
main()