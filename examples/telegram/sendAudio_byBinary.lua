local LuaBear = require("luaBear.luaBear")
local Berrante = require("LuaBerrante.LuaBerrante")


local session = Berrante.newTelegramSession({id_chat="-123456789", token="token"}, LuaBear.fetch)

if not session then
  print("Error:. internal")
  return 1
end

local audio = assert(io.open("madeira_grande.mp3", "rb"))
local binary_audio = audio:read("*all")
audio:close()

local response_message2 = session.sendAudio({audio={content=binary_audio, content_type="audio/mpeg", filename="madeira_grande.mp3"}, thumbnail={content="foto.jpg", content_type="image/jpeg", filename="doguinho.jpg"}})

print("body:\n", response_message2[1].body)
