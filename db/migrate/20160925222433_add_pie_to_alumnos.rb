class AddPieToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :pie, :boolean
  end
end
