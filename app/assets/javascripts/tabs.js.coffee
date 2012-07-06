# Generic tab view control

$ ->
  $(".tabControl a").click ->
    $(".tabControl li").removeClass('current')
    $(".tabContent").removeClass('current')
    $(@).parent().addClass('current')
    $("##{@id}_content").addClass('current')
    false
