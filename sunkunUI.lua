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
