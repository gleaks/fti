# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

regex = {filter: ['\\bactive-true', '\\bcurrent-true\\b'], cat: []}

$(document).on 'turbolinks:load', ->
  table = $('#assemblies-table').DataTable
    'pageLength': 50
    'order': [[0, 'asc']]
    'columnDefs': [{
      'targets': 'hidden'
      'visible': false
    }]
    'search':
      'regex': true
      'smart': false
      'search': '^(?=.*' + regex.filter.join(')(?=.*') + ')'

  if $('#assemblies-table').length
    $('button.toggle-filter').on 'click', (e) ->
      e.preventDefault()
      search = $(this).attr('cat-filter')
      console.log(search)
      if $(this).hasClass('active')
        $(this).removeClass('active')
        regex.filter.splice(regex.filter.indexOf('\\b' + search + '\\b'), 1)
      else
        $(this).addClass('active')
        regex.filter.unshift('\\b' + search + '\\b')
      if regex.cat.count < 1
        table.search('^(?=.*' + regex.filter.join(')(?=.*') + ')').draw()
      else
        table.search('^(?=.*' + regex.filter.join(')(?=.*') + ')
                    (?=.*(' + regex.cat.join('|') + '))').draw()

    $('button.toggle-category').on 'click', (e) ->
      e.preventDefault()
      search = $(this).attr('cat-order')
      console.log(search)
      if $(this).hasClass('active')
        $(this).removeClass('active')
        regex.cat.splice(regex.cat.indexOf('\\b' + search + '\\b'), 1)
      else
        $(this).addClass('active')
        regex.cat.unshift('\\b' + search + '\\b')
      if regex.filter.count < 1
        table.search('^(?=.*(' + regex.cat.join('|') + '))').draw()
      else
        table.search('^(?=.*' + regex.filter.join(')(?=.*') + ')
                    (?=.*(' + regex.cat.join('|') + '))').draw()
  return
