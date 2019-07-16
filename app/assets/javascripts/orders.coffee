# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('#orders-table').DataTable
    'pageLength': 50

  $('.s2').select2
    theme: 'bootstrap'

  $('#order_boms').on 'cocoon:after-insert', (e, i, o) ->
    $('.s2').select2
      theme: 'bootstrap'
    return
  return
