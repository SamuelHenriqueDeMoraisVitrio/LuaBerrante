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

  self.sendMessage = function()

    return {nil}
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
Private.BerranteGetInfoBot = function(self, method)

  local path = self.infos.url .. method

  local response = self.request({url = path, method = "GET"})

  print(response.status())
  print(response.read_body())

  return {nil}
end



Private = Private

---@param flags LuaBerranteTelegramFlags
---@param request_provider fun(props: RequestProps):RequestResponse
---@return BerranteTelegramBot
Berrante.newTelegramSession = function(flags, request_provider)

  ---@type BerranteTelegramBot
  local self = {}
  self.infos = {}

  self.infos.id_chat = flags.id_chat
  self.infos.url = flags.url .. "/bot" .. flags.token .. '/'

  self.request = request_provider

  Private.private_BerranteNewSessionTelegramModule(self)

  return self
end








    return Berrante;
end)()