# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ -> $("#score.form_element input").prop('disabled', true)

@toggle_scorecard_input = () ->
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
    $("#scorecard_toggle").text('or enter full scorecard')
