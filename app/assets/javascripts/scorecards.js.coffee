# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

custom_stat_counter = 0

$ ->
  custom_stat_counter = $('.scorecard #custom_stat_counter').val()
  $('#append_scorecard_line').click ->
    append_scorecard_row()
    false

append_scorecard_row = () ->
  row = $('<div class="line custom" />').append(
    $('<div class="unit size2of20 label element txt" />').append($('<input name="round[scorecard][stat_order][]" type="text" />'))
  )

  row.append($('<div class="unit size1of20 element txt" />').append(
    $("<input name=\"round[scorecard][holes_attributes][#{hole}][custom_stats][#{custom_stat_counter}]\" type=\"text\" />")
  )) for hole in [0..17]

  row.insertBefore($(".additional"))

  custom_stat_counter++
