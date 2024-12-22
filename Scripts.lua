-- Criação da janela principal
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Janela principal (quadrada e centralizada)
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 200, 0, 300)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 2
mainFrame.Visible = true

-- Variável para controlar a visibilidade da janela
local isWindowVisible = true

-- Botão de reexibir janela (minimizar/maximizar), aparece quando a janela está minimizada
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.5, -25, 0, -150)  -- Posição inicial
toggleButton.Text = "+"
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
toggleButton.Visible = false -- Inicialmente invisível

-- Função para alternar a visibilidade da janela principal
local function toggleWindow()
    isWindowVisible = not isWindowVisible
    mainFrame.Visible = isWindowVisible
    toggleButton.Visible = not isWindowVisible -- Mostra o botão se a janela estiver minimizada
end

-- Botão para minimizar/reexibir a janela principal
local minimizeButton = Instance.new("TextButton")
minimizeButton.Parent = mainFrame
minimizeButton.Size = UDim2.new(0, 50, 0, 30)
minimizeButton.Position = UDim2.new(1, -60, 0, 10) -- Posicionado no canto superior direito da janela
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

minimizeButton.MouseButton1Click:Connect(toggleWindow)

toggleButton.MouseButton1Click:Connect(function()
    isWindowVisible = true
    mainFrame.Visible = true
    toggleButton.Visible = false
end)

-- Variáveis de controle para os botões
local autoFarmActive = false
local pvpActive = false

-- Função para criar botões
local function createButton(name, position, callback)
    local button = Instance.new("TextButton")
    button.Parent = mainFrame
    button.Size = UDim2.new(0, 180, 0, 40)
    button.Position = position
    button.Text = name
    button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Função para iniciar/parar o Auto Farm
local function toggleAutoFarm()
    autoFarmActive = not autoFarmActive
    if autoFarmActive then
        print("Auto Farm ativado")
        while autoFarmActive do
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")
            local farmPosition = Vector3.new(0, 0, 0) -- Ajustar para a posição de treino

            humanoid:MoveTo(farmPosition)
            wait(1)
            print("Farmando...")
        end
    else
        print("Auto Farm desativado")
    end
end

