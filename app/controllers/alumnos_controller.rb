class AlumnosController < ApplicationController
  before_action :set_alumno, only: [:show, :edit, :update, :destroy]
  autocomplete :alumno, :nombres
  # subir matricula del sige con archivo xml
  def xml_file
    if params[:file]
      uploaded_file = params[:file]
      file_content = uploaded_file.read
      doc  = Nokogiri::XML(file_content) # (content , nil, 'UTF-8')
      # tipo_enseñanza: 10 = parbularia, 110 = basica
      doc.css("tipo_ensenanza").each do |nodo_ens|
        # si es parbularia
        if nodo_ens['codigo'] == '10'
          # se recorren los cursos
          nodo_ens.css("curso").each do |nodo_curso|
            if nodo_curso['grado'] == '4'
              @curso = "Pre-Kinder #{nodo_curso['letra'].strip}"
            elsif nodo_curso['grado'] == '5'
              @curso = "Kinder #{nodo_curso['letra'].strip}"
            end
            # se recorre la lista de alumnos del curso
            # si el alumno existe de actualiza
            nodo_curso.css("alumno").each do |nodo_alumno|
              matricular_alumno(nodo_alumno,@curso)
            end
          end
        elsif nodo_ens["codigo"] == '110'
          nodo_ens.css("curso").each do |nodo_curso|
            # se arma el curso ej: 1 A, 2 B
            @curso = "#{nodo_curso['grado'].strip}° #{nodo_curso['letra'].strip}"
            # se recorre la lista de alumnos del curso
            nodo_curso.css("alumno").each do |nodo_alumno|
              matricular_alumno(nodo_alumno,@curso)
            end
          end
        end
      end
      # devolver al inicio en caso  de exito
      redirect_to alumnos_url, notice: 'Matriculas actualizadas'
    else
      # al inicio con mensaje de error
      redirect_to alumnos_url, notice: 'Seleccione un archivo'
    end
  end

  # GET /alumnos
  # GET /alumnos.json
  def index
    # path  a la busqueda realizada
    session[:return_to] = request.fullpath

    @alumnos = Alumno.all.order('id')
    if params[:input_buscar]
      @alumnos = Alumno.nombre_like("%#{params[:input_buscar].gsub(' ', '%').upcase}%").order('nombres')
    else
    end
  end

  def autocomplete_alumno_nombres
    # gsub remplasa ' ' por % para lograr una mejor busqueda
    result = Alumno.nombre_like("%#{params[:term].gsub(' ', '%').upcase}%").order('nombres')
    render json: result.map { |alumno| {alumno: alumno.id,
                              label: "#{alumno.rut} - #{alumno.nombre_completo} - #{alumno.curso}",
                              value: alumno.rut,
                            }}
  end

  # GET /alumnos/1
  # GET /alumnos/1.json
  def show
  end

  # reportes
  def reportes
    case params[:tipo]
    when "por_curso"
      @titulo = "Reporte Matriculas por Nombre"
      @template = "por_curso"
      @lista = Alumno.all
    when "genero"
      @genero = Alumno.group(:genero).count
      @lista = Alumno.all
      @titulo = "Alumnos por Genero"
      @template = "matri_por_genero"
      @total = Alumno.all.count
    when "prioritario_genero"
      @tipo = "Prioritario"
      @lista = Alumno.where(subencion: @tipo)
      @titulo = "Alumnos Prioritarios por Genero"
      @template = "subencion_por_genero"
      @total = Alumno.where(subencion: @tipo).count
    when "preferente_genero"
      @tipo = "Preferente"
      @lista = Alumno.where(subencion: @tipo)
      @titulo = "Alumnos Preferente por Genero"
      @template = "subencion_por_genero"
      @total = Alumno.where(subencion: @tipo).count
    when "numero_personas"
      @titulo = "N° de personas en el hogar"
      @template = "numero_personas"
      @lista = Alumno.where("numero_personas IS NOT NULL")
    when "lista_etnia"
      @titulo = "Alumnos de descendencia indigena"
      @template = "etnia"
      @lista = Alumno.where("etnia != 'No'")
      @total = Alumno.all.count
    when "tuicion_vivienda"
      @titulo = "Tuicion Vivienda"
      @template = "tuicion_vivienda"
      @lista = Alumno.where("tipo_vivienda IS NOT NULL AND tipo_vivienda != ?","")
    when "religion"
      @titulo = "Preferencia de Religion"
      @template = "religion"
      @lista = Alumno.where("religion IS NOT NULL AND religion != ?","")
    when "pre_colegio"
      @titulo = "Colegios de Procedencia"
      @template = "pre_colegio"
      @lista = Alumno.where("procedencia IS NOT NULL AND procedencia != ?","")
    when "edu_padres"
      @titulo = "Escolaridad Padres"
      @template = "edu_padres"
      @lista_padre = Alumno.where("padre_escolaridad IS NOT NULL AND padre_escolaridad != ?","")
      @lista_madre = Alumno.where("madre_escolaridad IS NOT NULL AND madre_escolaridad != ?","")
    when "vive_con"
      @titulo = "Personas con quien Vive el Alumno"
      @template = "vive_con"
      @lista = Alumno.where("vive_con IS NOT NULL")
    when "necesita_alimento"
      @titulo = "Alumnos que necesitan Alimentacion"
      @template = "necesita_alimento"
      @lista = Alumno.where("necesita_alimento IS NOT NULL")
    when "subsidio_familiar"
      @titulo = "Alumnos con Subsidio Familiar"
      @template = "subsidio_familiar"
      @lista = Alumno.where("subsidio_familiar IS NOT NULL")
    when "nivel_socio_eco"
      @titulo = "Nivel SocioEconomico Alumnos"
      @template = "nivel_socio_eco"
      @deciles = {
        "1° Decil" => {"min"=> '0', "max" => '48750'},
        "2° Decil" => {"min"=> '48751', "max" => '74969'},
        "3° Decil" => {"min"=> '74970', "max" => '100709'},
        "4° Decil" => {"min"=> '100710', "max" => '125558'},
        "5° Decil" => {"min"=> '125559', "max" => '154166'},
        "6° Decil" => {"min"=> '154167', "max" => '193104'},
        "7° Decil" => {"min"=> '193105', "max" => '250663'},
        "8° Decil" => {"min"=> '250664', "max" => '325743'},
        "9° Decil" => {"min"=> '352744', "max" => '611728'},
        "10° Decil" => {"min"=> '611729', "max" => '9999999'},
      }
      @lista = Alumno.where("ingreso_familiar IS NOT NULL")
    when "nivel_socio_eco_curso"
      @titulo = "Nivel SocioEconomico Alumnos"
      @template = "nivel_socio_eco_curso"
      @lista = Alumno.all
    when "pie"
      @titulo = "Alumnos en Programa PIE"
      @template = "pie"
      @lista = Alumno.where("pie IS NOT NULL")
    when "aprendizaje"
      @titulo = "Alumnos con Problema de aprendizaje"
      @template = "aprendizaje"
      @lista = Alumno.where("problema_aprendizaje IS NOT NULL")
    when "ocupaciones"
      @titulo = "Lista Ocupaciones"
      @template = "ocupaciones"
      @lista_padre = Alumno.where("padre_ocupacion IS NOT NULL AND padre_ocupacion != ?","")
      @lista_madre = Alumno.where("madre_ocupacion IS NOT NULL AND madre_ocupacion != ?", "")
    else
    end

    respond_to do |format|
      format.pdf do
        render pdf: "reporte",
               template: "reportes/#{@template}",
               javascript_delay: 1000
      end
    end
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
        format.html { redirect_to @alumno, notice: 'Alumno Guardado con Exito.' }
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
        format.html { redirect_to @alumno, notice: 'Alumno Guardado con Exito.' }
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
      format.html { redirect_to alumnos_url, notice: 'Alumno borrado con Exito.' }
      format.json { head :no_content }
    end
  end

  private
    # recive el nodo_alumno con todos los datos del archivo xml
    # y el curso al que pertenece
    def matricular_alumno(alumno, curso)
      genero = "Masculino"
      if alumno['genero'].downcase == "f"
        genero = "Femenino"
      end
      etnia = "No"
      if alumno['codigo_etnia'] != "0"
        etnia = "Si"
      end

      # formato: 12345678-k
      rut = "#{alumno['run']}-#{alumno['digito_ve']}"
      alum = Alumno.find_by "rut = ?", rut
      # si se encuentra el alumno, se actualiza
      if( alum )
        # actualizar info del alumno
        alum.update_attributes(
          nombres: alumno['nombres'],
          paterno: alumno['ape_paterno'],
          materno: alumno['ape_materno'],
          domicilio: alumno['direccion'],
          rut: rut,
          etnia: etnia,
          genero: genero,
          curso: curso,
          telefono: alumno['telefono'],
          fecha_incorp: alumno['fecha_incorporacion_curso'],
          fecha_retiro: alumno['fecha_retiro'],
          f_nacimiento: alumno['fecha_nacimiento'],
        )
        alum.save
      else
        # si no, se crea un alumno nuevo
        # los rut del apoderado, madre, padre
        Alumno.create(
          nombres: "#{alumno['nombres']}",
          paterno: alumno['ape_paterno'],
          materno: alumno['ape_materno'],
          domicilio: alumno['direccion'],
          rut: rut,
          etnia: etnia,
          genero: genero,
          curso: curso,
          telefono: alumno['telefono'],
          fecha_incorp: alumno['fecha_incorporacion_curso'],
          fecha_retiro: alumno['fecha_retiro'],
          f_nacimiento: alumno['fecha_nacimiento'],
          madre_rut: rut,
          padre_rut: rut,
          apoderado_rut: rut,
        )
      end
    end


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
      :estado, :numero_matricula, :etnia, :religion, :pie
      )
    end
end
