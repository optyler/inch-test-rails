class CreateObjectHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :object_histories do |t|
      
      t.integer :reference
      t.string :key
      t.string :value

      t.references :object, polymorphic: true, index: true

      t.timestamps
    end
  end
end