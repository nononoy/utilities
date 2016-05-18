$(document)

  .on 'click', '.apartments_selection', (e) ->
    $(@).closest('#apartments_selection_wrapper').hide()
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
  .on 'click', '.new-voting-submit', (e) ->
    if $('.new_voting_green_checkbox').is(":checked") == false
      alert("Вы должны оповестить соседей о голосовании! ");
      $('.new_voting_green_checkbox').trigger("focus");
      event.preventDefault();

  .on 'click', '.js-discard-question', (e) ->
    href = $(@).data "href"
    $wrapper = $(@).closest('.vote-wrapper')
    $.ajax
      method: 'POST'
      url: href
      success: (data, e) ->
        $wrapper.replaceWith data

        $ ->

$(document).on 'ready page:load', ->
  _hcwp = window._hcwp or []
  _hcwp.push
    widget: 'Stream'
    widget_id: 74957
  do ->
    if 'HC_LOAD_INIT' of window
      HC_LOAD_INIT = true
      lang = (navigator.language or navigator.systemLanguage or navigator.userLanguage or 'en').substr(0, 2).toLowerCase()
      hcc = document.createElement('script')
      hcc.type = 'text/javascript'
      hcc.async = true
      hcc.src = (if 'https:' == document.location.protocol then 'https' else 'http') + '://w.hypercomments.com/widget/hc/74957/' + lang + '/widget.js'
      s = document.getElementsByTagName('script')[0]
      s.parentNode.insertBefore hcc, s.nextSibling