class FixDescriptiontoAnimes < ActiveRecord::Migration[6.1]
  def change
    change_column :animes, :description, :text
  end
end
