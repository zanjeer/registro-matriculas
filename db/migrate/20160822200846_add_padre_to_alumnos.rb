class AddPadreToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :padre_nombre, :string
    add_column :alumnos, :padre_rut, :string
    add_column :alumnos, :padre_ocupacion, :text
    add_column :alumnos, :padre_escolaridad, :string
    add_column :alumnos, :padre_direccion, :text
  end
end
