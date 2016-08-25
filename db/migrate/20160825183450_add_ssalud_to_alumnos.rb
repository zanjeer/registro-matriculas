class AddSsaludToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :sistema_salud, :string
  end
end
