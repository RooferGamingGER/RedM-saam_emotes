
--[[
 
       ______     ______     ______     __    __           ______     __  __     ______               
      /\  ___\   /\  __ \   /\  __ \   /\ "-./  \         /\  ___\   /\_\_\_\   /\  ___\            
      \ \___  \  \ \  __ \  \ \  __ \  \ \ \-./\ \    __  \ \  __\   \/_/\_\/_  \ \  __\   
       \/\_____\  \ \_\ \_\  \ \_\ \_\  \ \_\ \ \_\  /\_\  \ \_____\   /\_\/\_\  \ \_____\ 
        \/_____/   \/_/\/_/   \/_/\/_/   \/_/  \/_/  \/_/   \/_____/   \/_/\/_/   \/_____/ 
 
        
NOTE: If you want your animations to end instantly when the Key i pressed simply add "Immediately" after "ClearPedTasks" (im ROW 43), turning it into "ClearPedTasksImmediately"
NOTE2: If you want to change the cancel key replace The default hash "0xD9D0E1C0" (in ROW 41) with the one you want, here's a list "https://github.com/femga/rdr3_discoveries/tree/master/Controls" 

]]--

player = nil
status = false
RegisterCommand("e", function(source, args)
    player = PlayerPedId(-1);
    local emoteToPlay = args[1]
    if GetVehiclePedIsIn(player, false) ~= 0 then return end;
    startEmote(emoteToPlay)
end)


function startEmote(anim)
    if emote[anim] and player and status == false then 
        local ped = PlayerPedId()
        TaskStartScenarioInPlace(ped, GetHashKey(emote[anim].anim), playEnterAnim, true)

        status = true
    else 
        return; 
    end;
end

Citizen.CreateThread(function()
    while true do
        if status then
            if 
                IsControlPressed(1, 0xD9D0E1C0)
            then
                ClearPedTasks(player);
                status = false
            end
        end
        Citizen.Wait(0)
    end
end)

