class CreateStyles < ActiveRecord::Migration[7.0]
  def change
    create_table :styles do |t|
      t.string :name
      t.string :text

      t.timestamps
       remove_column :beers, :style
    end
  end
end
