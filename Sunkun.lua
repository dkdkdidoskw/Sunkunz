-- 孙坤脚本公告UI
-- 作者：孙坤
-- 不必要加密不重要的脚本😏

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 创建主UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SunKunAnnouncement"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- 添加背景模糊
local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Name = "UIBlur"
BlurEffect.Size = 10
BlurEffect.Parent = game:GetService("Lighting")

-- 主容器
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Position = UDim2.new(0.5, -20, 0.5, -30)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- 圆角效果
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- 边缘发光效果（彩色闪烁）
local EdgeGlow = Instance.new("UIStroke")
EdgeGlow.Name = "EdgeGlow"
EdgeGlow.Parent = MainFrame
EdgeGlow.Color = Color3.fromRGB(255, 0, 0)
EdgeGlow.Thickness = 3
EdgeGlow.Transparency = 0.2
EdgeGlow.LineJoinMode = Enum.LineJoinMode.Round

-- 标题栏
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BackgroundTransparency = 0.5
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

-- 标题文本（彩色闪烁）
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(0.5, 0, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "孙坤脚本|公告"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 20
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- 关闭按钮
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 70, 0, 30)
CloseButton.Position = UDim2.new(1, -70, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BackgroundTransparency = 0.2
CloseButton.Text = "关闭"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

-- 右侧标签容器
local TagContainer = Instance.new("Frame")
TagContainer.Name = "TagContainer"
TagContainer.Size = UDim2.new(0.4, 0, 1, 0)
TagContainer.Position = UDim2.new(0.6, 0, 0, 0)
TagContainer.BackgroundTransparency = 1
TagContainer.Parent = TitleBar

-- 云端标签
local CloudTag = Instance.new("TextButton")
CloudTag.Name = "CloudTag"
CloudTag.Size = UDim2.new(0, 60, 0, 25)
CloudTag.Position = UDim2.new(0, 5, 0.5, -12)
CloudTag.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
CloudTag.BackgroundTransparency = 0.3
CloudTag.Text = "云端"
CloudTag.TextColor3 = Color3.fromRGB(255, 255, 255)
CloudTag.TextSize = 12
CloudTag.Font = Enum.Font.Gotham
CloudTag.Parent = TagContainer

local CloudCorner = Instance.new("UICorner")
CloudCorner.CornerRadius = UDim.new(0, 8)
CloudCorner.Parent = CloudTag

-- 缝合标签
local StitchTag = Instance.new("TextButton")
StitchTag.Name = "StitchTag"
StitchTag.Size = UDim2.new(0, 60, 0, 25)
StitchTag.Position = UDim2.new(0, 70, 0.5, -12)
StitchTag.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
StitchTag.BackgroundTransparency = 0.3
StitchTag.Text = "缝合"
StitchTag.TextColor3 = Color3.fromRGB(255, 255, 255)
StitchTag.TextSize = 12
CloudTag.Font = Enum.Font.Gotham
StitchTag.Parent = TagContainer

local StitchCorner = Instance.new("UICorner")
StitchCorner.CornerRadius = UDim.new(0, 8)
StitchCorner.Parent = StitchTag

-- 版本标签
local VersionTag = Instance.new("TextButton")
VersionTag.Name = "VersionTag"
VersionTag.Size = UDim2.new(0, 70, 0, 25)
VersionTag.Position = UDim2.new(0, 135, 0.5, 10)
VersionTag.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
VersionTag.BackgroundTransparency = 0.3
VersionTag.Text = "版本v0.1"
VersionTag.TextColor3 = Color3.fromRGB(255, 255, 255)
VersionTag.TextSize = 12
VersionTag.Font = Enum.Font.Gotham
VersionTag.Parent = TagContainer

local VersionCorner = Instance.new("UICorner")
VersionCorner.CornerRadius = UDim.new(0, 8)
VersionCorner.Parent = VersionTag

-- 内容滚动框
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, -20, 1, -240)
ScrollFrame.Position = UDim2.new(0, 10, 0, 50)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollingEnabled = true
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
ScrollFrame.Parent = MainFrame

