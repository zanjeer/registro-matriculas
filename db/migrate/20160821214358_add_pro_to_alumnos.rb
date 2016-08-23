class AddProToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :procedencia, :string
    add_column :alumnos, :cur_repetidos, :string
  end
end
