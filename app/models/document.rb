class Document < ActiveRecord::Base
 include Workflow
  workflow do
    state :new do
      event :submit, :transitions_to => :awaiting_review
    end
    state :awaiting_review do
      event :review, :transitions_to => :being_reviewed
    end
    state :being_reviewed do
      event :accept, :transitions_to => :accepted
      event :reject, :transitions_to => :rejected
    end
    state :accepted
    state :rejected
  end

  def submit
    puts 'Document has been submitted'
    puts 'Notify email'
  end

def self.insert_state(state_name)
 # example call = state = Document.insert_state("testState")
 Document.workflow_spec.states[state_name] = Workflow::State.new(state_name, self)
end
def self.insert_event(event_name, previous_state, new_state)
  # example call = Document.insert_event(:test_event, :new, :hi)
  Document.workflow_spec.states[previous_state].events[event_name] = Workflow::Event.new(event_name,  Document.workflow_spec.states[new_state], {})
  define_method(event_name) { puts "Email someone please" }

end

end


