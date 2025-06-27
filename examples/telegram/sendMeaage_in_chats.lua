local LuaBear = require("luaBear.luaBear")
local Berrante = require("LuaBerrante.LuaBerrante")

local session = Berrante.newTelegramSession({id_chat="-123456789", token="token"}, LuaBear.fetch)

if not session then
  print("Error:. internal")
  return 1
end

local group1 = {
  "-123456789",
  "-123456789",
  "-123456789",
  "-123456789",
  "-123456789",
  "-123456789",
  "-123456789",
  "-123456789",
  "-123456789"
}

local group2 = {
  "-123456789",
  "-123456789",
  "-123456789",
  "-123456789",
  "-123456789",
  "-123456789",
  "-123456789",
  "-123456789",
  "-123456789"
}

local response_message0 = session.sendMessage({text = "Ola mundo"}, {group1, group2})

print("body:\n", response_message0[1].body)
