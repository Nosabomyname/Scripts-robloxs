-- GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local ReexibirButton = Instance.new("Frame")

-- Variáveis de controle
local isMinimized = false
local Dragging = false
local DragInput, StartPosition, DragStart

-- Adicionar GUI ao Player
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Configuração da janela principal
MainFrame.Size = UDim2.new(0, 600, 0, 400) -- Maior largura e comprimento
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

-- Configuração do título
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "Menu Principal"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Title.TextScaled = true
Title.Parent = MainFrame

-- Botão de minimizar
MinimizeButton.Size = UDim2.new(0, 100, 0, 40)
MinimizeButton.Position = UDim2.new(1, -110, 0, 5)
MinimizeButton.Text = "Minimizar"
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
MinimizeButton.Parent = MainFrame

-- Botão de reexibir
ReexibirButton.Size = UDim2.new(0, 50, 0, 50) -- Quadrado
ReexibirButton.Position = UDim2.new(0.5, -25, 0.9, -25) -- Inicialmente centralizado na parte inferior
ReexibirButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.8)
ReexibirButton.Visible = false
ReexibirButton.Parent = ScreenGui

-- Minimizar funcionalidade
MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    ReexibirButton.Visible = true
end)

-- Reexibir funcionalidade
ReexibirButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ReexibirButton.Visible = false
end)

-- Tornar o botão de reexibir arrastável
ReexibirButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = input.Position
        StartPosition = ReexibirButton.Position
    end
end)

ReexibirButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        DragInput = input
    end
end)

ReexibirButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == DragInput and Dragging then
        local Delta = input.Position - DragStart
        ReexibirButton.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
end)
AutoSpeedButton.MouseButton1Click:Connect(function()
    autoSpeedEnabled = not autoSpeedEnabled
    AutoSpeedButton.Text = autoSpeedEnabled and "Auto Farm: Velocidade (ON)" or "Auto Farm: Velocidade (OFF)"
    if autoSpeedEnabled then
        spawn(function()
            while autoSpeedEnabled do
                wait(0.1)
                pcall(function()
                    local player = game.Players.LocalPlayer
                    local char = player.Character
                    if char then
                        local treadmill = workspace:FindFirstChild("Treadmill") or workspace:FindFirstChild("Esteira")
                        if treadmill then
                            char.Humanoid:MoveTo(treadmill.Position)
                        end
                    end
                end)
            end
        end)
    end
end)
AutoStrengthButton.MouseButton1Click:Connect(function()
    autoStrengthEnabled = not autoStrengthEnabled
    AutoStrengthButton.Text = autoStrengthEnabled and "Auto Farm: Força (ON)" or "Auto Farm: Força (OFF)"
    if autoStrengthEnabled then
        spawn(function()
            while autoStrengthEnabled do
                wait(0.1)
                pcall(function()
                    local player = game.Players.LocalPlayer
                    local char = player.Character
                    if char then
                        local tool = char:FindFirstChildOfClass("Tool")
                        if tool then
                            tool:Activate() -- Auto Click
                        end
                    end
                end)
            end
        end)
    end
end)
PVPButton.MouseButton1Click:Connect(function()
    pvpEnabled = not pvpEnabled
    PVPButton.Text = pvpEnabled and "PVP (ON)" or "PVP (OFF)"
    if pvpEnabled then
        spawn(function()
            while pvpEnabled do
                wait(0.1)
                pcall(function()
                    local player = game.Players.LocalPlayer
                    local char = player.Character
                    if char then
                        local enemy = nil
                        local closestDistance = 30 -- Limite de 30 metros
                        for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                            if otherPlayer ~= player then
                                local otherChar = otherPlayer.Character
                                if otherChar and otherChar:FindFirstChild("HumanoidRootPart") then
                                    local distance = (char.HumanoidRootPart.Position - otherChar.HumanoidRootPart.Position).Magnitude
                                    if distance < closestDistance then
                                        closestDistance = distance
                                        enemy = otherChar
                                    end
                                end
                            end
                        end
                        if enemy then
                            char.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2) -- Teleportar perto
                            spawn(function()
                                while pvpEnabled and enemy and enemy:FindFirstChild("Humanoid") do
                                    wait(0.05)
                                    local tool = char:FindFirstChildOfClass("Tool")
                                    if tool then
                                        tool:Activate() -- Auto Click para atacar
                                    end
                                end
                            end)
                        end
                    end
                end)
            end
        end)
    end
end)
