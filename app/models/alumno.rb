class Alumno < ActiveRecord::Base
  validates :nombres, :materno, :paterno,  presence: true
  validates :rut, rut: true, presence: true, uniqueness: true
  validates :madre_rut, :padre_rut, :apoderado_rut, rut: true

  scope :nombre_like, -> (nombres, paterno, materno, rut) {
                    where("nombres LIKE ? OR paterno LIKE ? OR materno LIKE ? OR rut LIKE ?",
                    nombres, paterno, materno, rut)}

  def nombre_completo
   "#{nombres.upcase}  #{paterno.upcase} #{materno.upcase}"
  end
end
