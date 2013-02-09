# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ -> $("#addPrice").click =>
  # get last price in form
  old_fs = $(".inputs:eq(-1)")

  # clone sample row
  new_fs = old_fs.clone()
  id = new_fs.find("input:first").attr("id")
  number = parseInt(id.match(/\d+/),10)
  number = number+1
  new_fs.find("li:first").attr("id", "item_item_prices_attributes_" + number + "_name_input")
  new_fs.find("label:first").attr("for", "item_item_prices_attributes_" + number + "_name")
  new_fs.find("input:first").attr("id", "item_item_prices_attributes_" + number + "_name")
  new_fs.find("input:first").attr("name", "item[item_prices_attributes][" + number + "][name]")
  new_fs.find("input:first").val("")

  new_fs.find("li:eq(1)").attr("id", "item_item_prices_attributes_" + number + "_price_input")
  new_fs.find("label:eq(1)").attr("for", "item_item_prices_attributes_" + number + "_price")
  new_fs.find("input:eq(1)").attr("id", "item_item_prices_attributes_" + number + "_price")
  new_fs.find("input:eq(1)").attr("name", "item[item_prices_attributes][" + number + "][price]")
  new_fs.find("input:eq(1)").val("")

  new_fs.find("li:eq(2)").attr("id", "item_item_prices_attributes_" + number + "__destroy_input")
  new_fs.find("input:eq(2)").attr("name", "item[item_prices_attributes][" + number + "][_destroy]")
  new_fs.find("label:eq(2)").attr("for", "item_item_prices_attributes_" + number + "__destroy")
  new_fs.find("input:eq(3)").attr("id", "item_item_prices_attributes_" + number + "__destroy")
  new_fs.find("input:eq(3)").attr("name", "item[item_prices_attributes][" + number + "][_destroy]")

  new_fs.insertBefore("#addPrice")

  # get data from input fields
  #name = $("#shop_bundle_new_part_item_name_new").val()
  #amount = $("#shop_bundle_new_part_item_amount_new").val()
  #id = $("#shop_bundle_new_part_item_id_new").val()

  ## clear input field
  #$("#shop_bundle_new_part_item_name_new").val("")
  #$("#shop_bundle_new_part_item_amount_new").val("")
  #$("#shop_bundle_new_part_item_id_new").val("")


  # clear style
  #row.attr("id","")
  #row.attr("style","display:block")

  #row.appendTo("#item-list")

  ## item_name
  #row.find(".item_name").val(name)
  #row.find(".item_name").attr("id","shop_bundle_shop_bundle_parts_item_name_"+count)
  #row.find(".item_name").attr("name","shop_bundle[shop_bundle_parts][item_name_"+count+"]")