-- 公告内容
local AnnouncementContent = [[
欢迎你使用孙坤脚本(以后会一直更新(稍微快))＞ω＜

1.请遵守roblox规则规定
2.免费脚本(禁止倒卖)
3.仅供学习交流使用
5.使用后果自负

---【更新日记】---
1.增加公告UI
2.增加测试版
3.增加正式版
4.优化脚本性能
5.修复已知问题
6.增加云端功能
7.增加彩色特效
]]

local ContentText = Instance.new("TextLabel")
ContentText.Name = "ContentText"
ContentText.Size = UDim2.new(1, -10, 0, 0)
ContentText.BackgroundTransparency = 1
ContentText.Text = AnnouncementContent
ContentText.TextColor3 = Color3.fromRGB(255, 255, 255)
ContentText.TextSize = 14
ContentText.Font = Enum.Font.Gotham
ContentText.TextXAlignment = Enum.TextXAlignment.Left
ContentText.TextYAlignment = Enum.TextYAlignment.Top
ContentText.TextWrapped = true
ContentText.AutomaticSize = Enum.AutomaticSize.Y
ContentText.Parent = ScrollFrame

-- 更新滚动框大小
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ContentText.TextBounds.Y + 20)

-- 勾选同意区域
local AgreeSection = Instance.new("Frame")
AgreeSection.Name = "AgreeSection"
AgreeSection.Size = UDim2.new(1, -20, 0, 30)
AgreeSection.Position = UDim2.new(0, 10, 1, -180)
AgreeSection.BackgroundTransparency = 1
AgreeSection.Parent = MainFrame

-- 勾选按钮
local CheckBox = Instance.new("TextButton")
CheckBox.Name = "CheckBox"
CheckBox.Size = UDim2.new(0, 25, 0, 25)
CheckBox.Position = UDim2.new(0, 0, 0, 0)
CheckBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CheckBox.Text = " "
CheckBox.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckBox.TextSize = 20
CheckBox.Font = Enum.Font.GothamBold
CheckBox.Parent = AgreeSection

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 5)
CheckCorner.Parent = CheckBox

-- 勾选文本
local CheckText = Instance.new("TextLabel")
CheckText.Name = "CheckText"
CheckText.Size = UDim2.new(0.8, 0, 1, 0)
CheckText.Position = UDim2.new(0, 35, 0, 0)
CheckText.BackgroundTransparency = 1
CheckText.Text = "勾选同意签署用户协议"
CheckText.TextColor3 = Color3.fromRGB(200, 200, 200)
CheckText.TextSize = 14
CheckText.Font = Enum.Font.Gotham
CheckText.TextXAlignment = Enum.TextXAlignment.Left
CheckText.Parent = AgreeSection

-- 按钮容器
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Name = "ButtonContainer"
ButtonContainer.Size = UDim2.new(1, -20, 0, 120)
ButtonContainer.Position = UDim2.new(0, 10, 1, -140)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

-- 不同意按钮
local DisagreeButton = Instance.new("TextButton")
DisagreeButton.Name = "DisagreeButton"
DisagreeButton.Size = UDim2.new(1, 0, 0, 40)
DisagreeButton.Position = UDim2.new(0, 0, 0, 0)
DisagreeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
DisagreeButton.BackgroundTransparency = 0.2
DisagreeButton.Text = "不同意签署进入"
DisagreeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DisagreeButton.TextSize = 16
DisagreeButton.Font = Enum.Font.GothamBold
DisagreeButton.Parent = ButtonContainer

local DisagreeCorner = Instance.new("UICorner")
DisagreeCorner.CornerRadius = UDim.new(0, 8)
DisagreeCorner.Parent = DisagreeButton

-- 测试版按钮
local TestButton = Instance.new("TextButton")
TestButton.Name = "TestButton"
TestButton.Size = UDim2.new(0.48, 0, 0, 40)
TestButton.Position = UDim2.new(0, 0, 0, 50)
TestButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
TestButton.BackgroundTransparency = 0.2
TestButton.Text = "使用测试版"
TestButton.TextColor3 = Color3.fromRGB(200, 200, 200)
TestButton.TextSize = 16
TestButton.Font = Enum.Font.GothamBold
TestButton.Parent = ButtonContainer

local TestCorner = Instance.new("UICorner")
TestCorner.CornerRadius = UDim.new(0, 8)
TestCorner.Parent = TestButton

