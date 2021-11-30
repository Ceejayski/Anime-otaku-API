class AddImageToAnimes < ActiveRecord::Migration[6.1]
  def change
    add_column :animes, :header_image, :string
  end
end
