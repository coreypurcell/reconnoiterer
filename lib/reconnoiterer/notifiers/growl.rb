require 'ruby-growl'

module Outpost
  module Notifiers
    # The Campfire notifier issues Outpost notifications to the 37signals'
    # Campfire web app (http://campfirenow.com). It issues messages about
    # the system status in the specified subdomain and room.
    #
    # This requires the 'tinder' gem to be installed.
    class GrowlNotifier

      # @param [Hash] Options to create a campfire notification.
      # @option options [String] :subdomain The subdomain of your campfire
      #   rooms
      # @option options [String] :token An access token, can be found
      #   in your Account info
      # @option options [String] :room The room notifications will be sent to
      # @option options [Class] :campfire_notifier Another Campfire
      #   notification class. Defaults to Tinder's gem
      def initialize(options={})
        @host = options[:host]     || '127.0.0.1'
        @growl = Growl.new("localhost", "ruby-growl", ["ruby-growl Notification"], ["ruby-growl Notification"], nil)
        # @growl = Growl.new('localhost', "ruby-growl", ["Reconnoiterer Notification"], ["Reconnoiterer Notification"], nil)
      end

      # Issues a notification to a Campfire room. This is a callback, called by
      # an Outpost instance.
      # @param [Outpost::Application, #read] outpost an instance of an outpost, containing
      #   latest status, messages and reports that can be queried to build
      #   a notification message.
      def notify(outpost)
        status = outpost.last_status.to_s
        @growl.notify("ruby-growl Notification", "Reconnoiterer Status",
                      "System is #{status}: #{outpost.messages.join(',')}",1)
      end
    end
  end
end
