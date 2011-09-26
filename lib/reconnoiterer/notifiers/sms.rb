module Outpost
  module Notifiers
    class SMS

      # @param [Hash] Options to create an email notification.
      # @option options [String] :from The "from" email field
      # @option options [String] :to Where e-mails will be delivered
      # @option options [String] :subject The email's subject
      def initialize(options={})
        read_config
        @to      = options[:to]

        unless @from && @to
          raise ArgumentError, 'You need to set :from and :to to send an SMS.'
        end
      end

      # Issues a notification through email. This is a callback, called by
      # an Outpost instance.
      # @param [Outpost::Application, #read] outpost an instance of an outpost, containing
      #   latest status, messages and reports that can be queried to build
      #   a notification message.
      def notify(outpost)
        Twilio::SMS.create :to => @to, :from => @from,
                           :body => build_message(outpost)
      end

      private

      def read_config
        config = YAML.load_file("twilio.yaml")
        Twilio::Config.setup(
            :account_sid => config['twilio']['account_sid'],
            :auth_token => config['twilio']['auth_token']
        )
        @from = config['twilio']['phone_number']
      end

      def build_message(outpost)
        status = outpost.last_status.to_s

        message  = "Reconnoiterer: System is #{status.upcase}!\n\n"
        message << outpost.messages.join("\n")
        message[0..159] # trim message to fit in an sms
      end
    end
  end
end
