require 'ostruct'
module Webpacker::Helper
  # TODO: we should probably monkeypatch a deeper class
  def javascript_pack_tag(*names, defer: true, **options)
    names.map { |n| '<script src="/' + n + '.js"> </script>'}.join("\n").html_safe
  end
end
module ActionView::Helpers::CsrfHelper
  def csrf_meta_tags
    ''
  end
end
def stylesheet_link_tag (args) 
  args
end
