# All behavior controlling creating and editing scorecards

$(document).on 'click', '#show-scorecard a', ->
  hide_sections()
  $('#show-scorecard').hide()
  $('#scorecard input').prop 'disabled', false
  $('#scorecard').show()
  false

$(document).on 'click', '#show-score a', ->
  hide_sections()
  $('#show-score').hide()
  $('#score input').prop 'disabled', false
  $('#score').show()
  false

$(document).on 'click', '#show-garmin a', ->
  hide_sections()
  $('#show-garmin').hide()
  $('#import input').prop 'disabled', false
  $('#import').show()
  false


hide_sections = ->
  $('.details-section').hide()
  $('.details-section input').prop 'disabled', true
  $('#scorecard-toggles li').css 'display', 'inline-block'


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
