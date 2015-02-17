#= require jquery.validate
# require jquery.validate.additional-methods
#= require jquery.validate.localization/messages_ru


@initAddressFormValidation = () ->
  $('.js-form-address').validate
    ignore: ".date"


$(document).on 'cocoon:after-insert', '#user_buildings', (e, insertedItem) ->
   console.log '--after-insert-'
   initAddressFormValidation()
