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

  self.sendPhoto = function(body, args)

    return Private.BerranteSendPhoto(self, "sendPhoto", body, args)
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

local function serialize_form_part(name, value, boundary)
  return "--" .. boundary .. "\r\n"
    .. 'Content-Disposition: form-data; name="' .. name .. '"\r\n\r\n'
    .. tostring(value) .. "\r\n"
end

local function flatten_json(prefix, tbl, result)
  for k, v in pairs(tbl) do
    local full_key = prefix and (prefix .. "[" .. k .. "]") or k
    if type(v) == "table" then
      flatten_json(full_key, v, result)
    else
      result[full_key] = v
    end
  end
end

Private.private_BerranteFormaterRequisition = function(json, binary, content, namefile)
  local boundary = "----BERRANTE"

  -- Parte 1: gerar as partes textuais
  local flattened = {}
  flatten_json(nil, json, flattened)

  local parts = {}

  for k, v in pairs(flattened) do
    if k ~= "photo" then
      table.insert(parts, serialize_form_part(k, v, boundary))
    end
  end

  -- Parte 2: adicionar o arquivo binário
  local filename = namefile

  local photo_part_header = "--" .. boundary .. "\r\n"
    .. 'Content-Disposition: form-data; name="photo"; filename="' .. filename .. '"\r\n'
    .. "Content-Type: " .. content .. "\r\n\r\n"

  local footer = "\r\n--" .. boundary .. "--\r\n"

  -- Parte 3: montar corpo final
  local body = table.concat(parts) .. photo_part_header .. binary .. footer

  local headers = {
    ["Content-Type"] = "multipart/form-data; boundary=" .. boundary
  }

  return headers, body
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

---@param self BerranteTelegramBot
---@param method string
---@param json table
---@param args TelegramBotSendPhotoFlags
---@return BerranteTelegramResponse
Private.BerranteSendPhoto = function(self, method, json, args)

  local path = self.infos.url .. method

  json["chat_id"] = self.infos.id_chat

  local body = nil
  local headers = nil

  if args.is_local then

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