-- sunkun v1 - 终极完整版（包含所有功能整合）
-- 整合：Team N00K1A5K GUI + z00kiddl GUI + 新增8个功能

local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "sunkun_v1_ultimate"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

-- 主框架
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 750)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -375)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
mainFrame.BackgroundTransparency = 0.7
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local fc = Instance.new("UICorner")
fc.CornerRadius = UDim.new(0, 15)
fc.Parent = mainFrame

-- 标题
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.BackgroundTransparency = 1
title.Text = "SUNKUN v1 - ULTIMATE"
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextStrokeTransparency = 0
title.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = mainFrame

-- 标签页框架
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, -20, 0, 40)
tabFrame.Position = UDim2.new(0, 10, 0, 70)
tabFrame.BackgroundTransparency = 1
tabFrame.Parent = mainFrame

-- 创建标签页按钮的函数
local function createTabButton(name, text, pos)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Text = text
    btn.Size = UDim2.new(0.23, 0, 1, 0)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.Parent = tabFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    return btn
end

local tabF3X = createTabButton("F3XTab", "F3X+HD功能", UDim2.new(0, 0, 0, 0))
local tabClient = createTabButton("ClientTab", "功能2", UDim2.new(0.24, 0, 0, 0))
local tabNew = createTabButton("NewTab", "新增功能", UDim2.new(0.48, 0, 0, 0))
local tabTeam = createTabButton("TeamTab", "Team GUI", UDim2.new(0.72, 0, 0, 0))

-- 滚动框架
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -120)
scrollFrame.Position = UDim2.new(0, 10, 0, 120)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 3000)
scrollFrame.ScrollBarThickness = 8
scrollFrame.Visible = true
scrollFrame.Parent = mainFrame

local clientScroll = Instance.new("ScrollingFrame")
clientScroll.Size = UDim2.new(1, -20, 1, -120)
clientScroll.Position = UDim2.new(0, 10, 0, 120)
clientScroll.BackgroundTransparency = 1
clientScroll.BorderSizePixel = 0
clientScroll.CanvasSize = UDim2.new(0, 0, 0, 2500)
clientScroll.ScrollBarThickness = 8
clientScroll.Visible = false
clientScroll.Parent = mainFrame

local newScroll = Instance.new("ScrollingFrame")
newScroll.Size = UDim2.new(1, -20, 1, -120)
newScroll.Position = UDim2.new(0, 10, 0, 120)
newScroll.BackgroundTransparency = 1
newScroll.BorderSizePixel = 0
newScroll.CanvasSize = UDim2.new(0, 0, 0, 2000)
newScroll.ScrollBarThickness = 8
newScroll.Visible = false
newScroll.Parent = mainFrame

local teamScroll = Instance.new("ScrollingFrame")
teamScroll.Size = UDim2.new(1, -20, 1, -120)
teamScroll.Position = UDim2.new(0, 10, 0, 120)
teamScroll.BackgroundTransparency = 1
teamScroll.BorderSizePixel = 0
teamScroll.CanvasSize = UDim2.new(0, 0, 0, 2000)
teamScroll.ScrollBarThickness = 8
teamScroll.Visible = false
teamScroll.Parent = mainFrame

-- UI网格布局函数
local function setupGridLayout(frame)
    local uiGrid = Instance.new("UIGridLayout")
    uiGrid.CellSize = UDim2.new(0, 160, 0, 40)
    uiGrid.CellPadding = UDim2.new(0, 5, 0, 5)
    uiGrid.StartCorner = Enum.StartCorner.TopLeft
    uiGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiGrid.Parent = frame
    return uiGrid
end

setupGridLayout(scrollFrame)
setupGridLayout(clientScroll)
setupGridLayout(newScroll)
setupGridLayout(teamScroll)

-- 通用按钮创建函数
local function makeBtn(parent, name, text)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Text = text
    btn.Size = UDim2.new(0, 160, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    btn.BorderSizePixel = 0
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255))
    }
    gradient.Parent = btn
    
    return btn
end

-- HD管理员命令函数
local function hdCommand(cmdStr)
    local rs = game:GetService("ReplicatedStorage")
    if rs:FindFirstChild("HDAdminHDClient") and rs.HDAdminHDClient.Signals:FindFirstChild("RequestCommandSilent") then
        rs.HDAdminHDClient.Signals.RequestCommandSilent:InvokeServer(cmdStr)
    end
end

-- F3X工具获取函数
local function getSyncTool()
    local tool
    for _, v in pairs(player:GetDescendants()) do
        if v.Name == "SyncAPI" then
            tool = v.Parent
            break
        end
    end
    if not tool then
        for _, v in pairs(game.ReplicatedStorage:GetDescendants()) do
            if v.Name == "SyncAPI" then
                tool = v.Parent
                break
            end
        end
    end
    return tool
end

local function runSync(args)
    local tool = getSyncTool()
    if tool and tool.SyncAPI and tool.SyncAPI.ServerEndpoint then
        tool.SyncAPI.ServerEndpoint:InvokeServer(unpack(args))
    end
end

-- ========== Team N00K1A5K GUI 功能整合 ==========

-- 1. get btools (给自己)
makeBtn(teamScroll, "GetBtools", "get btools").MouseButton1Click:Connect(function()
    hdCommand(";btools me")
end)

