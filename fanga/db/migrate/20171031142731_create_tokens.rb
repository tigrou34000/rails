class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.references :user
      t.string :token_string
      t.integer :token_type
      t.date :created_date
    end
  end
end
