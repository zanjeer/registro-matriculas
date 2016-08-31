class AddIndexrutToAlumnos < ActiveRecord::Migration
  def change
    add_index :alumnos, :rut
  end
end
