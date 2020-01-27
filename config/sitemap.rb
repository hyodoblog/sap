# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://sap.hyodoblog.com"

SitemapGenerator::Sitemap.create do
  add root_path
end
