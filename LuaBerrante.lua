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

Private.private_BerranteFormaterRequisition = function(json, files, headers)
  local boundary = "----BERRANTE"

  -- Parte 1: gerar as partes textuais
  local flattened = {}
  flatten_json(nil, json, flattened)

  local parts = {}

  local binary_fields = {}
  for _, name in ipairs(files or {}) do
    binary_fields[name] = true
  end

  -- agora o loop fica limpo e eficiente
  for k, v in pairs(flattened) do
    if not binary_fields[k] then
      table.insert(parts, serialize_form_part(k, v, boundary))
    end
  end

  -- adicionar arquivos binários
  for _, field_name in ipairs(files or {}) do
    local file = json[field_name]
    --assert(file and file.content and file.content_type and file.filename, "Dados incompletos para arquivo: " .. tostring(field_name))

    local part = "--" .. boundary .. "\r\n"
      .. 'Content-Disposition: form-data; name="' .. field_name .. '"; filename="' .. file.filename .. '"\r\n'
      .. "Content-Type: " .. file.content_type .. "\r\n\r\n"
      .. file.content .. "\r\n"

    table.insert(parts, part)
  end

  -- footer sem \r\n extra no começo
  local footer = "--" .. boundary .. "--\r\n"

  -- corpo final
  local body = table.concat(parts) .. footer

  headers["Content-Type"] = "multipart/form-data; boundary=" .. boundary

  return body
end



Private = Private

Private.private_BerranteStringIsBinary = function(path)
  local arquivo = io.open(path, "r")
  if arquivo then
    arquivo:close()
    return false
  end

  return true
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
---@return BerranteTelegramResponse
Private.BerranteSendPhoto = function(self, method, json)

  local path = self.infos.url .. method

  json["chat_id"] = self.infos.id_chat

  local keys = {"photo"}
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
        print("chegou aq!!!")
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