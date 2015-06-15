require 'logging'
require 'logging.rolling_file'
require 'conf.settings'

local logger = logging.rolling_file(LOG_PATH or 'log.log', 1024*100, 10)
logger:setLevel(LOG_LEVEL or logging.DEBUG)

return logger
