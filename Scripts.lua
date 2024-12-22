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

-- Variável para controlar a visibilidade da janela
local isWindowVisible = true

-- Botão de reexibir janela (minimizar/maximizar), posicionado acima da janela principal
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.5, -25, 0, -200)  -- Posicionado acima da janela principal
toggleButton.Text = "+"
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)

toggleButton.MouseButton1Click:Connect(function()
    -- Alterna a visibilidade da janela principal
    isWindowVisible = not isWindowVisible
    mainFrame.Visible = isWindowVisible  -- Muda a visibilidade da janela
    toggleButton.Text = isWindowVisible and "-" or "+"  -- Muda o texto do botão
end)

-- Função para criar botões
local function createButton(name, position, callback)
    local button = Instance.new("TextButton")
    button.Parent = mainFrame
    button.Size = UDim2.new(0, 180, 0, 40)
    button.Position = position
    button.Text = name
    button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    button.MouseButton1Click:Connect(callback)
end

-- Botões para ativar/desativar funcionalidades
createButton("Ativar PVP", UDim2.new(0, 10, 0, 50), function() 
    print("PVP ativado") 
end)

createButton("Ativar Auto Farm", UDim2.new(0, 10, 0, 100), function() 
    print("Auto Farm ativado") 
end)

-- Função para iniciar o Auto Farm simulando cliques contínuos
local function startAutoFarm()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoid = character:FindFirstChild("Humanoid")
    
    -- Localiza a posição do botão de treino ou ferramenta na tela do jogo
    local farmPosition = Vector3.new(0, 0, 0)  -- Posição onde o clique será feito

    -- Ajuste o valor de farmPosition para a posição exata de treinamento
    while true do
        humanoid:MoveTo(farmPosition)  -- Move o personagem para a posição de farm
        wait(1)  -- Atraso entre os cliques para simular o uso real da ferramenta
        print("Clicando na posição de treino para farmar")
    end
end