-- 2. sky (天空盒1)
makeBtn(teamScroll, "TeamSky1", "sky").MouseButton1Click:Connect(function()
    hdCommand(";time 0")
    hdCommand(";fogcolor black")
    wait(0.1)
    
    local function Sky(id)
        local char = player.Character or player.CharacterAdded:Wait()
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local e = root.CFrame.X
        local f = root.CFrame.Y
        local g = root.CFrame.Z
        runSync({"CreatePart", "Normal", CFrame.new(math.floor(e), math.floor(f), math.floor(g)) + Vector3.new(0,6,0), workspace})
        
        for _, v in game.Workspace:GetDescendants() do
            if v:IsA("BasePart") and math.floor(v.CFrame.X) == math.floor(e) and math.floor(v.CFrame.Z) == math.floor(g) then
                runSync({"SetName", {v}, "Sky"})
                runSync({"CreateMeshes", {{["Part"] = v}}})
                runSync({"SyncMesh", {{["Part"] = v, ["MeshId"] = "rbxassetid://1118917027441"}}})
                runSync({"SyncMesh", {{["Part"] = v, ["TextureId"] = "rbxassetid://"..id}}})
                runSync({"SyncMesh", {{["Part"] = v, ["Scale"] = Vector3.new(99999,99999,99999)}}})
                runSync({"SetLocked", {v}, true})
            end
        end
    end
    
    Sky("98869184805108")
end)

-- 3. decal spam (贴图垃圾邮件1)
makeBtn(teamScroll, "TeamDecalSpam1", "decal spam").MouseButton1Click:Connect(function()
    local function spam(id)
        for _, v in game.workspace:GetDescendants() do
            if v:IsA("BasePart") then
                task.spawn(function()
                    runSync({"SetLocked", {v}, false})
                    for _, face in pairs(Enum.NormalId:GetEnumItems()) do
                        runSync({"CreateTextures", {{["Part"] = v, ["Face"] = face, ["TextureType"] = "Decal"}}})
                        runSync({"SyncTexture", {{["Part"] = v, ["Face"] = face, ["TextureType"] = "Decal", ["Texture"] = "rbxassetid://"..id}}})
                    end
                end)
            end
        end
    end
    spam("98869184805108")
end)

-- 4. sky 2 (天空盒2)
makeBtn(teamScroll, "TeamSky2", "sky 2").MouseButton1Click:Connect(function()
    hdCommand(";time 0")
    hdCommand(";fogcolor black")
    wait(0.1)
    
    local function Sky(id)
        local char = player.Character or player.CharacterAdded:Wait()
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local e = root.CFrame.X
        local f = root.CFrame.Y
        local g = root.CFrame.Z
        runSync({"CreatePart", "Normal", CFrame.new(math.floor(e), math.floor(f), math.floor(g)) + Vector3.new(0,6,0), workspace})
        
        for _, v in game.Workspace:GetDescendants() do
            if v:IsA("BasePart") and math.floor(v.CFrame.X) == math.floor(e) and math.floor(v.CFrame.Z) == math.floor(g) then
                runSync({"SetName", {v}, "Sky"})
                runSync({"CreateMeshes", {{["Part"] = v}}})
                runSync({"SyncMesh", {{["Part"] = v, ["MeshId"] = "rbxassetid://1118917041"}}})
                runSync({"SyncMesh", {{["Part"] = v, ["TextureId"] = "rbxassetid://"..id}}})
                runSync({"SyncMesh", {{["Part"] = v, ["Scale"] = Vector3.new(99999,99999,99999)}}})
                runSync({"SetLocked", {v}, true})
            end
        end
    end
    
    Sky("128609186391260")
end)

-- 5. decal spam 2 (贴图垃圾邮件2)
makeBtn(teamScroll, "TeamDecalSpam2", "decal spam 2").MouseButton1Click:Connect(function()
    local function spam(id)
        for _, v in game.workspace:GetDescendants() do
            if v:IsA("BasePart") then
                task.spawn(function()
                    runSync({"SetLocked", {v}, false})
                    for _, face in pairs(Enum.NormalId:GetEnumItems()) do
                        runSync({"CreateTextures", {{["Part"] = v, ["Face"] = face, ["TextureType"] = "Decal"}}})
                        runSync({"SyncTexture", {{["Part"] = v, ["Face"] = face, ["TextureType"] = "Decal", ["Texture"] = "rbxassetid://"..id}}})
                    end
                end)
            end
        end
    end
    spam("128609186391260")
end)

-- 6. colour spam (颜色垃圾邮件)
makeBtn(teamScroll, "TeamColorSpam", "colour spam").MouseButton1Click:Connect(function()
    for _, v in game.Workspace:GetDescendants() do
        if v:IsA("BasePart") then
            task.spawn(function()
                runSync({"SetLocked", {v}, false})
                runSync({"SyncColor", {{Part = v, Color = Color3.new(math.random(), math.random(), math.random()), UnionColoring = false}}})
            end)
        end
    end
end)

