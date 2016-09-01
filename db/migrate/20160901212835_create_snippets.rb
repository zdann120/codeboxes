class CreateSnippets < ActiveRecord::Migration[5.0]
  def change
    create_table :snippets do |t|
      t.references :box, foreign_key: true
      t.string :token
      t.string :haiku
      t.string :title
      t.text :code

      t.timestamps
    end
    add_index :snippets, :token, unique: true
    add_index :snippets, :haiku, unique: true
  end
end
