class AddSubencionToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :subencion, :string
  end
end