-- 正式版按钮
local FormalButton = Instance.new("TextButton")
FormalButton.Name = "FormalButton"
FormalButton.Size = UDim2.new(0.48, 0, 0, 40)
FormalButton.Position = UDim2.new(0.52, 0, 0, 50)
FormalButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
FormalButton.BackgroundTransparency = 0.2
FormalButton.Text = "使用正式版"
FormalButton.TextColor3 = Color3.fromRGB(200, 200, 200)
FormalButton.TextSize = 16
FormalButton.Font = Enum.Font.GothamBold
FormalButton.Parent = ButtonContainer

local FormalCorner = Instance.new("UICorner")
FormalCorner.CornerRadius = UDim.new(0, 8)
FormalCorner.Parent = FormalButton

-- 变量
local isChecked = false
local glowTween
local titleGlowTween
local buttonGlowTween

-- 标题闪烁颜色
local titleColors = {
    Color3.fromRGB(255, 50, 50),   -- 红色
    Color3.fromRGB(50, 255, 50),   -- 绿色
    Color3.fromRGB(50, 50, 255)    -- 蓝色
}

-- UI边缘闪烁颜色
local edgeColors = {
    Color3.fromRGB(255, 0, 0),     -- 红色
    Color3.fromRGB(0, 255, 0),     -- 绿色
    Color3.fromRGB(0, 0, 255),     -- 蓝色
    Color3.fromRGB(255, 255, 0),   -- 黄色
    Color3.fromRGB(255, 0, 255),   -- 紫色
    Color3.fromRGB(0, 255, 255)    -- 青色
}

-- 按钮闪烁颜色
local buttonColors = {
    Color3.fromRGB(255, 100, 100), -- 亮红色
    Color3.fromRGB(100, 255, 100), -- 亮绿色
    Color3.fromRGB(100, 100, 255)  -- 亮蓝色
}

-- 标题闪烁动画
local function startTitleAnimation()
    local colorIndex = 1
    titleGlowTween = TweenService:Create(
        TitleText,
        TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
        {TextColor3 = titleColors[colorIndex]}
    )
    titleGlowTween:Play()
    
    titleGlowTween.Completed:Connect(function()
        if TitleText.Parent then
            colorIndex = colorIndex + 1
            if colorIndex > #titleColors then
                colorIndex = 1
            end
            startTitleAnimation()
        end
    end)
end

