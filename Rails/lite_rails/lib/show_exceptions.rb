require 'erb'

class ShowExceptions
  def initialize(app)
    @app = app

  end

  attr_accessor :app

  def call(env)
    begin
      @app.call(env)
    rescue => exception
      render_exception(exception)
      # return [exception.message, '500', exception.class]
    end
  end

  private

  def render_exception(e)
    # exception = e
    path = File.dirname(__FILE__) + "/template/rescue.html.erb"
    file_data = File.read(path)

    file_content = ERB.new(file_data).result(binding)

    res = Rack::Response.new( [file_content], '500', { 'Content-type' => 'text/html' } )

    ['500', {'Content-type' => 'text/html'}, file_content]
  end

end
