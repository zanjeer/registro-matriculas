class AddReligionToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :religion, :string
  end
end
