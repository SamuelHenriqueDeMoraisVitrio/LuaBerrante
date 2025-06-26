
Private = Private

local function private_BerranteTelegramCallMessage(self, method, body, ids)
  local results = {}
  results.cont = 0

  if not ids or #ids == 0 then
    local res = Private.BerranteSendMessage(self, method, body, nil)
    table.insert(results, res)
    results.cont = results.cont + 1
    return results
  end

  for _, id_group in ipairs(ids) do
    for _, id in ipairs(id_group) do
      local result = Private.BerranteSendMessage(self, method, body, id)
      table.insert(results, result)
      results.cont = results.cont + 1
    end
  end

  return results
end

local function private_BerranteTelegramCallFormData(self, method, body, files, ids)
  local results = {}
  results.cont = 0

  if not ids or #ids == 0 then
    local res = Private.private_TelegramSendMessageWithFormData(self, method, body, files, nil)
    table.insert(results, res)
    results.cont = results.cont + 1
    return results
  end

  for _, id_group in ipairs(ids) do
    for _, id in ipairs(id_group) do
      local result = Private.private_TelegramSendMessageWithFormData(self, method, body, files, id)
      table.insert(results, result)
      results.cont = results.cont + 1
    end
  end

  return results
end

---@param self BerranteTelegramBot
---@return BerranteTelegramBot
Private.private_BerranteNewSessionTelegramModule = function(self)

  self.getMe = function()
    return Private.BerranteGetInfoBot(self, "getMe")
  end

  self.sendMessage = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "sendMessage", body, ids)
  end

  self.sendPhoto = function(body, ids)
    return private_BerranteTelegramCallFormData(self, "sendPhoto", body, {"photo"}, ids)
  end

  self.sendDocument = function(body, ids)
    return private_BerranteTelegramCallFormData(self, "sendDocument", body, {"document", "thumbnail"}, ids)
  end

  self.sendVideo = function(body, ids)
    return private_BerranteTelegramCallFormData(self, "sendVideo", body, {"video", "thumbnail", "cover"}, ids)
  end

  self.sendAudio = function(body, ids)
    return private_BerranteTelegramCallFormData(self, "sendAudio", body, {"audio", "thumbnail"}, ids)
  end

  self.sendVoice = function(body, ids)
    return private_BerranteTelegramCallFormData(self, "sendVoice", body, {"voice"}, ids)
  end

  self.sendContact = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "sendContact", body, ids)
  end

  self.sendLocation = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "sendLocation", body, ids)
  end

  self.forwardMessage = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "forwardMessage", body, ids)
  end

  self.forwardMessages = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "forwardMessages", body, ids)
  end

  self.copyMessage = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "copyMessage", body, ids)
  end

  self.copyMessages = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "copyMessages", body, ids)
  end

  self.sendAnimation = function(body, ids)
    return private_BerranteTelegramCallFormData(self, "sendAnimation", body, {"animation", "thumbnail"}, ids)
  end

  self.sendVideoNote = function(body, ids)
    return private_BerranteTelegramCallFormData(self, "sendVideoNote", body, {"video_note", "thumbnail"}, ids)
  end

  self.sendPaidMedia = function(body, ids)
    return private_BerranteTelegramCallFormData(self, "sendPaidMedia", body, {"media", "thumbnail"}, ids)
  end

  self.sendMediaGroup = function(body, ids)
    return private_BerranteTelegramCallFormData(self, "sendMediaGroup", body, {"media"}, ids)
  end

  self.sendVenue = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "sendVenue", body, ids)
  end

  self.sendPoll = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "sendPoll", body, ids)
  end

  self.sendDice = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "sendDice", body, ids)
  end

  self.sendSticker = function(body, ids)
    return private_BerranteTelegramCallFormData(self, "sendSticker", body, {"sticker"}, ids)
  end

  self.editMessageText = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "editMessageText", body, ids)
  end

  self.editMessageCaption = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "editMessageCaption", body, ids)
  end

  self.editMessageMedia = function(body, ids)
    return private_BerranteTelegramCallFormData(self, "editMessageMedia", body, {"media"}, ids)
  end

  self.editMessageReplyMarkup = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "editMessageReplyMarkup", body, ids)
  end

  self.deleteMessage = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "deleteMessage", body, ids)
  end

  self.answerCallbackQuery = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "answerCallbackQuery", body, ids)
  end

  self.answerInlineQuery = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "answerInlineQuery", body, ids)
  end

  self.getFile = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "getFile", body, ids)
  end

  self.getUserProfilePhotos = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "getUserProfilePhotos", body, ids)
  end

  self.getChat = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "getChat", body, ids)
  end

  self.getChatAdministrators = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "getChatAdministrators", body, ids)
  end

  self.getChatMember = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "getChatMember", body, ids)
  end

  self.getChatMemberCount = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "getChatMemberCount", body, ids)
  end

  self.leaveChat = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "leaveChat", body, ids)
  end

  self.getUpdates = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "getUpdates", body, ids)
  end

  return self

end



