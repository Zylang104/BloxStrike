 while true do
    if workspace:FindFirstChild("Debris") then
        for _, folder in workspace.Debris:GetChildren() do
            if folder.Name:match("Voxel") then
                folder:ClearAllChildren()
                folder:Destroy()
            end
        end
    end
    wait(0.5)
end 
