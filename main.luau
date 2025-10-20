--!strict

local gameIds: {number} = {
	126922689754590, 
}

if (gameIds[game.GameId]) then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Melishy/console/refs/heads/main/games/"..game.GameId..".luau"))()
else
  warn("Margo Console: nah buddy this game isn't on our list lol")
end
