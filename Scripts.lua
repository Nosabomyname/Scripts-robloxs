-- Criação da janela principal
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Janela principal (quadrada e centralizada)
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 200, 0, 350)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 2
mainFrame.Visible = true

-- Botão para minimizar e reexibir a janela (colocado acima da janela normal)
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.5, -25, 0, -200)  -- Colocado mais acima da janela
toggleButton.Text = "+"
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)

-- Variável para controlar a visibilidade da janela
local isWindowVisible = true

toggleButton.MouseButton1Click:Connect(function()
    isWindowVisible = not isWindowVisible
    mainFrame.Visible = isWindowVisible  -- Muda a visibilidade da janela
    toggleButton.Text = isWindowVisible and "-" or "+"  -- Muda o texto do botão
end)

-- Função para criar botões
local buttons = {}

local function createButton(name, position, callback)
    local button = Instance.new("TextButton")
    button.Parent = mainFrame
    button.Size = UDim2.new(0, 180, 0, 40)
    button.Position = position
    button.Text = name
    button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    button.MouseButton1Click:Connect(callback)
    table.insert(buttons, button)
    return button
end

-- Criação dos botões de funcionalidade
createButton("Ativar PVP", UDim2.new(0, 10, 0, 50), function() 
    print("PVP ativado") 
    pvpFrame.Visible = true  -- Mostra a janela para inserir o nome do jogador
end)
createButton("Ativar Auto Farm", UDim2.new(0, 10, 0, 100), function() 
    print("Auto Farm ativado") 
    startAutoFarm()  -- Função para iniciar o Auto Farm
end)

-- Criação da área de entrada de nome do jogador para PvP
local pvpFrame = Instance.new("Frame")
pvpFrame.Parent = screenGui
pvpFrame.Size = UDim2.new(0, 200, 0, 100)
pvpFrame.Position = UDim2.new(0.5, -100, 0.5, -150)
pvpFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
pvpFrame.Visible = false  -- Inicialmente invisível

local nameInput = Instance.new("TextBox")
nameInput.Parent = pvpFrame
nameInput.Size = UDim2.new(0, 180, 0, 40)
nameInput.Position = UDim2.new(0, 10, 0, 10)
nameInput.PlaceholderText = "Nome do jogador"
nameInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local pvpButton = Instance.new("TextButton")
pvpButton.Parent = pvpFrame
pvpButton.Size = UDim2.new(0, 180, 0, 40)
pvpButton.Position = UDim2.new(0, 10, 0, 60)
pvpButton.Text = "Iniciar PvP"
pvpButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

-- Função para ativar o PvP
pvpButton.MouseButton1Click:Connect(function()
    local targetName = nameInput.Text
    local targetPlayer = nil

    -- Procurar pelo jogador pelo nome
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Name:lower() == targetName:lower() then
            targetPlayer = player
            break
        end
    end

    -- Se o jogador foi encontrado, ativar o PvP
    if targetPlayer then
        local targetCharacter = targetPlayer.Character
        if targetCharacter then
            local humanoid = targetCharacter:FindFirstChild("Humanoid")
            if humanoid then
                -- Posicionar o personagem para "atacar" à distância
                local character = game.Players.LocalPlayer.Character
                if character then
                    local targetPosition = targetCharacter.HumanoidRootPart.Position
                    local currentPosition = character.HumanoidRootPart.Position

                    -- Ação de "bater" à distância
                    local distance = (targetPosition - currentPosition).Magnitude
                    if distance < 50 then  -- Verifica se está dentro da distância de "bater"
                        -- Lógica para acertar o jogador
                        print("Atacando " .. targetName)
                    else
                        print("Jogador está muito distante")
                    end
                end
            end
        end
    else
        print("Jogador não encontrado")
    end
end)

-- Função para iniciar o Auto Farm
local function startAutoFarm()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoid = character:FindFirstChild("Humanoid")

    -- Localiza a ferramenta de treino (ex: pesos ou esteira)
    local closestTool = nil
    local closestDistance = math.huge
    for _, tool in ipairs(workspace:GetChildren()) do
        if tool:IsA("Model") and (tool.Name == "Peso" or tool.Name == "Esteira") then
            local distance = (character.HumanoidRootPart.Position - tool.PrimaryPart.Position).Magnitude
            if distance < closestDistance then
                closestTool = tool
                closestDistance = distance
            end
        end
    end

    -- Se uma ferramenta foi encontrada, começar o Auto Farm
    if closestTool then
        print("Iniciando Auto Farm com a ferramenta: " .. closestTool.Name)
        -- Simula os cliques contínuos na ferramenta de treino
        while true do
            humanoid:MoveTo(closestTool.PrimaryPart.Position)
            wait(1)  -- Atraso entre os cliques para simular o uso real da ferramenta
            -- Aqui você pode adicionar mais lógicas de farm (como dar cliques, etc)
        end
    else
        print("Nenhuma ferramenta de treino encontrada")
    end
end
