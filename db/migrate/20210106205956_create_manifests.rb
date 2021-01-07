class CreateManifests < ActiveRecord::Migration[6.1]
  def change
    create_table :manifests do |t|
      t.string :name
      t.string :react_version
      t.string :react_dom_version
      t.string :fluent_version

      t.timestamps
    end
  end
end
