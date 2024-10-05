local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "QFB|Legends of speed", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest", IntroText = "QFB Team"})
local Tab = Window:MakeTab({
	Name = "Testing-Zone",
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

