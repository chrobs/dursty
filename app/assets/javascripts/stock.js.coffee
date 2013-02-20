# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@loadSoldBundles = (id) =>
  from = $("#stock_" + id + "_from").val().replace(/\./g,"-")
  to = $("#stock_" + id + "_to").val().replace(/\./g,"-")

  $("#stock_" + id + "_load_link").addClass("icon-spin")
  $("#stock_" + id + "_soldBundles").fadeOut('slow')
  #$("#stock_" + id + "_soldBundles").empty()
  $("#stock_" + id + "_soldBundles").load('/stock/'+id+'/sold-bundles/'+from+'/'+to,
    (response, status, xhr) =>
      $("#stock_" + id + "_soldBundles").fadeIn('slow')
      $("#stock_" + id + "_load_link").removeClass("icon-spin")
  )

