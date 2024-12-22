-- Criar GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Janela principal
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
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

-- Criar o botão de Recompensa
local rewardButton = Instance.new("TextButton")
rewardButton.Parent = mainFrame
rewardButton.Size = UDim2.new(0, 250, 0, 50)
rewardButton.Position = UDim2.new(0, 25, 0, 50)
rewardButton.Text = "Receber Recompensa"
rewardButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)

-- Função de Recompensa (energéticos, força e rebirth 2x)
local lastRewardTime = 0
local rewardCooldown = 600  -- 10 minutos (600 segundos)

rewardButton.MouseButton1Click:Connect(function()
    local currentTime = tick()
    
    -- Verifica se já se passaram 10 minutos
    if currentTime - lastRewardTime >= rewardCooldown then
        lastRewardTime = currentTime
        
        -- Dando recompensa
        local player = game.Players.LocalPlayer
        local playerStats = player:FindFirstChild("leaderstats")
        
        if playerStats then
            local strength = playerStats:FindFirstChild("Strength")
            local coins = playerStats:FindFirstChild("Coins")
            local xp = playerStats:FindFirstChild("XP")
            local rebirths = playerStats:FindFirstChild("Rebirths")

            if strength then
                strength.Value = strength.Value + 500  -- Aumenta 500 de força
            end

            if coins then
                coins.Value = coins.Value + 100  -- Aumenta 100 moedas
            end

            if xp then
                xp.Value = xp.Value + 50  -- Aumenta 50 de XP
            end
            
            if rebirths then
                rebirths.Value = rebirths.Value + 2  -- Aumenta 2x de rebirth
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
        rewardButton.Text = "Aguarde: 10 Minutos"
        rewardButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        
        wait(1)
        
        rewardButton.Text = "Receber Recompensa"
        rewardButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    end
end)

-- Barra de pesquisa para PvP (inclusa como no código original)
local searchBarFrame = Instance.new("Frame")
searchBarFrame.Parent = mainFrame
searchBarFrame.Size = UDim2.new(0, 250, 0, 50)
searchBarFrame.Position = UDim2.new(0, 25, 0, 170)
searchBarFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
searchBarFrame.Visible = false -- Inicialmente invisível

local searchLabel = Instance.new("TextLabel")
searchLabel.Parent = searchBarFrame
searchLabel.Size = UDim2.new(0, 250, 0, 30)
searchLabel.Position = UDim2.new(0, 0, 0, 0)
searchLabel.Text = "Digite o nome do jogador"
searchLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
searchLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

local searchBox = Instance.new("TextBox")
searchBox.Parent = searchBarFrame
searchBox.Size = UDim2.new(0, 250, 0, 20)
searchBox.Position = UDim2.new(0, 0, 0, 30)
searchBox.PlaceholderText = "Nome do jogador"
searchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local searchButton = Instance.new("TextButton")
searchButton.Parent = searchBarFrame
searchButton.Size = UDim2.new(0, 250, 0, 30)
searchButton.Position = UDim2.new(0, 0, 0, 60)
searchButton.Text = "Buscar Jogador"
searchButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

-- Função para ativar PvP e mostrar a barra de pesquisa (já implementado)
-- Funções para as demais funcionalidades PvP
-- ...

-- Funções de animação para o botão (já implementado)
-- ...

-- Criar GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Janela principal
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 300, 0, 500)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
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

-- Criar o botão de Recompensa
local rewardButton = Instance.new("TextButton")
rewardButton.Parent = mainFrame
rewardButton.Size = UDim2.new(0, 250, 0, 50)
rewardButton.Position = UDim2.new(0, 25, 0, 50)
rewardButton.Text = "Receber Recompensa"
rewardButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)

-- Função de Recompensa (energéticos, força e rebirth 2x)
local lastRewardTime = 0
local rewardCooldown = 600  -- 10 minutos (600 segundos)

rewardButton.MouseButton1Click:Connect(function()
    local currentTime = tick()

    -- Verifica se já se passaram 10 minutos
    if currentTime - lastRewardTime >= rewardCooldown then
        lastRewardTime = currentTime
        
        -- Dando recompensa
        local player = game.Players.LocalPlayer
        local playerStats = player:FindFirstChild("leaderstats")
        
        if playerStats then
            local strength = playerStats:FindFirstChild("Strength")
            local coins = playerStats:FindFirstChild("Coins")
            local xp = playerStats:FindFirstChild("XP")
            local rebirths = playerStats:FindFirstChild("Rebirths")

            if strength then
                strength.Value = strength.Value + 500  -- Aumenta 500 de força
            end

            if coins then
                coins.Value = coins.Value + 100  -- Aumenta 100 moedas
            end

            if xp then
                xp.Value = xp.Value + 50  -- Aumenta 50 de XP
            end
            
            if rebirths then
                rebirths.Value = rebirths.Value + 2  -- Aumenta 2x de rebirth
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
        rewardButton.Text = "Aguarde: 10 Minutos"
        rewardButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        
        wait(1)
        
        rewardButton.Text = "Receber Recompensa"
        rewardButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    end
end)

-- Barra de pesquisa para PvP (inclusa como no código original)
local searchBarFrame = Instance.new("Frame")
searchBarFrame.Parent = mainFrame
searchBarFrame.Size = UDim2.new(0, 250, 0, 50)
searchBarFrame.Position = UDim2.new(0, 25, 0, 170)
searchBarFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
searchBarFrame.Visible = false -- Inicialmente invisível

