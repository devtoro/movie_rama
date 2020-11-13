class CreateMovieReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_reactions do |t|
      t.integer :reaction_id, null: false
      t.references :movie, null: false
      t.references :user,
                   foreign_key: { on_delete: :cascade },
                   null: false,
                   index: false

      t.timestamps
    end

    add_index :movie_reactions, %i[movie_id user_id], unique: true
    add_index :movie_reactions, %i[movie_id reaction_id]
  end
end
