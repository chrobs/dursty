# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


#$ -> $(".item_name").autocomplete({
#            source: [{label:"Pete Freitag", value:1}, {label:"Pete Doe", value:2}],
#            select: (event, ui) =>
#                  $(event.target).val(ui.item.label)
#                  $(event.target).parent().parent().find(".item_id input").val(ui.item.value)
#                  return false
#            })

jQuery ->
  $(".table-datatable").dataTable({
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    aLengthMenu: [[10, 50,100, -1],[10, 50,100, "All"]]
  })

@del_row = (event) =>
  $(event.currentTarget).parent().parent().remove()

$ -> $("#addItem").click =>
  # get max_items and increment
  count = parseInt($("#shop_bundle_max_items").val(),10)
  count += 1
  $("#shop_bundle_max_items").val(count)

  # get data from input fields
  name = $("#shop_bundle_item_name_new").val()
  amount = $("#shop_bundle_item_amount_new").val()
  id = $("#shop_bundle_item_id_new").val()

  # clear input field
  $("#shop_bundle_item_name_new").val("")
  $("#shop_bundle_item_amount_new").val("")
  $("#shop_bundle_item_id_new").val("")

  # clone sample row
  row = $("#item-row-sample").clone()

  # clear style
  row.attr("id","")
  row.attr("style","display:block")

  row.appendTo("#item-list")

  # item_name
  row.find(".item_name").val(name)
  row.find(".item_name").attr("id","shop_bundle_shop_bundle_parts_item_name_"+count)
  row.find(".item_name").attr("name","shop_bundle[shop_bundle_parts][item_name_"+count+"]")

  # item_amount
  row.find(".item_amount").val(amount)
  row.find(".item_amount").attr("id","shop_bundle_shop_bundle_parts_item_amount_"+count)
  row.find(".item_amount").attr("name","shop_bundle[shop_bundle_parts][item_amount_"+count+"]")

  # item_id
  row.find(".item_id input").val(id)
  row.find(".item_id input").attr("id","shop_bundle_shop_bundle_parts_item_id_"+count)
  row.find(".item_id input").attr("name","shop_bundle[shop_bundle_parts][item_id_"+count+"]")
