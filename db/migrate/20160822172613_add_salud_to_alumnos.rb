class AddSaludToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :problema_audicion, :boolean
    add_column :alumnos, :problema_dental, :boolean
    add_column :alumnos, :problema_vision, :boolean
    add_column :alumnos, :problema_medico, :boolean
    add_column :alumnos, :problema_descripcion, :text
  end
end
