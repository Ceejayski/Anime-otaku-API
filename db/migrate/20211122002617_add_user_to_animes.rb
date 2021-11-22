class AddUserToAnimes < ActiveRecord::Migration[6.1]
  def change
    add_reference :animes, :user, null: false, foreign_key: true
  end
end
