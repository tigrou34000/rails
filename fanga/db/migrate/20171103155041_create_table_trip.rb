class CreateTableTrip < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.references :user, foreign_key: true
      t.references :aerodrome_dep, foreign_key: { to_table: :aerodromes }
      t.references :aerodrome_arr, foreign_key: { to_table: :aerodromes }
    end
  end
end
