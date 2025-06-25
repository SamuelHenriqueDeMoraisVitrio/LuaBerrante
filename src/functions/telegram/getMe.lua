
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


