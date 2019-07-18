# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('#orders-table').DataTable
    'pageLength': 50
    dom: "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" +
          "<'row'<'col-sm-12'tr>>" +
          "<'row'<'col-sm-5'i><'col-sm-7'p>>"
    buttons: [
      'colvis'
    ]

  $('.s2').select2
    theme: 'bootstrap'

  $('#order_boms').on 'cocoon:after-insert', (e, i, o) ->
    $('.s2').select2
      theme: 'bootstrap'
    return
  return
