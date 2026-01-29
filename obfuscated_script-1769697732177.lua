-- === 單腳本管理員面板 (ESP顯示血量/道具 + 完整功能) ===
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ===== GUI 建立 =====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdminPanel"
screenGui.ResetOnSpawn = false -- 重生不消失
screenGui.Parent = PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0,280,0,540)
mainFrame.Position = UDim2.new(0,10,0,10)
mainFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- ===== 面板開關按鈕 =====
local togglePanelButton = Instance.new("TextButton")
togglePanelButton.Size = UDim2.new(0,80,0,25)
togglePanelButton.Position = UDim2.new(1,-85,0,5)
togglePanelButton.Text = "收起面板"
togglePanelButton.BackgroundColor3 = Color3.fromRGB(70,70,70)
togglePanelButton.TextColor3 = Color3.new(1,1,1)
togglePanelButton.Parent = screenGui

togglePanelButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    togglePanelButton.Text = mainFrame.Visible and "收起面板" or "打開面板"
end)

-- ===== 狀態顯示 =====
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1,-10,0,40)
statusLabel.Position = UDim2.new(0,5,0,0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(0,255,0)
statusLabel.TextScaled = true
statusLabel.Text = "速度: 0  | 跳躍: 0  | 生命: 0/0"
statusLabel.Parent = mainFrame

-- ===== ESP 開關 =====
local toggleESPButton = Instance.new("TextButton")
toggleESPButton.Size = UDim2.new(1, -10, 0, 30)
toggleESPButton.Position = UDim2.new(0,5,0,45)
toggleESPButton.Text = "開啟 ESP"
toggleESPButton.BackgroundColor3 = Color3.fromRGB(70,70,70)
toggleESPButton.TextColor3 = Color3.new(1,1,1)
toggleESPButton.Parent = mainFrame

-- ===== 無敵開關 =====
local toggleGodButton = Instance.new("TextButton")
toggleGodButton.Size = UDim2.new(1,-10,0,30)
toggleGodButton.Position = UDim2.new(0,5,0,80)
toggleGodButton.Text = "開啟 無敵"
toggleGodButton.BackgroundColor3 = Color3.fromRGB(70,70,70)
toggleGodButton.TextColor3 = Color3.new(1,1,1)
toggleGodButton.Parent = mainFrame

-- ===== 無線跳躍開關 =====
local toggleFlyJumpButton = Instance.new("TextButton")
toggleFlyJumpButton.Size = UDim2.new(1,-10,0,30)
toggleFlyJumpButton.Position = UDim2.new(0,5,0,115)
toggleFlyJumpButton.Text = "開啟 無線跳躍"
toggleFlyJumpButton.BackgroundColor3 = Color3.fromRGB(70,70,70)
toggleFlyJumpButton.TextColor3 = Color3.new(1,1,1)
toggleFlyJumpButton.Parent = mainFrame

-- ===== Teleport 點 =====
local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(1,-10,0,30)
teleportButton.Position = UDim2.new(0,5,0,150)
teleportButton.Text = "傳送到設定點"
teleportButton.BackgroundColor3 = Color3.fromRGB(70,70,70)
teleportButton.TextColor3 = Color3.new(1,1,1)
teleportButton.Parent = mainFrame

local setTPButton = Instance.new("TextButton")
setTPButton.Size = UDim2.new(1,-10,0,30)
setTPButton.Position = UDim2.new(0,5,0,185)
setTPButton.Text = "設定傳送點"
setTPButton.BackgroundColor3 = Color3.fromRGB(70,70,70)
setTPButton.TextColor3 = Color3.new(1,1,1)
setTPButton.Parent = mainFrame

-- ===== 速度控制 =====
local speedPlus = Instance.new("TextButton")
speedPlus.Size = UDim2.new(0.48,-5,0,30)
speedPlus.Position = UDim2.new(0,5,0,220)
speedPlus.Text = "速度 +10"
speedPlus.BackgroundColor3 = Color3.fromRGB(70,70,70)
speedPlus.TextColor3 = Color3.new(1,1,1)
speedPlus.Parent = mainFrame

local speedMinus = Instance.new("TextButton")
speedMinus.Size = UDim2.new(0.48,-5,0,30)
speedMinus.Position = UDim2.new(0.52,0,0,220)
speedMinus.Text = "速度 -10"
speedMinus.BackgroundColor3 = Color3.fromRGB(70,70,70)
speedMinus.TextColor3 = Color3.new(1,1,1)
speedMinus.Parent = mainFrame

-- ===== 跳躍控制 =====
local jumpPlus = Instance.new("TextButton")
jumpPlus.Size = UDim2.new(0.48,-5,0,30)
jumpPlus.Position = UDim2.new(0,5,0,255)
jumpPlus.Text = "跳躍 +10"
jumpPlus.BackgroundColor3 = Color3.fromRGB(70,70,70)
jumpPlus.TextColor3 = Color3.new(1,1,1)
jumpPlus.Parent = mainFrame

local jumpMinus = Instance.new("TextButton")
jumpMinus.Size = UDim2.new(0.48,-5,0,30)
jumpMinus.Position = UDim2.new(0.52,0,0,255)
jumpMinus.Text = "跳躍 -10"
jumpMinus.BackgroundColor3 = Color3.fromRGB(70,70,70)
jumpMinus.TextColor3 = Color3.new(1,1,1)
jumpMinus.Parent = mainFrame

-- ===== 玩家瞬移列表 =====
local playerListFrame = Instance.new("ScrollingFrame")
playerListFrame.Size = UDim2.new(1,-10,0,150)
playerListFrame.Position = UDim2.new(0,5,0,290)
playerListFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
playerListFrame.BorderSizePixel = 0
playerListFrame.CanvasSize = UDim2.new(0,0,0,0)
playerListFrame.Parent = mainFrame

-- ===== Humanoid Helper =====
local function getHumanoid(player)
    if player.Character then
        return player.Character:FindFirstChild("Humanoid")
    end
end

-- ===== ESP 功能 =====
local ESPEnabled = false
local espTags = {}

local function getPlayerToolName(player)
    -- 嘗試取得玩家持有的第一個工具
    if player.Character then
        for _, item in pairs(player.Character:GetChildren()) do
            if item:IsA("Tool") then
                return item.Name
            end
        end
    end
    return "無"
end

local function createESP(target)
    if target.Character and target.Character:FindFirstChild("Head") then
        local head = target.Character.Head
        local humanoid = getHumanoid(target)
        if not humanoid then return end

        if not head:FindFirstChild("ESP_Tag") then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESP_Tag"
            billboard.Adornee = head
            billboard.Size = UDim2.new(0,150,0,50)
            billboard.AlwaysOnTop = true
            billboard.Parent = head

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1,0,1,0)
            label.BackgroundTransparency = 1
            label.TextScaled = true
            label.Text = target.Name
            label.Parent = billboard

            espTags[target] = label
        end

        -- 顏色依隊伍
        local color = target.Team == LocalPlayer.Team and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)

        -- 更新文字: 名稱 + 血量 + 道具
        espTags[target].Text = string.format("%s\n血量: %.0f/%.0f\n道具: %s",
            target.Name,
            humanoid.Health,
            humanoid.MaxHealth,
            getPlayerToolName(target)
        )
        espTags[target].TextColor3 = color
    end