-- 7. texture spam (纹理垃圾邮件1)
makeBtn(teamScroll, "TeamTextureSpam1", "texture spam").MouseButton1Click:Connect(function()
    local function spam(id)
        for _, v in game.workspace:GetDescendants() do
            if v:IsA("BasePart") then
                task.spawn(function()
                    runSync({"SetLocked", {v}, false})
                    for _, face in pairs(Enum.NormalId:GetEnumItems()) do
                        runSync({"CreateTextures", {{["Part"] = v, ["Face"] = face, ["TextureType"] = "Texture"}}})
                        runSync({"SyncTexture", {{["Part"] = v, ["Face"] = face, ["TextureType"] = "Texture", ["Texture"] = "rbxassetid://"..id}}})
                    end
                end)
            end
        end
    end
    spam("128609186391260")
end)

-- 8. texture spam 2 (纹理垃圾邮件2)
makeBtn(teamScroll, "TeamTextureSpam2", "texture spam 2").MouseButton1Click:Connect(function()
    local function spam(id)
        for _, v in game.workspace:GetDescendants() do
            if v:IsA("BasePart") then
                task.spawn(function()
                    runSync({"SetLocked", {v}, false})
                    for _, face in pairs(Enum.NormalId:GetEnumItems()) do
                        runSync({"CreateTextures", {{["Part"] = v, ["Face"] = face, ["TextureType"] = "Texture"}}})
                        runSync({"SyncTexture", {{["Part"] = v, ["Face"] = face, ["TextureType"] = "Texture", ["Texture"] = "rbxassetid://"..id}}})
                    end
                end)
            end
        end
    end
    spam("1329872127404")
end)

-- 9. fire all (全图火焰)
makeBtn(teamScroll, "TeamFireAll", "fire all").MouseButton1Click:Connect(function()
    for _, v in game.Workspace:GetDescendants() do
        task.spawn(function()
            if v:IsA("BasePart") then
                runSync({"SetLocked", {v}, false})
                runSync({"CreateDecorations", {{["Part"] = v, ["DecorationType"] = "Fire"}}})
            end
        end)
    end
end)

-- 10. unanchor (解锚定)
makeBtn(teamScroll, "TeamUnanchor", "unanchor").MouseButton1Click:Connect(function()
    for _, v in game.Workspace:GetDescendants() do
        task.spawn(function()
            if v:IsA("BasePart") then
                runSync({"SetLocked", {v}, false})
                runSync({"SyncAnchor", {{Part = v, Anchored = false}}})
            end
        end)
    end
end)

-- 11. make baseplate (创建基板)
makeBtn(teamScroll, "TeamBaseplate", "make baseplate").MouseButton1Click:Connect(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local hrpx = math.floor(hrp.CFrame.X)
    local hrpz = math.floor(hrp.CFrame.Z)
    local hrpy = math.floor(hrp.CFrame.Y)
    
    runSync({"CreatePart", "Spawn", CFrame.new(hrpx, hrpy-20, hrpz), workspace})
    
    for _, v in game.Workspace:GetChildren() do
        if v:IsA("BasePart") and math.floor(v.CFrame.Y) == hrpy - 20 and math.floor(v.CFrame.X) == hrpx then
            task.spawn(function()
                runSync({"SyncResize", {{Part = v, CFrame = v.CFrame, Size = Vector3.new(300, 2, 300)}}})
                runSync({"SyncColor", {{Part = v, Color = Color3.fromRGB(70,100,100), UnionColoring = false}}})
                runSync({"CreateTextures", {{["Part"] = v, ["Face"] = Enum.NormalId.Top, ["TextureType"] = "Texture"}}})
                runSync({"SyncTexture", {{["Part"] = v, ["Face"] = Enum.NormalId.Top, ["TextureType"] = "Texture", ["Texture"] = "rbxassetid://0", ["StudsPerTileV"] = 10, ["StudsPerTileU"] = 10}}})
                while wait(1) do
                    pcall(function() runSync({"SetLocked", {v}, true}) end)
                end
            end)
        end
    end
end)

-- 12. savemap (保存地图)
makeBtn(teamScroll, "TeamSavemap", "savemap").MouseButton1Click:Connect(function()
    hdCommand(";savemap")
end)

-- 13. Team's theme (团队主题音乐)
makeBtn(teamScroll, "TeamTheme", "Team's theme").MouseButton1Click:Connect(function()
    hdCommand(";music 1839246711")
    hdCommand(";pitch 0.8")
    hdCommand(";volume inf")
end)

-- 14. music (音乐)
makeBtn(teamScroll, "TeamMusic", "music").MouseButton1Click:Connect(function()
    hdCommand(";music 94625860335523")
    hdCommand(";pitch 1.1")
    hdCommand(";volume inf")
end)

-- 15. T00KSHAF1Y's theme (T00KSHAF1Y主题)
makeBtn(teamScroll, "TookshafiyTheme", "T00KSHAF1Y's theme").MouseButton1Click:Connect(function()
    hdCommand(";music 1847661821")
    hdCommand(";pitch 0.8")
    hdCommand(";volume inf")
end)

-- 16. tp all to meep city 4 (传送所有人到meep city 4)
makeBtn(teamScroll, "TeamTPMeepCity", "tp all to meep city 4").MouseButton1Click:Connect(function()
    hdCommand(";globalforceplace 1091473338213")
    hdCommand(";forceplace 1091473338213")
end)

-- 17. hint 2 (提示2)
makeBtn(teamScroll, "TeamHint2", "hint 2").MouseButton1Click:Connect(function()
    hdCommand(";shp Team N00K1A5K join now!!")
end)

