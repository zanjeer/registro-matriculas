class ChangeStringToBoolean < ActiveRecord::Migration
  def change
    remove_column :alumnos, :necesita_alimento, :string
    remove_column :alumnos, :protec_social, :string
    remove_column :alumnos, :etnia, :string
    remove_column :alumnos, :problema_aprendizaje, :string

    add_column :alumnos, :necesita_alimento, :boolean, :default => false, :null => false
    add_column :alumnos, :protec_social, :boolean, :default => false, :null => false
    add_column :alumnos, :etnia, :boolean, :default => false, :null => false
    add_column :alumnos, :problema_aprendizaje, :boolean, :default => false, :null => false
  end
end
