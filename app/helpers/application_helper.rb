module ApplicationHelper
  def getItemsAutocompleteForBundle
    return Item.itemsForAutocomplete
  end
end
