# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

regex = ['\\bTotal\\b', '\\bMaterial Count\\b',
  '\\bCustomer Requirement\\b', '\\bConfirmed Order\\b']

$(document).on 'turbolinks:load', ->
  # Set up datatable
  table = $('#material-table').DataTable(
    'paging': false
    'ordering': false
    'info': false
    'scrollX': true
    'columnDefs': [{
      'targets': 'hidden'
      'visible': false
    }
    {
      'targets': 'nosearch'
      'searchable': false
    }
    {
      'targets': 'search'
      'searchable': true
    }]
    'search':
      'regex': true
      'smart': false
      'search': (regex.join('|'))
    rowGroup:
      dataSrc: 1
      endRender: null
    dom: 'rtip'
    'drawCallback': (settings) ->
      api = @api()

      confirmed_orders = api.rows('.math').data()
      confirmed_count = api.row('#customer-requirement')
      inventory = api.rows('.inventory.visible').data()
      inv_balance = api.row('#inventory-balance')
      balance = api.row('#material-balance')
      minorder = api.row('#min-order')

      # Remove the first column (customer name) from the order row
      order_nums = confirmed_orders.map((order) ->
        order.shift()
        order.shift()
        order
      )
      inv_nums = inventory.map((inv) ->
        inv.shift()
        inv.shift()
        inv
      )
      # Add together each element of the array of orders to get a sum
      order_sums = order_nums.reduce((array1, array2) ->
        array1.map (value, index) ->
          parseInt(value) + parseInt(array2[index])
      )
      inv_sums = inv_nums.reduce((array1, array2) ->
        array1.map (value, index) ->
          parseInt(value) + parseInt(array2[index])
      )
      balance_sums = inv_sums.map((value, index) ->
        parseInt(value) - parseInt(order_sums[index])
      )
      minorder_sums = inv_sums.map((value, index) ->
        bal = parseInt(value) - parseInt(order_sums[index])
        if bal >= 0
          return 0
        if bal < 0
          return Math.abs(bal)
      )
      # Add the first column name to the final array of sums
      order_sums.unshift('<b>Customer Requirement</b>', 'Customer Requirement')
      inv_sums.unshift('<b>Inventory Count</b>', 'Total')
      balance_sums.unshift('<b>Material Balance</b>', 'Total')
      minorder_sums.unshift('<b>Min. Order Quantity', 'Total')
      # Add the sum information to the table and redraw the table
      confirmed_count.data(order_sums)
      inv_balance.data(inv_sums)
      balance.data(balance_sums)
      minorder.data(minorder_sums)

      api.cells('.conditional').every(() ->
        cell = this.node()
        if parseInt(this.data()) <= 0
          this.data('0')
          $(cell).addClass('red')
        if parseInt(this.data()) > 0 and parseInt(this.data()) < 3
          $(cell).addClass('yellow')
        if parseInt(this.data()) > 2 and parseInt(this.data()) < 6
          $(cell).addClass('blue')
        if parseInt(this.data()) > 5
          $(cell).addClass('green')
        return
      )

      api.cells('.conditional2').every(() ->
        cell = this.node()
        if parseInt(this.data()) > 0
          $(cell).addClass('red')
      )

      api.rows('.math').invalidate()
      api.rows('.inventory.visible').invalidate()

    )

  if $('#material-table').length
    new ($.fn.dataTable.Buttons)(table,
      buttons: [
        'copy', 'print', 'pdf', 'excel', 'csv'
    ])

    $('.toolbar').append(table.buttons(0, null).container())

    $('i.toggle-vis').on 'click', (e) ->
      e.preventDefault()
      columns = table.columns('.hidden.' + $(this).attr('data-column'))
      column = table.column('.hidden.' + $(this).attr('data-column'))
      columns.visible !column.visible()
      if column.visible()
        $(this).text('keyboard_arrow_left')
      else
        $(this).text('keyboard_arrow_right')

    $('button.toggle-order').on 'click', (e) ->
      e.preventDefault()
      search = $(this).attr('data-order')
      rowclass = search.toLowerCase().split(' ')[0]
      if $(this).hasClass('active')
        $(this).removeClass('active')
        regex.splice(regex.indexOf('\\b' + search + '\\b'), 1)
        table.rows('.' + rowclass).nodes().to$().removeClass('math')
        table.search(regex.join('|')).draw()
      else
        $(this).addClass('active')
        regex.unshift('\\b' + search + '\\b')
        table.rows('.' + rowclass).nodes().to$().addClass('math')
        table.search(regex.join('|')).draw()
  return
