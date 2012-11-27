
$(document).on 'click', '#course_note_control', ->
  $('#course_note').load $(@).attr('href')
  false
