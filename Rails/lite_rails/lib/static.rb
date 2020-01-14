class Static
  attr_reader :root, :app, :file_distrib
  # attr_accessor :app
  def initialize(app)
    @app = app
    @root = :public
    @file_distrib = FileDistrib.new(@root)
  end

  def call(env)
    req = Rack::Request.new(env)
    path = req.path

    if can_serve?(path)
      res = file_distrib.call(env)
    else
      res = app.call(env)
    end

    res
  end

  private
  
  def can_serve?(path)
    #returns nil or truthy value if http path belongs to public data.
    path.index("/#{root}")
  end

end



class FileDistrib

  MIME = {
    '.txt' => 'text/plain',
    '.jpg' => 'image/jpeg',
    '.zip' => 'application/zip',
    '.png' => 'image/png'
  }

  def initialize(root)
    @root = root
  end

  def call(env)
    res = Rack::Response.new
    file_name = requested_file_name(env)

    if File.exists?(file_name)
      serve_file(file_name, res)
    else
      res.status = 404
      res.write("File Not Found")
    end
    res
  end

  private

  def serve_file(file_name, res)
    extension = File.extname(file_name)
    content_type = MIME[extension]
    file = File.read(file_name)
    res["Content-type"] = content_type
    res.write(file)
  end

  def requested_file_name(env)
    req = Rack::Request.new(env)
    path = req.path
    dir = File.dirname(__FILE__)
    File.join(dir, "..", path)
  end
end

