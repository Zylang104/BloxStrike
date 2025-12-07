 local Lighting = game:GetService("Lighting")

for _, obj in pairs(Lighting:GetChildren()) do
    obj:Destroy()
end

Lighting.Brightness = 5
Lighting.GlobalShadows = false
Lighting.FogEnd = 100000
Lighting.FogStart = 0
Lighting.ClockTime = 12
Lighting.GeographicLatitude = 0
Lighting.Changed:Connect(function(prop)
    if prop == "Brightness" or prop == "GlobalShadows" or prop == "FogEnd" or prop == "FogStart" then
        task.wait()
        Lighting.Brightness = 10
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 100000
        Lighting.FogStart = 0
    end
end)

print("Fullbright loaded") 
