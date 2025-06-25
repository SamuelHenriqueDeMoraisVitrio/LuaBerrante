return (function()    
      local Private = {};
      local Berrante = {};
  

Private = Private

---@param self BerranteTelegramBot
---@return BerranteTelegramBot
Private.private_BerranteNewSessionTelegramModule = function(self)

  self.getMe = function()
    return Private.BerranteGetInfoBot(self, "getMe")
  end

  self.sendMessage = function(body)

    return Private.BerranteSendMessage(self, "sendMessage", body)
  end

  self.sendPhoto = function()

    return {nil}
  end

  self.sendDocument = function()

    return {nil}
  end

  self.sendVideo = function()

    return {nil}
  end

  self.sendAudio = function()

    return {nil}
  end

  self.sendContact = function()

    return {nil}
  end

  self.sendLocation = function()

    return {nil}
  end

  self.sendVoice = function()

    return {nil}
  end

  return self

end






Private = Private

---@param self BerranteTelegramBot
---@param method string
---@return BerranteTelegramResponse
Private.BerranteGetInfoBot = function(self, method)

  local path = self.infos.url .. method

  local response = self.request({url = path, method = "GET"})

  local content_type = response.headers["Content-Type"]

  ----@type BerranteTelegramResponse
  local objResponse = {}

  objResponse.status_code = response.status_code
  objResponse.in_error = false

  if content_type ~= "application/json" or objResponse.status_code ~= 200 then
    objResponse.in_error = true
  end

  objResponse.body = response.read_body()
  objResponse.json = response.read_body_json()

  local result = objResponse.json["result"]

  self.infos.first_name = result["first_name"]
  self.infos.id = result["id"]
  self.infos.is_bot = result["is_bot"]
  self.infos.username = result["username"]

  return objResponse
end




Private = Private

---@param self BerranteTelegramBot
---@param method string
---@param json table
---@return BerranteTelegramResponse
Private.BerranteSendMessage = function(self, method, json)

  local path = self.infos.url .. method

  json["chat_id"] = self.infos.id_chat

  local response = self.request({url = path, method = "POST", body=json})

  local content_type = response.headers["Content-Type"]

  ----@type BerranteTelegramResponse
  local objResponse = {}

  objResponse.status_code = response.status_code
  objResponse.in_error = false

  if content_type ~= "application/json" or objResponse.status_code ~= 200 then
    objResponse.in_error = true
  end

  objResponse.body = response.read_body()
  objResponse.json = response.read_body_json()

  return objResponse
end



Private = Private

---@param flags LuaBerranteTelegramFlags
---@param request_provider fun(props: RequestProps):RequestResponse
---@return BerranteTelegramBot | nil
Berrante.newTelegramSession = function(flags, request_provider)

  ----@type BerranteTelegramBot
  local self = {}
  self.infos = {}

  if not flags.url then
    flags.url = "https://api.telegram.org"
  end

  -- Remove a barra final se existir
  if flags.url:sub(-1) == "/" then
    flags.url = flags.url:sub(1, -2)
  end

  self.infos.id_chat = flags.id_chat
  self.infos.token = flags.token
  self.infos.url = flags.url .. "/bot" .. flags.token .. '/'

  self.request = request_provider

  Private.private_BerranteNewSessionTelegramModule(self)

  if self.getMe().in_error then
    return nil
  end

  return self
end








    return Berrante;
end)()