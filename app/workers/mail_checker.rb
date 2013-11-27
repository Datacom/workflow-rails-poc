  class MailChecker
    include Sidekiq::Worker
    include Sidetiq::Schedulable

  #recurrence { secondly }
  recurrence {minutely.second_of_minute(1)}
  def perform(name, count)
    inbox = WorkflowConcept::Application::INBOX
    events = inbox.get_events.select {|e| e.is_a? Viewpoint::EWS::Types::NewMailEvent}

        if events.count > 0
          puts "Event Found"
          WorkflowConcept::Application.deal_with_events(events)
        else
          puts"No Events"
        end
end
end