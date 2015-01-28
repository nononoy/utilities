

$(document).on 'change', '#voting_building_id', (e) ->
  apartment = $(@).find('option:selected').data 'apartment'
  console.log apartment
  $('.js-apartment').text apartment
