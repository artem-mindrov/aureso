class CreateModelTypes < ActiveRecord::Migration
  def change
    create_table :model_types do |t|
      t.references :model, index: true, foreign_key: true, null: false
      t.string :name, index: true, null: false
      t.string :model_type_code
      t.string :slug
      t.decimal :base_price, null: false

      t.timestamps
    end

    add_index :model_types, :slug, unique: true
  end
end
