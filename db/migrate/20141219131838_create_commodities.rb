class CreateCommodities < ActiveRecord::Migration

	# possible datatypes
	# :binary
	# :boolean
	# :date
	# :datetime
	# :decimal
	# :float
	# :integer
	# :primary_key
	# :references
	# :string
	# :text
	# :time
	# :timestamp

  def up
  	create_table :commodity_types do |t|
  		t.string :name
  		t.integer :order_num

  		t.timestamps
  	end

    create_table :commodities do |t|
      t.integer :commodity_type_id
      t.string :name
      t.integer :galactic_average_price

      t.timestamps
    end

    create_table :station_types do |t|
      t.string :name
      t.boolean :has_small_dock
      t.boolean :has_medium_dock
      t.boolean :has_large_dock

      t.timestamps
    end

    create_table :alliances do |t|
      t.string :name

      t.timestamps
    end

    create_table :systems do |t|
      t.string :name
      t.integer :alliance_id

      t.timestamps
    end

    create_table :stations do |t|
      t.integer :system_id
      t.integer :station_type_id
      t.string :name
      t.boolean :has_commodities
      t.boolean :has_refuel
      t.boolean :has_repair
      t.boolean :has_re_arm
      t.boolean :has_outfitting
      t.boolean :has_shipyard

      t.timestamps
    end

    create_table :station_commodities do |t|
      t.integer :station_id
      t.integer :commodity_id
      t.string :demanded_or_supplied
      t.string :demand_or_supply_level
      t.integer :buy_or_sell_price

      t.timestamps
    end
  end

  def down
  	drop_table :station_commodities
  	drop_table :stations
  	drop_table :systems
  	drop_table :alliances
  	drop_table :station_types
  	drop_table :commodities
  	drop_table :commodity_types
  end
end
