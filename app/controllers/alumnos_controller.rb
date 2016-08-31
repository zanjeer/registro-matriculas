class AlumnosController < ApplicationController
  before_action :set_alumno, only: [:show, :edit, :update, :destroy]
  autocomplete :alumno, :nombres

  # tipo_ense 10 = parbularia, 110= basica
  def xml_file
    if params[:file]
      uploaded_file = params[:file]
      file_content = uploaded_file.read
      # Nokogiri.XML(file_content, nil, 'UTF-8')
      doc  = Nokogiri::XML(file_content)
      # funciona
      # se recore por tipo de enseñanza
      doc.css("tipo_ensenanza").each do |nodo_ens|
        # pre basica 4 = pre Kinder /// 5 = Kinder
        if nodo_ens['codigo'] == '10'
          # se recorren los cursos
          nodo_ens.css("curso").each do |nodo_curso|
            if nodo_curso['grado'] == '4'
              @grado = 'Pre-Kinder'
            elsif nodo_curso['grado'] == '5'
              @grado = 'Kinder'
            end
            @curso = "#{@grado} #{nodo_curso['letra']}"

            # se recorre la lista de alumnos del curso
            nodo_curso.css("alumno").each do |nodo_alumno|
              @genero = "Masculino"
              if nodo_alumno['genero'].downcase == "f"
                @genero = "Femenino"
              end
              @rut = "#{nodo_alumno['run']}-#{nodo_alumno['digito_ve']}"


              @alum = Alumno.find_by "rut = ?", @rut

              if( @alum )
                # actualizar info del alumno
                @alum.update_attributes(
                  nombres: nodo_alumno['nombres'],
                  paterno: nodo_alumno['ape_paterno'],
                  materno: nodo_alumno['ape_materno'],
                  domicilio: nodo_alumno['direccion'],
                  rut: @rut,
                  genero: @genero,
                  curso: @curso,
                  telefono: nodo_alumno['telefono'],
                  fecha_incorp: nodo_alumno['fecha_incorporacion_curso'],
                  fecha_retiro: nodo_alumno['fecha_retiro'],
                  f_nacimiento: nodo_alumno['fecha_nacimiento'],
                )
                @alum.save
              else
                # si no  alum se crea el alumno nuevo
                Alumno.create(
                  nombres: "#{nodo_alumno['nombres']}",
                  paterno: nodo_alumno['ape_paterno'],
                  materno: nodo_alumno['ape_materno'],
                  domicilio: nodo_alumno['direccion'],
                  rut: @rut,
                  genero: @genero,
                  curso: @curso,
                  telefono: nodo_alumno['telefono'],
                  fecha_incorp: nodo_alumno['fecha_incorporacion_curso'],
                  fecha_retiro: nodo_alumno['fecha_retiro'],
                  f_nacimiento: nodo_alumno['fecha_nacimiento'],
                  madre_rut: "#{nodo_alumno['run']}-#{nodo_alumno['digito_ve']}",
                  padre_rut: "#{nodo_alumno['run']}-#{nodo_alumno['digito_ve']}",
                  apoderado_rut: "#{nodo_alumno['run']}-#{nodo_alumno['digito_ve']}",
                )
              end

            end

          end
        elsif nodo_ens["codigo"] == '110'
          # se recorren los cursos
          nodo_ens.css("curso").each do |nodo_curso|
            @curso = "#{nodo_curso['grado']}° #{nodo_curso['letra']}"
            # se recorre la lista de alumnos del curso
            nodo_curso.css("alumno").each do |nodo_alumno|
              @genero = "Masculino"
              if nodo_alumno['genero'].downcase == "f"
                @genero = "Femenino"
              end

              @rut = "#{nodo_alumno['run']}-#{nodo_alumno['digito_ve']}"

              @alum = Alumno.find_by "rut = ?", @rut
              if( @alum )
                @alum.update_attributes(
                  nombres: "#{nodo_alumno['nombres']}",
                  paterno: nodo_alumno['ape_paterno'],
                  materno: nodo_alumno['ape_materno'],
                  domicilio: nodo_alumno['direccion'],
                  rut: @rut,
                  genero: @genero,
                  curso: @curso,
                  telefono: nodo_alumno['telefono'],
                  fecha_incorp: nodo_alumno['fecha_incorporacion_curso'],
                  fecha_retiro: nodo_alumno['fecha_retiro'],
                  f_nacimiento: nodo_alumno['fecha_nacimiento'],
                )
                @alum.save
              else
                Alumno.create(
                  nombres: "#{nodo_alumno['nombres']}",
                  paterno: nodo_alumno['ape_paterno'],
                  materno: nodo_alumno['ape_materno'],
                  domicilio: nodo_alumno['direccion'],
                  rut: @rut,
                  genero: @genero,
                  curso: @curso,
                  telefono: nodo_alumno['telefono'],
                  fecha_incorp: nodo_alumno['fecha_incorporacion_curso'],
                  fecha_retiro: nodo_alumno['fecha_retiro'],
                  f_nacimiento: nodo_alumno['fecha_nacimiento'],
                  madre_rut: "#{nodo_alumno['run']}-#{nodo_alumno['digito_ve']}",
                  padre_rut: "#{nodo_alumno['run']}-#{nodo_alumno['digito_ve']}",
                  apoderado_rut: "#{nodo_alumno['run']}-#{nodo_alumno['digito_ve']}",
                )
              end
            end

          end
        end
      end

      # funciona
      # @pre_basica.css("curso").each do |node|
      #   @a = "#{node['grado']}° #{node['letra']}"


      # end
      # render xml: @colegio
      # @doc.xpath("//curso//alumno").attr("nombres")
    else
      redirect_to alumnos_url, notice: 'Seleccione un archivo'
    end

  end


  # GET /alumnos
  # GET /alumnos.json
  def index
    @alumnos = Alumno.all.order('id')
    if params[:search]
      @alumnos = Alumno.nombre_like("%#{params[:search].upcase}%",
                                  "%#{params[:search].upcase}%",
                                  "%#{params[:search].upcase}%",
                                  "%#{params[:search].upcase}%",
                                  "%#{params[:search].upcase}%").order('nombres')


    else
    end
  end

  def autocomplete_alumno_nombres
    @result = Alumno.nombre_like("%#{params[:term].upcase}%",
                                "%#{params[:term].upcase}%",
                                "%#{params[:term].upcase}%",
                                "%#{params[:term].upcase}%",
                                "%#{params[:term].upcase}%").order('nombres')

    render json: @result.map { |alumno| {alumno: alumno.id,
                              label: "#{alumno.rut} - #{alumno.nombre_completo} - #{alumno.curso}",
                              value: alumno.rut,
                              nombre: alumno.nombre_completo, rut: alumno.rut,
                              fono: alumno.telefono,
                            }}
  end

  # GET /alumnos/1
  # GET /alumnos/1.json
  def show
  end

  # GET /alumnos/new
  def new
    @alumno = Alumno.new
  end

  # GET /alumnos/1/edit
  def edit
  end

  # POST /alumnos
  # POST /alumnos.json
  def create
    @alumno = Alumno.new(alumno_params)

    respond_to do |format|
      if @alumno.save
        format.html { redirect_to @alumno, notice: 'Alumno was successfully created.' }
        format.json { render :show, status: :created, location: @alumno }
      else
        format.html { render :new }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alumnos/1
  # PATCH/PUT /alumnos/1.json
  def update
    respond_to do |format|
      if @alumno.update(alumno_params)
        format.html { redirect_to @alumno, notice: 'Alumno was successfully updated.' }
        format.json { render :show, status: :ok, location: @alumno }
      else
        format.html { render :edit }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alumnos/1
  # DELETE /alumnos/1.json
  def destroy
    @alumno.destroy
    respond_to do |format|
      format.html { redirect_to alumnos_url, notice: 'Alumno was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alumno
      @alumno = Alumno.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alumno_params
      params.require(:alumno).permit(:nombres, :materno, :paterno, :rut, :genero,
      :f_nacimiento, :telefono, :domicilio, :comuna, :procedencia, :cur_repetidos,
      :problema_audicion, :problema_dental, :problema_vision, :problema_medico,
      :problema_descripcion, :alergia_medicamento, :vive_con, :posicion_familia,
      :numero_hermanos, :numero_personas, :tipo_vivienda, :madre_rut, :madre_nombre,
      :madre_ocupacion, :madre_direccion, :madre_escolaridad, :padre_rut, :padre_nombre,
      :padre_ocupacion, :padre_direccion, :padre_escolaridad, :apoderado_rut, :apoderado_nombre,
      :apoderado_ocupacion, :apoderado_direccion, :apoderado_escolaridad, :subsidio_familiar,
      :subencion, :sistema_salud, :curso, :fecha_incorp, :problema_aprendizaje,
      :fecha_retiro, :causa_retiro, :ingreso_familiar, :necesita_alimento, :protec_social,
      :estado, :numero_matricula
      )
    end
end