end

local function removeESP()
    for _, label in pairs(espTags) do
        if label then label:Destroy() end
    end
    espTags = {}
end

toggleESPButton.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    toggleESPButton.Text = ESPEnabled and "關閉 ESP" or "開啟 ESP"
    if not ESPEnabled then removeESP() end
end)

RunService.RenderStepped:Connect(function()
    if ESPEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                createESP(player)
            end
        end
    end
end)

-- ===== 無敵 =====
local godEnabled = false
toggleGodButton.MouseButton1Click:Connect(function()
    godEnabled = not godEnabled
    toggleGodButton.Text = godEnabled and "關閉 無敵" or "開啟 無敵"
end)

RunService.RenderStepped:Connect(function()
    local humanoid = getHumanoid(LocalPlayer)
    if humanoid then
        if godEnabled then humanoid.Health = humanoid.MaxHealth end
        -- 狀態顯示
        statusLabel.Text = string.format("速度: %.0f | 跳躍: %.0f | 生命: %.0f/%.0f",
            humanoid.WalkSpeed, humanoid.JumpPower, humanoid.Health, humanoid.MaxHealth)
    end
end)

-- ===== Teleport 點 =====
local teleportPos = nil
setTPButton.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        teleportPos = LocalPlayer.Character.HumanoidRootPart.Position
        setTPButton.Text = "點已設定"
    end
