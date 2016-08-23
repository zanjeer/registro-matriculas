class CreateAlumnos < ActiveRecord::Migration
  def change
    create_table :alumnos do |t|
      t.string :nombres
      t.string :materno
      t.string :paterno
      t.string :rut
      t.date :f_nacimiento
      t.integer :telefono
      t.text :domicilio
      t.string :comuna

      t.timestamps
    end
  end
end
