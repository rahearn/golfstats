# All behavior controlling creating and editing scorecards

custom_stat_counter = 0

$ ->
  custom_stat_counter = $('.scorecard #custom_stat_counter').val()
  $('#append_scorecard_line').click -> append_scorecard_row()
  $('#scorecard_toggle').click -> toggle_scorecard_view()

toggle_scorecard_view = () ->
  $("#scorecard.form_element").toggle()
  $("#score.form_element").toggle()

  $("#score.form_element input").prop(
    'disabled'
    !$("#round_score").prop('disabled')
  )
  $("#scorecard.form_element input").prop(
    'disabled'
    !$("#round_score").prop('disabled')
  )

  if $("#round_score").prop('disabled')
    $("#scorecard_toggle").text('enter only the score')
  else
    $("#scorecard_toggle").text('enter full scorecard')
  false


append_scorecard_row = () ->
  row = $('<div class="line custom" />').append(
    $('<div class="unit size2of20 label element txt" />').append($('<input name="round[scorecard][stat_order][]" type="text" />'))
  )

  row.append($('<div class="unit size1of20 element txt" />').append(
    $("<input name=\"round[scorecard][holes_attributes][#{hole}][custom_stats][#{custom_stat_counter}]\" type=\"text\" pattern=\"[0-9yYtTnNfF]*\" />")
  )) for hole in [0..17]

  row.insertBefore($(".additional"))

  custom_stat_counter++
  false
