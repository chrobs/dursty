# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

count = 1
first = "<tr><td><input id='shop_bundle_item_id_"
second = "' type='text' size='30' name='shop_bundle[item_id_"
third = "]'></td>"
fourth = "<td><input id='shop_bundle_item_amount_"
fifth = "' type='text' size='5' name='shop_bundle[item_amount_"
sixth = "]'></td></tr>"

$ -> $("#addItem").click =>
  count += 1
  $ -> $("#item-list").append(first + count + second + count + third + fourth + count + fifth + count + sixth)
