-- Criar GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Janela principal
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 2
mainFrame.Visible = true

-- Variável para controle de visibilidade da janela
local isWindowVisible = true

-- Botão de minimizar
local minimizeButton = Instance.new("TextButton")
minimizeButton.Parent = mainFrame
minimizeButton.Size = UDim2.new(0, 50, 0, 30)
minimizeButton.Position = UDim2.new(1, -60, 0, 10)
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

-- Função para minimizar
minimizeButton.MouseButton1Click:Connect(function()
    isWindowVisible = not isWindowVisible
    mainFrame.Visible = isWindowVisible
end)

-- Botão de Auto Farm
local autoFarmButton = Instance.new("TextButton")
autoFarmButton.Parent = mainFrame
autoFarmButton.Size = UDim2.new(0, 250, 0, 50)
autoFarmButton.Position = UDim2.new(0, 25, 0, 50)
autoFarmButton.Text = "Auto Farm: Desligado"
autoFarmButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

-- Variável para controle do Auto Farm
local isAutoFarmActive = false

-- Função para ativar/desativar Auto Farm
autoFarmButton.MouseButton1Click:Connect(function()
    isAutoFarmActive = not isAutoFarmActive
    if isAutoFarmActive then
        autoFarmButton.Text = "Auto Farm: Ligado"
        autoFarmButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        -- Iniciar Auto Click (simular cliques rápidos)
        print("Auto Farm Ativado")
        
        -- Inicia o Auto Click
        while isAutoFarmActive do
            -- Simula um clique na tela
            local mouse = game.Players.LocalPlayer:GetMouse()
            mouse.Button1Down:Fire()
            wait(0.05)  -- Atraso entre os cliques, ajustável para controle de velocidade
        end
    else
        autoFarmButton.Text = "Auto Farm: Desligado"
        autoFarmButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        -- Para o Auto Click
        print("Auto Farm Desativado")
    end
end)
