
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
