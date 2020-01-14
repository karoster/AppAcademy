require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req, @res = req, res
    @params = req.params.merge(route_params)
    @already_built_response = false
    @@protect_forgery ||= false
  end

  #allow user of rails_lite to enable forgery protection
  def self.protect_from_forgery
    @@protect_forgery = true
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  #validating that the authenticity token exists, and is equal to the authenticity token
  #submitted on the POST request form
  def check_authenticity_token
    cookie = @req.cookies["authenticity_token"]
    unless cookie && cookie == params['authenticity_token']
      raise "Invalid authenticity token"
    end
  end

  #lazily create the authenticity token and store it in cookies
  #this method is only called in GET requests
  def form_authenticity_token
    @token ||= SecureRandom::urlsafe_base64(16)
    res.set_cookie('authenticity_token', value: @token, path: '/')
    @token
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "Already built response" if already_built_response?
    res['location'] = url
    res.status = 302
    @already_built_response = true
    session.store_session(res)

  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    root_path = File.dirname(__FILE__) + "/../views"
    leaf_path = self.class.name.underscore + "/" + template_name.to_s + ".html.erb"
    file_path = File.join(root_path, leaf_path)
    file_data = File.read(file_path)
    file_content = ERB.new(file_data).result(binding)
    render_content(file_content, "text/html")
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise "Already built response" if already_built_response?
    res['Content-type'] = content_type
    res.write(content)
    @already_built_response = true
    session.store_session(res)
  end

  
  def protecting_from_forgery?
    @@protect_forgery
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    if !req.get? && protecting_from_forgery?
      check_authenticity_token
    else
      form_authenticity_token
    end

    self.send(name)
    render(name) unless already_built_response?

    nil
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(req)
  end

  #method exposing a 'Flash' object
  def flash
    @flash ||= Flash.new(req)
  end
end

