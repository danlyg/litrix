class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :country
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
