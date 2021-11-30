class AddRatingsToAnimes < ActiveRecord::Migration[6.1]
  def change
    add_column :animes, :rating, :integer
  end
end
