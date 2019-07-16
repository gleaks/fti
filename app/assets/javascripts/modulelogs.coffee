# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  table = $('#modulelogs-table').DataTable
    'pageLength': 50
    'order': [[0, 'desc']]
    'search':
      'regex': true
      'smart': false

  if $('#modulelogs-table').length
    $('a.toggle-assembly').on 'click', (e) ->
      e.preventDefault()
      search = $(this).attr('data-order')
      $('a.toggle-assembly').removeClass('active')
      $(this).addClass('active')
      if search == '_all'
        $('#modlogfilters').text('All Modules')
        table.search('').draw()
      else
        $('#modlogfilters').text(search)
        table.search('\\s' + search + '\\b').draw()
        # REGEX TO FIND 'AC Motherboard' AND ('Tested' OR 'Shipped') = ^(?=.*\bAC Motherboard\b)(?=.*(\bTested\b | \bShipped\b))
  return
