# encoding: UTF-8
# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  # navigation.renderer = Your::Custom::Renderer

  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  # navigation.selected_class = 'your_selected_class'

  # Specify the class that will be applied to the current leaf of
  # active navigation items. Defaults to 'simple-navigation-active-leaf'
  # navigation.active_leaf_class = 'your_active_leaf_class'

  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # If you need to add custom html around item names, you can define a proc that will be called with the name you pass in to the navigation.
  # The example below shows how to wrap items spans.
  # navigation.name_generator = Proc.new {|name| "<span>#{name}</span>"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false

  # Define the primary navigation
  navigation.items do |first|
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.  # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #           some special options that can be set:
    #           :if - Specifies a proc to call to determine if the item should
    #                 be rendered (e.g. <tt>:if => Proc.new { current_user.admin? }</tt>). The
    #                 proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :unless - Specifies a proc to call to determine if the item should not
    #                     be rendered (e.g. <tt>:unless => Proc.new { current_user.admin? }</tt>). The
    #                     proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :method - Specifies the http-method for the generated link - default is :get.
    #           :highlights_on - if autohighlighting is turned off and/or you want to explicitly specify
    #                            when the item should be highlighted, you can set a regexp which is matched
    #                            against the current URI.  You may also use a proc, or the symbol <tt>:subpath</tt>. 
    #
    first.item :home, '<i class="icon-home"/></i> Home', root_path

    unless user_signed_in?
      first.item :termine, '<i class="icon-calendar"/></i> Termine', public_sale_dates_path
      first.item :login, '<i class="icon-signin"></i> Login', new_user_session_path
    end


    if user_signed_in?
      first.item :kassenstand, '<i class="icon-tasks"></i> Kassenstand', userkonto_show_path(current_user.id)
      first.item :verkauf, '<i class="icon-shopping-cart"></i> Verkauf', shop_index_path do |shop|
        ShopBundleCategory.all.each do |c|
          shop.item c.name.to_sym, '<i class="icon-caret-right"></i> '+c.name, shop_index_path(:category => c.id)
        end
      end


      first.item :lagerwart, '<i class="icon-beer"></i> Lagerwart', stock_index_path, :if => Proc.new { current_user.lagerwart || current_user.admin}, :highlights_on => %r(^/stock_changes|^/stock) do |lager|
        lager.item :artikel, '<i class="icon-caret-right"></i> Artikel', items_path, :highlights_on => %r(^/items)
        lager.item :shopbundlecategories, '<i class="icon-caret-right"></i> Kategorien', shop_bundle_categories_path, :highlights_on => %r(^/shop_bundle_categories)
        lager.item :shopbundles, '<i class="icon-caret-right"></i> ShopBundles', shop_bundles_path, :highlights_on => %r(^/shop_bundles)
      end

      first.item :kassenwart, '<i class="icon-credit-card"></i> Kassenwart', kasse_uebersicht_path, :if => Proc.new { current_user.kassenwart || current_user.admin} do |kasse|
        kasse.item :konten, '<i class="icon-caret-right"></i> Konten', kasse_uebersicht_path, :highlights_on => %r(^/kontos/\d+$|^/kasse/uebersicht$|^/konto_transactions)
        kasse.item :kontoadmin, '<i class="icon-caret-right"></i> Kontoadmin', kontos_path, :highlights_on => %r(^/kontos($|/new$|/\d+/edit$))
      end

      first.item :useradmin, '<i class="icon-user"></i> Useradmin', users_path, :if => Proc.new {current_user.admin}, :highlights_on => %r(^/admin/) do |admin|
      end

      if current_user.admin || current_user.stocks.any?{|s| s.name == "oph"}
        first.item :termine, '<i class="icon-calendar"></i> Termine', sale_date_index_path
      end

      first.item :logout, '<i class="icon-signout"></i> Logout', destroy_user_session_path, :method => :delete
    end
    # You can also specify a condition-proc that needs to be fullfilled to display an item.
    # Conditions are part of the options. They are evaluated in the context of the views,
    # thus you can use all the methods and vars you have available in the views.
    #primary.item :key_3, 'Admin', url, :class => 'special', :if => Proc.new { current_user.admin? }
    #primary.item :key_4, 'Account', url, :unless => Proc.new { logged_in? }

    # you can also specify a css id or class to attach to this particular level
    # works for all levels of the menu
    # primary.dom_id = 'menu-id'
    # primary.dom_class = 'menu-class'

    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false

  end

end
