-- Criar GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Janela principal
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 250, 0, 300)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 2

-- Variável de visibilidade da janela
local isWindowVisible = true

-- Botão para minimizar/reexibir
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.5, -25, 0, -200)
toggleButton.Text = "+"
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
toggleButton.Visible = false -- Inicialmente invisível

local minimizeButton = Instance.new("TextButton")
minimizeButton.Parent = mainFrame
minimizeButton.Size = UDim2.new(0, 50, 0, 30)
minimizeButton.Position = UDim2.new(1, -60, 0, 10)
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

-- Funções para minimizar/reexibir
minimizeButton.MouseButton1Click:Connect(function()
    isWindowVisible = false
    mainFrame.Visible = false
    toggleButton.Visible = true
end)

toggleButton.MouseButton1Click:Connect(function()
    isWindowVisible = true
    mainFrame.Visible = true
    toggleButton.Visible = false
end)

-- Variável de controle do Auto Farm
local autoFarmActive = false

-- Função de Auto Farm
local function toggleAutoFarm()
    autoFarmActive = not autoFarmActive
    if autoFarmActive then
        print("Auto Farm ativado")
        spawn(function()
            while autoFarmActive do
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local humanoid = character:WaitForChild("Humanoid")
                local farmPosition = Vector3.new(0, 0, 0) -- Ajuste a posição para o local de treino

                humanoid:MoveTo(farmPosition)
                wait(1)
                print("Farmando...")
            end
        end)
    else
        print("Auto Farm desativado")
    end
end

-- Botão para ativar/desativar Auto Farm
local autoFarmButton = Instance.new("TextButton")
autoFarmButton.Parent = mainFrame
autoFarmButton.Size = UDim2.new(0, 200, 0, 40)
autoFarmButton.Position = UDim2.new(0, 25, 0, 50)
autoFarmButton.Text = "Ativar Auto Farm"
autoFarmButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)

autoFarmButton.MouseButton1Click:Connect(function()
    toggleAutoFarm()
    autoFarmButton.Text = autoFarmActive and "Desativar Auto Farm" or "Ativar Auto Farm"
end)

-- Variável de controle do PVP
local pvpActive = false

-- Função para detectar jogadores vivos
local function getAlivePlayers()
    local players = game.Players:GetPlayers()
    local alivePlayers = {}

    for _, player in ipairs(players) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
            local targetHumanoid = player.Character:FindFirstChild("Humanoid")
            if targetHumanoid and targetHumanoid.Health > 0 then
                table.insert(alivePlayers, player)
            end
        end
    end
    return alivePlayers
end

-- Função para atacar jogadores
local function attackPlayer(targetPlayer)
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")

    local targetCharacter = targetPlayer.Character
    if targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart") then
        local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")

        -- Teleportar e atacar
        rootPart.CFrame = targetRootPart.CFrame
        wait(0.1)

        while targetCharacter:FindFirstChild("Humanoid") and targetCharacter.Humanoid.Health > 0 do
            targetCharacter.Humanoid:TakeDamage(50)
            wait(0.1)
        end
    end
end

-- Função de PVP automático
local function togglePVP()
    pvpActive = not pvpActive
    if pvpActive then
        print("PVP ativado")
        spawn(function()
            while pvpActive do
                local alivePlayers = getAlivePlayers()
                for _, targetPlayer in ipairs(alivePlayers) do
                    if pvpActive then
                        attackPlayer(targetPlayer)
                    end
                end
                wait(1)
            end
        end)
    else
        print("PVP desativado")
    end
end

-- Botão para ativar/desativar PVP
local pvpButton = Instance.new("TextButton")
pvpButton.Parent = mainFrame
pvpButton.Size = UDim2.new(0, 200, 0, 40)
pvpButton.Position = UDim2.new(0, 25, 0, 100)
pvpButton.Text = "Ativar PVP"
pvpButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

pvpButton.MouseButton1Click:Connect(function()
    togglePVP()
    pvpButton.Text = pvpActive and "Desativar PVP" or "Ativar PVP"
end)
