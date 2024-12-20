-- Criar GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local ShowButton = Instance.new("TextButton")  -- Novo botão para mostrar a janela
local AutoFarmButton = Instance.new("TextButton")
local PvPButton = Instance.new("TextButton")
local AutoCollectButton = Instance.new("TextButton")
local IsMinimized = false -- Variável para controlar o estado de minimização

-- Configurações iniciais
local autofarmEnabled = false
local pvpEnabled = false
local autoCollectEnabled = false

-- Adicionar ao jogador
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Configuração do MainFrame
MainFrame.Size = UDim2.new(0, 300, 0, 400)  -- Maior janela
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
MainFrame.Parent = ScreenGui
MainFrame.Visible = true  -- Inicialmente visível

-- Configuração do título
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Title.Text = "Menu"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextScaled = true
Title.Parent = MainFrame

-- Botão de minimizar
MinimizeButton.Size = UDim2.new(0, 50, 0, 50)
MinimizeButton.Position = UDim2.new(1, -50, 0, 0)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.BackgroundColor3 = Color3.new(0.5, 0.1, 0.1)
MinimizeButton.Parent = MainFrame

-- Botão para mostrar a janela
ShowButton.Size = UDim2.new(0, 150, 0, 50)
ShowButton.Position = UDim2.new(0.5, -75, 1, -60)  -- Posição do botão na tela
ShowButton.Text = "Mostrar Janela"
ShowButton.TextColor3 = Color3.new(1, 1, 1)
ShowButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.2)
ShowButton.Visible = false  -- Inicialmente invisível
ShowButton.Parent = ScreenGui

-- Botão Auto Farm
AutoFarmButton.Size = UDim2.new(1, 0, 0, 50)
AutoFarmButton.Position = UDim2.new(0, 0, 0, 60)
AutoFarmButton.Text = "Auto Farm: OFF"
AutoFarmButton.TextColor3 = Color3.new(1, 1, 1)
AutoFarmButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.2)
AutoFarmButton.Parent = MainFrame

-- Botão PvP
PvPButton.Size = UDim2.new(1, 0, 0, 50)
PvPButton.Position = UDim2.new(0, 0, 0, 120)
PvPButton.Text = "PvP: OFF"
PvPButton.TextColor3 = Color3.new(1, 1, 1)
PvPButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.2)
PvPButton.Parent = MainFrame

-- Botão Auto Coleta
AutoCollectButton.Size = UDim2.new(1, 0, 0, 50)
AutoCollectButton.Position = UDim2.new(0, 0, 0, 180)
AutoCollectButton.Text = "Auto Coleta: OFF"
AutoCollectButton.TextColor3 = Color3.new(1, 1, 1)
AutoCollectButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.2)
AutoCollectButton.Parent = MainFrame

-- Função para minimizar/maximizar
MinimizeButton.MouseButton1Click:Connect(function()
    IsMinimized = not IsMinimized
    MainFrame.Visible = not IsMinimized  -- Alterna a visibilidade
    ShowButton.Visible = IsMinimized  -- Torna o botão de mostrar visível se minimizado
end)

-- Função para reexibir a janela
ShowButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ShowButton.Visible = false
    IsMinimized = false
end)

-- Função para ativar/desativar Auto Farm
AutoFarmButton.MouseButton1Click:Connect(function()
    autofarmEnabled = not autofarmEnabled
    AutoFarmButton.Text = autofarmEnabled and "Auto Farm: ON" or "Auto Farm: OFF"
    if autofarmEnabled then
        spawn(function()
            while autofarmEnabled do
                wait(0.05)  -- Aumentando a velocidade do farm
                pcall(function()
                    -- Simula o clique para farmar, seja com peso ou outros métodos
                    local player = game.Players.LocalPlayer
                    if player.Character then
                        -- Ativar ferramenta (simula o clique)
                        local tool = player.Character:FindFirstChildOfClass("Tool")
                        if tool then
                            tool:Activate()  -- Simula o clique para farmar força
                        end

                        -- Verificar e clicar automaticamente em outros objetos de farm
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj:IsA("Part") and obj.Name == "Weight" then
                                -- Clicar nos objetos de peso para aumentar força e durabilidade
                                player.Character.HumanoidRootPart.CFrame = obj.CFrame
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- Função para ativar/desativar PvP
PvPButton.MouseButton1Click:Connect(function()
    pvpEnabled = not pvpEnabled
    PvPButton.Text = pvpEnabled and "PvP: ON" or "PvP: OFF"
    if pvpEnabled then
        spawn(function()
            while pvpEnabled do
                wait(0.05)  -- Aumentando a velocidade do PvP
                pcall(function()
                    -- Atacar inimigos automaticamente dentro do alcance
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                            local humanoid = player.Character.Humanoid
                            local distance = (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                            if distance < 20 then
                                -- Atacar automaticamente
                                local character = game.Players.LocalPlayer.Character
                                local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                                -- Ação de bater
                                local tool = character:FindFirstChildOfClass("Tool")
                                if tool then
                                    tool:Activate()  -- Simula o ataque
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- Função para ativar/desativar Auto Coleta
AutoCollectButton.MouseButton1Click:Connect(function()
    autoCollectEnabled = not autoCollectEnabled
    AutoCollectButton.Text = autoCollectEnabled and "Auto Coleta: ON" or "Auto Coleta: OFF"
    if autoCollectEnabled then
        spawn(function()
            while autoCollectEnabled do
                wait(2)  -- Aumentando a velocidade da coleta
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj.Name == "Reward" and obj:IsA("Part") then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                        end
                    end
                end)
            end
        end)
    end
end)
