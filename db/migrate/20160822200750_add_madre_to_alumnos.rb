class AddMadreToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :madre_nombre, :string
    add_column :alumnos, :madre_rut, :string
    add_column :alumnos, :madre_ocupacion, :text
    add_column :alumnos, :madre_escolaridad, :string
    add_column :alumnos, :madre_direccion, :text
  end
end
