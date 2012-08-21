
$ ->
  $('#course_note_control').click ->
    $('#course_note').load $(@).attr('href')
    false
