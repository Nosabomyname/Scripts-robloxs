-- Criação da janela principal
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Janela principal (quadrada e centralizada)
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 200, 0, 200)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 2
mainFrame.Visible = true

-- Variável para controlar a visibilidade da janela
local isWindowVisible = true

-- Botão de reexibir janela (minimizar/maximizar), posicionado acima da janela principal
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.5, -25, 0, -150)  -- Posicionado acima da janela principal
toggleButton.Text = "+"
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)

toggleButton.MouseButton1Click:Connect(function()
    -- Alterna a visibilidade da janela principal
    isWindowVisible = not isWindowVisible
    mainFrame.Visible = isWindowVisible
    toggleButton.Text = isWindowVisible and "-" or "+"
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

-- Função para iniciar o Auto Farm simulando cliques contínuos
local function startAutoFarm()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    -- Posição de treino ou ferramenta
    local farmPosition = Vector3.new(0, 0, 0) -- Ajustar para a posição desejada

    while true do
        if not isWindowVisible then break end -- Para se a janela for minimizada
        humanoid:MoveTo(farmPosition)  -- Move o personagem para a posição de treino
        wait(1)  -- Simula o atraso entre os cliques
        print("Auto Farm em andamento...")
    end
end

-- Botão para ativar Auto Farm
createButton("Ativar Auto Farm", UDim2.new(0, 10, 0, 50), function()
    print("Auto Farm ativado")
    startAutoFarm()
end)
