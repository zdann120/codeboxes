class AddLanguageToSnippets < ActiveRecord::Migration[5.0]
  def change
    add_column :snippets, :language, :string
  end
end
