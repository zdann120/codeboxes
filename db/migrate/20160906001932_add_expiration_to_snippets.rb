class AddExpirationToSnippets < ActiveRecord::Migration[5.0]
  def change
    add_column :snippets, :expires, :boolean, default: false
    add_column :snippets, :expiration, :datetime
  end
end