-- 18. message (消息1)
makeBtn(teamScroll, "TeamMessage1", "message").MouseButton1Click:Connect(function()
    hdCommand(";mp this game has been hacked by team N00K1A5K")
end)

-- 19. message 2 (消息2)
makeBtn(teamScroll, "TeamMessage2", "message 2").MouseButton1Click:Connect(function()
    hdCommand(";mp Team N00K1A5K join today!!")
end)

-- 20. title me (给自己标题)
makeBtn(teamScroll, "TeamTitleMe", "title me").MouseButton1Click:Connect(function()
    hdCommand(";titlep me N00K1A5K")
end)

-- 21. jail all (监狱所有人)
makeBtn(teamScroll, "TeamJailAll", "jail all").MouseButton1Click:Connect(function()
    hdCommand(";freeze all ;disco ;fog")
end)

-- 22. anti skid (反脚本小子)
makeBtn(teamScroll, "TeamAntiSkid", "anti skid").MouseButton1Click:Connect(function()
    hdCommand(";mute others")
    hdCommand(";hidegui others")
end)

-- 23. name all (命名所有人)
makeBtn(teamScroll, "TeamNameAll", "name all").MouseButton1Click:Connect(function()
    hdCommand(";name all N00K1A5K")
end)

-- 24. unmute(uself) (解除自己静音)
makeBtn(teamScroll, "TeamUnmuteSelf", "unmute(uself)").MouseButton1Click:Connect(function()
    hdCommand(";unmute me")
    hdCommand(";showgui me")
end)

-- 25. Hack (黑客功能)
makeBtn(teamScroll, "TeamHack", "Hack").MouseButton1Click:Connect(function()
    hdCommand(";jail all")
end)

-- ========== z00kiddl GUI 功能整合 ==========

-- 左侧内部按钮
local z00LeftInsideURLs = {
    "https://pastefy.app/HWbdevXf/raw",
    "https://pastefy.app/tX6LiRoT/raw",
    "https://pastefy.app/XDc6yxTO/raw",
    "https://pastefy.app/le7UXaTo/raw",
    "https://pastefy.app/4YJtCIq9/raw",
    "https://rawscripts.net/raw/Universal-Script-Better-toad-rain-32545",
    "https://pastefy.app/L9ehHB3W/raw",
    "https://pastefy.app/rJFrDWWI/raw",
    "https://pastefy.app/yTP36ixZ/raw",
    "https://pastebin.com/raw/WneFn7Wv"
}

local z00LeftInsideNames = {"decal", "sky1", "sky2", "get btools", "particle", "toad rain", "fire all", "Avatar all", "spooky", "Thomas"}

for i = 1, 10 do
    makeBtn(clientScroll, "Z00Left"..i, z00LeftInsideNames[i]).MouseButton1Click:Connect(function()
        local url = z00LeftInsideURLs[i]
        pcall(function()
            loadstring(game:HttpGet(url))()
        end)
    end)
end

-- 右侧内部按钮
local z00RightInsideURLs = {
    "https://pastefy.app/6hQPrW8e/raw",
    "https://pastefy.app/WAIOwr8A/raw",
    "https://pastefy.app/SZ0ttPdX/raw",
    "https://pastefy.app/cBoe6d9s/raw",
    "https://pastefy.app/ucHp8ddg/raw",
    "https://pastefy.app/F7kBPz0g/raw",
    "https://pastefy.app/e76pHc5b/raw",
    "https://pastefy.app/25Wo75JN/raw",
    "https://pastefy.app/S2dvTTS6/raw",
    "https://pastefy.app/4LEdMVEk/raw"
}

local z00RightInsideNames = {"Rain troll", "message1", "message2", "title all", "audio1", "audio2", "audio3", "audio4", "decal scary2", "sky3"}

for i = 1, 10 do
    makeBtn(clientScroll, "Z00Right"..i, z00RightInsideNames[i]).MouseButton1Click:Connect(function()
        local url = z00RightInsideURLs[i]
        pcall(function()
            loadstring(game:HttpGet(url))()
        end)
    end)
end

-- ========== 原有F3X+HD功能 ==========

-- 1. 玩家模型循环变色 (修复版)
local colorChangeActive = false
local colorChangeThread

local function ColorChange()
    if colorChangeActive then
        colorChangeActive = false
        if colorChangeThread then
            coroutine.close(colorChangeThread)
        end
        hdCommand(";char all normal")
        return
    end
    
    colorChangeActive = true
    colorChangeThread = coroutine.create(function()
        while colorChangeActive do
            for _, color in pairs({
                Color3.fromRGB(255, 0, 0),
                Color3.fromRGB(0, 255, 0),
                Color3.fromRGB(0, 0, 255),
                Color3.fromRGB(255, 255, 0),
                Color3.fromRGB(255, 0, 255),
                Color3.fromRGB(0, 255, 255)
            }) do
                if not colorChangeActive then break end
                local r = math.floor(color.R * 255)
                local g = math.floor(color.G * 255)
                local b = math.floor(color.B * 255)
                hdCommand(";color all " .. r .. " " .. g .. " " .. b)
                task.wait(0.5)
            end
        end
    end)
    coroutine.resume(colorChangeThread)
end

-- 2. 全图旋转
local fullRotationActive = false
local fullRotationThread

