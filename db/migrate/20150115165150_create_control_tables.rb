class CreateControlTables < ActiveRecord::Migration
  def up
    create_table :allegiances do |t|
      t.string :name

      t.timestamps
    end

    create_table :economies do |t|
      t.string :name

      t.timestamps
    end

    create_table :station_economies do |t|
      t.integer :station_id
      t.integer :economy_id

      t.timestamps
    end

    create_table :population_levels do |t|
      t.string :name

      t.timestamps
    end

    create_table :governments do |t|
      t.string :name

      t.timestamps
    end

    # add field systems.eds_id (int, NULL)
    add_column :systems, :eds_id, :integer, :null => true, after: :id

    # add field systems.x (float, NULL)
    # add field systems.y (float, NULL)
    # add field systems.z (float, NULL)
    add_column :systems, :x, :float, :null => true, after: :eds_id
    add_column :systems, :y, :float, :null => true, after: :eds_id
    add_column :systems, :z, :float, :null => true, after: :eds_id

    # add field systems.allegiance_id (int, NULL)
    add_column :systems, :allegiance_id, :integer, :null => true, after: :id

    # add field systems.government_id (int, NULL)
    add_column :systems, :government_id, :integer, :null => true, after: :allegiance_id

    # add field stations.allegiance_id (int, NULL)
    add_column :stations, :allegiance_id, :integer, :null => true, after: :id

    # add field stations.population_level_id (int, NULL)
    add_column :stations, :population_level_id, :integer, :null => true, after: :allegiance_id

    # add field stations.government_id (int, NULL)
    add_column :stations, :government_id, :integer, :null => true, after: :population_level_id

    # add field stations.has_blackmarket (boolean, NULL)
    add_column :stations, :has_blackmarket, :boolean, :null => true, after: :has_shipyard

    # drop field systems.alliance_id
    remove_column :systems, :alliance_id

    # drop alliances table
    drop_table :alliances
  end

  def down
    create_table :alliances do |t|
      t.string :name

      t.timestamps
    end

    add_column :systems, :alliance_id, :int, :null => true

    remove_column :stations, :has_blackmarket
    remove_column :stations, :government_id
    remove_column :stations, :population_level_id
    remove_column :stations, :allegiance_id

    remove_column :systems, :government_id
    remove_column :systems, :allegiance_id
    remove_column :systems, :x
    remove_column :systems, :y
    remove_column :systems, :z
    remove_column :systems, :eds_id

    drop_table :governments
    drop_table :population_levels
    drop_table :station_economies
    drop_table :economies
    drop_table :allegiances
  end
end
