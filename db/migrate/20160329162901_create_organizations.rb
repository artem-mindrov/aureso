class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, index: true, null: false
      t.string :public_name, null: false
      t.integer :type, null: false, default: 0
      t.integer :pricing_policy, null: false, default: 0

      t.timestamps
    end
  end
end
