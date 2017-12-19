# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready', ->
  console.log('ok')
  $('.wp1').waypoint (->
    $('.wp1').addClass 'animated fadeInLeft'
    $('.wp1').removeClass 'wp1'
    return
  ), offset: '55%'
  $('.wp2').waypoint (->
    $('.wp2').addClass 'animated fadeInUp'
    $('.wp2').removeClass 'wp2'
    return
  ), offset: '55%'
  $('.wp3').waypoint (->
    $('.wp3').addClass 'animated fadeInDown'
    $('.wp3').removeClass 'wp3'
    return
  ), offset: '55%'
  return
