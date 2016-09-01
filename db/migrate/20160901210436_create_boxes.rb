class CreateBoxes < ActiveRecord::Migration[5.0]
  def change
    create_table :boxes do |t|
      t.string :token
      t.references :user, foreign_key: true
      t.string :title
      t.integer :privacy_level
      t.string :box_language

      t.timestamps
    end
    add_index :boxes, :token, unique: true
  end
end
