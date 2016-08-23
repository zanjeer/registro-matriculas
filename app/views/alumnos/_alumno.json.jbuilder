json.extract! alumno, :id, :nombres, :materno, :paterno, :rut, :f_nacimiento, :telefono, :domicilio, :comuna, :created_at, :updated_at
json.url alumno_url(alumno, format: :json)