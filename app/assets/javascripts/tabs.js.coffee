# Generic tab view control

$ ->
  $("#tabcontrol li").click ->
    $("#tabcontrol li").removeClass('current')
    $(".tabcontent").removeClass('current')
    $(@).addClass('current')
    $("##{@id}_content").addClass('current')
    false
