@initKladr = ($input_wrapper) ->
  if $input_wrapper.length > 0
    addressUpdate = ->
      address = $.kladr.getAddress $input_wrapper
      $input_wrapper.find(".js-address").val address
      return

    $city = $input_wrapper.find(".js-city")
    $street = $input_wrapper.find(".js-street")
    $building = $input_wrapper.find(".js-building_number")

    $.kladr.setDefault
      parentInput: ".js-form-address"
      verify: true
      labelFormat: (obj, query) ->
        label = ""
        name = obj.name.toLowerCase()
        query = query.name.toLowerCase()
        start = name.indexOf(query)
        start = (if start > 0 then start else 0)
        label += obj.typeShort + ". "  if obj.typeShort
        if query.length < obj.name.length
          label += obj.name.substr(0, start)
          label += "<strong>" + obj.name.substr(start, query.length) + "</strong>"
          label += obj.name.substr(start + query.length, obj.name.length - query.length - start)
        else
          label += "<strong>" + obj.name + "</strong>"
        if obj.parents
          k = obj.parents.length - 1

          while k > -1
            parent = obj.parents[k]
            if parent.name
              label += "<small>, </small>"  if label
              label += "<small>" + parent.name + " " + parent.typeShort + ".</small>"
            k--
        label

      change: (obj) ->
        addressUpdate()
        return

      checkBefore: ->
        $input = $(@)
        unless $.trim($input.val())
          addressUpdate()
          false

    $city.kladr
      token: '53022dde31608f4d77000030'
      type: $.kladr.type.city
    $street.kladr
      token: '53022dde31608f4d77000030'
      type: $.kladr.type.street
      valueFormat: (obj, query) ->
        "#{obj.typeShort}. #{obj.name}"
    $building.kladr
      token: '53022dde31608f4d77000030'
      type: $.kladr.type.building


    $city.kladr "withParents", true
    $building.kladr "verify", false

    return


$(document).on "ready page:load", ->

  $('#user_buildings').on 'cocoon:before-insert', (e, insertedItem) ->
    initKladr(insertedItem)

  $('.nested-fields').each ->
    initKladr($(@))
