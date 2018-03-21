class CreateSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :submissions do |t|
      t.string :name
      t.string :email
      t.string :pwd
      t.string :phone

      t.timestamps
    end
  end
end
