module ApplicationHelper
  def header_link_item(name, path, query_param)
    class_name = 'nav-item'
    class_name << ' active' if current_page?(path)

    content_tag :li, class: class_name do
      link_to name, path+query_param, class: 'nav-link'
    end
  end

  def header_link_dropdown(name, paths)
    class_name = 'nav-link dropdown-toggle'
    paths.each do |path|
      class_name << ' active' if current_page?(path)
    end
    link_to name, '#', class: class_name, id: 'navbarDropdown',
                  'role' => 'buttom', 'data-toggle' => 'dropdown',
                  'aria-haspopup' => true, 'aria-expanded' => false
  end
end
