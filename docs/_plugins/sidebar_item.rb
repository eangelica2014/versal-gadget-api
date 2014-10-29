module Jekyll
  module SidebarItemFilter
    def sidebar_item_link(item)
      pageID = @context.registers[:page]["id"]
      itemID = item["id"]
      baseurl = @context.registers[:site].config['baseurl']
      href = item["href"] || "#{baseurl}/docs/#{itemID}.html"
      className = pageID == itemID ? ' class="active"' : ''

      return "<a href=\"#{href}\"#{className}>#{item["title"]}</a>"
    end
  end
end

Liquid::Template.register_filter(Jekyll::SidebarItemFilter)
