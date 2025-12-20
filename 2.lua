-- 客户端脚本，放在StarterPlayerScripts或LocalScript中
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 创建屏幕GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CoolkiddNotifications"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- 创建消息容器
local notificationContainer = Instance.new("Frame")
notificationContainer.Name = "NotificationContainer"
notificationContainer.Size = UDim2.new(0, 300, 1, -20)
notificationContainer.Position = UDim2.new(1, 10, 1, -10) -- 初始位置在屏幕外右侧
notificationContainer.AnchorPoint = Vector2.new(1, 1) -- 右下角锚点
notificationContainer.BackgroundTransparency = 1
notificationContainer.Parent = screenGui

-- 消息框样式
local function createMessageFrame(message)
    local messageFrame = Instance.new("Frame")
    messageFrame.Name = "MessageFrame"
    messageFrame.Size = UDim2.new(0, 0, 0, 40) -- 初始宽度为0
    messageFrame.Position = UDim2.new(1, 0, 1, -50) -- 右下角
    messageFrame.AnchorPoint = Vector2.new(1, 1)
    messageFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    messageFrame.BackgroundTransparency = 0.5
    messageFrame.BorderSizePixel = 0
    messageFrame.ClipsDescendants = true
    
    -- 圆角
    local uICorner = Instance.new("UICorner")
    uICorner.CornerRadius = UDim.new(0, 8)
    uICorner.Parent = messageFrame
    
    -- 阴影
    local uIStroke = Instance.new("UIStroke")
    uIStroke.Color = Color3.new(1, 1, 1)
    uIStroke.Transparency = 0.8
    uIStroke.Thickness = 1
    uIStroke.Parent = messageFrame
    
    -- 文本标签
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "MessageText"
    textLabel.Size = UDim2.new(1, -20, 1, -10)
    textLabel.Position = UDim2.new(0, 10, 0, 5)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = message
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.Font = Enum.Font.GothamSemibold
    textLabel.TextSize = 16
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextWrapped = false
    textLabel.TextScaled = false
    textLabel.Parent = messageFrame
    
    return messageFrame
end

-- 动画：消息框从右侧滑入
local function slideInAnimation(messageFrame)
    local tweenInfo = TweenInfo.new(
        0.5, -- 持续时间
        Enum.EasingStyle.Quad, -- 缓动样式
        Enum.EasingDirection.Out -- 缓动方向
    )
    
    local tween = TweenService:Create(messageFrame, tweenInfo, {
        Size = UDim2.new(0, 280, 0, 40) -- 展开到完整宽度
    })
    
    tween:Play()
    return tween
end

-- 动画：消息框向上移动
local function moveUpAnimation(messageFrame, targetPosition)
    local tweenInfo = TweenInfo.new(
        0.3,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )
    
    local tween = TweenService:Create(messageFrame, tweenInfo, {
        Position = targetPosition
    })
    
    tween:Play()
    return tween
end

-- 动画：消息框淡出
local function fadeOutAnimation(messageFrame)
    local tweenInfo = TweenInfo.new(
        0.5,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )
    
    local tween = TweenService:Create(messageFrame, tweenInfo, {
        BackgroundTransparency = 1,
        Position = UDim2.new(1, 0, 1, -100) -- 向上移动并淡出
    })
    
    tween:Play()
    
    -- 动画完成后销毁
    tween.Completed:Connect(function()
        messageFrame:Destroy()
    end)
    
    return tween
end

-- 显示消息的函数
local activeMessages = {}
local messageQueue = {}

local function showNotification(message)
    table.insert(messageQueue, message)
end

-- 处理消息队列
local function processQueue()
    if #messageQueue > 0 then
        local message = table.remove(messageQueue, 1)
        
        -- 创建新消息框
        local messageFrame = createMessageFrame(message)
        messageFrame.Parent = notificationContainer
        
        -- 滑入动画
        slideInAnimation(messageFrame)
        
        -- 将所有现有消息上移
        for i, existingFrame in ipairs(activeMessages) do
            local targetPosition = UDim2.new(1, 0, 1, -50 - (i * 50))
            moveUpAnimation(existingFrame, targetPosition)
        end
        
        -- 将新消息添加到列表
        table.insert(activeMessages, 1, messageFrame)
        
        -- 5秒后移除消息
        task.delay(5, function()
            if messageFrame and messageFrame.Parent then
                -- 从活动消息列表中移除
                for i, frame in ipairs(activeMessages) do
                    if frame == messageFrame then
                        table.remove(activeMessages, i)
                        break
                    end
                end
                
                -- 淡出动画
                fadeOutAnimation(messageFrame)
                
                -- 更新剩余消息的位置
                for i, remainingFrame in ipairs(activeMessages) do
                    local targetPosition = UDim2.new(1, 0, 1, -50 - ((i-1) * 50))
                    moveUpAnimation(remainingFrame, targetPosition)
                end
            end
        end)
    end
end

-- 循环显示消息
local messageText = "孙坤军团已入侵😂" -- 孙坤军团已入侵
local isRunning = true

task.spawn(function()
    while isRunning do
        showNotification(messageText)
        task.wait(3) -- 每3秒显示一次新消息
    end
end)

-- 定期处理队列
RunService.Heartbeat:Connect(function()
    processQueue()
end)

-- 清理函数
local function cleanup()
    isRunning = false
    screenGui:Destroy()
end

-- 当玩家离开时清理
player.CharacterRemoving:Connect(cleanup)
game:GetService("UserInputService").WindowFocused:Connect(function()
    -- 窗口焦点变化时也可以调整
end)

-- 可选：添加一个测试按钮（仅开发时使用）
local function addTestButton()
    local testButton = Instance.new("TextButton")
    testButton.Name = "TestButton"
    testButton.Size = UDim2.new(0, 100, 0, 50)
    testButton.Position = UDim2.new(0, 10, 0, 10)
    testButton.Text = "测试消息"
    testButton.Parent = screenGui
    
    testButton.MouseButton1Click:Connect(function()
        showNotification("测试消息: " .. os.time())
    end)
end

-- 取消注释下面这行以启用测试按钮
-- addTestButton()

print("孙坤军团消息系统已启动！")