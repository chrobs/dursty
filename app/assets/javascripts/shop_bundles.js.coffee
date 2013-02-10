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

@item_get_prices = (obj) =>
  id = $(obj).find(":selected").attr("value")
  tr = $(obj).parent().parent().parent()
  priceoptions = $(tr).find("select:eq(1)")

  $(obj).parent().append("<i class='icon-spinner icon-spin'></p>")
  $(priceoptions).empty()
  $.getJSON('/items/'+id+'/get-priceoptions',
    (data) =>
      $.each(data, (key,value) =>
        $.each(value, (k,v) =>
          $(priceoptions).append($("<option></option>").attr("value",k).text(v))
        )
      )
      $(obj).parent().find("i:last").remove()
  )
