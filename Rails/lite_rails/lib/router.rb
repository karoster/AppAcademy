class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    
    @pattern = pattern
    @http_method = http_method
    
    @controller = controller_class
    @rest_action = action_name

  end

  # checks if pattern matches path and method matches request method
  def matches?(req)
    (@pattern =~ req.path) && (req.request_method.downcase == @http_method.to_s)
  end

  # use pattern to pull out route params (save for later?)
  # instantiate controller and call controller action
  def run(req, res)
    # params = {}
    regex = Regexp.new(@pattern)
    match_data = regex.match(req.path)
    route_params = {}
    match_data.names.each { |key| route_params[key] = match_data[key] }

    instance_controller = @controller.new(req, res, route_params)
    instance_controller.invoke_action(@rest_action)
  end
end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  # simply adds a new route to the list of routes
  def add_route(pattern, method, controller_class, action_name)
    @routes << Route.new(pattern, method, controller_class, action_name)
  end

  def get(pattern, controller_class, action_name)
    add_route(pattern, :get, controller_class, action_name)
  end

  def post(pattern, controller_class, action_name)
    add_route(pattern, :post, controller_class, action_name)

  end

  def put(pattern, controller_class, action_name)
    add_route(pattern, :put, controller_class, action_name)

  end

  def delete(pattern, controller_class, action_name)
    add_route(pattern, :delete, controller_class, action_name)
  end

  # evaluate the proc in the context of the instance
  # for syntactic sugar :)
  def draw(&proc)
    self.instance_eval(&proc)
  end

  # make each of these methods that
  # when called add route
  [:get, :post, :put, :delete].each do |http_method|
  end

  # should return the route that matches this request
  def match(req)
    @routes.each do |route|
      return route if route.matches?(req)
    end
    nil
  end

  # either throw 404 or call run on a matched route
  def run(req, res)
    matched_route = match(req)
    if matched_route
      matched_route.run
    else
      res.status = 404
      res.write("could not match given route")
    end
  end
end
