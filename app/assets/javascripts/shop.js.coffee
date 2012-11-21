# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@shop_buy_bundle = (event, bundle) =>
  amount = $(event.currentTarget).parent().find("input").val()
  window.location="/shop/add_to_card/" + bundle + "/" + amount

@shop_del_bundle = (event, bundle) =>
  window.location="/shop/remove_from_card/" + bundle

@shop_change_bundle_amount = (event, bundle, amount) =>
  window.location="/shop/add_to_card/" + bundle + "/" + amount
