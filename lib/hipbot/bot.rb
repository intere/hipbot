module Hipbot
  class Bot < Reactable
    attr_accessor :configuration, :connection, :error_handler

    CONFIGURABLE_OPTIONS = [:name, :jid, :password, :adapter, :helpers, :plugins, :teams, :rooms]
    delegate *CONFIGURABLE_OPTIONS, to: :configuration
    alias_method :to_s, :name

    def initialize
      super
      self.configuration = Configuration.new.tap(&self.class.configuration)
      self.error_handler = self.class.error_handler
      extend(self.adapter || Adapters::Hipchat)
    end

    def reactions
      defined_reactions + plugin_reactions + default_reactions
    end

    def react sender, room, message
      matches = matching_reactions(sender, room, message)
      matches.first.invoke(sender, room, message) if matches.size > 0
    end

    class << self
      ACCESSORS = { configure: :configuration, on_preload: :preloader, on_error: :error_handler }

      ACCESSORS.each do |setter, getter|
        define_method(setter) do |&block|
          instance_variable_set("@#{getter}", block)
        end

        define_method(getter) do
          instance_variable_get("@#{getter}") || Proc.new{}
        end
      end

      def start!
        ::EM::run do
          Helpers.module_exec(&preloader)
          new.start!
        end
      end
    end

    private

    def plugin_reactions
      included_plugins.map(&:defined_reactions).flatten
    end

    def included_plugins
      @included_plugins ||= begin
        Array(plugins).map do |object|
          plugin = object.kind_of?(Plugin) ? object : object.new
          plugin.bot = self
          plugin
        end
      end
    end

    def default_reactions
      super + included_plugins.flat_map(&:default_reactions)
    end

    def matching_reactions sender, room, message
      reactions.select { |r| r.match?(sender, room, message) }
    end
  end
end
