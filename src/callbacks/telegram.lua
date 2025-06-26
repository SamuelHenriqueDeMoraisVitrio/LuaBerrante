
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

  self.sendContact = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "sendContact", body, ids)
  end

  self.sendLocation = function(body, ids)
    return private_BerranteTelegramCallMessage(self, "sendLocation", body, ids)
  end

  self.sendVoice = function(body, ids)
    return private_BerranteTelegramCallFormData(self, "sendVoice", body, {"voice"}, ids)
  end

  return self

end



