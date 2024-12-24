-- Criar GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Janela principal
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 350, 0, 450)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 2
mainFrame.Visible = true

-- Variável de visibilidade da janela
local isWindowVisible = true

-- Botão para minimizar/reexibir
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.5, -25, 0, -200)
toggleButton.Text = "+"
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
toggleButton.Visible = false -- Inicialmente invisível

local minimizeButton = Instance.new("TextButton")
minimizeButton.Parent = mainFrame
minimizeButton.Size = UDim2.new(0, 50, 0, 30)
minimizeButton.Position = UDim2.new(1, -60, 0, 10)
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

-- Funções para minimizar/reexibir
minimizeButton.MouseButton1Click:Connect(function()
    isWindowVisible = false
    mainFrame.Visible = false
    toggleButton.Visible = true
end)

toggleButton.MouseButton1Click:Connect(function()
    isWindowVisible = true
    mainFrame.Visible = true
    toggleButton.Visible = false
end)

-- Função para criar botões de forma dinâmica
local function createButton(parent, text, position, callback)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = UDim2.new(0, 300, 0, 50)
    button.Position = position
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Funções específicas para cada botão
local isAutoFarmActive = false
local function toggleAutoFarm(button)
    isAutoFarmActive = not isAutoFarmActive
    if isAutoFarmActive then
        button.Text = "Auto Farm: Ligado"
        button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        print("Auto Farm Ativado")
        -- Lógica do Auto Farm
        while isAutoFarmActive do
            -- Simula ações de Auto Farm
            wait(0.05)
        end
    else
        button.Text = "Auto Farm: Desligado"
        button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        print("Auto Farm Desativado")
    end
end

local isPvPActive = false
local function togglePvP(button)
    isPvPActive = not isPvPActive
    if isPvPActive then
        button.Text = "PvP: Ligado"
        button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        print("PvP Ativado")
        -- Adicione lógica PvP aqui
    else
        button.Text = "PvP: Desligado"
        button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        print("PvP Desativado")
    end
end

local isMortalAutoKillActive = false
local function toggleMortalAutoKill(button)
    isMortalAutoKillActive = not isMortalAutoKillActive
    if isMortalAutoKillActive then
        button.Text = "Mortal Auto Kill: Ligado"
        button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Health = 0 -- Mata o jogador
            end
        end
        print("Mortal Auto Kill Ativado")
    else
        button.Text = "Mortal Auto Kill: Desligado"
        button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        print("Mortal Auto Kill Desativado")
    end
end

local lastRewardTime = 0
local rewardCooldown = 30 -- 30 segundos
local function claimReward(button)
    local currentTime = tick()
    if currentTime - lastRewardTime >= rewardCooldown then
        lastRewardTime = currentTime
        -- Adiciona recompensas ao jogador
        local player = game.Players.LocalPlayer
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then
            local strength = leaderstats:FindFirstChild("Strength")
            local coins = leaderstats:FindFirstChild("Coins")
            if strength then strength.Value += 500 end
            if coins then coins.Value += 100 end
        end
        button.Text = "Recompensa Recebida!"
        button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        wait(1)
        button.Text = "Receber Recompensa"
        button.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    else
        button.Text = "Aguarde: 30 segundos"
        button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        wait(1)
        button.Text = "Receber Recompensa"
        button.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    end
end

-- Criar botões na GUI
createButton(mainFrame, "Auto Farm: Desligado", UDim2.new(0, 25, 0, 50), toggleAutoFarm)
createButton(mainFrame, "PvP: Desligado", UDim2.new(0, 25, 0, 120), togglePvP)
createButton(mainFrame, "Mortal Auto Kill: Desligado", UDim2.new(0, 25, 0, 190), toggleMortalAutoKill)
createButton(mainFrame, "Receber Recompensa", UDim2.new(0, 25, 0, 260), claimReward)autoFarmButton.MouseButton1Click:Connect(function()
    isAutoFarmActive = not isAutoFarmActive
    if isAutoFarmActive then
        autoFarmButton.Text = "Auto Farm: Ligado"
        autoFarmButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        print("Auto Farm Ativado")
        
        -- Exemplo de lógica de Auto Farm
        while isAutoFarmActive do
            local player = game.Players.LocalPlayer
            local character = player.Character
            if character then
                -- Adicione ações específicas do Auto Farm, como usar ferramentas ou coletar itens
                print("Executando Auto Farm...")
            end
            wait(0.05)
        end
    else
        autoFarmButton.Text = "Auto Farm: Desligado"
        autoFarmButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        print("Auto Farm Desativado")
    end
end)local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local mouse = player:GetMouse()

local teleportDistance = 10 -- Distância para detectar o jogador mais próximo
local attackCooldown = 0.5 -- Tempo entre os "cliques" automáticos
local attacking = false