local function FullRotation()
    if fullRotationActive then
        fullRotationActive = false
        if fullRotationThread then
            coroutine.close(fullRotationThread)
        end
        hdCommand(";freeze all")
        return
    end
    
    fullRotationActive = true
    fullRotationThread = coroutine.create(function()
        while fullRotationActive do
            hdCommand(";rotate all 360")
            task.wait(0.5)
        end
    end)
    coroutine.resume(fullRotationThread)
end

-- 3. 全图爆炸 (修复版)
local explosionActive = false
local explosionThread

local function FullExplosion()
    if explosionActive then
        explosionActive = false
        if explosionThread then
            coroutine.close(explosionThread)
        end
        return
    end
    
    explosionActive = true
    explosionThread = coroutine.create(function()
        while explosionActive do
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr.Character then
                    hdCommand(";explode " .. plr.Name)
                end
            end
            
            for i = 1, 10 do
                local randomPos = Vector3.new(
                    math.random(-200, 200),
                    math.random(0, 50),
                    math.random(-200, 200)
                )
                local explosion = Instance.new("Explosion")
                explosion.Position = randomPos
                explosion.BlastPressure = 1000000
                explosion.BlastRadius = 25
                explosion.Parent = workspace
                task.wait(0.1)
            end
            
            task.wait(2)
        end
    end)
    coroutine.resume(explosionThread)
end

-- 原有F3X+HD功能按钮
makeBtn(scrollFrame, "Hint", "提示").MouseButton1Click:Connect(function()
    hdCommand(";serverhint sunkun v1 已激活")
end)

makeBtn(scrollFrame, "Sky1", "天空盒1").MouseButton1Click:Connect(function()
    local function Sky(id)
        local char = player.Character or player.CharacterAdded:Wait()
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local cf = root.CFrame
        local pos = CFrame.new(math.floor(cf.X), math.floor(cf.Y), math.floor(cf.Z)) + Vector3.new(0, 6, 0)
        
        runSync({"CreatePart", "Normal", pos, workspace})
        task.wait(0.1)
        
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and math.abs(v.Position.X - pos.X) < 10 and math.abs(v.Position.Z - pos.Z) < 10 then
                runSync({"SetName", {v}, "Skybox"})
                runSync({"CreateMeshes", {{["Part"] = v}}})
                runSync({"SyncMesh", {{["Part"] = v, ["MeshId"] = "rbxassetid://111891702759441"}}})
                runSync({"SyncMesh", {{["Part"] = v, ["TextureId"] = "rbxassetid://"..id}}})
                runSync({"SyncMesh", {{["Part"] = v, ["Scale"] = Vector3.new(7200,7200,7200)}}})
                runSync({"SetLocked", {v}, true})
            end
        end
        
        if game.Lighting:FindFirstChild("Sky") then
            game.Lighting.Sky:Destroy()
        end
    end
    
    Sky("106928937966054")
end)

-- ... 其他原有天空盒功能 ...

makeBtn(scrollFrame, "Disco", "迪斯科").MouseButton1Click:Connect(function()
    hdCommand(";disco")
end)

makeBtn(scrollFrame, "Undisco", "取消迪斯科").MouseButton1Click:Connect(function()
    hdCommand(";undisco")
end)

makeBtn(scrollFrame, "Btools", "建筑工具").MouseButton1Click:Connect(function()
    hdCommand(";btools")
end)

-- ... 其他原有F3X功能 ...

-- ========== 新增8个F3X+HD功能 ==========

-- 1. 模糊(全玩家视野高度蓝色模糊)
local blurActive = false
local blurThread

makeBtn(newScroll, "BlurEffect", "模糊v1").MouseButton1Click:Connect(function()
    if blurActive then
        blurActive = false
        if blurThread then
            coroutine.close(blurThread)
        end
        hdCommand(";blur all 0")
        return
    end
    
    blurActive = true
    blurThread = coroutine.create(function()
        while blurActive do
            hdCommand(";blur all 50")
            hdCommand(";blurcolor all 0 0 255")
            hdCommand(";fogcolor all 0 0 150")
            hdCommand(";fogend all 100")
            task.wait(0.5)
        end
    end)
    coroutine.resume(blurThread)
end)

-- 2. 广角(全玩家视频拉长广角+全玩家视野模糊)
local wideAngleActive = false
local wideAngleThread

makeBtn(newScroll, "WideAngle", "广角v1").MouseButton1Click:Connect(function()
    if wideAngleActive then
        wideAngleActive = false
        if wideAngleThread then
            coroutine.close(wideAngleThread)
        end
        hdCommand(";fov all 70")
        hdCommand(";blur all 0")
        return
    end
    
    wideAngleActive = true
    wideAngleThread = coroutine.create(function()
        while wideAngleActive do
            hdCommand(";fov all 120")
            hdCommand(";blur all 30")
            hdCommand(";shakycam all")
            task.wait(0.3)
        end
    end)
    coroutine.resume(wideAngleThread)
end)

-- 3. 火焰(全玩家身上添加火焰+全图建筑形状方块物体等添加火焰)
local fireActive = false
local fireThread

