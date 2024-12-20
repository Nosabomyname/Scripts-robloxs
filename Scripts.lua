-- Adicionando a função de Auto Click

local AutoClickEnabled = false -- Variável de controle para o Auto Click

-- Botão Auto Click
local AutoClickButton = Instance.new("TextButton")
AutoClickButton.Size = UDim2.new(1, 0, 0, 50)
AutoClickButton.Position = UDim2.new(0, 0, 0, 240)  -- Ajuste a posição do botão conforme necessário
AutoClickButton.Text = "Auto Click: OFF"
AutoClickButton.TextColor3 = Color3.new(1, 1, 1)
AutoClickButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.2)
AutoClickButton.Parent = MainFrame

-- Função para ativar/desativar Auto Click
AutoClickButton.MouseButton1Click:Connect(function()
    AutoClickEnabled = not AutoClickEnabled
    AutoClickButton.Text = AutoClickEnabled and "Auto Click: ON" or "Auto Click: OFF"
    
    if AutoClickEnabled then
        spawn(function()
            while AutoClickEnabled do
                wait(0.1) -- Intervalo entre os cliques, pode ajustar conforme necessário
                pcall(function()
                    -- Simula um clique na tela
                    local player = game.Players.LocalPlayer
                    if player.Character then
                        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart then
                            -- Simula o "clique" no personagem do jogador
                            humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 0, 1) -- Move o jogador ligeiramente (simulando clique)
                        end
                    end
                end)
            end
        end)
    end
end)

-- Restante do script continua aqui...-- Criar GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local ReopenButton = Instance.new("TextButton")
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

-- Botão de reexibir (quando minimizado)
ReopenButton.Size = UDim2.new(0, 100, 0, 50)
ReopenButton.Position = UDim2.new(0.5, -50, 0.5, -25)  -- Centralizado
ReopenButton.Text = "Reexibir"
ReopenButton.TextColor3 = Color3.new(1, 1, 1)
ReopenButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.2)
ReopenButton.Parent = ScreenGui
ReopenButton.Visible = false  -- Inicialmente invisível

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
    ReopenButton.Visible = IsMinimized  -- Mostra o botão de reexibir quando minimizado
end)

-- Função para reexibir a janela
ReopenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ReopenButton.Visible = false  -- Esconde o botão de reexibir
    IsMinimized = false  -- Estado não minimizado
end)

-- Função para ativar/desativar Auto Farm
AutoFarmButton.MouseButton1Click:Connect(function()
    autofarmEnabled = not autofarmEnabled
    AutoFarmButton.Text = autofarmEnabled and "Auto Farm: ON" or "Auto Farm: OFF"
    if autofarmEnabled then
        spawn(function()
            while autofarmEnabled do
                wait(0.1)
                pcall(function()
                    -- Simula um clique na tela para farmar
                    local player = game.Players.LocalPlayer
                    if player.Character then
                        -- Ativar ferramenta (simula o clique)
                        local tool = player.Character:FindFirstChildOfClass("Tool")
                        if tool then
                            tool:Activate()  -- Simula o clique para farmar força
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
                wait(1)
                pcall(function()
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                            local humanoid = player.Character.Humanoid
                            local distance = (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                            if distance < 20 then
                                humanoid:TakeDamage(10)
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
                wait(5)
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
