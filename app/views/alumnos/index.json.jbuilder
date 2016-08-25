json.array!(@alumnos) do |alumno|
  json.extract! alumno, :id, :nombres
  json.url alumno_url(alumno, format: :json)
end
