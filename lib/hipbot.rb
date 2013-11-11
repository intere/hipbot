require 'active_support/concern'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/array/extract_options'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/string/inflections'
require 'ostruct'
require 'json'
require 'eventmachine'
require 'em-http-request'
require 'xmpp4r-hipchat'

require 'hipbot/cache'
require 'hipbot/patches/encoding'
require 'hipbot/logger'
require 'hipbot/callbacks/base'
require 'hipbot/callbacks/message'
require 'hipbot/callbacks/private_message'
require 'hipbot/callbacks/room_message'
require 'hipbot/callbacks/presence'
require 'hipbot/callbacks/lobby_presence'
require 'hipbot/callbacks/room_presence'
require 'hipbot/callbacks/invite'
require 'hipbot/adapter'
require 'hipbot/adapters/hipchat/initializer'
require 'hipbot/adapters/hipchat'
require 'hipbot/adapters/telnet'
require 'hipbot/adapters/shell'
require 'hipbot/reaction_factory'
require 'hipbot/reactable'
require 'hipbot/matchable'
require 'hipbot/configuration'
require 'hipbot/configurable'
require 'hipbot/bot'
require 'hipbot/plugin'
require 'hipbot/storages/base'
require 'hipbot/storages/hash'
require 'hipbot/http'
require 'hipbot/helpers'
require 'hipbot/match'
require 'hipbot/message'
require 'hipbot/reaction'
require 'hipbot/response'
require 'hipbot/room'
require 'hipbot/user'
require 'hipbot/version'
