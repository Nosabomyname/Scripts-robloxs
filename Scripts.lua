-- Criar GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local AutoFarmButton = Instance.new("TextButton")
local AutoClickButton = Instance.new("TextButton")
local AntiBanButton = Instance.new("TextButton")
local IsMinimized = false

-- Variáveis de controle
local autoFarmEnabled = false
local autoClickEnabled = false
local antiBanEnabled = false

-- Adicionar ao jogador
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Configuração do MainFrame
MainFrame.Size = UDim2.new(0, 300, 0, 450)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
MainFrame.Parent = ScreenGui
MainFrame.Visible = true

-- Configuração do título
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Title.Text = "Menu de Script"
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

-- Botão Auto Farm
AutoFarmButton.Size = UDim2.new(1, 0, 0, 50)
AutoFarmButton.Position = UDim2.new(0, 0, 0, 60)
AutoFarmButton.Text = "Auto Farm: OFF"
AutoFarmButton.TextColor3 = Color3.new(1, 1, 1)
AutoFarmButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.2)
AutoFarmButton.Parent = MainFrame

-- Botão Auto Click
AutoClickButton.Size = UDim2.new(1, 0, 0, 50)
AutoClickButton.Position = UDim2.new(0, 0, 0, 120)
AutoClickButton.Text = "Auto Click: OFF"
AutoClickButton.TextColor3 = Color3.new(1, 1, 1)
AutoClickButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.2)
AutoClickButton.Parent = MainFrame

-- Botão Anti Ban
AntiBanButton.Size = UDim2.new(1, 0, 0, 50)
AntiBanButton.Position = UDim2.new(0, 0, 0, 180)
AntiBanButton.Text = "Anti Ban: OFF"
AntiBanButton.TextColor3 = Color3.new(1, 1, 1)
AntiBanButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.2)
AntiBanButton.Parent = MainFrame

-- Função para minimizar/maximizar
MinimizeButton.MouseButton1Click:Connect(function()
    IsMinimized = not IsMinimized
    MainFrame.Visible = not IsMinimized
end)

-- Função para ativar/desativar Auto Farm
AutoFarmButton.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    AutoFarmButton.Text = autoFarmEnabled and "Auto Farm: ON" or "Auto Farm: OFF"
    if autoFarmEnabled then
        spawn(function()
            while autoFarmEnabled do
                wait(0.1)
                pcall(function()
                    local player = game.Players.LocalPlayer
                    if player.Character then
                        local tool = player.Character:FindFirstChildOfClass("Tool")
                        if tool then
                            tool:Activate()  -- Simula o clique para farmar
                        end
                    end
                end)
            end
        end)
    end
end)

-- Função para ativar/desativar Auto Click
AutoClickButton.MouseButton1Click:Connect(function()
    autoClickEnabled = not autoClickEnabled
    AutoClickButton.Text = autoClickEnabled and "Auto Click: ON" or "Auto Click: OFF"
    if autoClickEnabled then
        spawn(function()
            while autoClickEnabled do
                wait(0.1) -- Intervalo de clique
                pcall(function()
                    local player = game.Players.LocalPlayer
                    local mouse = player:GetMouse()
                    local position = mouse.Hit.p
                    mouse1click(position)
                end)
            end
        end)
    end
end)

-- Função para simular clique do mouse
function mouse1click(position)
    local userInputService = game:GetService("UserInputService")
    local input = Instance.new("InputObject")
    input.UserInputType = Enum.UserInputType.MouseButton1
    input.Position = position
    userInputService.InputBegan:Fire(input)
end

-- Função Anti-Ban
AntiBanButton.MouseButton1Click:Connect(function()
    antiBanEnabled = not antiBanEnabled
    AntiBanButton.Text = antiBanEnabled and "Anti Ban: ON" or "Anti Ban: OFF"
    if antiBanEnabled then
        spawn(function()
            while antiBanEnabled do
                wait(5)  -- Evita detecção de automação
                pcall(function()
                    -- Evita detecção automática
                    local player = game.Players.LocalPlayer
                    if player.Character then
                        -- Exemplo de ação para reduzir o risco de banimento
                        player.Character:MoveTo(Vector3.new(math.random(-100, 100), 50, math.random(-100, 100)))  -- Faz o personagem mover-se aleatoriamente
                    end
                end)
            end
        end)
    end
end)

-- Função para dar controle à janela
local function centerWindow()
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -225)
end

centerWindow()  -- Inicializa a janela centralizada
