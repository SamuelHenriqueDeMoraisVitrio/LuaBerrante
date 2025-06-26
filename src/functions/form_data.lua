
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
