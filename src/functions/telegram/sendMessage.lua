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
  objResponse.body = response.read_body()

  if content_type ~= "application/json" or objResponse.status_code ~= 200 then
    objResponse.in_error = true
  end

  objResponse.json = response.read_body_json()

  return objResponse
end
