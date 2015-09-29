# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

init_countdown = ->
  console.log 'Reinitializing countdown'
  $.each $('.countdown'), (index, value) ->
    time = $(value).data('countdown')

    $(value).countdown time, (event) ->
      $(this).html(event.strftime('%-Dd %H:%M:%S'))

init_datatables = ->
  auctions_table = $('#auctions-table')
  auctions_table.DataTable
    "order": [[ 4, 'asc' ]]
  auctions_table.on 'draw.dt', ->
    init_countdown()

ready = ->
  init_countdown()
  init_datatables()

$(document).ready(ready)
$(document).on('page:load', ready)