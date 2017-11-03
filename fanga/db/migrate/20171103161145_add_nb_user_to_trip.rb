class AddNbUserToTrip < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :created_at, :datetime
    add_column :trips, :updated_at, :datetime
    add_column :trips, :nb_passager, :integer
  end
end
