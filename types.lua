
-- Params in newDriver

---@class RequestResponse
---@field status number
---@field headers table<string, string>
---@field read_body fun(): string
---@field read_body_json fun(): table

---@class RequestProps
---@field url string
---@field method string | nil
---@field headers table<string, string> | nil
---@field body table | string | nil

---@class TelegramBotInfo
---@field id string
---@field is_bot boolean
---@field first_name string
---@field username string
---@field token string
---@field id_chat string
---@field url string

---@class BerranteTelegramBot
---@field request fun(props: RequestProps):RequestResponse
---@field infos TelegramBotInfo
---@field getMe fun():table
---@field sendMessage fun():table
---@field sendPhoto fun():table
---@field sendAudio fun():table
---@field sendDocument fun():table
---@field sendVideo fun():table
---@field sendVoice fun():table
---@field sendLocation fun():table
---@field sendContact fun():table

---@class LuaBerranteTelegramFlags
---@field token string
---@field id_chat string
---@field url string | nil

---@class LuaBerranteModule
---@field newTelegramSession fun(flags: LuaBerranteTelegramFlags, request_maker: fun(props: RequestProps):RequestResponse): BerranteTelegramBot

---@type LuaBerranteModule
Berrante = Berrante
