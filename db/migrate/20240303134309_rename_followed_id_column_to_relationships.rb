class RenameFollowedIdColumnToRelationships < ActiveRecord::Migration[6.1]
  def change
    rename_column :relationships, :followee_id, :followed_id
  end
end
