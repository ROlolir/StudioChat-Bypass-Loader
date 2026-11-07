local Players = game:GetService("Players")
local Chat = game:GetService("Chat")

local function createCustomBubble(player, character, message)
	local head = character:FindFirstChild("Head")
	if not head then return end

	local billboard = head:FindFirstChild("UnfilteredBubble")
	if billboard then billboard:Destroy() end

	billboard = Instance.new("BillboardGui")
	billboard.Name = "UnfilteredBubble"
	billboard.Size = UDim2.new(0, 200, 0, 50)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true
	billboard.Adornee = head
	billboard.Parent = head

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	frame.BackgroundTransparency = 0.2
	frame.SizeConstraint = Enum.SizeConstraint.RelativeXY
	
	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 8)
	uiCorner.Parent = frame

	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, -10, 1, -10)
	textLabel.Position = UDim2.new(0, 5, 0, 5)
	textLabel.BackgroundTransparency = 1
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.TextSize = 14
	textLabel.Text = message
	textLabel.TextWrapped = true
	textLabel.Font = Enum.Font.SourceSansBold
	textLabel.Parent = frame

	frame.Parent = billboard
	task.wait(5)
	if billboard then billboard:Destroy() end
end

local function onPlayerAdded(player)
	player.Chatted:Connect(function(message)
		local character = player.Character
		if character then
			task.spawn(createCustomBubble, player, character, message)
		end
	end)
end

Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in ipairs(Players:GetPlayers()) do
	onPlayerAdded(player)
end
