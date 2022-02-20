

--[[ 


                                                                     
                                                                     
HHHHHHHHH     HHHHHHHHH                   lllllll                    
H:::::::H     H:::::::H                   l:::::l                    
H:::::::H     H:::::::H                   l:::::l                    
HH::::::H     H::::::HH                   l:::::l                    
  H:::::H     H:::::H      eeeeeeeeeeee    l::::lppppp   ppppppppp   
  H:::::H     H:::::H    ee::::::::::::ee  l::::lp::::ppp:::::::::p  
  H::::::HHHHH::::::H   e::::::eeeee:::::eel::::lp:::::::::::::::::p 
  H:::::::::::::::::H  e::::::e     e:::::el::::lpp::::::ppppp::::::p
  H:::::::::::::::::H  e:::::::eeeee::::::el::::l p:::::p     p:::::p
  H::::::HHHHH::::::H  e:::::::::::::::::e l::::l p:::::p     p:::::p
  H:::::H     H:::::H  e::::::eeeeeeeeeee  l::::l p:::::p     p:::::p
  H:::::H     H:::::H  e:::::::e           l::::l p:::::p    p::::::p
HH::::::H     H::::::HHe::::::::e         l::::::lp:::::ppppp:::::::p
H:::::::H     H:::::::H e::::::::eeeeeeee l::::::lp::::::::::::::::p 
H:::::::H     H:::::::H  ee:::::::::::::e l::::::lp::::::::::::::pp  
HHHHHHHHH     HHHHHHHHH    eeeeeeeeeeeeee llllllllp::::::pppppppp    
                                                  p:::::p            
                                                  p:::::p            
                                                 p:::::::p           
                                                 p:::::::p           
                                                 p:::::::p           
                                                 ppppppppp           
                                                                     
 ~ This script has been scripted by Zeyy ~


- To setup your bot please take a look in the settings part. [line.74]



> "setup", / Intialize the alt, TP's to you and automatically set their FPS cap if the function is toggled.
> "bring" / Bring all the alt to you.

> "uptime", / Return the number of minute the bot has there managers script launched.
> "setFPScap", / Limits your alt FPS to avoid them taking too much GPU,CPU capacity.

> "drop start/stop" / Toggle the dropping function. While toggled the alt will automatically drop 10.000$ every 15s.

> "advertise start/stop" / Toggle the spam message function. While toggled the alt will automatically send the specified message.
> "setAdvertise [MESSAGE]" / Set the message that would be sent in the 'advertise start/stop' function.

> "showWallet", / Get every alt to show their wallet.
> "hideWallet", / Get every alt to show hide wallet.



]]





local Syn,KRNL = 'Synapse X','KRNL'
local current_exploit = identifyexecutor()

if not (current_exploit:match(Syn) or current_exploit:match(KRNL)) then
    game.Players.LocalPlayer:Kick("\nThis Alt Managers is only compatible with KRNL or SynapseX")
end

repeat wait() until game:IsLoaded()
local player = game.Players.LocalPlayer
local Character = player.Character

local Managers = {'PearlZeyy'}
local prefix = '.'

local setting = {
    ["Drop"] = false,
    
    ["Advertise"] = false,
    ["AdvertiseMsg"] = '',

    ["FPSRestrict"] = true,
    ['FPSCap'] = 3,

    ["UPTIME"] = 0
}

print('Started Managers Handle!')

function IsAManager(user)
    if (table.find(Managers, user)) then
        return true
    end
end

function SayMessage(msg)
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, 'All')
end

player.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), game.Workspace.CurrentCamera.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), game.Workspace.CurrentCamera.CFrame)
end)



function Command(message, Manager)

    local cmd = message:split(' ')[1]
    local argument = message:split(' ')[2]

    if (Manager == player.Name) then
        return
    end

    if (cmd == prefix..'showWallet') then
        pcall(function ()
            game:GetService("Players").LocalPlayer.Backpack.Wallet.Parent = game:GetService("Players").LocalPlayer.Character
            SayMessage('Succes! @' .. Manager)
        end)
    end

    if (cmd == prefix..'hideWallet') then
        pcall(function ()
            game:GetService("Players").LocalPlayer.Character.Wallet.Parent = game:GetService("Players").LocalPlayer.Backpack
            SayMessage('Succes! @' .. Manager)
        end)
    end

    if (cmd == prefix..'setup') then
        player.Character:MoveTo(game.Players[Manager].Character.Head.Position)
        SayMessage('Succes! @' .. Manager)
        if (setting.FPSRestrict) then
        setfpscap(setting.FPSCap)    
        SayMessage('FPS Cap set to ' .. tostring(setting.FPSCap))
        end    
    end


    if (cmd == prefix..'bring') then
        player.Character:MoveTo(game.Players[Manager].Character.Head.Position)
        SayMessage('Succes! @' .. Manager)
    end

    if (cmd == prefix .. 'drop' and argument == 'start') then
        setting.Drop = true
        SayMessage('Succes! @' .. Manager)
    else
        if (cmd == prefix .. 'drop' and argument == 'stop') then
            setting.Drop = false
            SayMessage('Succes! @' .. Manager)
        end
    end

    if (cmd == prefix .. 'uptime') then
SayMessage(tostring(setting.UPTIME/60)..'Minute!')
    end 
    if (cmd == prefix .. 'setFPScap') then
        setfpscap(tonumber(argument))
        SayMessage('Succes! @' .. Manager)
    end

    if (cmd == prefix .. 'advertise' and argument == 'start') then
        setting.Advertise = true
        SayMessage('Succes! @' .. Manager)
    else
        if (cmd == prefix .. 'advertise' and argument == 'stop') then
            setting.Advertise = false
            SayMessage('Succes! @' .. Mhanager)
        end
    end

    if (cmd == prefix .. 'setAdvertise') then
        setting.AdvertiseMsg = argument
        SayMessage('Succes! @' .. Manager)
    end


end

-- Module 
-- // Dropper

game.RunService.RenderStepped:Connect(function()
    if not (setting.Drop) then
        return
    end
    game.ReplicatedStorage.MainEvent:FireServer("DropMoney", '10000')
end)

-- // Advertiser

game.RunService.RenderStepped:Connect(function()
    wait(2)
    if not (setting.Advertise) then
        return
    end
    SayMessage(setting.AdvertiseMsg)
end)


-- Loader 



game.Players.PlayerAdded:Connect(function(player)
    if (IsAManager(player)) then

        player.Chatted:Connect(function(messageToR)
            Command(messageToR, player.Name)
        end)
    end
end)

for i, v in pairs(game.Players:GetChildren()) do
    if (IsAManager(v.Name)) then
        v.Chatted:Connect(function(messageToR)

            Command(messageToR, v.Name)
        end)
    end
end



-- // UPTIME counter
while wait(1) do
setting.UPTIME = setting.UPTIME +1

end
