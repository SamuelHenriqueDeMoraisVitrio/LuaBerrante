
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





