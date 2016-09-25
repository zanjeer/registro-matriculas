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

  def decil
    case ingreso_familiar
    when 0 .. 48750
      "1° Decil"
    when 48751 .. 74969
      "2° Decil"
    when 74970 .. 100709
      "3° Decil"
    when 100710 .. 125558
      "4° Decil"
    when 125559 .. 154166
      "5° Decil"
    when 154167 .. 193104
      "6° Decil"
    when 193105 .. 250663
      "7° Decil"
    when 250664 .. 325743
      "8° Decil"
    when 352744 .. 611728
      "9° Decil"
    when 611729 .. 9999999
      "10° Decil"
    else
      "no definido"
    end
  end
end
