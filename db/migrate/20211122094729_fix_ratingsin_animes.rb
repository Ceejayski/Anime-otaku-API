class FixRatingsinAnimes < ActiveRecord::Migration[6.1]
  def change
    change_column :animes, :rating, :float
  end
end
