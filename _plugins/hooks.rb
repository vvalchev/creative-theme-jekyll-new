# WARNING: This script will not be executed on github-pages.

# This hool will look at all sections in all pages, and if a sections
# contains entry 'menu_title', it will create a new menu item, pointing
# to that sections and put it into the 'headers' menu.
require 'logger'
require 'yaml'

log = Logger.new(STDOUT)

Jekyll::Hooks.register :site, :post_read do |site, payload|
  menus = site.data["menus"]["header"]
  site.pages.each do |page|
    unless page.data["sections"] == nil
      page.data["sections"].each do |section|
        if section["menu_title"] != nil and section["section_id"] != nil
          title = section["menu_title"]
          if ! _has_menu(menus, title)
            log.debug("Adding section '#{title}' to the menu.")
            menus.push({
              "url" => page.url + "#" + section["section_id"],
              "title" => title
            })
          end
        end
      end
    end
  end
  log.debug("The final menu is:\n#{menus.to_yaml}")
end

def _has_menu(menus, title)
  result = menus.select do |item|
    item["title"] == title
  end
  return result.size > 0
end
