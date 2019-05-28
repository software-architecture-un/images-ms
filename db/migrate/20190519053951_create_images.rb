class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.integer :imageableid
      t.integer :imageabletype
      t.string :base64

      t.timestamps
    end
  end
end
