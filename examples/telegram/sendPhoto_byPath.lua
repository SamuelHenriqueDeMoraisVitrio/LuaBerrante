local LuaBear = require("luaBear.luaBear")
local Berrante = require("Berrante.LuaBerrante")


local session = Berrante.newTelegramSession({id_chat="-123456789", token="token"}, LuaBear.fetch)

if not session then
  print("Error:. internal")
  return 1
end

local response_message1 = session.sendPhoto({photo={content="foto.jpg", content_type="image/jpeg", filename="doguinho.jpg"}, capition="teste com binario"})

print("body:\n", response_message1[1].body)
