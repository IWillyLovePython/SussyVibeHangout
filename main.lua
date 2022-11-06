--Dreamer#5114 / cereb#2188
--robloxscriptsforum: vroom1234567890
--use this script to troll oders lol

local detain = game.ReplicatedStorage.DetainEvent

function gig()
    game:GetService("StarterGui"):SetCore("SendNotification", {
    	Title = "Credits",
    	Text = "r: lvg1e\ndsc: Dreamer#5114/cereb#2188\nrsf: vroom1234567890"
    })
end

function commands()
    game:GetService("StarterGui"):SetCore("SendNotification", {
    	Title = ":Commands",
    	Text = "Execute via Chat\n:cmds, :get\n:kick, :bring, :release\n:music"
    })
end

function get()
    if not game.Players.LocalPlayer.Backpack:FindFirstChild("Detain") and not game.Players.LocalPlayer.Character:FindFirstChild("Detain") then
        oldCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-414, 274, -1109)
        wait(1)
        for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("Part") or v:IsA("MeshPart") then
                if game:GetService("Players").LocalPlayer:DistanceFromCharacter(v.Position) <= 15 and v:FindFirstChild("ProximityPrompt") then
                    fireproximityprompt(v.ProximityPrompt)
                end
            end
        end
        game.Players.LocalPlayer.Backpack:WaitForChild("Detain")
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldCFrame
    end
end
function release()
    detain:FireServer("undetain")
end


function bring(player)
    if player ~= "all" and not game.Players:FindFirstChild(player) then
        for _, v in pairs(game.Players:GetChildren()) do
            if string.find(string.lower(v.Name), string.lower(player)) or string.find(string.lower(v.DisplayName), string.lower(player)) then
                player = tostring(v)
            end
        end
    end

    if player == "all" then
        for i,v in pairs(game.Players:GetChildren()) do
            if v ~= game.Players.LocalPlayer then
                pcall(function()
                    repeat wait() until game.Workspace[tostring(v)]:FindFirstChild("Head")
                    detain:FireServer("detain", game:GetService("Workspace")[tostring(v)].Head)
                    wait()
                end)
            end
        end
    else
        detain:FireServer("detain", game:GetService("Workspace")[player].Head)
    end
end


function kick(player)
    oldCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    wait()
    bring(player)
    wait(1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(105, 265, -817)
    wait(1)
    detain:FireServer("undetain")
    wait(1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldCFrame
end
function music(id)
    game:GetService("ReplicatedStorage").MusicEvents.RequestSong:FireServer(id)
end
   
function messageCmd(msg)
    local splitted = string.split(msg, " ")
    if table.find({":cmds", ":release", ":kick", ":bring", ":get", ":music"}, splitted[1]) then
        if splitted[1] == ":get" then
            get()
        elseif splitted[1] == ":release" then
            release()
        elseif splitted[1] == ":bring" then
            bring(splitted[2])
        elseif splitted[1] == ":kick" then
            kick(splitted[2])
        elseif splitted[1] == ":music" then
            music(tonumber(splitted[2]))
        elseif splitted[1] == ":cmds" then
            commands()
        end
    end
end

game.Players.LocalPlayer.Chatted:Connect(function(msg)
    messageCmd(msg)
end)

gig()