-- Função para verificar se um jogador está dentro do raio
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

-- Função para iniciar o PvP
local function startPvP(targetPlayer)
    local targetCharacter = targetPlayer.Character
    if not targetCharacter then return end
    
    -- Teleporta para o jogador mais próximo
    character:SetPrimaryPartCFrame(targetCharacter.HumanoidRootPart.CFrame)
    
    -- Começa a atacar rapidamente
    attacking = true
    while attacking do
        -- Aqui vamos simular o ataque
        -- Simula um dano no outro jogador (exemplo simples de ataque)
        local targetHumanoid = targetCharacter:FindFirstChild("Humanoid")
        if targetHumanoid then
            targetHumanoid:TakeDamage(10) -- Causa 10 de dano no outro jogador
        end
        
        -- Aguarda um tempo entre os ataques
        wait(attackCooldown)
    end
end

-- Função para parar o PvP
local function stopPvP()
    attacking = false
end

-- Verificar constantemente o jogador mais próximo
game:GetService("RunService").Heartbeat:Connect(function()
    local closestPlayer = getClosestPlayer()
    if closestPlayer then
        startPvP(closestPlayer)
    else
        stopPvP() -- Caso não haja jogadores próximos, para o PvP
    end
end)mortalAutoKillButton.MouseButton1Click:Connect(function()
    isMortalAutoKillActive = not isMortalAutoKillActive
    if isMortalAutoKillActive then
        mortalAutoKillButton.Text = "Mortal Auto Kill: Ligado"
        mortalAutoKillButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
            end
        end
    else
        mortalAutoKillButton.Text = "Mortal Auto Kill: Desligado"
        mortalAutoKillButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end)-- Botão de Recompensa ajustado
local rewardButton = Instance.new("TextButton")
rewardButton.Parent = mainFrame
rewardButton.Size = UDim2.new(0, 250, 0, 50)
rewardButton.Position = UDim2.new(0, 25, 0, 50)
rewardButton.Text = "Receber Recompensa"
rewardButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)

-- Função de Recompensa (força, gemas, XP dos pets e rebirths)
local lastRewardTime = 0
local rewardCooldown = 30 -- Tempo reduzido para 30 segundos

-- Função que aumenta as habilidades (XP) dos pets e salva as habilidades
local function increasePetsXP()
    local player = game.Players.LocalPlayer
    local playerPets = player:FindFirstChild("Pets") -- Aqui assume-se que o jogador tem um objeto Pets

    if playerPets then
        for _, pet in pairs(playerPets:GetChildren()) do
            local petXP = pet:FindFirstChild("XP")
            if petXP then
                -- Aumenta o XP do pet para o valor máximo possível (exemplo: 1000)
                petXP.Value = petXP.Value + 1000
                -- Salvar o XP para que ele não diminua ao reiniciar
                petXP.Changed:Connect(function()
                    petXP.Value = petXP.Value -- Garante que o XP não diminua
                end)
            end
        end
    end
end

-- Usar o evento InputBegan para garantir que funcione em Android (touch) e PC (mouse)
rewardButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local currentTime = tick()

        -- Verifica se já se passaram 30 segundos
        if currentTime - lastRewardTime >= rewardCooldown then
            lastRewardTime = currentTime

            -- Dando recompensas
            local player = game.Players.LocalPlayer
            local playerStats = player:FindFirstChild("leaderstats")

            if playerStats then
                local strength = playerStats:FindFirstChild("Strength")
                local gems = playerStats:FindFirstChild("Gems")
                local rebirths = playerStats:FindFirstChild("Rebirths")

                -- 1. Aumenta o máximo de força possível (1 milhão)
                if strength then
                    strength.Value = 1000000 -- Aumenta para 1 milhão de força
                end

                -- 2. Aumenta 10.000 gemas
                if gems then
                    gems.Value = gems.Value + 10000 -- Aumenta 10.000 gemas
                end

                -- 3. Aumenta XP dos pets (habilidades)
                increasePetsXP()

                -- 4. Aumenta 20x rebirths ou mais
                if rebirths then
                    rebirths.Value = rebirths.Value + 20 -- Aumenta 20x rebirths
                end
            end

            -- Feedback visual de recompensa recebida
            rewardButton.Text = "Recompensa Recebida!"
            rewardButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

            wait(1)

            -- Resetando o botão após a recompensa
            rewardButton.Text = "Receber Recompensa"
            rewardButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        else
            -- Se o cooldown não tiver acabado
            local remainingTime = math.ceil(rewardCooldown - (currentTime - lastRewardTime))
            rewardButton.Text = "Aguarde: " .. remainingTime .. "s"
            rewardButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

            wait(1)

            rewardButton.Text = "Receber Recompensa"
            rewardButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        end
    end
end)
