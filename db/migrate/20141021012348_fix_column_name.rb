class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :phone_numbers, :type, :phone_type
  end
end