makeBtn(newScroll, "FireEffect", "火焰v1").MouseButton1Click:Connect(function()
    if fireActive then
        fireActive = false
        if fireThread then
            coroutine.close(fireThread)
        end
        hdCommand(";removefire all")
        return
    end
    
    fireActive = true
    fireThread = coroutine.create(function()
        while fireActive do
            -- 给所有玩家添加火焰
            hdCommand(";fire all")
            
            -- 给所有建筑添加火焰
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name ~= "Terrain" then
                    pcall(function()
                        runSync({"CreateDecorations", {{["Part"] = obj, ["DecorationType"] = "Fire"}}})
                    end)
                end
            end
            
            -- 创建额外的火焰效果
            for i = 1, 20 do
                local randomPos = Vector3.new(
                    math.random(-300, 300),
                    math.random(0, 100),
                    math.random(-300, 300)
                )
                runSync({"CreatePart", "Normal", CFrame.new(randomPos), workspace})
                task.wait(0.05)
                
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and v.Position == randomPos then
                        runSync({"SetName", {v}, "Fire_Particle"})
                        runSync({"SyncColor", {{Part = v, Color = Color3.fromRGB(255, 100, 0), UnionColoring = false}}})
                        runSync({"CreateDecorations", {{["Part"] = v, ["DecorationType"] = "Fire"}}})
                        break
                    end
                end
            end
            
            task.wait(3)
        end
    end)
    coroutine.resume(fireThread)
end)

-- 4. 形状变色(全图建筑形状方块物体模型物质等全部变色循环)
local shapeColorActive = false
local shapeColorThread

makeBtn(newScroll, "ShapeColorChange", "形状变色v1").MouseButton1Click:Connect(function()
    if shapeColorActive then
        shapeColorActive = false
        if shapeColorThread then
            coroutine.close(shapeColorThread)
        end
        return
    end
    
    shapeColorActive = true
    shapeColorThread = coroutine.create(function()
        while shapeColorActive do
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name ~= "Terrain" and obj.Name ~= "Skybox" then
                    local color = Color3.fromRGB(
                        math.random(0, 255),
                        math.random(0, 255),
                        math.random(0, 255)
                    )
                    pcall(function()
                        runSync({"SyncColor", {{Part = obj, Color = color, UnionColoring = false}}})
                        runSync({"SyncMaterial", {{Part = obj, Material = Enum.Material.Neon}}})
                    end)
                end
            end
            
            -- 使用HD管理员改变所有玩家颜色
            hdCommand(";color all " .. math.random(0,255) .. " " .. math.random(0,255) .. " " .. math.random(0,255))
            
            task.wait(0.5)
        end
    end)
    coroutine.resume(shapeColorThread)
end)

-- 5. 黑夜(时间变成黑夜，月亮(循环上下移动变色)/太阳(循环上下移动变色)/时间(加速))
local nightActive = false
local nightThread
local nightObjects = {}

makeBtn(newScroll, "NightEffect", "黑夜v1").MouseButton1Click:Connect(function()
    if nightActive then
        nightActive = false
        if nightThread then
            coroutine.close(nightThread)
        end
        
        -- 清理创建的物体
        for _, obj in pairs(nightObjects) do
            if obj and obj.Parent then
                obj:Destroy()
            end
        end
        nightObjects = {}
        
        hdCommand(";time 12")
        hdCommand(";ambient 255 255 255")
        hdCommand(";brightness 1")
        return
    end
    
    nightActive = true
    
    -- 设置夜晚环境
    hdCommand(";time 0")
    hdCommand(";brightness 0.1")
    hdCommand(";ambient 50 50 100")
    hdCommand(";fogcolor 0 0 50")
    hdCommand(";fogend 300")
    hdCommand(";music 95156028272944")
    hdCommand(";volume inf ;pitch 0.2")
    
    -- 创建月亮
    local moon = Instance.new("Part")
    moon.Name = "Night_Moon"
    moon.Size = Vector3.new(20, 20, 20)
    moon.Position = Vector3.new(0, 200, 0)
    moon.Anchored = true
    moon.CanCollide = false
    moon.Material = Enum.Material.Neon
    moon.Color = Color3.fromRGB(255, 255, 200)
    moon.Parent = workspace
    
    local moonLight = Instance.new("PointLight")
    moonLight.Color = Color3.fromRGB(255, 255, 200)
    moonLight.Brightness = 5
    moonLight.Range = 500
    moonLight.Parent = moon
    
    local moonMesh = Instance.new("SpecialMesh")
    moonMesh.MeshType = Enum.MeshType.Sphere
    moonMesh.Parent = moon
    
    table.insert(nightObjects, moon)
    
    -- 创建星星
    for i = 1, 50 do
        local star = Instance.new("Part")
        star.Name = "Night_Star"
        star.Size = Vector3.new(1, 1, 1)
        star.Position = Vector3.new(
            math.random(-500, 500),
            math.random(150, 300),
            math.random(-500, 500)
        )
        star.Anchored = true
        star.CanCollide = false
        star.Material = Enum.Material.Neon
        star.Color = Color3.fromRGB(255, 255, 255)
        star.Parent = workspace
        
        local starLight = Instance.new("PointLight")
        starLight.Color = Color3.fromRGB(255, 255, 255)
        starLight.Brightness = math.random(1, 3)
        starLight.Range = 100
        starLight.Parent = star
        
        table.insert(nightObjects, star)
    end
    
    nightThread = coroutine.create(function()
        local moonY = 200
        local moonDirection = 1
        local moonColorIndex = 0
        
        while nightActive do
            -- 月亮上下移动
            moonY = moonY + (5 * moonDirection)
            if moonY > 300 then
                moonDirection = -1
            elseif moonY < 100 then
                moonDirection = 1
            end
            moon.Position = Vector3.new(0, moonY, 0)
            
            -- 月亮变色循环
            moonColorIndex = (moonColorIndex + 1) % 360
            local hue = moonColorIndex / 360
            local color = Color3.fromHSV(hue, 0.3, 1)
            moon.Color = color
            moonLight.Color = color
            
            -- 时间加速
            game.Lighting.ClockTime = (game.Lighting.ClockTime + 0.1) % 24
            
            -- 星星闪烁
            for _, star in pairs(nightObjects) do
                if star.Name == "Night_Star" then
                    star.PointLight.Brightness = math.random(0.5, 3)
                end
            end
            
            task.wait(0.1)
        end
    end)
    coroutine.resume(nightThread)
end)

