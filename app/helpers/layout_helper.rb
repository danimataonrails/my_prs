module LayoutHelper
  def title(title)
    content_for :title, title
    title
  end

  def menu_options_for(items)
    html = []
    items.each do |item|
      if policy(item).index?
        html << menu_option(t(".#{item.to_s.pluralize}"), url_for(controller: item.to_s.pluralize, action: :index, only_path: true))
      end
    end
    html.join.html_safe
  end
  
  def menu_option(caption, path, options = {})
    content_tag :li do
      link_to caption, path, options
    end
  end
  
  def table_head_for(scope, columns)
    content_tag :tr do
      columns.collect do |column|
        content_tag :th, t(column, scope: scope)
      end.join.html_safe
    end.html_safe
  end
  
  def table_rows_for(data, columns)
    html = []
    if data.any?
      data.collect do |datum|
        row = content_tag :tr do
          columns.collect do |column|
            content_tag :td, datum.send(column)
          end
        end
        html << row
      end
    else
      html << content_tag(:tr, content_tag(:td, t('.no_data'), colspan: columns.size))
    end
    html.join.html_safe
  end
  
  def flash_messages
  end
end
