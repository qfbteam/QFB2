local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "QFB|Legends of speed", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest", IntroText = "QFB Team"})
local Tab = Window:MakeTab({
	Name = "Farm",
	Icon = "",
	PremiumOnly = false
})

local running = false -- Variável para controlar o estado do loop

-- Adiciona o toggle
Tab:AddToggle({
    Name = "Farm Gem",
    Default = false,
    Callback = function(Value)
        running = Value -- Atualiza a variável com o estado do toggle

        -- Se o toggle for ativado
        if running then
            while running do
                local args = {
                    [1] = "collectOrb",
                    [2] = "Gem",
                    [3] = "City"
                }

                game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                wait(0.001) -- Espera 0.001 segundos
            end
        end
    end    
})

local running = false -- Variável para controlar o estado do loop

-- Adiciona o toggle
Tab:AddToggle({
    Name = "Farm Speed",
    Default = false,
    Callback = function(Value)
        running = Value -- Atualiza a variável com o estado do toggle

        -- Se o toggle for ativado
        if running then
            local orbs = {"Red Orb", "Orange Orb", "Blue Orb", "Yellow Orb"} -- Lista dos tipos de orb
            while running do
                for _, orb in ipairs(orbs) do
                    local args = {
                        [1] = "collectOrb",
                        [2] = orb,
                        [3] = "City"
                    }

                    game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                    wait(0.001) -- Espera 0.001 segundos antes de coletar o próximo orb
                end
            end
        end
    end    
})

local isRunning = false -- Variável para controlar o loop

Tab:AddToggle({
    Name = "Rebhirt",
    Default = false,
    Callback = function(Value)
        print(Value)
        isRunning = Value -- Atualiza a variável com o estado do toggle

        if Value then
            -- Começa a rodar quando o toggle é ativado
            while isRunning do
                local args = {
                    [1] = "rebirthRequest"
                }
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer(unpack(args))
                
                wait(1) -- Espera 1 segundo antes de repetir (ajuste conforme necessário)
            end
        end
    end    
})

-- Para garantir que o loop seja encerrado quando o toggle for desativado
while true do
    wait(0.1) -- Aguarda um pouco para não sobrecarregar o desempenho
    if not isRunning then
        break -- Sai do loop se o toggle estiver desativado
    end
end

local Tab = Window:MakeTab({
	Name = "Hoops",
	Icon = "",
	PremiumOnly = false
})

-- Supondo que você tenha o objeto 'Player' e 'Hoops' no seu jogo
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local hoopsFolder = workspace:WaitForChild("Hoops") -- A pasta que contém os objetos

local isTeleporting = false
local itemIndex = 1

-- Função para teleportar o humanoide para a pasta "Hoops" e teleportar os itens
local function teleportToHoops()
	while isTeleporting do
		-- Teleporta o humanoide para a posição do primeiro item na pasta "Hoops"
		local items = hoopsFolder:GetChildren()
		if #items > 0 then
			local item = items[itemIndex]
			if item:IsA("Model") and item.PrimaryPart then
				humanoidRootPart.CFrame = item.PrimaryPart.CFrame -- Teleporta o humanoide para o item

				-- Teleporta o item para o humanoide
				item:SetPrimaryPartCFrame(humanoidRootPart.CFrame)

				-- Atualiza o índice do item a ser teleportado
				itemIndex = (itemIndex % #items) + 1 -- Move para o próximo item, volta ao primeiro se chegar ao fim
			end
		end
		wait(1) -- Aguarda um segundo antes de teleportar o próximo item
	end
end

-- Configura o toggle
Tab:AddToggle({
	Name = "Teleport Hoops",
	Default = false,
	Callback = function(Value)
		isTeleporting = Value
		itemIndex = 1 -- Reinicia o índice dos itens ao ativar
		if Value then
			teleportToHoops() -- Inicia o loop de teleportação
		end
	end
})

local Tab = Window:MakeTab({
	Name = "Teleport",
	Icon = "",
	PremiumOnly = false
})


local TeleportCoordinates = {
    Omega = Vector3.new(4529.80, 74.32, 6404.12),
    ["Comming Soon"] = Vector3.new(5000, 100, 7000) -- Adicione as coordenadas que você deseja para essa opção
}

Tab:AddDropdown({
    Name = "Dropdown",
    Default = "Omega",
    Options = {"Omega", "Comming Soon"},
    Callback = function(Value)
        selectedOption = Value -- Armazena a opção selecionada
    end    
})

Tab:AddButton({
    Name = "Tp",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart") -- Espera até que o HumanoidRootPart esteja disponível

        -- Teleporta o jogador para as coordenadas da opção selecionada
        if TeleportCoordinates[selectedOption] then
            humanoidRootPart.Position = TeleportCoordinates[selectedOption]
            print(selectedOption .. " teleportado para: " .. tostring(TeleportCoordinates[selectedOption]))
        else
            print("Opção inválida.")
        end
    end    
})
