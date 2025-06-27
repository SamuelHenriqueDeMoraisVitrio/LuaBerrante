local LuaBear = require("luaBear.luaBear")
local Berrante = require("LuaBerrante.LuaBerrante")


local session = Berrante.newTelegramSession({id_chat="-123456789", token="token"}, LuaBear.fetch)

if not session then
  print("Error:. internal")
  return 1
end

print(session.infos.first_name)

local response_message0 = session.sendMessage({text = "Ola mundo"})

local image = assert(io.open("foto.jpg", "rb"))
local binary_image = image:read("*all")
image:close()

local audio = assert(io.open("madeira_grande.mp3", "rb"))
local binary_audio = audio:read("*all")
audio:close()

local response_message1 = session.sendPhoto({photo={content=binary_image, content_type="image/jpeg", filename="doguinho.jpg"}, capition="teste com binario"})

local response_message2 = session.sendAudio({audio={content=binary_audio, content_type="audio/mpeg", filename="madeira_grande.mp3"}, thumbnail={content="foto.jpg", content_type="image/jpeg", filename="doguinho.jpg"}})

local response_message3 = session.getUpdates()

print("erro:", response_message3[1].in_error)
print("code:", response_message3[1].status_code)
print("body:\n", response_message3[1].body)
