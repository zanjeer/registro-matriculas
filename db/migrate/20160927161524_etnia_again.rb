class EtniaAgain < ActiveRecord::Migration
  def change
    remove_column :alumnos, :etnia, :boolean, :default => false, :null => false

    add_column :alumnos, :etnia, :string
  end
end
