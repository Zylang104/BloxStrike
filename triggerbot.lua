local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local function IsEnemy(plr)
    if plr == LocalPlayer then return false end
    local myChar = LocalPlayer.Character
    local theirChar = plr.Character
    if not myChar or not theirChar then return false end
    return myChar.Parent.Name ~= theirChar.Parent.Name
end

local function EnemyUnderCrosshair()
    local rayOrigin = Camera.CFrame.Position
    local rayDirection = Camera.CFrame.LookVector * 500
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
    
    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    if raycastResult then
        local hitPart = raycastResult.Instance
        local hitChar = hitPart:FindFirstAncestorOfClass("Model")
        if hitChar and hitChar:FindFirstChild("Frog") and hitChar:FindFirstChild("HumanoidRootPart") then
            local hitPlayer = Players:GetPlayerFromCharacter(hitChar)
            if hitPlayer and IsEnemy(hitPlayer) then
                return true
            end
        end
    end
    return false
end

RunService.RenderStepped:Connect(function()
    if UserInputService:IsKeyDown(Enum.KeyCode.E) and EnemyUnderCrosshair() then
        if mouse1click then
            mouse1click()
        end
        task.wait(0.05) -- delay
    end
end)

print("loaded")
