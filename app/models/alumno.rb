class Alumno < ActiveRecord::Base
  validates :nombres, presence: true
  validates :rut, rut: true, presence: true, uniqueness: true

end
