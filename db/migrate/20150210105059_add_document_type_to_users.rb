class AddDocumentTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :document_type, :integer, before: :series
  end
end
