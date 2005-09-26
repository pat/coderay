# CodeRay dynamic highlighter
#
# Usage: start this and your browser.
# 
# Go to http://localhost:49374/?<path to the file>
# (mnemonic: 49374 = Four-Nine-Three-Seven-Four = For No Token Shall Fall)
# and you should get the highlighted version.

require 'webrick'
require 'pathname'

class << File
	alias dir? directory?
end

require 'erb'
include ERB::Util
def url_decode s
	s.to_s.gsub(/%([0-9a-f]{2})/i) { [$1.hex].pack 'C' }
end

class String
	def to_link name = File.basename(self)
		"<a href=\"?path=#{url_encode self}\">#{name}</a>"
	end
end

require 'coderay'
class CodeRayServlet < WEBrick::HTTPServlet::AbstractServlet

	STYLE = 'style="font-family: sans-serif; color: navy;"'
	BANNER = '<p><img src="http://rd.cYcnus.de/coderay/coderay-banner" style="border: 0" alt="HIghlighted by CodeRay"/></p>'

	def do_GET req, res
		q = req.query_string || ''
		args = Hash[*q.scan(/(.*?)=(.*?)(?:&|$)/).flatten].each_value { |v| v.replace url_decode(v) }
		path = args.fetch 'path', '.'
		
		backlinks = '<p>current path: %s<br />' % html_escape(path) +
			(Pathname.new(path) + '..').cleanpath.to_s.to_link('up') + ' - ' +
			'.'.to_link('current') + '</p>'
		
		res.body = 
			if File.dir? path
				path = Pathname.new(path).cleanpath.to_s
				dirs, files = Dir[File.join(path, '*')].sort.partition { |p| File.dir? p }

				page = "<html><head></head><body #{STYLE}>"
				page << backlinks
				
				page << '<dl>'
				page << "<dt>Directories</dt>\n" + dirs.map do |p|
					"<dd>#{p.to_link}</dd>\n"
				end.join << "\n"
				page << "<dt>Files</dt>\n" + files.map do |p|
					"<dd>#{p.to_link}</dd>\n"
				end.join << "\n"
				page << "</dl>\n"
				page << "#{BANNER}</body></html>"
			
			elsif File.exist? path
				div = CodeRay.scan_file(path).html :tab_width => 8, :wrap => :div
				div.replace <<-DIV
	<div #{STYLE}>
		#{backlinks}
#{div}
	</div>
	#{BANNER}
				DIV
				div.page
			end

		res['Content-Type'] = 'text/html'
	end
end

# 0xCODE = 49374 
module CodeRay
	PORT = 0xC0DE
end

server = WEBrick::HTTPServer.new :Port => CodeRay::PORT

server.mount '/', CodeRayServlet

server.mount_proc '/version' do |req, res|
	res.body = 'CodeRay::Version = ' + CodeRay::Version
	res['Content-Type'] = "text/plain"
end

trap("INT") { server.shutdown }
server.start