-- UI边缘闪烁动画
local function startEdgeAnimation()
    local edgeIndex = 1
    glowTween = TweenService:Create(
        EdgeGlow,
        TweenInfo.new(0.8, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
        {Color = edgeColors[edgeIndex]}
    )
    glowTween:Play()
    
    glowTween.Completed:Connect(function()
        if EdgeGlow.Parent then
            edgeIndex = edgeIndex + 1
            if edgeIndex > #edgeColors then
                edgeIndex = 1
            end
            startEdgeAnimation()
        end
    end)
end

-- 按钮闪烁动画
local function startButtonAnimation()
    local buttonIndex = 1
    buttonGlowTween = TweenService:Create(
        TestButton.UIStroke or EdgeGlow,
        TweenInfo.new(1.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
        {Color = buttonColors[buttonIndex]}
    )
    buttonGlowTween:Play()
    
    buttonGlowTween.Completed:Connect(function()
        if TestButton.Parent then
            buttonIndex = buttonIndex + 1
            if buttonIndex > #buttonColors then
                buttonIndex = 1
            end
            startButtonAnimation()
        end
    end)
end

-- 为所有按钮添加边缘效果
for _, button in pairs({CloseButton, CloudTag, StitchTag, VersionTag, CheckBox, DisagreeButton, TestButton, FormalButton}) do
    local stroke = Instance.new("UIStroke")
    stroke.Parent = button
    stroke.Color = button.Parent == TestButton and Color3.fromRGB(100, 100, 255) or Color3.fromRGB(100, 100, 100)
    stroke.Thickness = 2
    stroke.Transparency = 0.3
end

-- 云端标签点击事件
CloudTag.MouseButton1Click:Connect(function()
    local originalText = CloudTag.Text
    CloudTag.Text = "github.com"
    CloudTag.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    
    task.wait(5)
    
    CloudTag.Text = originalText
    CloudTag.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
end)

-- 缝合标签点击事件
StitchTag.MouseButton1Click:Connect(function()
    local originalText = StitchTag.Text
    StitchTag.Text = "缝合版v0.1"
    
    task.wait(2)
    
    StitchTag.Text = originalText
end)

-- 版本标签点击事件
VersionTag.MouseButton1Click:Connect(function()
    local originalText = VersionTag.Text
    VersionTag.Text = "最新版本"
    
    task.wait(3)
    
    VersionTag.Text = originalText
end)

-- 勾选按钮功能
CheckBox.MouseButton1Click:Connect(function()
    isChecked = not isChecked
    if isChecked then
        CheckBox.Text = "✓"
        CheckBox.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        
        -- 启用正式版和测试版按钮
        FormalButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        FormalButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        TestButton.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
        TestButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        CheckBox.Text = " "
        CheckBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        
        -- 禁用正式版和测试版按钮
        FormalButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        FormalButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        
        TestButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        TestButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end)

-- 关闭按钮功能
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    BlurEffect:Destroy()
    print("孙坤脚本UI已关闭")
end)

-- 不同意按钮功能
DisagreeButton.MouseButton1Click:Connect(function()
    -- 运行三个脚本
    print("运行不同意脚本...")
    
    local success1, err1 = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dkdkdidoskw/Sunkunz/main/1.lua"))()
    end)
    
    local success2, err2 = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dkdkdidoskw/Sunkunz/main/2.lua"))()
    end)
    
    local success3, err3 = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dkdkdidoskw/Sunkunz/main/3.lua"))()
    end)
    
    if success1 and success2 and success3 then
        print("所有脚本已成功运行！")
    else
        print("部分脚本运行失败！")
    end
    
    -- 关闭UI
    task.wait(1)
    ScreenGui:Destroy()
    BlurEffect:Destroy()
end)

-- 测试版按钮功能
TestButton.MouseButton1Click:Connect(function()
    if not isChecked then
        TestButton.Text = "请先勾选同意"
        TestButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        
        task.wait(2)
        
        if isChecked then
            TestButton.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
        else
            TestButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        end
        TestButton.Text = "使用测试版"
        return
    end
    
    TestButton.Text = "加载中..."
    
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dkdkdidoskw/Sunkunz/main/Sunkunkey1.lua"))()
    end)
    
    if success then
        TestButton.Text = "成功！"
        TestButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        
        task.wait(2)
        
        ScreenGui:Destroy()
        BlurEffect:Destroy()
        print("孙坤测试版脚本已启动")
    else
        TestButton.Text = "加载失败"
        TestButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        
        task.wait(2)
        
        TestButton.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
        TestButton.Text = "使用测试版"
    end
end)

-- 正式版按钮功能
FormalButton.MouseButton1Click:Connect(function()
    if not isChecked then
        FormalButton.Text = "请先勾选同意"
        FormalButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        
        task.wait(2)
        
        if isChecked then
            FormalButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        else
            FormalButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        end
        FormalButton.Text = "使用正式版"
        return
    end
    
    FormalButton.Text = "加载中..."
    
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dkdkdidoskw/Sunkunz1/main/Sunkun正式.lua"))()
    end)
    
    if success then
        FormalButton.Text = "成功！"
        FormalButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        
        task.wait(2)
        
        ScreenGui:Destroy()
        BlurEffect:Destroy()
        print("孙坤正式版脚本已启动")
    else
        FormalButton.Text = "加载失败"
        FormalButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        
        task.wait(2)
        
        FormalButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        FormalButton.Text = "使用正式版"
    end
end)

-- 启动所有动画
startTitleAnimation()
startEdgeAnimation()
startButtonAnimation()

-- 清理连接
ScreenGui.Destroying:Connect(function()
    if glowTween then
        glowTween:Cancel()
    end
    if titleGlowTween then
        titleGlowTween:Cancel()
    end
    if buttonGlowTween then
        buttonGlowTween:Cancel()
    end
    if BlurEffect then
        BlurEffect:Destroy()
    end
end)

print("孙坤脚本公告UI已加载！")
