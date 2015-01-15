class CreateControlTables < ActiveRecord::Migration
  def change
    create_table :allegiances do |t|
      t.string :name

      t.timestamps
    end

    create_table :economies do |t|
      t.string :name

      t.timestamps
    end

    create_table :station_economies do |t|
      t.int :station_id
      t.int :economy_id

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
    add_column :systems, :allegiance_id, :int, :null => true, after: :id

    # add field systems.government_id (int, NULL)
    add_column :systems, :government_id, :int, :null => true, after: :allegiance_id

    # add field stations.allegiance_id (int, NULL)
    add_column :stations, :allegiance_id, :int, :null => true, after: :id

    # add field stations.population_level_id (int, NULL)
    add_column :stations, :population_level_id, :int, :null => true, after: :allegiance_id

    # add field stations.government_id (int, NULL)
    add_column :stations, :government_id, :int, :null => true, after: :population_level_id

    # add field stations.has_blackmarket (boolean, NULL)
    add_column :stations, :has_blackmarket, :boolean, :null => true, after: :has_shipyard

    # drop field systems.alliance_id
    remove_column :systems, :alliance_id

    # drop alliances table
    drop_table :alliances

    # foreign keys
    add_foreign_key :station_economies, :stations, :column => :station_id, :name => 'station_economies_stations_fk'
    add_foreign_key :station_economies, :economies, :column => :economy_id, :name => 'station_economies_economies_fk'

    add_foreign_key :systems, :allegiances, :column => :allegiance_id, :name => 'systems_allegiances_fk'
    add_foreign_key :systems, :governments, :column => :government_id, :name => 'systems_governments_fk'

    add_foreign_key :stations, :allegiances, :column => :allegiance_id, :name => 'stations_allegiances_fk'
    add_foreign_key :stations, :population_levels, :column => :population_level_id, :name => 'stations_population_levels_fk'
    add_foreign_key :stations, :governments, :column => :government_id, :name => 'stations_governments_fk'

  end
end
