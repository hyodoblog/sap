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

  def default_meta_tags
    {
      site: '研究室マッチングシステム',
      reverse: true,
      separator: '|',
      og: defalut_og,
      twitter: default_twitter_card
    }
  end

  private

  def defalut_og
    {
      title: '研究室マッチングシステム',          # :full_title とすると、サイトに表示される <title> と全く同じものを表示できる
      description: '多くの大学では、大学3年次の末に研究室への配属が行われます。この研究室配属において、学生と研究室の満足度を高める目的で開発されたシステムが当サービス、「研究室マッチングシステム」です。',
      url: 'https://sap.hyodoblog.com',
      image: 'https://sap.hyodoblog.com/ogp.jpg'
    }
  end

  def default_twitter_card
    {
      card: 'summary_large_image', # または summary
      site: '@yusei_hyodo'            # twitter ID
    }
  end
end
