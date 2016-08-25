class AddSubsidioToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :subsidio_familiar, :boolean
  end
end