local searchLabel = Instance.new("TextLabel")
searchLabel.Parent = searchBarFrame
searchLabel.Size = UDim2.new(0, 250, 0, 30)
searchLabel.Position = UDim2.new(0, 0, 0, 0)
searchLabel.Text = "Digite o nome do jogador"
searchLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
searchLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

local searchBox = Instance.new("TextBox")
searchBox.Parent = searchBarFrame
searchBox.Size = UDim2.new(0, 250, 0, 20)
searchBox.Position = UDim2.new(0, 0, 0, 30)
searchBox.PlaceholderText = "Nome do jogador"
searchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local searchButton = Instance.new("TextButton")
searchButton.Parent = searchBarFrame
searchButton.Size = UDim2.new(0, 250, 0, 30)
searchButton.Position = UDim2.new(0, 0, 0, 60)
searchButton.Text = "Buscar Jogador"
searchButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

-- Criar os botões de Auto Farm, PvP e Mortal Auto Kill
local autoFarmButton = Instance.new("TextButton")
autoFarmButton.Parent = mainFrame
autoFarmButton.Size = UDim2.new(0, 250, 0, 50)
autoFarmButton.Position = UDim2.new(0, 25, 0, 250)
autoFarmButton.Text = "Auto Farm: Desligado"
autoFarmButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

local pvpButton = Instance.new("TextButton")
pvpButton.Parent = mainFrame
pvpButton.Size = UDim2.new(0, 250, 0, 50)
pvpButton.Position = UDim2.new(0, 25, 0, 310)
pvpButton.Text = "PvP: Desligado"
pvpButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

local mortalAutoKillButton = Instance.new("TextButton")
mortalAutoKillButton.Parent = mainFrame
mortalAutoKillButton.Size = UDim2.new(0, 250, 0, 50)
mortalAutoKillButton.Position = UDim2.new(0, 25, 0, 370)
mortalAutoKillButton.Text = "Mortal Auto Kill: Desligado"
mortalAutoKillButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

-- Variáveis para controle das opções
local isAutoFarmActive = false
local isPvPActive = false
local isMortalAutoKillActive = false

-- Função para alternar o Auto Farm
autoFarmButton.MouseButton1Click:Connect(function()
    isAutoFarmActive = not isAutoFarmActive
    if isAutoFarmActive then
        autoFarmButton.Text = "Auto Farm: Ligado"
        autoFarmButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        print("Auto Farm Ativado")
    else
        autoFarmButton.Text = "Auto Farm: Desligado"
        autoFarmButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        print("Auto Farm Desativado")
    end
end)

-- Função para ativar PvP
pvpButton.MouseButton1Click:Connect(function()
    isPvPActive = not isPvPActive
    if isPvPActive then
        pvpButton.Text = "PvP: Ligado"
        pvpButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        print("PvP Ativado")
    else
        pvpButton.Text = "PvP: Desligado"
        pvpButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        print("PvP Desativado")
    end
end)

-- Função para ativar Mortal Auto Kill
mortalAutoKillButton.MouseButton1Click:Connect(function()
    isMortalAutoKillActive = not isMortalAutoKillActive
    if isMortalAutoKillActive then
        mortalAutoKillButton.Text = "Mortal Auto Kill: Ligado"
        mortalAutoKillButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                local humanoid = player.Character.Humanoid
                humanoid.Health = 0 -- Mata o jogador
            end
        end
        print("Mortal Auto Kill Ativado")
    else
        mortalAutoKillButton.Text = "Mortal Auto Kill: Desligado"
        mortalAutoKillButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        print("Mortal Auto Kill Desativado")
    end
end)

-- Função de animação do botão
local function animateButton(button)
    local originalSize = button.Size
    local originalColor = button.BackgroundColor3
    button.Size = UDim2.new(0, 250, 0, 55)
    button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    wait(0.3)
    button.Size = originalSize
    button.BackgroundColor3 = originalColor
end

-- Adicionar animações ao clicar nos botões
pvpButton.MouseButton1Click:Connect(function()
    animateButton(pvpButton)
end)

mortalAutoKillButton.MouseButton1Click:Connect(function()
    animateButton(mortalAutoKillButton)
end)

-- Função para alternar o Auto Farm
autoFarmButton.MouseButton1Click:Connect(function()
    isAutoFarmActive = not isAutoFarmActive
    if isAutoFarmActive then
        autoFarmButton.Text = "Auto Farm: Ligado"
        autoFarmButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        -- Aqui você pode adicionar a lógica do Auto Farm
        print("Auto Farm Ativado")
        
        -- Iniciar Auto Click (simular cliques rápidos)
        local player = game.Players.LocalPlayer
        local buttonToClick = -- Aqui você coloca o botão que deseja simular o clique
        while isAutoFarmActive do
            if buttonToClick then
                -- Simula o clique no botão
                buttonToClick:Click()  -- Isso vai clicar no botão repetidamente
            end
            wait(0.05)  -- Atraso entre os cliques, ajustável conforme a velocidade desejada
        end
    else
        autoFarmButton.Text = "Auto Farm: Desligado"
        autoFarmButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        -- Aqui você pode desativar o Auto Farm
        print("Auto Farm Desativado")
    end
end)
