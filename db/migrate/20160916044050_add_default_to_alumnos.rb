class AddDefaultToAlumnos < ActiveRecord::Migration
  def change
    change_column :alumnos, :subsidio_familiar, :boolean, :default => false, :null => false
    change_column :alumnos, :problema_dental, :boolean, :default => false, :null => false
    change_column :alumnos, :problema_dental, :boolean, :default => false, :null => false
    change_column :alumnos, :problema_vision, :boolean, :default => false, :null => false
    change_column :alumnos, :problema_audicion, :boolean, :default => false, :null => false
    change_column :alumnos, :problema_medico, :boolean, :default => false, :null => false
    change_column :alumnos, :problema_aprendizaje, :string, :default => 'false'
    change_column :alumnos, :necesita_alimento, :string, :default => 'false'
    change_column :alumnos, :protec_social, :string, :default => 'false'
    change_column :alumnos, :etnia, :string, :default => 'false'
    change_column :alumnos, :estado, :string, :default => 'Activa'
  end
end
