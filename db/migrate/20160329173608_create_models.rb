class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.references :organization, index: true, foreign_key: true, null: false
      t.string :name, null: false
      t.string :slug

      t.timestamps
    end

    add_index :models, :slug, unique: true
    add_index :models, :name, unique: true
  end
end
