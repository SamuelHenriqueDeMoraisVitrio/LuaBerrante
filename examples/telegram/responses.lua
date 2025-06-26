local LuaBear = require("luaBear.luaBear")
local Berrante = require("Berrante.LuaBerrante")


local session = Berrante.newTelegramSession({id_chat="-123456789", token="token"}, LuaBear.fetch)

if not session then
  print("Error:. internal")
  return 1
end

local devs = {
  "-123456789",
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

local response_message0 = session.sendMessage({text = "Ola mundo"}, {devs})

for i = 1, response_message0.cont do
  if response_message0[i].in_error then
    print("\nIn error: ", response_message0[i].status_code, "Body:\n")
    print(response_message0[i].body)
  end
  local json = response_message0[i].json
  print("OK:", json.ok)
end



