# LuaBerrante

**Berrante** is a lightweight Lua library that acts as an abstraction layer for messaging APIs like Telegram, Gmail, and others. It allows you to build pluggable notification systems, giving your application the power to send messages, media, and perform interactive actions in an easy and extensible way.

---

## 📦 Installation

You can include `Berrante` as part of your Lua project. It depends on external request modules that you must inject manually, providing full control over HTTP behavior.

```bash
curl -L -s https://github.com/SamuelHenriqueDeMoraisVitrio/LuaBerrante/releases/download/V0.0.1/LuaBerrante.lua -o Berrante.zip && unzip Berrante.zip && rm -rf Berrante.zip
```

It is recommended to use the **Lua-bear** lib as the entire lib was created based on it.

```bash
mkdir -p luaBear && \
curl -L -o luaBear/luaBear.lua https://github.com/OUIsolutions/Lua-Bear/releases/download/0.1.3/luaBear.lua && \
curl -L -o luaBear/luaBear.so https://github.com/OUIsolutions/Lua-Bear/releases/download/0.1.3/luaBear.so
```

---

## 🧠 Concept

Berrante allows you to create messaging sessions for specific platforms. For example, with Telegram you can create a messaging bot session and interact with the API via a friendly and extensible Lua interface.

```lua
local bear = require("luaBear.luaBear")
local berrante = require("Berrante.LuaBerrante")

-- Create Telegram bot session
local session = berrante.newTelegramSession({
  token = "YOUR_TELEGRAM_BOT_TOKEN",
  id_chat = "DEFAULT_CHAT_ID"
}, bear.fetch)
```

> `bear.fetch` is your own HTTP request implementation. Berrante does **not** perform network calls directly.

---

## 📬 Sending Messages

Once you've created a session, you can use the bot methods to send different types of messages. All message-related functions accept two parameters:

1. `body` (table): The Telegram API request payload.
2. `destination` (optional): A list of chat ID groups. If provided, these will override the default `id_chat`.

### 📝 Text Message

```lua

local client = {
  "123456",
  "123456",
  "123456"
}

local devs = {
  "123456",
  "123456",
  "123456",
  "123456"
}

local response = session.sendMessage(
  { text = "Hello from Berrante!" },
  { client, devs }
)
```

### 🖼️ Sending Media

For media like photos, videos, documents, etc., you can use a string for public URLs or a table for local files/binary data.

#### Using a URL

```lua
local response = session.sendPhoto({
  photo = "https://example.com/image.jpg",
  caption = "Public image"
})
```

#### Using Binary Content

```lua
local response = session.sendPhoto({
  photo = {
    content = binary_image,
    content_type = "image/jpeg",
    filename = "doguinho.jpg"
  },
  caption = "Binary upload"
})
```

> 🔥 It's **strongly recommended** to provide `content_type` and `filename` (with extension) for binary files.

---

## 📦 Supported Telegram Methods

Berrante supports a wide variety of Telegram Bot API methods:

- ✅ `getMe`
- ✅ `sendMessage`
- ✅ `sendPhoto`, `sendVideo`, `sendAudio`, `sendDocument`, `sendVoice`
- ✅ `sendLocation`, `sendContact`, `sendVenue`
- ✅ `sendAnimation`, `sendVideoNote`, `sendSticker`, `sendDice`, `sendPoll`
- ✅ `sendMediaGroup`, `sendPaidMedia`
- ✅ `forwardMessage`, `forwardMessages`, `copyMessage`, `copyMessages`
- ✅ `editMessageText`, `editMessageCaption`, `editMessageMedia`, `editMessageReplyMarkup`
- ✅ `deleteMessage`
- ✅ `answerCallbackQuery`, `answerInlineQuery`
- ✅ `getFile`, `getUserProfilePhotos`
- ✅ `getChat`, `getChatAdministrators`, `getChatMember`, `getChatMemberCount`
- ✅ `leaveChat`
- ✅ `getUpdates`

Each of these functions returns a list of responses — one for each destination chat — with the following structure:

```lua
{
  status_code = 200,
  body = "...raw body...",
  json = {...parsed response...},
  in_error = false,
  chat_id = "ID that received this request"
}
```

Ps:. The json will only be generated if 'in_error' is false.

---

## 🧩 Dependency Injection

Berrante does not include its own HTTP layer. You must inject your own request function in this format:

```lua
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
```

This gives you full flexibility to use any HTTP client library (e.g., Bear, LuaSocket, etc.).

---

## 🧪 Example Use

```lua
local bear = require("luaBear.luaBear")
local berrante = require("berrante")

local session = berrante.newTelegramSession({
  token = "TOKEN",
  id_chat = "123456"
}, bear.fetch)

local response = session.sendMessage({text="Testing Berrante!"})
print(response[1].json)
```

---

## ⚠️ Notes

- If `destination` is omitted, the message will go to the `id_chat` defined during session creation.
- If `destination` is provided, it overrides the default and sends the request to each group of chat IDs sequentially.
- All media operations support both **public URLs** (string) and **local file uploads** (table).
- All responses are grouped in a list of per-chat objects.

---

## 🐮 Why “Berrante”?

Because it’s a horn. It makes noise. It warns your team.

---

# Lua-bear:
MIT License

Copyright (c) 2025 OUI

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

---

