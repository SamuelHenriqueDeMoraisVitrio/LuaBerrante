
-- Params in newDriver

---@class RequestResponse
---@field status_code integer
---@field headers table<string, string>
---@field read_body fun(): string
---@field read_body_json fun(): table
---@field read_body_chunk fun(size:integer): string

---@class RequestProps
---@field url string
---@field method string | nil
---@field headers table<string, string> | nil
---@field body string | table | nil

---@class TelegramBotInfo
---@field id string
---@field is_bot boolean
---@field first_name string
---@field username string
---@field token string
---@field id_chat string
---@field url string

---@class BerranteTelegramResponse
---@field status_code integer
---@field body string | nil
---@field json table
---@field in_error boolean

---@class BerranteTelegramBot
---@field request fun(props: RequestProps):RequestResponse
---@field infos TelegramBotInfo
---@field getMe fun():BerranteTelegramResponse
---@field sendMessage fun(body:table):BerranteTelegramResponse
---@field sendPhoto fun(body:table, is_local:boolean, is_binary:boolean):BerranteTelegramResponse
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
---@field newTelegramSession fun(flags: LuaBerranteTelegramFlags, request_maker: fun(props: RequestProps):RequestResponse): BerranteTelegramBot | nil

---@type LuaBerranteModule
Berrante = Berrante
