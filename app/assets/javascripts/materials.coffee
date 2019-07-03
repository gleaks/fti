# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  # Set up datatable
  table = $('#material-table').DataTable(
    'paging': false
    'ordering': false
    'info': false
    'searching': false
    'columnDefs': [{
      'targets': 'hidden'
      'visible': false
    }]
    'drawCallback': (settings) ->
      api = @api()

      confirmed_orders = api.rows('.confirmed-orders').data()
      confirmed_count = api.row('#confirmed-orders')
      inventory = api.rows('.inventory.visible').data()
      inv_balance = api.row('#inventory-balance')
      balance = api.row('#material-balance')

      # Remove the first column (customer name) from the order row
      order_nums = confirmed_orders.map((order) ->
        order.shift()
        order
      )
      inv_nums = inventory.map((inv) ->
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
      # Add the first column name to the final array of sums
      order_sums.unshift('<b>Customer Requirement</b>')
      inv_sums.unshift('<b>Inventory Count</b>')
      balance_sums.unshift('<b>Material Balance</b>')
      # Add the sum information to the table and redraw the table
      confirmed_count.data(order_sums)
      inv_balance.data(inv_sums)
      balance.data(balance_sums)

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
  )
  return
