$ ->
  responsiveNavigation()
  $(document).on 'page:load', responsiveNavigation

$(document).on 'click', '.btn', ->
  Turbolinks.visit $(@).find('a').attr 'href'
  false

responsiveNavigation = ->
  $('nav').addClass('js')
  $('nav ul').tinyNav
    header: true
