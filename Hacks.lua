getgenv().autoTap = false;
getgenv().autoRebirth = false;
getgenv().buyEgg = false;


local remotePath = game:GetService("ReplicatedStorage").Aero.AeroRemoteServices;


function doTap()
    spawn(function()
        while getgenv().autoTap == true do
            local args = {[1] = 1}
            remotePath.ClickService.Click:FireServer(unpack(args))
            wait()
        end
    end)
end

function autoRebirth(rebirthAmount)
    spawn(function()
        while getgenv().autoRebirth == true do
            remotePath.RebirthService.BuyRebirths:FireServer(rebirthAmount)
            wait()
        end
    end)
end

function buyEgg(eggType)
    spawn(function()
        while wait() do
            if not getgenv().buyEgg then break end;
            remotePath.EggService.Purchase:FireServer(eggType)
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


game.Players.LocalPlayer.Character.Head.NameTag.Frame.Visible = false; -- Safety ban check (Hides Nametag)

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/AikaV3rm/UiLib/master/Lib.lua')))()

local w = library:CreateWindow("Clicker Madness")

local b = w:CreateFolder("Autofarm")

local c = w:CreateFolder("Egg")

local d = w:CreateFolder("Teleports")

b:DestroyGui()


b:Toggle("Auto Tap",function(bool)
    getgenv().autoTap = bool
    print('Auto Tap is: ', bool);
    if bool then
        doTap();
    end
end)

local selectedRebirth;
b:Dropdown("Rebirth Amt",{"1","10","100", "1000"},true,function(value)
    selectedRebirth = value;
     print(value)
 end)

b:Toggle("Auto Rebirth",function(bool)
    getgenv().autoRebirth = bool
    print('Auto Rebirth is: ', bool);
    if bool and selectedRebirth then
        autoRebirth(selectedRebirth);
    end
end)

c:Toggle("Auto Buy Egg",function(bool)
    getgenv().buyEgg = bool
    print('Auto Rebirth is: ', bool);
    if bool then
        buyEgg('basic');
    end
end)

local selectedWorld;

d:Dropdown("World",{"Desert","Winter","Lava", "Toxic"},true,function(value)
    selectedWorld = value;
     print(value)
 end)

d:Button("Teleport",function()
    if selectedWorld then
        teleportWorld(selectedWorld)
    end
end)
