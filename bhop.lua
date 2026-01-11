local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Settings = {
    Enabled = true,
    Key = Enum.KeyCode.Space
}

local MainLoop = RunService.RenderStepped:Connect(function()
    if not Settings.Enabled then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    
    -- Check if space is held
    if UserInputService:IsKeyDown(Settings.Key) then
        -- Check if on ground
        if hum.FloorMaterial ~= Enum.Material.Air then
            hum.Jump = true
        end
    end
end)

local function Unload()
    MainLoop:Disconnect()
    print("autobhop Unloaded")
end

getgenv().AutoBhop = {
    Settings = Settings,
    Unload = Unload
}

print("loaded")
