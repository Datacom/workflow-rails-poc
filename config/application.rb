require File.expand_path('../boot', __FILE__)
require 'rails/all'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)
  # Monkey patch to remove invalid SOAP message
  Viewpoint::EWS::SOAP::EwsBuilder.module_eval do
    def pull_subscription_request(subopts)
     @nbuild.PullSubscriptionRequest('xmlns'=>'http://schemas.microsoft.com/exchange/services/2006/types') {
      folder_ids!(subopts[:folder_ids]) if subopts[:folder_ids]
      event_types!(subopts[:event_types]) if subopts[:event_types]
      watermark!(subopts[:watermark]) if subopts[:watermark]
      timeout!(subopts[:timeout]) if subopts[:timeout]
    }
  end
end

module WorkflowConcept
  class Application < Rails::Application
   require './app/workers/mail_checker'
   MailChecker.perform_async('poll', 1)
   user = 'docgenie@datacom.co.nz'
   pass = 'D0cGen1eonmars3'
   endpoint = 'https://webmail.datacom.co.nz/ews/exchange.asmx'

  # Connection
  CLI = Viewpoint::EWSClient.new endpoint, user, pass
  CLI.ews.server_version ="Exchange2007"
  INBOX = CLI.get_folder :inbox
  INBOX.subscribe( %w{NewMailEvent})
  
  def deal_with_events(events)
    mail = []
    events.each do |e|
      item = INBOX.get_item JsonPath.on(e.item_id.to_json, '$..id').first
      mail << item
    end

    mail.each do |m|
      puts "Subject: #{m.subject} || Message: #{ m.body}"
    end
  end

end
end

# Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de