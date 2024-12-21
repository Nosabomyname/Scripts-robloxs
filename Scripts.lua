-- Criar a interface
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local MinimizeButton = Instance.new("TextButton")
local ReappearButton = Instance.new("TextButton")
local TabContainer = Instance.new("Frame")
local Tab1 = Instance.new("TextButton")
local Tab2 = Instance.new("TextButton")
local Tab3 = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")

local AutoFarmForceButton = Instance.new("TextButton")
local AutoFarmSpeedButton = Instance.new("TextButton")
local PvPButton = Instance.new("TextButton")

local autoFarmForceActive = false
local autoFarmSpeedActive = false
local autoPvPActive = false

-- Configuração da interface
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)

-- Botão para minimizar
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = MainFrame
MinimizeButton.Text = "-"
MinimizeButton.Size = UDim2.new(0, 50, 0, 30)
MinimizeButton.Position = UDim2.new(1, -60, 0, 10)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

-- Botão para reexibir
ReappearButton.Name = "ReappearButton"
ReappearButton.Parent = ScreenGui
ReappearButton.Text = "Delta"
ReappearButton.Size = UDim2.new(0, 50, 0, 50)
ReappearButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ReappearButton.Visible = false

-- Container das abas
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.Size = UDim2.new(0, 400, 0, 50)
TabContainer.Position = UDim2.new(0, 0, 0, 30)
TabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

Tab1.Name = "Tab1"
Tab1.Parent = TabContainer
Tab1.Text = "Auto Farm Força"
Tab1.Size = UDim2.new(0, 130, 0, 50)
Tab1.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

Tab2.Name = "Tab2"
Tab2.Parent = TabContainer
Tab2.Text = "Auto Farm Velocidade"
Tab2.Size = UDim2.new(0, 130, 0, 50)
Tab2.Position = UDim2.new(0.33, 0, 0, 0)
Tab2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

Tab3.Name = "Tab3"
Tab3.Parent = TabContainer
Tab3.Text = "PvP"
Tab3.Size = UDim2.new(0, 130, 0, 50)
Tab3.Position = UDim2.new(0.66, 0, 0, 0)
Tab3.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.Size = UDim2.new(1, 0, 0.7, 0)
ContentFrame.Position = UDim2.new(0, 0, 0.25, 0)
ContentFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

AutoFarmForceButton.Name = "AutoFarmForceButton"
AutoFarmForceButton.Parent = ContentFrame
AutoFarmForceButton.Text = "Ativar Auto Farm Força"
AutoFarmForceButton.Size = UDim2.new(0, 200, 0, 50)
AutoFarmForceButton.Position = UDim2.new(0.5, -100, 0.1, 0)
AutoFarmForceButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)

AutoFarmSpeedButton.Name = "AutoFarmSpeedButton"
AutoFarmSpeedButton.Parent = ContentFrame
AutoFarmSpeedButton.Text = "Ativar Auto Farm Velocidade"
AutoFarmSpeedButton.Size = UDim2.new(0, 200, 0, 50)
AutoFarmSpeedButton.Position = UDim2.new(0.5, -100, 0.4, 0)
AutoFarmSpeedButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)

PvPButton.Name = "PvPButton"
PvPButton.Parent = ContentFrame
PvPButton.Text = "Ativar PvP"
PvPButton.Size = UDim2.new(0, 200, 0, 50)
PvPButton.Position = UDim2.new(0.5, -100, 0.7, 0)
PvPButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)

-- Funções para mover a janela
local dragging = false
local dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Funções de Minimizar e Reexibir
MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    ReappearButton.Visible = true
end)

ReappearButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ReappearButton.Visible = false
end)

-- Funções de Auto Farm Força
AutoFarmForceButton.MouseButton1Click:Connect(function()
    autoFarmForceActive = not autoFarmForceActive
    if autoFarmForceActive then
        AutoFarmForceButton.Text = "Desativar Auto Farm Força"
        AutoFarmForceButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Verde (ativado)
        while autoFarmForceActive do
            wait(0.1)
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
            wait(0.1)
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
        end
    else
        AutoFarmForceButton.Text = "Ativar Auto Farm Força"
        AutoFarmForceButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Vermelho (desativado)
    end
end)

-- Funções de Auto Farm Velocidade
AutoFarmSpeedButton.MouseButton1Click:Connect(function()
    autoFarmSpeedActive = not autoFarmSpeedActive
    if autoFarmSpeedActive then
        AutoFarmSpeedButton.Text = "Desativar Auto Farm Velocidade"
        AutoFarmSpeedButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Verde (ativado)
        local treadmill = workspace:FindFirstChild("Treadmill") -- Nome da esteira
        if treadmill then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = treadmill.CFrame
            wait(0.5)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
        end
    else
        AutoFarmSpeedButton.Text = "Ativar Auto Farm Velocidade"
        AutoFarmSpeedButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Vermelho (desativado)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
    end
end)

-- Funções de PvP
PvPButton.MouseButton1Click:Connect(function()
    autoPvPActive = not autoPvPActive
    if autoPvPActive then
        PvPButton.Text = "Desativar PvP"
        PvPButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Verde (ativado)
        while autoPvPActive do
            wait(0.1)
            local nearestPlayer = nil
            local shortestDistance = 30 -- Distância máxima
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    local distance = (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance < shortestDistance then
                        nearestPlayer = player
                        shortestDistance = distance
                    end
                end
            end
            if nearestPlayer then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = nearestPlayer.Character.HumanoidRootPart.CFrame
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
                wait(0.1)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
            end
        end
    else
        PvPButton.Text = "Ativar PvP"
        PvPButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Vermelho (desativado)
    end
end)
