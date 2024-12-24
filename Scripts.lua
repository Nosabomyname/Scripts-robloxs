local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

-- Criando a janela
local window = Instance.new("Frame")
window.Size = UDim2.new(0, 300, 0, 300)
window.Position = UDim2.new(0.5, -150, 0.5, -150)
window.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
window.BorderSizePixel = 2
window.Parent = screenGui

-- Criando o botão de minimizar
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 50, 0, 25)
minimizeButton.Position = UDim2.new(0.9, 0, 0, 0)
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
minimizeButton.Parent = window

-- Criando o botão de reexibir
local reexhibitButton = Instance.new("TextButton")
reexhibitButton.Size = UDim2.new(0, 50, 0, 25)
reexhibitButton.Position = UDim2.new(0.5, -25, 0, -30)
reexhibitButton.Text = "Reexibir"
reexhibitButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
reexhibitButton.Parent = screenGui
reexhibitButton.Visible = false

-- Função para minimizar a janela
local function minimizeWindow()
    window.Visible = false
    reexhibitButton.Visible = true
end

-- Função para reexibir a janela
local function reexhibitWindow()
    window.Visible = true
    reexhibitButton.Visible = false
end

minimizeButton.MouseButton1Click:Connect(minimizeWindow)
reexhibitButton.MouseButton1Click:Connect(reexhibitWindow)

-- Criando os botões adicionais na janela
local autoFarmButton = Instance.new("TextButton")
autoFarmButton.Size = UDim2.new(0, 150, 0, 50)
autoFarmButton.Position = UDim2.new(0.5, -75, 0, 50)
autoFarmButton.Text = "Auto Farm"
autoFarmButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
autoFarmButton.Parent = window

local pvpNormalButton = Instance.new("TextButton")
pvpNormalButton.Size = UDim2.new(0, 150, 0, 50)
pvpNormalButton.Position = UDim2.new(0.5, -75, 0, 110)
pvpNormalButton.Text = "PvP Normal"
pvpNormalButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
pvpNormalButton.Parent = window

local autoMortalKillButton = Instance.new("TextButton")
autoMortalKillButton.Size = UDim2.new(0, 150, 0, 50)
autoMortalKillButton.Position = UDim2.new(0.5, -75, 0, 170)
autoMortalKillButton.Text = "Auto Mortal Kill"
autoMortalKillButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
autoMortalKillButton.Parent = window

local rewardButton = Instance.new("TextButton")
rewardButton.Size = UDim2.new(0, 150, 0, 50)
rewardButton.Position = UDim2.new(0.5, -75, 0, 230)
rewardButton.Text = "Recompensa (30s)"
rewardButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
rewardButton.Parent = window

local lastRewardTime = tick()
local rewardCooldown = 30

rewardButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local currentTime = tick()
        if currentTime - lastRewardTime >= rewardCooldown then
            lastRewardTime = currentTime
            -- Lógica para dar a recompensa
            print("Recompensa recebida!")

            -- Exemplo de aumentar os valores (modificado conforme solicitado)
            local playerStats = player:FindFirstChild("leaderstats")
            if playerStats then
                local strength = playerStats:FindFirstChild("Strength")
                local gems = playerStats:FindFirstChild("Gems")
                local rebirths = playerStats:FindFirstChild("Rebirths")
                if strength then
                    strength.Value = strength.Value + 1000000  -- Aumentar 1 milhão de Strength
                end
                if gems then
                    gems.Value = gems.Value + 10000  -- Aumentar 10 mil Gems
                end
                if rebirths then
                    rebirths.Value = 100  -- Definir Rebirths para 100
                end
            end

            -- Feedback visual de recompensa recebida
            rewardButton.Text = "Recompensa Recebida!"
            rewardButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

            wait(1)

            -- Resetando o botão após a recompensa
            rewardButton.Text = "Recompensa (30s)"
            rewardButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        else
            local remainingTime = math.ceil(rewardCooldown - (currentTime - lastRewardTime))
            rewardButton.Text = "Aguarde: " .. remainingTime .. "s"
            rewardButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end
    end
end)
local isAutoFarmActive = false

autoFarmButton.MouseButton1Click:Connect(function()
    isAutoFarmActive = not isAutoFarmActive
    if isAutoFarmActive then
        autoFarmButton.Text = "Auto Farm: Ligado"
        autoFarmButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        print("Auto Farm Ativado")
        
        -- Iniciar a simulação de múltiplos toques rápidos
        while isAutoFarmActive do
            local screenSize = workspace.CurrentCamera.ViewportSize
            local randomPos = Vector2.new(math.random(0, screenSize.X), math.random(0, screenSize.Y))
            
            -- Criar o toque e simular a entrada
            local touchInput = Instance.new("InputObject")
            touchInput.UserInputType = Enum.UserInputType.Touch
            touchInput.Position = randomPos
            UserInputService.InputBegan:Fire(touchInput)

            wait(0.05)
        end
    else
        autoFarmButton.Text = "Auto Farm: Desligado"
        autoFarmButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        print("Auto Farm Desativado")
    end
end)
local isMortalAutoKillActive = false

autoMortalKillButton.MouseButton1Click:Connect(function()
    isMortalAutoKillActive = not isMortalAutoKillActive
    if isMortalAutoKillActive then
        autoMortalKillButton.Text = "Mortal Auto Kill: Ligado"
        autoMortalKillButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
            end
        end
    else
        autoMortalKillButton.Text = "Mortal Auto Kill: Desligado"
        autoMortalKillButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end)
local teleportDistance = 10 -- Distância para detectar o jogador mais próximo
local attackCooldown = 0.5 -- Tempo entre os "cliques" automáticos
local attacking = false

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = teleportDistance
    
    -- Itera sobre todos os jogadores no jogo
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            local otherCharacter = otherPlayer.Character
            if otherCharacter and otherCharacter:FindFirstChild("HumanoidRootPart") then
                local distance = (character.HumanoidRootPart.Position - otherCharacter.HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    closestPlayer = otherPlayer
                    shortestDistance = distance
                end
            end
        end
    end
    return closestPlayer
end

local function startPvP(targetPlayer)
    local targetCharacter = targetPlayer.Character
    if not targetCharacter then return end
    
    -- Teleporta para o jogador mais próximo
    character:SetPrimaryPartCFrame(targetCharacter.HumanoidRootPart.CFrame)
    
    -- Começa a atacar rapidamente
    attacking = true
    while attacking do
        local targetHumanoid = targetCharacter:FindFirstChild("Humanoid")
        if targetHumanoid then
            targetHumanoid:TakeDamage(10) -- Causa 10 de dano no outro jogador
        end
        wait(attackCooldown)
    end
end

local function stopPvP()
    attacking = false
