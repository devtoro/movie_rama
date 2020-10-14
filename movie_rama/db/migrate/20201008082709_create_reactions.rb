class CreateReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :reactions do |t|
      t.string :name, null: false
      t.string :color

      t.timestamps
    end

    add_index :reactions, :name, unique: true
  end
end
