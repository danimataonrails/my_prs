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
  
  def table_head_for(scope, columns, actions = true)
    ths = columns.collect do |column|
      content_tag :th, t(column, scope: scope)
    end.join.html_safe
    ths += content_tag(:th, '&nbsp;'.html_safe) if actions
    content_tag(:tr, ths).html_safe
  end
  
  def table_rows_for(data, columns, actions = true)
    html = []
    if data.any?
      data.collect do |datum|
        tds = columns.collect do |column|
          content_tag :td, datum.send(column)
        end.join.html_safe
        if actions
          tds += content_tag :td do
            [link_to(t('actions.show'), datum),
              link_to(t('actions.edit'), [:edit, datum]),
              link_to(t('actions.destroy'), datum, method: :delete)].join('&nbsp').html_safe
          end
        end
        html << content_tag(:tr, tds)
      end
    else
      html << content_tag(:tr, content_tag(:td, t('.no_data'), colspan: columns.size))
    end
    html.join.html_safe
  end
  
  def fields_for(object, columns, scope)
    content_tag :dl do
      columns.collect do |column|
        content_tag(:dt, t(column, scope: scope)) +
        content_tag(:dd, object.send(column))
      end.join.html_safe
    end
  end
  
  def model_options(klass)
    policy_scope(klass.all).map{|k| [k.name, k.id]}
  end

  def flash_messages
  end
  
  def cancel_link
    link_to(t('actions.cancel'), :back)
  end

  def submit_or_cancel
    [cancel_link, button_tag(t('actions.submit'))].join('&nbsp;').html_safe
  end
end
