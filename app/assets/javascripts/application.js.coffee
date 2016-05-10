#= require jquery
#= require jquery_ujs
#= require jquery.colorbox.turbolinks
#= require twitter/bootstrap
#= require bootstrap
#= require jquery.mask
#= require jquery.kladr.min
#= require cocoon
#= require users
#= require votings
#= require forms

#= require turbolinks
$(document).on "ready page:load", ->
  $('.date').mask '99.99.9999', placeholder: 'дд.мм.гггг'
  $('.datetime').mask '99.99.9999 99:99', placeholder: 'дд.мм.гггг чч:мм'
  $('.phone').mask '+7(999)999-99-99'
  $('.colorbox').colorbox
    maxWidth: $( window ).width()
