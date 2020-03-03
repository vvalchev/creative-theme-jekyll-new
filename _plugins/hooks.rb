# Load all sections, that has menu_title into the 'header' menu
Jekyll::Hooks.register :site, :post_read do |site, payload|
  site.pages.each do |page|
    unless page.data["sections"] == nil
      page.data["sections"].each do |section|
        if section["menu_title"] != nil and section["section_id"] != nil
          site.data["menus"]["header"].push({
            "url" => page.url + "#" + section["section_id"],
            "title" => section["menu_title"]
          })
        end
      end
    end
  end
end
