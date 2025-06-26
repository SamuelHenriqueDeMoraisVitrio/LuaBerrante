Private = Private

---@param self BerranteTelegramBot
---@param method string
---@param json table
---@return BerranteTelegramResponse
Private.private_TelegramSendMessageWithFormData = function(self, method, json, keys)

  local path = self.infos.url .. method

  json["chat_id"] = self.infos.id_chat

  local body = nil
  local headers = {}
  local files = {}
  local have_local = false

  for _, key in ipairs(keys) do
    local value = json[key]
    if value ~= nil and type(value) ~= "string" then
      table.insert(files, key)
      local file_table = json[key]
      file_table.content_type = file_table.content_type or ""
      file_table.filename = file_table.filename or ""

      if not Private.private_BerranteStringIsBinary(file_table.content) then
        local file = assert(io.open(file_table.content, "rb"))
        file_table.content = file:read("*all")
        file:close()
      end

      have_local = true
    end
  end

  if have_local then
    body = Private.private_BerranteFormaterRequisition(json, files, headers)
  end

  body = body or json

  local response = self.request({url = path, method = "POST", body=body, headers=headers})

  local content_type_response = response.headers["Content-Type"]

  ----@type BerranteTelegramResponse
  local objResponse = {}

  objResponse.status_code = response.status_code
  objResponse.in_error = false
  objResponse.body = response.read_body()

  if content_type_response ~= "application/json" or objResponse.status_code ~= 200 then
    objResponse.in_error = true
    return objResponse
  end

  objResponse.json = response.read_body_json()

  return objResponse
end
