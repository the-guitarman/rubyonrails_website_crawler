class AddTitleToUrl < ActiveRecord::Migration[6.0]
  def change
    add_column :urls, :title, :string
  end
end
