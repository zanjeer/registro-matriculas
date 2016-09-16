class Alumno < ActiveRecord::Base
  validates :nombres, :materno, :paterno,  presence: true
  validates :rut, rut: true, presence: true, uniqueness: true
  validates :madre_rut, :padre_rut, :apoderado_rut, rut: true

  scope :nombre_like, -> (query) {
                    where("CONCAT_WS(' ', nombres, paterno, materno, curso) LIKE :s OR
                          rut LIKE :s ",s: "%#{query}%" )}

  def nombre_completo
   "#{nombres.upcase}  #{paterno.upcase} #{materno.upcase}"
  end

  def nombre_completo_formal
    "#{paterno.upcase} #{materno.upcase} #{nombres.upcase}"
  end
end
