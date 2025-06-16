-- ===============================================
-- ceeeeshytam INVINCIBILITY SCRIPT
-- Fitur: Full Godmode, Anti Death, No Damage
-- ===============================================
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Hapus jika sudah ada
if Character:FindFirstChild("GodmodeFF") then Character.GodmodeFF:Destroy() end

-- Fungsi utama
local function EnableGodmode()
    -- Force Field permanen
    local ff = Instance.new("ForceField")
    ff.Name = "GodmodeFF"
    ff.Parent = Character
    
    -- Proteksi health
    Humanoid.HealthChanged:Connect(function()
        if Humanoid.Health < Humanoid.MaxHealth then
            Humanoid.Health = Humanoid.MaxHealth
        end
    end)
    
    -- Proteksi kematian
    Humanoid.StateChanged:Connect(function(_, newState)
        if newState == Enum.HumanoidStateType.Dead then
            Humanoid:ChangeState(Enum.HumanoidStateType.Running)
        end
    end)
    
    -- Proteksi ragdoll
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
end

-- UI sederhana
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "InvincibilityGUI"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 60)
Frame.Position = UDim2.new(0.8, 0, 0.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Frame.Parent = ScreenGui

local Status = Instance.new("TextLabel")
Status.Text = "GODMODE: ACTIVATED"
Status.TextColor3 = Color3.new(0, 1, 0)
Status.Size = UDim2.new(1, 0, 1, 0)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.SourceSansBold
Status.TextSize = 18
Status.Parent = Frame

-- Auto reconnect jika karakter respawn
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    task.wait(1)
    EnableGodmode()
end)

-- Aktifkan
EnableGodmode()

-- Notifikasi
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "INVINCIBILITY ACTIVATED",
    Text = "You are now immune to all damage!",
    Duration = 5
})
