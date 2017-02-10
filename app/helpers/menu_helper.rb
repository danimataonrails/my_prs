module MenuHelper
  def menu_options_for(items)
    html = []
    items.each do |item|
      if policy(item).index?
        html << menu_option(t(".#{item.to_s.pluralize}"), url_for(controller: item.to_s.pluralize, action: :index, only_path: true))
      end
    end
    html.join('').html_safe
  end
  
  def menu_option(caption, path)
    content_tag :li do
      link_to caption, path
    end
  end
end
