class Alumno < ActiveRecord::Base
  validates :nombres, :materno, :paterno,  presence: true
  validates :rut, rut: true, presence: true, uniqueness: true
  validates :madre_rut, :padre_rut, :apoderado_rut, rut: true

  scope :nombre_like, -> (nombres, paterno, materno, rut, curso) {
                    where("upper(nombres) LIKE ? OR upper(paterno) LIKE ? OR upper(materno) LIKE ? OR rut LIKE ? OR upper(curso) LIKE ?",
                    nombres, paterno, materno, rut, curso)}

  def nombre_completo
   "#{nombres.upcase}  #{paterno.upcase} #{materno.upcase}"
  end
end
