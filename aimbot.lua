local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- settings
local Settings = {
    FOV = 50,
    Smoothness = 4,
    TargetPart = "Head",
    WallCheck = true,
    HoldKey = Enum.KeyCode.LeftAlt -- i unfortunatly didn't put an option there for toggle so you gotta live whit it
}

-- team check (i use it for all scripts basically)
local function IsEnemy(plr)
    if plr == LocalPlayer then return false end
    local myChar = LocalPlayer.Character
    local theirChar = plr.Character
    if not myChar or not theirChar then return false end
    return myChar.Parent.Name ~= theirChar.Parent.Name
end

-- wallcheck
local function IsVisible(part)
    if not Settings.WallCheck then return true end
    local origin = Camera.CFrame.Position
    local direction = (part.Position - origin).Unit * 1000
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = {LocalPlayer.Character}
    local result = workspace:Raycast(origin, direction, params)
    if result then
        return result.Instance:IsDescendantOf(part.Parent)
    end
    return true
end

-- center of the screen
local ScreenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

-- fov circle
local Circle = Drawing.new("Circle") -- on velocity this will suck a lot for some reason
Circle.Radius = Settings.FOV
Circle.Thickness = 1.6
Circle.Color = Color3.fromRGB(255, 255, 255)
Circle.Filled = false
Circle.Transparency = 0.7
Circle.Visible = true

-- loop
RunService.RenderStepped:Connect(function()
    Circle.Position = ScreenCenter

    if not UserInputService:IsKeyDown(Settings.HoldKey) then return end

    local bestTarget = nil
    local bestDist = Settings.FOV

    for _, plr in Players:GetPlayers() do
        if plr == LocalPlayer or not plr.Character then continue end
        if not IsEnemy(plr) then continue end

        local hum = plr.Character:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end

        local part = plr.Character:FindFirstChild(Settings.TargetPart)
        if not part then continue end
        if not IsVisible(part) then continue end
        local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
        if not onScreen then continue end

        local dist = (Vector2.new(screenPos.X, screenPos.Y) - ScreenCenter).Magnitude
        if dist < bestDist then
            bestTarget = Vector2.new(screenPos.X, screenPos.Y)
            bestDist = dist
        end
    end

    if bestTarget then
        local deltaX = (bestTarget.X - ScreenCenter.X) / Settings.Smoothness
        local deltaY = (bestTarget.Y - ScreenCenter.Y) / Settings.Smoothness
        mousemoverel(deltaX, deltaY)
    end
end)

print("loaded")
