class RemoveUniquenessFromTitleInNews < ActiveRecord::Migration[6.0]
  def change
    remove_index :news, :title
    add_index :news, :title, unique: false
  end
end
