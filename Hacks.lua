getgenv().autoTap = true;
getgenv().autoRebirth = true;
getgenv().buyEgg = true;
getgenv().thisvalue = "my name";


local remotePath = game:GetService("ReplicatedStorage").Aero.AeroRemoteServices;

function doTap()
    spawn(function()
        while autoTap == true do
            local args = {[1] = 1}
            remotePath.ClickService.Click:FireServer(unpack(args))
            wait()
        end
    end)
end

function autoRebirth(rebirthAmount)
    spawn(function()
        while autoRebirth == true do
            local args = {[1] = rebirthAmount}
            remotePath.RebirthService.BuyRebirths:FireServer(unpack(args))
            wait()
        end
    end)
end

function buyEgg(eggType, eggLimit)
    spawn(function()
        local iteration = 0;
        while wait() do
            if not buyEgg or iteration == eggLimit then break end;
            remotePath.EggService.Purchase:FireServer(eggType)
            iteration = iteration +1
        end
    end)
end


function getCurrentPlayerPOS()
    local plyr = game.Players.LocalPlayer;
    if plyr.Character then
        return plyr.Character.HumanoidRootPart.Position;
        end
        return false;
end

function teleportTO(placeCFrame)
    local plyr = game.Players.LocalPlayer;
    if plyr.Character then
        plyr.Character.HumanoidRootPart.CFrame = placeCFrame;
    end
end


function teleportWorld(world)
    if game:GetService("Workspace").Worlds:FindFirstChild(world) then
        teleportTO(game:GetService("Workspace").Worlds[world].Teleport.CFrame)
    end
end

teleportWorld("Desert") -- Change Desert to whatever world you want to go into





game.Players.LocalPlayer.Character.Head.NameTag.Frame.Visible = false; -- Safety ban check (Hides Name)
