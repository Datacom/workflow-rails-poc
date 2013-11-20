class AddWorkFlowStateToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :workflow_state, :string
  end
end
