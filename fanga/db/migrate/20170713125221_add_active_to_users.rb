class AddActiveToUsers < ActiveRecord::Migration[5.2]

  def change


    add_column :users, :activate_account, :boolean
    add_column :users, :surname, :string
    add_column :users, :nickname, :string
    add_column :users, :dob, :date
  end

end
