 while true do
    local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("FlashbangEffect")
    if gui then
        gui:Destroy()
    end
    local effect = game.Lighting:FindFirstChild("FlashbangColorCorrection")
    if effect then
        effect:Destroy()
    end
    wait(0.2)
end 
