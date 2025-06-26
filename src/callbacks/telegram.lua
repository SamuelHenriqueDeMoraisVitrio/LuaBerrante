
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

  self.sendPhoto = function(body)
    return Private.BerranteSendPhoto(self, "sendPhoto", body)
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



