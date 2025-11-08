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
    ℹ️ The code below is required for loading scripts, so you may ignore it!
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

--[[ LOADER ]]--

if not data then
    return Wind:Notify({
            Title = "Margo Console",
            Content = "Nah, I don't think this game is on our list...",
            Duration = 6.9,
            Icon = "scroll-text"
        })
end

if data.places and #data.places > 0 and not table.find(data.places, game.PlaceId) then
    return Wind:Notify({
                Title = "Margo Console",
                Content = "Mm, this game is definitely on our list, but NOT the \"place\". Hop in different place inside of this game!",
                Duration = 6.9,
                Icon = "scroll-text"
            })
end

Wind:Notify({
    Title = "Margo Console",
    Content = string.format("Alright bet, loading script for %s!", data.title and data.title or data),
    Duration = 6.9,
    Icon = "pizza"
})

if type(res) ~= "function" then
    return Wind:Notify({
                Title = "Margo Console",
                Content = "Hold up, the script is NOT a \"function\", so it won't be executed anyway",
                Duration = 6.9,
                Icon = "pizza"
            })
end

local suc, err = pcall(res)

if not suc then
    Wind:Notify({
        Title = "Margo Console",
        Content = "Awgh, nope, it got error.. Check out the console I guess...",
        Duration = 6.9,
        Icon = "pizza"
    })

    return error("[Margo Console/ERROR]: "..err)
end
