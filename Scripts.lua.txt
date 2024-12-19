-- Variáveis do jogador e do personagem
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local autoFarmEnabled = false -- Variável para controlar se o auto farm está ativo ou não

-- Criar a interface gráfica (GUI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Criar o painel de controle
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100) -- Tamanho do painel
frame.Position = UDim2.new(0.5, -100, 0.5, -50) -- Posição do painel
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.Parent = ScreenGui

-- Criar o botão de Ativar
local activateButton = Instance.new("TextButton")
activateButton.Size = UDim2.new(0, 180, 0, 40)
activateButton.Position = UDim2.new(0, 10, 0, 10)
activateButton.Text = "Ativar Auto Farm"
activateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
activateButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
activateButton.Parent = frame

-- Criar o botão de Desativar
local deactivateButton = Instance.new("TextButton")
deactivateButton.Size = UDim2.new(0, 180, 0, 40)
deactivateButton.Position = UDim2.new(0, 10, 0, 50)
deactivateButton.Text = "Desativar Auto Farm"
deactivateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
deactivateButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
deactivateButton.Parent = frame

-- Função para ativar o Auto Farm
local function StartAutoFarm()
    while autoFarmEnabled do
        -- Encontrar o objeto farmável (troque "FarmableObject" pelo nome do objeto no jogo)
        local farmObject = workspace:FindFirstChild("FarmableObject")
        if farmObject then
            -- Move o personagem até o objeto farmável
            character:MoveTo(farmObject.Position)
            -- Espera até o personagem chegar
            wait(1)
            -- Interage com o objeto (se necessário)
            farmObject.Touched:Connect(function(hit)
                if hit.Parent == character then
                    -- Simula a coleta (isso pode ser qualquer ação que o jogo faça ao interagir com o objeto)
                    print("Coletando item!")
                end
            end)
            wait(5)  -- Intervalo para repetir
        else
            print("Objeto não encontrado para farm.")
        end
        wait(2)  -- Intervalo entre tentativas
    end
end

-- Função para ativar o Auto Farm ao clicar no botão
activateButton.MouseButton1Click:Connect(function()
    autoFarmEnabled = true
    StartAutoFarm()  -- Inicia o Auto Farm
end)

-- Função para desativar o Auto Farm ao clicar no botão
deactivateButton.MouseButton1Click:Connect(function()
    autoFarmEnabled = false
    print("Auto Farm desativado.")
end)
