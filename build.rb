#!/usr/bin/env ruby

require 'fileutils'

FileUtils.rm_r 'web' if Dir.exist? 'web'
FileUtils.mkdir_p 'web/image'

Dir.glob 'image/*' do |image|
	system 'convert', image, *%w[-resize 960x -strip -quality 70], "web/image/#{File.basename image, '.*'}.webp"
end

html = File.read 'Starlight_s Revenge.html'
html.gsub! %r{src=&quot;image/([a-z\-]+)\.(jpg|png|webp)&quot;} do
	"src=&quot;image/#$1.webp&quot;"
end
File.write 'web/index.html', html
