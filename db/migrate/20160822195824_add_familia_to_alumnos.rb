class AddFamiliaToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :tipo_vivienda, :string
    add_column :alumnos, :numero_personas, :integer
    add_column :alumnos, :numero_hermanos, :integer
    add_column :alumnos, :posicion_familia, :integer
    add_column :alumnos, :vive_con, :string
  end
end
