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

-- Lógica de recompensa com cooldown de 30 segundos
local lastRewardTime = tick()
local rewardCooldown = 30

rewardButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local currentTime = tick()
        if currentTime - lastRewardTime >= rewardCooldown then
            lastRewardTime = currentTime
            -- Lógica para dar a recompensa
            print("Recompensa recebida!")

            -- Exemplo de aumentar os valores (modifique conforme necessário)
            local playerStats = player:FindFirstChild("leaderstats")
            if playerStats then
                local strength = playerStats:FindFirstChild("Strength")
                local gems = playerStats:FindFirstChild("Gems")
                local rebirths = playerStats:FindFirstChild("Rebirths")
                if strength then
                    strength.Value = strength.Value + 100
                end
                if gems then
                    gems.Value = gems.Value + 100
                end
                if rebirths then
                    rebirths.Value = rebirths.Value + 1
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

-- Funções para os outros botões (colocar lógicas reais dos scripts)
autoFarmButton.MouseButton1Click:Connect(function()
    -- Ativar o Auto Farm
    print("Auto Farm Ativado!")
end)

pvpNormalButton.MouseButton1Click:Connect(function()
    -- Ativar PvP Normal
    print("PvP Normal Ativado!")
end)

autoMortalKillButton.MouseButton1Click:Connect(function()
    -- Ativar Auto Mortal Kill
    print("Auto Mortal Kill Ativado!")
end)local UserInputService = game:GetService("UserInputService")

-- Variáveis de controle
local isAutoFarmActive = false
local autoFarmButton = script.Parent -- Supondo que o botão esteja em 'script.Parent'

-- Função para ativar e desativar o Auto Farm
autoFarmButton.MouseButton1Click:Connect(function()
    isAutoFarmActive = not isAutoFarmActive
    if isAutoFarmActive then
        autoFarmButton.Text = "Auto Farm: Ligado"
        autoFarmButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        print("Auto Farm Ativado")
        
        -- Iniciar a simulação de múltiplos toques rápidos
        while isAutoFarmActive do
            -- Simula um toque na tela em uma posição aleatória (ajuste conforme necessário)
            local screenSize = workspace.CurrentCamera.ViewportSize
            local randomPos = Vector2.new(math.random(0, screenSize.X), math.random(0, screenSize.Y))
            
            -- Criar o toque e simular a entrada
            local touchInput = Instance.new("InputObject")
            touchInput.UserInputType = Enum.UserInputType.Touch
            touchInput.Position = randomPos
            UserInputService.InputBegan:Fire(touchInput)

            -- Ajuste a frequência de cliques
            wait(0.05) -- Ajuste a frequência de cliques conforme necessário
        end
    else
        autoFarmButton.Text = "Auto Farm: Desligado"
        autoFarmButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        print("Auto Farm Desativado")
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
end)
