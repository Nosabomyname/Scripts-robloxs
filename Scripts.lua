local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Criar a tela da GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- Criar o painel da janela
local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.Size = UDim2.new(
frame.Parent = screenGui
frame
0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 2

-- Criar o botão de minimizar
local minimizeButton = Instance.new("TextButton")
minimizeButton.Parent = frame
minimizeButton.Size = UDim2.new(0, 100, 0, 30)
minimizeButton.Position = UDim2.new(0, 10, 0, 10)
minimizeButton.Text = 
minimize
"Minimizar"
minimizeButton.BackgroundColor3 = Color3.fromRGB(
minim
100, 100, 100)
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Criar o botão de reexibir

l
local reDisplayButton = Instance.new("TextButton")
reDisplayButton.Parent = screenGui
reDisplayButton.Size = UDim2.new(
reDisplayButton.Parent = screenGui
reDi

reDisplay
0, 100, 0, 30)
reDisplayButton.Position = UDim2.new(
reDisplayButton.Pos
0.5, -50, 0, 10)
reDisplayButton.Text = "Reexibir"
reDisplayButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
reDisplayButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Criar o botão de farm

loc
local farmButton = Instance.new("TextButton")
farmButton.Parent = frame
farmButton.Size = UDim2.new(
farmButton.Parent
0, 100, 0, 30)
farmButton.Position = UDim2.new(0, 10, 0, 50)
farmButton.Text = 
far
"Iniciar Farm"
farmButton.BackgroundColor3 = Color3.fromRGB(
farmButton.BackgroundColor3 = Col
0, 255, 0)
farmButton.TextColor3 = Color3.fromRGB(
farmButton.Te
0, 0, 0)

-- Variável para controlar o estado do auto click
local autoClickEnabled = false
local clickDelay = 0.1 -- Intervalo entre os cliques

-- Função de auto-click para Android
local function autoClick()
    while autoClickEnabled do
        -- Obtém a posição do toque na tela
        local touch = player:GetMouse().Hit.Position
        local screenPos = workspace.CurrentCamera:WorldToScreenPoint(touch)
        
        -- Simula um clique na posição da tela (touch)
        game:GetService("UserInputService"):InputBegin(Enum.UserInputType.Touch, screenPos)
        wait(clickDelay)
        game:GetService("UserInputService"):InputEnd(Enum.UserInputType.Touch, screenPos)
    end
end

-- Funcionalidade do botão de minimizar
minimizeButton.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

-- Funcionalidade do botão de reexibir
reDisplayButton.MouseButton1Click:Connect(function()
    frame.Visible = true

en
end)

-- Funcionalidade do botão de farm
farmButton.MouseButton1Click:Connect(
fa
function()
    autoClickEnabled = not autoClickEnabled
    if autoClickEnabled then
        farmButton.Text = "Parar Farm"
        autoClick()  -- Inicia o clique automático
    else
        farmButton.Text = "Iniciar Farm"
    end
end)
