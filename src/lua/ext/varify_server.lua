local Class = require 'util.Class'
local logger = require 'util.log'
local cjson = require 'cjson.safe'
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
    logger:debug('wechat uri args: %s', cjson.encode(args))

    if signature and timestamp and nonce and echostr then
        local t = {token, timestamp, nonce}
        table.sort(t)
        local s = ngx.sha1_bin(table.concat(t))
        local tmp_str = ''
        for i=1, #s do
            tmp_str = tmp_str .. string.format('%02x', string.byte(s:sub(i, i)))
        end
        logger:debug('calculated signature: %s', tostring(tmp_str))
        if tmp_str == signature then
            ngx.say(echostr)
            ngx.exit(200)
        end
    end
    ngx.exit(204)
end

return WeChatTest
