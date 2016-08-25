class AddGeneroToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :genero, :string
    add_column :alumnos, :curso, :string
    add_column :alumnos, :fecha_incorp, :date
    add_column :alumnos, :problema_aprendizaje, :string
    add_column :alumnos, :fecha_retiro, :date
    add_column :alumnos, :causa_retiro, :text
    add_column :alumnos, :ingreso_familiar, :integer
    add_column :alumnos, :necesita_alumento, :string
    add_column :alumnos, :protec_social, :string
  end
end
