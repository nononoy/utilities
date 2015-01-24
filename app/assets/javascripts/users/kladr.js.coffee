$(document).on "ready page:load", ->

  # Включаем получение родительских объектов для населённых пунктов

  # Отключаем проверку введённых данных для строений
  setLabel = ($input, text) ->
    text = text.charAt(0).toUpperCase() + text.substr(1).toLowerCase()
    $input.parent().find("label").text text
    return
  mapUpdate = ->
    zoom = 4
    address = $.kladr.getAddress(".js-form-address", (objs) ->
      result = ""
      $.each objs, (i, obj) ->
        name = ""
        type = ""
        if $.type(obj) is "object"
          name = obj.name
          type = " " + obj.type
          switch obj.contentType
            when $.kladr.type.region
              zoom = 4
            when $.kladr.type.district
              zoom = 7
            when $.kladr.type.city
              zoom = 10
            when $.kladr.type.street
              zoom = 13
            when $.kladr.type.building
              zoom = 16
        else
          name = obj
        result += ", "  if result
        result += type + name
        return

      result
    )
    if address and map_created
      geocode = ymaps.geocode(address)
      geocode.then (res) ->
        map.geoObjects.each (geoObject) ->
          map.geoObjects.remove geoObject
          return

        position = res.geoObjects.get(0).geometry.getCoordinates()
        placemark = new ymaps.Placemark(position, {}, {})
        map.geoObjects.add placemark
        map.setCenter position, zoom
        return

    return
  addressUpdate = ->
    address = $.kladr.getAddress(".js-form-address")
    $("[name='user[address]']").val address
    return

  # $region = $("[name='user[region]']")
  # $district = $("[name='user[district]']")
  $city = $("[name='user[city]']")
  $street = $("[name='user[street]']")
  $building = $("[name='user[building]']")

  map = null
  map_created = false

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
      # if obj && obj.contentType == 'city'
      #   console.log(obj)
      setLabel $(@), obj.type  if obj
      addressUpdate()
      mapUpdate()
      return

    checkBefore: ->
      $input = $(@)
      unless $.trim($input.val())
        addressUpdate()
        mapUpdate()
        false

  # $region.kladr
  #   type: $.kladr.type.region
  #   token: '53022dde31608f4d77000030'
  # $district.kladr
  #   token: '53022dde31608f4d77000030'
  #   type: $.kladr.type.district
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

  # ymaps.ready ->
  ymaps.ready ->
    return  if map_created
    map_created = true
    map = new ymaps.Map("map",
      center: [
        56.1365500
        40.3965800

      ]
      zoom: 12
      controls: []
    )
    map.controls.add "zoomControl",
      position:
        right: 10
        top: 10

    return

  return
