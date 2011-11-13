class ChangeToStringDocumentInClient < ActiveRecord::Migration
  def up
    change_column :clients, :document, :string
  end

  def down
  end
end