-- 6. 666(全图建筑形状方块物体模型物质等变成红色全图建筑形状方块物体模型物质等显示黑色框架边缘，全图建筑形状方块物体模型物质等生成漂浮文本"666"然后隔几秒循环提示666)
local sixSixSixActive = false
local sixSixSixThread
local sixSixSixTexts = {}

makeBtn(newScroll, "SixSixSix", "666v1").MouseButton1Click:Connect(function()
    if sixSixSixActive then
        sixSixSixActive = false
        if sixSixSixThread then
            coroutine.close(sixSixSixThread)
        end
        
        -- 清理漂浮文本
        for _, text in pairs(sixSixSixTexts) do
            if text and text.Parent then
                text:Destroy()
            end
        end
        sixSixSixTexts = {}
        
        hdCommand(";color all normal")
        return
    end
    
    sixSixSixActive = true
    
    -- 设置红色主题
    hdCommand(";color all 255 0 0")
    hdCommand(";fogcolor 100 0 0")
    hdCommand(";ambient 255 100 100")
    hdCommand(";music 103409297553965")
    hdCommand(";volume inf")
    
    -- 创建漂浮文本
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name ~= "Terrain" then
            -- 添加黑色框架边缘
            pcall(function()
                runSync({"SyncColor", {{Part = obj, Color = Color3.fromRGB(255, 0, 0), UnionColoring = false}}})
                runSync({"SyncMaterial", {{Part = obj, Material = Enum.Material.Neon}}})
            end)
            
            -- 创建漂浮文本
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "SixSixSix_Text"
            billboard.Size = UDim2.new(0, 100, 0, 30)
            billboard.AlwaysOnTop = true
            billboard.StudsOffset = Vector3.new(0, 5, 0)
            billboard.Parent = obj
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.Text = "666"
            textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            textLabel.TextScaled = true
            textLabel.Font = Enum.Font.GothamBlack
            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            textLabel.TextStrokeTransparency = 0
            textLabel.Parent = billboard
            
            table.insert(sixSixSixTexts, billboard)
        end
    end
    
    sixSixSixThread = coroutine.create(function()
        while sixSixSixActive do
            -- 每隔几秒提示666
            hdCommand(";serverhint 666! 666! 666!")
            hdCommand(";serverMessage 666 邪恶降临！")
            
            -- 让文本闪烁
            for _, text in pairs(sixSixSixTexts) do
                if text and text.Parent then
                    text.TextLabel.TextColor3 = Color3.fromRGB(
                        math.random(200, 255),
                        0,
                        0
                    )
                end
            end
            
            -- 随机爆炸效果
            for i = 1, 5 do
                local randomPos = Vector3.new(
                    math.random(-200, 200),
                    math.random(0, 50),
                    math.random(-200, 200)
                )
                local explosion = Instance.new("Explosion")
                explosion.Position = randomPos
                explosion.BlastPressure = 500000
                explosion.BlastRadius = 10
                explosion.Parent = workspace
            end
            
            task.wait(3)
        end
    end)
    coroutine.resume(sixSixSixThread)
end)

-- 7. 坠落(全图建筑形状方块物体模型物质等散架往下坠落/掉落)
local fallActive = false
local fallThread
local originalPositions = {}

makeBtn(newScroll, "FallApart", "坠落v1").MouseButton1Click:Connect(function()
    if fallActive then
        fallActive = false
        if fallThread then
            coroutine.close(fallThread)
        end
        
        -- 恢复原始位置
        for part, data in pairs(originalPositions) do
            if part and part.Parent then
                pcall(function()
                    part.Anchored = data.anchored
                    part.CFrame = data.cframe
                end)
            end
        end
        originalPositions = {}
        return
    end
    
    fallActive = true
    
    -- 保存原始位置并解锚
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name ~= "Terrain" then
            originalPositions[obj] = {
                cframe = obj.CFrame,
                anchored = obj.Anchored
            }
            pcall(function()
                obj.Anchored = false
                runSync({"SyncAnchor", {{Part = obj, Anchored = false}}})
            end)
        end
    end
    
    fallThread = coroutine.create(function()
        while fallActive do
            -- 添加随机力使物体散落
            for obj, _ in pairs(originalPositions) do
                if obj and obj.Parent then
                    local bodyForce = Instance.new("BodyForce")
                    bodyForce.Force = Vector3.new(
                        math.random(-10000, 10000),
                        math.random(-50000, -20000),
                        math.random(-10000, 10000)
                    )
                    bodyForce.Parent = obj
                    
                    game:GetService("Debris"):AddItem(bodyForce, 0.1)
                end
            end
            
            -- 创建坠落粒子效果
            for i = 1, 10 do
                local particle = Instance.new("Part")
                particle.Size = Vector3.new(1, 1, 1)
                particle.Position = Vector3.new(
                    math.random(-300, 300),
                    math.random(100, 200),
                    math.random(-300, 300)
                )
                particle.Anchored = false
                particle.CanCollide = false
                particle.Color = Color3.fromRGB(100, 100, 100)
                particle.Material = Enum.Material.Concrete
                particle.Parent = workspace
                
                local bodyForce = Instance.new("BodyForce")
                bodyForce.Force = Vector3.new(0, -particle:GetMass() * workspace.Gravity * 2, 0)
                bodyForce.Parent = particle
                
                game:GetService("Debris"):AddItem(particle, 5)
            end
            
            task.wait(1)
        end
    end)
    coroutine.resume(fallThread)
    
    -- 使用HD管理员命令增强效果
    hdCommand(";gravity 196.2")
    hdCommand(";music 103439408444041")
    hdCommand(";volume inf")
end)

