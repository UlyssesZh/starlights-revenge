#!/usr/bin/env ruby

require 'fileutils'

FileUtils.rm_r 'web' if Dir.exist? 'web'
FileUtils.mkdir_p 'web/image'

Dir.glob 'image/*' do |image|
	system 'convert', image, *%w[-strip -quality 70], "web/image/#{File.basename image, '.*'}.webp"
end

html = File.read 'Starlight_s Revenge.html'
html.gsub! %r{src=&quot;image/([a-z\-]+)\.(jpg|png|webp)&quot;} do
	"src=&quot;image/#$1.webp&quot;"
end

title = "Starlight's Revenge"
base_url = "https://ulysseszh.github.io/starlights-revenge"
description = 'Starlight Glimmer carries out a revenge after her leadership in her town is overthrown!'
html.sub! %{<meta charset="utf-8">\n}, <<HTML
<meta charset="utf-8">
<meta property="og:title" content="#{title}" />
<meta property="og:locale" content="en_US" />
<meta property="og:type" content="website" />
<meta property="og:url" content="#{base_url}" />
<meta property="og:image" content="#{base_url}/image/confront-m6.webp" />
<meta name="description" content="#{description}" />
<meta property="og:description" content="#{description}" />
<meta name="twitter:card" content="summary_large_image" />
<meta property="twitter:image" content="#{base_url}/image/confront-m6.webp" />
<meta property="twitter:title" content="#{title}" />
<link rel="canonical" href="#{base_url}" />
<link rel="icon" href="#{base_url}/icon.svg" />
<meta name="theme-color" content="#69328f" />
<meta name="theme-color" media="(prefers-color-scheme: light)" content="#9be9d8" />
HTML

File.write 'web/index.html', html

FileUtils.cp 'icon.svg', 'web/icon.svg'
