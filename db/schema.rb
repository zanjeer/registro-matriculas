# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160831203402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alumnos", force: true do |t|
    t.string   "nombres"
    t.string   "materno"
    t.string   "paterno"
    t.string   "rut"
    t.date     "f_nacimiento"
    t.integer  "telefono"
    t.text     "domicilio"
    t.string   "comuna"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "procedencia"
    t.string   "cur_repetidos"
    t.boolean  "problema_audicion"
    t.boolean  "problema_dental"
    t.boolean  "problema_vision"
    t.boolean  "problema_medico"
    t.text     "problema_descripcion"
    t.text     "alergia_medicamento"
    t.string   "tipo_vivienda"
    t.integer  "numero_personas"
    t.integer  "numero_hermanos"
    t.integer  "posicion_familia"
    t.string   "vive_con"
    t.string   "madre_nombre"
    t.string   "madre_rut"
    t.text     "madre_ocupacion"
    t.string   "madre_escolaridad"
    t.text     "madre_direccion"
    t.string   "padre_nombre"
    t.string   "padre_rut"
    t.text     "padre_ocupacion"
    t.string   "padre_escolaridad"
    t.text     "padre_direccion"
    t.string   "apoderado_nombre"
    t.string   "apoderado_rut"
    t.text     "apoderado_ocupacion"
    t.string   "apoderado_escolaridad"
    t.text     "apoderado_direccion"
    t.boolean  "subsidio_familiar"
    t.string   "subencion"
    t.string   "sistema_salud"
    t.string   "genero"
    t.string   "curso"
    t.date     "fecha_incorp"
    t.string   "problema_aprendizaje"
    t.date     "fecha_retiro"
    t.text     "causa_retiro"
    t.integer  "ingreso_familiar"
    t.string   "necesita_alimento"
    t.string   "protec_social"
    t.string   "estado"
    t.integer  "numero_matricula"
  end

  add_index "alumnos", ["rut"], name: "index_alumnos_on_rut", using: :btree

  create_table "comments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
