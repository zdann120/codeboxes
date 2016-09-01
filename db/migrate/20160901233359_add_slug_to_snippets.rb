class AddSlugToSnippets < ActiveRecord::Migration[5.0]
  def change
    add_column :snippets, :slug, :string
    add_index :snippets, :slug, unique: true
  end
end
