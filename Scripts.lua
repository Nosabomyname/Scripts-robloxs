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
        
        local player = game.Players.LocalPlayer
        local character = player.Character
        
        -- Lógica de Auto Farm
        while isAutoFarmActive do
            if character then
                -- Adicione ações específicas do Auto Farm, como usar ferramentas ou coletar itens
                print("Executando Auto Farm...")
            end
            wait(0.05) -- Intervalo de tempo para evitar lag excessivo
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
        
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoid = character:WaitForChild("Humanoid")
        
        local targetPlayer = nil
        local teleportDistance = 10 -- Distância para detectar o jogador mais próximo
        
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

        -- Loop de PvP que tenta detectar o jogador mais próximo
        while isPvPActive do
            targetPlayer = getClosestPlayer()
            if targetPlayer then
                local targetCharacter = targetPlayer.Character
                if targetCharacter then
                    -- Teleporta para o jogador mais próximo
                    character:SetPrimaryPartCFrame(targetCharacter.HumanoidRootPart.CFrame)
                    print("Teleportando para o jogador mais próximo:", targetPlayer.Name)
                    wait(1) -- Espera um pouco antes de continuar
                end
            end
            wait(0.5) -- Intervalo de tempo para evitar lag excessivo
        end
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
        print("Mortal Auto Kill Ativado")
        
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Health = 0 -- Mata o jogador
            end
        end
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
local autoFarmButton = createButton(mainFrame, "Auto Farm: Desligado", UDim2.new(0, 25, 0, 50), function()
    toggleAutoFarm(autoFarmButton)
end)

local pvpButton = createButton(mainFrame, "PvP: Desligado", UDim2.new(0, 25, 0, 120), function()
    togglePvP(pvpButton)
end)

local mortalAutoKillButton = createButton(mainFrame, "Mortal Auto Kill: Desligado", UDim2.new(0, 25, 0, 190), function()
    toggleMortalAutoKill(mortalAutoKillButton)
end)

local rewardButton = createButton(mainFrame, "Receber Recompensa", UDim2.new(0, 25, 0, 260), function()
    claimReward(rewardButton)
end)
