

$(document)

  .on 'change', '#voting_building_id', (e) ->
    apartment = $(@).find('option:selected').data 'apartment'
    console.log apartment
    $('.js-apartment').text apartment

  .on 'click', '.js-accept-question', (e) ->
    href = $(@).data "href"
    $wrapper = $(@).closest('.vote-wrapper')
    $.ajax
      method: 'POST'
      url: href
      success: (data, e) ->
        $wrapper.replaceWith data

  .on 'click', '.js-discard-question', (e) ->
    href = $(@).data "href"
    $wrapper = $(@).closest('.vote-wrapper')
    $.ajax
      method: 'POST'
      url: href
      success: (data, e) ->
        $wrapper.replaceWith data
