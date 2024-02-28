class RenameMessColumnToDirectMessages < ActiveRecord::Migration[6.1]
  def change
    rename_column :direct_messages, :mess, :message
  end
end