end)

teleportButton.MouseButton1Click:Connect(function()
    if teleportPos and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(teleportPos)
    end
end)

-- ===== 速度/跳躍控制 =====
speedPlus.MouseButton1Click:Connect(function()
    local humanoid = getHumanoid(LocalPlayer)
    if humanoid then humanoid.WalkSpeed = humanoid.WalkSpeed + 10 end
end)
speedMinus.MouseButton1Click:Connect(function()
    local humanoid = getHumanoid(LocalPlayer)
    if humanoid then humanoid.WalkSpeed = math.max(0, humanoid.WalkSpeed - 10) end
end)
jumpPlus.MouseButton1Click:Connect(function()
    local humanoid = getHumanoid(LocalPlayer)
    if humanoid then humanoid.JumpPower = humanoid.JumpPower + 10 end
end)
jumpMinus.MouseButton1Click:Connect(function()
    local humanoid = getHumanoid(LocalPlayer)
    if humanoid then humanoid.JumpPower = math.max(0, humanoid.JumpPower - 10) end
end)

-- ===== 無線跳躍 =====
local flyJumpEnabled = false
toggleFlyJumpButton.MouseButton1Click:Connect(function()
    flyJumpEnabled = not flyJumpEnabled
    toggleFlyJumpButton.Text = flyJumpEnabled and "關閉 無線跳躍" or "開啟 無線跳躍"
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if flyJumpEnabled and input.KeyCode == Enum.KeyCode.Space then
        local humanoid = getHumanoid(LocalPlayer)
        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- ===== 玩家列表瞬移 =====
local function updatePlayerList()
    for _, child in pairs(playerListFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    local yPos = 0
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1,-10,0,25)
            btn.Position = UDim2.new(0,5,0,yPos)
            btn.Text = "瞬移到: "..p.Name
            btn.BackgroundColor3 = Color3.fromRGB(80,80,80)
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Parent = playerListFrame

            btn.MouseButton1Click:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                end
            end)

            yPos = yPos + 30
        end
    end
    playerListFrame.CanvasSize = UDim2.new(0,0,0,yPos)
end

-- ===== 重力控制 =====
local gravityLabel = Instance.new("TextLabel")
gravityLabel.Size = UDim2.new(1,-10,0,25)
gravityLabel.Position = UDim2.new(0,5,0,490)
gravityLabel.BackgroundTransparency = 1
gravityLabel.TextColor3 = Color3.fromRGB(0,255,255)
gravityLabel.TextScaled = true
gravityLabel.Text = "重力: "..workspace.Gravity
gravityLabel.Parent = mainFrame

local gravityPlus = Instance.new("TextButton")
gravityPlus.Size = UDim2.new(0.48,-5,0,30)
gravityPlus.Position = UDim2.new(0,5,0,515)
gravityPlus.Text = "重力 +10"
gravityPlus.BackgroundColor3 = Color3.fromRGB(70,70,70)
gravityPlus.TextColor3 = Color3.new(1,1,1)
gravityPlus.Parent = mainFrame

local gravityMinus = Instance.new("TextButton")
gravityMinus.Size = UDim2.new(0.48,-5,0,30)
gravityMinus.Position = UDim2.new(0.52,0,0,515)
gravityMinus.Text = "重力 -10"
gravityMinus.BackgroundColor3 = Color3.fromRGB(70,70,70)
gravityMinus.TextColor3 = Color3.new(1,1,1)
gravityMinus.Parent = mainFrame

-- 按鈕功能
gravityPlus.MouseButton1Click:Connect(function()
    workspace.Gravity = workspace.Gravity + 10
    gravityLabel.Text = "重力: "..workspace.Gravity
end)

gravityMinus.MouseButton1Click:Connect(function()
    workspace.Gravity = math.max(0, workspace.Gravity - 10)
    gravityLabel.Text = "重力: "..workspace.Gravity
end)

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()
