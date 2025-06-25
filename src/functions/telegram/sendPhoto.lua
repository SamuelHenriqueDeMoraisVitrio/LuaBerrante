
Private = Private

---@param self BerranteTelegramBot
---@param method string
---@param json table
---@param is_local boolean
---@param is_binary boolean
---@return BerranteTelegramResponse
Private.BerranteSendPhoto = function(self, method, json, is_local, is_binary)

  local path = self.infos.url .. method

  json["chat_id"] = self.infos.id_chat

  local body = nil
  local headers = nil

  if is_local then
    if not is_binary then
      local file = assert(io.open(json["photo"], "rb"))
      json["photo"] = file:read("*all")
      file:close()
    end

    headers, body = Private.private_BerranteFormaterRequisition(json, json["photo"])

  else

    headers = {}
    body = json

  end

  local response = self.request({url = path, method = "POST", body=body, headers=headers})

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
