module ApplicationHelper
  def header_link_item(name, path)
    class_name = 'nav-item'
    class_name << ' active' if current_page?(path)

    content_tag :li, class: class_name do
      link_to(name, path, class: 'nav-link', rel: 'nofollow')
    end
  end

  def header_link_dropdown(name, paths)
    class_name = 'nav-link dropdown-toggle'
    paths.each do |path|
      class_name << ' active' if current_page?(path)
    end
    link_to(name, '#', class: class_name, id: 'navbarDropdown',
                  'role' => 'buttom', 'data-toggle' => 'dropdown',
                  'aria-haspopup' => true, 'aria-expanded' => false)
  end

  def default_meta_tags
    {
      site: '研究室マッチングシステム',
      description: '多くの大学では、大学3年次の末に研究室への配属が行われます。この研究室配属において、学生と研究室の満足度を高める目的で開発されたシステムが当サービス、「研究室マッチングシステム」です。',
      keywords: 'SAP,研究室,配属,マッチング,研究室つらい,研究室行きたくない,研究室訪問',
      icon: asset_path("favicon.ico"),
      reverse: true,
      separator: '|',
      charset: "UTF-8",
      og: defalut_og,
      twitter: default_twitter_card,
      fb: default_facebook
    }
  end

  private

  def defalut_og
    {
      title: '研究室マッチングシステム',
      description: '多くの大学では、大学3年次の末に研究室への配属が行われます。この研究室配属において、学生と研究室の満足度を高める目的で開発されたシステムが当サービス、「研究室マッチングシステム」です。',
      url: 'https://sap.hyodoblog.com',
      type: 'website',
      image: asset_path('ogp.jpg'),
      site_name: '研究室マッチングシステム',
      locale: "ja_JP"
    }
  end

  def default_twitter_card
    {
      card: 'summary_large_image', # または summary
      site: '@yusei_hyodo'            # twitter ID
    }
  end

  def default_facebook
    {
      app_id: ENV['FACEBOOK_ID']
    }
  end
end
