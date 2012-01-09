# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@switchTabs = () ->
  $(".tabControl a").click (event) ->
    $(".tabControl li").removeClass('current')
    $(".tabContent").removeClass('current')
    $(@).parent().addClass('current')
    $("##{@id}_content").addClass('current')