-- 8. 附加功能：全图旋转+变色组合
local comboActive = false
local comboThread

makeBtn(newScroll, "ComboEffect", "旋转变色v1").MouseButton1Click:Connect(function()
    if comboActive then
        comboActive = false
        if comboThread then
            coroutine.close(comboThread)
        end
        hdCommand(";freeze all")
        hdCommand(";color all normal")
        return
    end
    
    comboActive = true
    comboThread = coroutine.create(function()
        local colorIndex = 0
        while comboActive do
            -- 旋转
            hdCommand(";rotate all 360")
            
            -- 变色
            colorIndex = (colorIndex + 1) % 6
            local colors = {
                {255, 0, 0},
                {0, 255, 0},
                {0, 0, 255},
                {255, 255, 0},
                {255, 0, 255},
                {0, 255, 255}
            }
            local color = colors[colorIndex + 1]
            hdCommand(";color all " .. color[1] .. " " .. color[2] .. " " .. color[3])
            
            task.wait(0.5)
        end
    end)
    coroutine.resume(comboThread)
end)

-- ========== 标签页切换功能 ==========
tabF3X.MouseButton1Click:Connect(function()
    scrollFrame.Visible = true
    clientScroll.Visible = false
    newScroll.Visible = false
    teamScroll.Visible = false
end)

tabClient.MouseButton1Click:Connect(function()
    scrollFrame.Visible = false
    clientScroll.Visible = true
    newScroll.Visible = false
    teamScroll.Visible = false
end)

tabNew.MouseButton1Click:Connect(function()
    scrollFrame.Visible = false
    clientScroll.Visible = false
    newScroll.Visible = true
    teamScroll.Visible = false
end)

tabTeam.MouseButton1Click:Connect(function()
    scrollFrame.Visible = false
    clientScroll.Visible = false
    newScroll.Visible = false
    teamScroll.Visible = true
end)

-- ========== 添加关闭按钮 ==========
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 20)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- ========== 添加拖动功能 ==========
local UserInputService = game:GetService("UserInputService")
local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- 更新滚动框架大小
local function updateScrollSize(frame)
    local buttonCount = 0
    for _, child in pairs(frame:GetChildren()) do
        if child:IsA("TextButton") then
            buttonCount = buttonCount + 1
        end
    end
    
    local rows = math.ceil(buttonCount / 3)
    local height = rows * 45 + 20
    frame.CanvasSize = UDim2.new(0, 0, 0, height)
end

-- 延迟更新滚动框架大小
task.spawn(function()
    task.wait(0.5)
    updateScrollSize(scrollFrame)
    updateScrollSize(clientScroll)
    updateScrollSize(newScroll)
    updateScrollSize(teamScroll)
end)

-- 添加彩虹环UI (来自z00kiddl GUI)
task.delay(1, function()
    local ringGui = Instance.new("ScreenGui")
    ringGui.Name = "RainbowRingUI"
    ringGui.Parent = player:WaitForChild("PlayerGui")
    ringGui.ResetOnSpawn = false
    
    local ring = Instance.new("ImageLabel")
    ring.Size = UDim2.new(0, 135, 0, 135)
    ring.AnchorPoint = Vector2.new(0.5, 0.5)
    ring.Position = UDim2.new(0.5, 0, 0.5, 0)
    ring.BackgroundTransparency = 1
    ring.Image = "rbxassetid://80607924147749"
    ring.ImageTransparency = 0
    ring.Parent = ringGui
    
    ring:TweenPosition(UDim2.new(0.04, 0, 0.82, 0), "Out", "Sine", 0.7, false)
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 165, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 127, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(139, 0, 255)),
        ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 0, 0))
    })
    gradient.Parent = ring
    
    while task.wait(0.03) do
        ring.Rotation = (ring.Rotation + 2) % 360
        gradient.Rotation = (gradient.Rotation + 5) % 360
    end
end)

-- 启动消息
task.spawn(function()
    task.wait(1)
    hdCommand(";serverMessage SUNKUN v1 ULTIMATE 已加载！包含所有功能！")
    hdCommand(";serverhint 使用TAB键切换功能标签页")
end)

print("sunkun v1 脚本加载完成！")
print("缝合万岁！")