
Private = Private

---@param self BerranteTelegramBot
---@param method string
---@param json table
---@param args TelegramBotSendPhotoFlags | nil
---@return BerranteTelegramResponse
Private.BerranteSendPhoto = function(self, method, json, args)

  local path = self.infos.url .. method

  json["chat_id"] = self.infos.id_chat

  local body = nil
  local headers = nil

  if args and (args.is_local or args.is_binary) then --Precisa verificar args para o auto complete não me enxer.

    args.content_type = args.content_type or "application/octet-stream"
    args.file_name = args.file_name or "file_image"

    if not args.is_binary then
      local file = assert(io.open(json["photo"], "rb"))
      json["photo"] = file:read("*all")
      file:close()
    end

    headers, body = Private.private_BerranteFormaterRequisition(json, json["photo"], args.content_type, args.file_name)
  end

  headers = headers or {}
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
