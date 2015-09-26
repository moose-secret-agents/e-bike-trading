# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $.each $('.countdown'), (index, value) ->
    time = $(value).html()

    $(value).countdown time, (event) ->
      $(this).html(event.strftime('%-Dd %H:%M:%S'))

$(document).ready(ready)
$(document).on('page:load', ready)