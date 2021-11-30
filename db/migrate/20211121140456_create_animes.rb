class CreateAnimes < ActiveRecord::Migration[6.1]
  def change
    create_table :animes do |t|
      t.string :name
      t.string :description
      t.string :slug

      t.timestamps
    end
    add_index :animes, :slug, unique: true
  end
end
