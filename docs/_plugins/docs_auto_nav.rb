def get_page_lookup(toc)
  toc.inject([]) do |pages, section|
    section['items'].each do |page|
      unless page['href']
        pages << page
      end
    end
    pages
  end
end

def find_next_page(page, toc)
  page_lookup = get_page_lookup toc
  page_index = page_lookup.index {|_page| page.data['id'] == _page['id']}
  if page_index
    page_lookup[page_index + 1]
  end
end

def find_prev_page(page, toc)
  page_lookup = get_page_lookup toc
  page_index = page_lookup.index {|_page| page.data['id'] == _page['id']}
  if page_index && (page_index > 0)
    page_lookup[page_index - 1]
  end
end

module DocsAutoNav
  class Generator < Jekyll::Generator
    def generate(site)
      toc = site.data['toc']
      site.pages.map do |page|
        page.data['next'] = find_next_page page, toc
        page.data['prev'] = find_prev_page page, toc
      end
    end
  end
end
