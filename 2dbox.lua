local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Boxes = {}

local function IsEnemy(plr)
    if plr == LocalPlayer then return false end
    local myChar = LocalPlayer.Character
    local theirChar = plr.Character
    if not myChar or not theirChar then return false end
    return myChar.Parent.Name ~= theirChar.Parent.Name
end

local function CreateBox(plr)
    if Boxes[plr] then return end
    local box = Drawing.new("Square")
    box.Thickness = 1.6
    box.Filled = false
    box.Color = Color3.fromRGB(255, 0, 0)
    box.Transparency = 1
    box.Visible = false
    Boxes[plr] = box
end

local function RemoveBox(plr)
    if Boxes[plr] then
        Boxes[plr]:Remove()
        Boxes[plr] = nil
    end
end

RunService.RenderStepped:Connect(function()
    for plr, box in pairs(Boxes) do
        local char = plr.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Head") then
            box.Visible = false
            continue
        end

        if not IsEnemy(plr) then
            box.Visible = false
            continue
        end

        local hrp = char.HumanoidRootPart
        local head = char.Head

        local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.6, 0))
        local rootPos = Camera:WorldToViewportPoint(hrp.Position)
        local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3.5, 0))

        if rootPos.Z < 0 then
            box.Visible = false
            continue
        end

        local height = math.abs(headPos.Y - legPos.Y)
        local width = height * 0.55

        box.Size = Vector2.new(width, height)
        box.Position = Vector2.new(rootPos.X - width/2, rootPos.Y - height/2)
        box.Visible = true
    end
end)

Players.PlayerAdded:Connect(CreateBox)
Players.PlayerRemoving:Connect(RemoveBox)

for _, plr in Players:GetPlayers() do
    if plr ~= LocalPlayer then
        CreateBox(plr)
    end
end

print("loaded")
