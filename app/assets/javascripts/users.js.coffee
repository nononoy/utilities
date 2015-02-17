#= require_tree ./users
$(document).on "ready page:load", ->
  $('#voting_questions .links a.add_fields').trigger 'click'
