
Private = Private

---@param self BerranteTelegramBot
---@param method string
Private.BerranteGetInfoBot = function(self, method)

  local path = self.infos.url .. method

  local response = self.request({url = path, method = "GET"})

  print(response.status())
  print(response.read_body())

  return {nil}
end
