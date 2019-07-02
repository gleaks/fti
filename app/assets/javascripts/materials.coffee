# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  table = $('#material-table').DataTable(
    'paging': false
    'ordering': false
    'info': false
    'searching': false
    'columnDefs': [{
      'targets': 'visibility:collapse'
      'visible': false
    }] )
  
  return
