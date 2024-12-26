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

-- Variáveis para o Auto Farm e Anti AFK
local isAutoFarmActive = false
local isAntiAFKActive = false
local UserInputService = game:GetService("UserInputService")
local lastClickTime = tick()

-- Função Auto Farm (Simula o clique)
autoFarmButton.MouseButton1Click:Connect(function()
    isAutoFarmActive = not isAutoFarmActive
    if isAutoFarmActive then
        autoFarmButton.Text = "Auto Farm: Ligado"
        autoFarmButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        print("Auto Farm Ativado")
        
        -- Inicia a simulação de múltiplos toques rápidos
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

-- Função Anti AFK (Simula movimentos)
local function antiAFK()
    isAntiAFKActive = true
    while isAntiAFKActive do
        -- Simula um pequeno movimento do mouse a cada 10 segundos
        if tick() - lastClickTime >= 10 then
            local mouse = game.Players.LocalPlayer:GetMouse()
            mouse.Move:Fire(Vector3.new(0, 0, 0))  -- Movimentação do mouse
            lastClickTime = tick()
        end
        wait(5)
    end
end

-- Inicia o Anti AFK quando o Auto Farm é ativado
autoFarmButton.MouseButton1Click:Connect(function()
    if isAutoFarmActive then
        antiAFK()  -- Inicia o Anti AFK
    end
end)

-- Função PvP Normal (Simples)
pvpNormalButton.MouseButton1Click:Connect(function()
    -- Função para atacar o jogador mais próximo
    local closestPlayer = nil
    local teleportDistance = 10 -- Distância para detectar o jogador mais próximo
    local character = player.Character
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
    
    -- Se o jogador mais próximo for encontrado, teleportar e atacar
    if closestPlayer then
        local targetCharacter = closestPlayer.Character
        if targetCharacter then
            character:SetPrimaryPartCFrame(targetCharacter.HumanoidRootPart.CFrame)
            local targetHumanoid = targetCharacter:FindFirstChild("Humanoid")
            if targetHumanoid then
                targetHumanoid.Health = 0  -- Mata o outro jogador independente de sua saúde
            end
        end
    end
end)

-- Função Mortal Auto Kill (Desativa ou Ativa a função)
autoMortalKillButton.MouseButton1Click:Connect(function()
    local isMortalAutoKillActive = false
    isMortalAutoKillActive = not isMortalAutoKillActive
    if isMortalAutoKillActive then
        autoMortalKillButton.Text = "Mortal Auto Kill: Ligado"
        autoMortalKillButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        
        -- Mata todos os jogadores no jogo
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0  -- Mata todos os jogadores
                end
            end
        end
    else
        autoMortalKillButton.Text = "Mortal Auto Kill: Desligado"
        autoMortalKillButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end)
