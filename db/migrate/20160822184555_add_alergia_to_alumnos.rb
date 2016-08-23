class AddAlergiaToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :alergia_medicamento, :text
  end
end
