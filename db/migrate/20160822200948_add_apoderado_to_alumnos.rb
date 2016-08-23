class AddApoderadoToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :apoderado_nombre, :string
    add_column :alumnos, :apoderado_rut, :string
    add_column :alumnos, :apoderado_ocupacion, :text
    add_column :alumnos, :apoderado_escolaridad, :string
    add_column :alumnos, :apoderado_direccion, :text
  end
end
