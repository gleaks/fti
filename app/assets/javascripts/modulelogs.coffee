# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

regex = {assembly: '', cat: []}

$(document).on 'turbolinks:load', ->
  table = $('#modulelogs-table').DataTable
    'pageLength': 50
    'order': [[0, 'desc']]
    'search':
      'regex': true
      'smart': false
    dom: "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" +
          "<'row'<'col-sm-12'tr>>" +
          "<'row'<'col-sm-5'i><'col-sm-7'p>>"
    buttons: [
      'colvis'
    ]

  if $('#modulelogs-table').length
    $('button.toggle-category').on 'click', (e) ->
      e.preventDefault()
      search = $(this).attr('cat-order')
      if $(this).hasClass('active')
        $(this).removeClass('active')
        regex.cat.splice(regex.cat.indexOf('\\b' + search + '\\b'), 1)
      else
        $(this).addClass('active')
        regex.cat.unshift('\\b' + search + '\\b')
      if regex.assembly == ''
        table.search('^(?=.*(' + regex.cat.join('|') + '))').draw()
      else
        table.search('^(?=.*\\s' + regex.assembly + '\\b)
                    (?=.*(' + regex.cat.join('|') + '))').draw()
    $('a.toggle-assembly').on 'click', (e) ->
      e.preventDefault()
      search = $(this).attr('data-order')
      $('a.toggle-assembly').removeClass('active')
      $(this).addClass('active')
      if search == '_all'
        regex.assembly = ''
      else
        regex.assembly = search
      if regex.cat.length < 1
        if search == '_all'
          table.search('').draw()
        else
          table.search('^(?=.*\\s' + search + '\\b)').draw()
      else
        if search == '_all'
          table.search('^(?=.*(' + regex.cat.join('|') + '))').draw()
        else
          table.search('^(?=.*\\s' + search + '\\b)
                      (?=.*(' + regex.cat.join('|') + '))').draw()
  return
