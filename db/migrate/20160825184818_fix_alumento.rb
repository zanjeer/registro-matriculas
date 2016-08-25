class FixAlumento < ActiveRecord::Migration
  def change
    rename_column :alumnos, :necesita_alumento, :necesita_alimento
  end
end
