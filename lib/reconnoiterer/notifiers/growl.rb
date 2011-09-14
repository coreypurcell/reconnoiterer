require 'ruby-growl'

module Outpost
  module Notifiers
    # Growl is a Mac OS X app that allows popup notifications on the
    # desktop. There is a linux library called libnotify that should
    # also work with ruby-growl
    #
    # Make sure you have Growl set to allow remote application
    # registration

    class GrowlNotifier

      # @option options [String] :host The host that ruby growl should
      # send the notification to.
      #   notification class. Defaults to Tinder's gem
      def initialize(options={})
        @host = options[:host] || 'localhost'
        puts @host
        @growl = Growl.new(@host, "ruby-growl", ["ruby-growl Notification"], ["ruby-growl Notification"], nil)
      end

      # Issues a notification to a growl. This is a callback, called by
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
