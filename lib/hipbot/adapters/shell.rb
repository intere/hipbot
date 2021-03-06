module Hipbot
  module Adapters
    class Shell
      attr_accessor :connection

      def start!
        EM.open_keyboard(KeyboardHandler, self)
      end

      def invite_to_room(*); end
      def join_room(*); end
      def kick_from_room(*); end
      def leave_room(*); end
      def restart!; end
      def send_to_room(*); end
      def set_presence(*); end
      def set_topic(*); end

      module KeyboardHandler
        include EM::Protocols::LineText2
        include Cache

        def initialize adapter
          adapter.connection = self
        end

        attr_cache :user do
          Hipbot::User.find_or_create_by(name: 'Shell User')
        end

        def receive_line data
          Hipbot.react(user, nil, data.strip)
        end
      end
    end
  end
end
