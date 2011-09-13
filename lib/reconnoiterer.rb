require_relative 'reconnoiterer/app'

module Reconnoiterer
  def setup
    app = App.new
    port = 5555
    host = 'localhost'

    puts "> Starting the core on brb://#{host}:#{port}"
    BrB::Service.start_service(:object => app.outpost, :verbose => true, :host => host, :port => port)
    EM.reactor_thread.join
  end
end

Thread.abort_on_exception = true
