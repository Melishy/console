--[[
.        :                                        .,~:::::                                  `::.          
;;,.    ;;;                                     ,;;;'````'                                   ;;;          
[[[[, ,[[[[,  ,ccc,  =,,[[== ,ccc,    ,ccc,     [[[         ,ccc,  [ccccc, ,cc[[[cc.  ,ccc,  [[[,cc[[[cc. 
$$$$$$$$"$$$ $$$cc$$$`$$$"``$$$cc$$$ $$$"c$$$   $$$        $$$"c$$$$$$$"$$$$$$____   $$$"c$$$$$'$$$___--' 
888 Y88" 888o888   888888   888   888888   88   `88bo,__,o,888   88888  Y88o.     88,888   88\8o88b    ,o,
MMM  M'  "MMM "YUM" MP"MM,   "YUM" MP "YUMMP      "YUMMMMMP""YUMMP MMM  "MMM"YUMMMMP" "YUMMP  MM;"YUMMMMP"
                                  MMM                                                                     
                            ,c.   ###                                                                     
                            \M###MMU                                                                      

}---------------------------------------------------------------------------------------------------------------------{
    ⚠️ IMPORTANT:
    You must copy and use the FULL script below, NOT clicking on the link!

    loadstring(game:HttpGet("https://raw.githubusercontent.com/Melishy/console/main/main.luau"))()
}---------------------------------------------------------------------------------------------------------------------{
    ℹ️ You can ignore the code below
}---------------------------------------------------------------------------------------------------------------------{
]]

if not game:IsLoaded() then
    game.Loaded:Wait()
end

--[[ VARIABLES ]]--

local meta = {
    [7521520342] = {
        title = "Quiet or Die"
    }
}
local data = meta[game.GameId]

local Wind = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local res = loadstring(game:HttpGet("https://raw.githubusercontent.com/Melishy/console/" .. (shared.Margo_Branch and tostring(shared.Margo_Branch) or "main") .. "/games/" .. tostring(game.GameId) .. ".luau"))

--[[ LOGIC ]]--

if not data then
    return Wind:Notify({
            Title = "Margo Console",
            Content = "Uh, the game isn't on our supported games list :P",
            Duration = 6.9,
            Icon = "scroll-text"
        })
end

if data.places and #data.places > 0 and not table.find(data.places, game.PlaceId) then
    return Wind:Notify({
                Title = "Margo Console",
                Content = "Uh, while the game is supported, this place isn't on that list :d",
                Duration = 6.9,
                Icon = "scroll-text"
            })
end

Wind:Notify({
    Title = "Margo Console",
    Content = "Okay, loading a script for " .. tostring(data.title),
    Duration = 6.9,
    Icon = "pizza"
})

if type(res) ~= "function" then
    return Wind:Notify({
                Title = "Margo Console",
                Content = "Actually, nevermind. I have found issues though",
                Duration = 6.9,
                Icon = "pizza"
            })
end

local suc, err = pcall(res)

if not suc then
    Wind:Notify({
        Title = "Margo Console",
        Content = "I'm now confused, so the error has occurred",
        Duration = 6.9,
        Icon = "pizza"
    })

    return error("[Margo Console/ERROR]: "..err)
end
