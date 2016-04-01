class ApiConstraints
  def initialize(options)
    @version, @default = options[:version], options[:default]
  end

  def matches?(req)
    @default || req.headers['Accept'].include?("application/vnd.aureso.v#{@version}")
  end
end