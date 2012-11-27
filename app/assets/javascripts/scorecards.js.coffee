# All behavior controlling creating and editing scorecards

$(document).on 'click', '#scorecard_toggle', ->
  $("#scorecard").toggle()
  $("#score").toggle()

  $("#score input").prop(
    'disabled'
    !$("#round_score").prop('disabled')
  )
  $("#scorecard input").prop(
    'disabled'
    !$("#round_score").prop('disabled')
  )

  if $("#round_score").prop('disabled')
    $("#scorecard_toggle").text('enter only the score')
  else
    $("#scorecard_toggle").text('enter full scorecard')
  false


$(document).on 'click', '#append_custom_statistic', ->
  name = prompt 'Please enter the statistic name', null
  return false if !name? || $.trim(name) == ''
  name = $.trim name
  stat_counter = $('#custom_stat_counter').val()

  $('form').append $("<input name=\"round[scorecard][stat_order][]\" type=\"hidden\" value=\"#{name}\" />")
  $("#hole#{hole}").append(
    $('<div>').addClass('entry txt').append($('<div>').addClass('element').html(
      $("<input name=\"round[scorecard][holes_attributes][#{hole}][custom_stats][#{stat_counter}]\" type=\"text\" pattern=\"[0-9yYtTnNfF]*\" placeholder=\"#{name}\" />")
    ))
  ) for hole in [0..17]

  $('#custom_stat_counter').val ++stat_counter
  resize_entries stat_counter
  false


resize_entries = (num_columns) ->
  columns = 4 + num_columns
  $('.hole .entry').css 'width', "#{85 / columns}%"
