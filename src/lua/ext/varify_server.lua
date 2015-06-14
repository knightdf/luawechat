local Class = require 'util.Class'
local log = require 'util.log'
local ngx = package.loaded['ngx']
require 'conf.settings'

local token = Token

WeChatTest = Class:new()

function WeChatTest:check_server(ngx)
    local args = ngx.req.get_uri_args()
    local signature = args.signature
    local timestamp = args.timestamp
    local nonce = args.nonce
    local echostr = args.echostr

    if signature and timestamp and nonce and echostr then
        local t = {token, timestamp, nonce}
        table.sort(t)
        local s = ngx.sha1_bin(table.concat(t))
        if s == signature then
            ngx.say(echostr)
            ngx.exit(200)
        end
    end
    ngx.exit(204)
end

return WeChatTest
