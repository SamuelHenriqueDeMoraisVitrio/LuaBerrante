
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
    return Private.private_TelegramSendMessageWithFormData(self, "sendPhoto", body, {"photo"})
  end

  self.sendDocument = function(body)

    return Private.private_TelegramSendMessageWithFormData(self, "sendDocument", body, {"document", "thumbnail"})
  end

  self.sendVideo = function(body)

    return Private.private_TelegramSendMessageWithFormData(self, "sendVideo", body, {"video", "thumbnail", "cover"})
  end

  self.sendAudio = function(body)
    return Private.private_TelegramSendMessageWithFormData(self, "sendAudio", body, {"audio", "thumbnail"})
  end

  self.sendContact = function(body)

    return Private.BerranteSendMessage(self, "sendContact", body)
  end

  self.sendLocation = function(body)

    return Private.BerranteSendMessage(self, "sendLocation", body)
  end

  self.sendVoice = function(body)

    return Private.private_TelegramSendMessageWithFormData(self, "sendVoice", body, {"voice"})
  end

  return self

end



