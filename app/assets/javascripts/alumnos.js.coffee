# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# funciona after turbolinks
$(document).on 'turbolinks:load', ->
  # formato RUT y muestra si hay errores
  # alumno/_form -> tab ALUMNO
  $('#alumno_rut').Rut
    on_error: ->
      $('#error_rut').addClass('has-error').removeClass('has-success')
      return
    on_success: ->
      $('#error_rut').addClass('has-success').removeClass('has-error')
      return

  $('#alumno_madre_rut').Rut
    on_error: ->
      $('#error_rut_madre').addClass('has-error').removeClass('has-success')
      return
    on_success: ->
      $('#error_rut_madre').addClass('has-success').removeClass('has-error')
      return

  $('#alumno_padre_rut').Rut
    on_error: ->
      $('#error_rut_padre').addClass('has-error').removeClass('has-success')
      return
    on_success: ->
      $('#error_rut_padre').addClass('has-success').removeClass('has-error')
      return

  $('#alumno_apoderado_rut').Rut
    on_error: ->
      $('#error_rut_apo').addClass('has-error').removeClass('has-success')
      return
    on_success: ->
      $('#error_rut_apo').addClass('has-success').removeClass('has-error')
      return
  # TRUE = vive_con_OTRO
  # alumno/_form -> tab FAMILIA
  es_otro = (valor) ->
    if valor != 'Abuelos' and valor != 'Madre' and valor != 'Padre' and
       valor != 'Padres' and valor != '' #solo queda una opcion
      return true
    return false

  $('#input_otro').hide()
  # mostrar input (otro) si esta seleccionado, solo pasa al inicio
  # alumno/_form -> tab FAMILIA
  if es_otro($('#input_otro').val())
    $('#input_otro').prop('disabled', false).show()
    $('#alumno_vive_con_otro').prop("checked", true)
  else
    $('#input_otro').prop('disabled', true).hide()

  # on Change mostrar o ocultar input(otro)
  # alumno/_form -> tab FAMILIA
  $('input[type=radio][name="alumno[vive_con]"]').change ->
    if es_otro(@value)
      $('#input_otro').prop('disabled', false).show()
    else
      $('#input_otro').prop('disabled', true).hide()

  # agregar .val() del input al valor del check_box.value
  # alumno/_form -> tab FAMILIA
  $('#input_otro').change ->
    $('#alumno_vive_con_otro').val(@value)
    console.log(@value)
  return

# $('#buscar_id').bind 'railsAutocomplete.select', (event, data) ->
#   ### Do something here ###
#   alert data.item.id
#   return
