# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

regex = {active: 'active-true', cat: []}

$(document).on 'turbolinks:load', ->
  table = $('#parts-table').DataTable
    'pageLength': 50
    'order': [[0, 'asc']]
    'search':
      'regex': true
      'smart': false
      'search': '^(?=.*\\s' + regex.active + '\\b)'
    'columnDefs': [{
      'targets': 'hidden'
      'visible': false
    }]
    dom: "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" +
          "<'row'<'col-sm-12'tr>>" +
          "<'row'<'col-sm-5'i><'col-sm-7'p>>"
    buttons: [
      'colvis'
    ]

  if $('#parts-table').length
    $('a.toggle-category').on 'click', (e) ->
      e.preventDefault()
      search = $(this).attr('cat-order')
      if $(this).hasClass('active')
        $(this).removeClass('active')
        regex.cat.splice(regex.cat.indexOf('\\s' + search + '\\b'), 1)
      else
        $(this).addClass('active')
        regex.cat.unshift('\\s' + search + '\\b')
      if regex.active == ''
        table.search('^(?=.*(' + regex.cat.join('|') + '))').draw()
      else
        table.search('^(?=.*\\s' + regex.active + '\\b)
                    (?=.*(' + regex.cat.join('|') + '))').draw()
    $('button.toggle-active').on 'click', (e) ->
      e.preventDefault()
      search = $(this).attr('cat-filter')
      if $(this).hasClass('active')
        $(this).removeClass('active')
        regex.active = ''
      else
        $(this).addClass('active')
        regex.active = search
      if regex.cat.length < 1
        table.search('^(?=.*\\s' + regex.active + '\\b)').draw()
      else
        table.search('^(?=.*\\s' + regex.active + '\\b)
                    (?=.*(' + regex.cat.join('|') + '))').draw()
  return
