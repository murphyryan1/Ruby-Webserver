require 'thread'
require 'socket'
require 'erb'

class RequestHandler
	def initialize(session)
		@session = session
	end

	def process
		while @session.gets.chop.length != 0
		end
		@session.puts "HTTP/1.1 200 OK"
		@session.puts "content-type: text/html"
		@session.puts ""

		myfile = IO.readlines("ryan.html")
		@session.puts myfile

		@session.close

	end
end

server = TCPServer.new("0.0.0.0", "8888")

while (session = server.accept)
	Thread.new(session) do |newSession|
		RequestHandler.new(newSession).process
	end
end
