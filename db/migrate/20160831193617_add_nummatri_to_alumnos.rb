class AddNummatriToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :estado, :string
    add_column :alumnos, :numero_matricula, :integer
  end
end
