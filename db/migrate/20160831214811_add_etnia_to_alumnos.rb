class AddEtniaToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :etnia, :string
  end
end
