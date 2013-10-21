class FakeMiddleware
  def initialize(app)
    @file_path = File.expand_path('../reqres.yml', __FILE__)
    @app = app
  end

  def define_actions
    unless @action_defined
      puts "-----------define action-----------"
      hash = YAML.load(File.read(@file_path))
      hash.each do |k, v|
        v.each do |key, value|
          expected_request = value["request"]
          expected_response = value["response"]
          @app.class.send(expected_request["method"].downcase, expected_request["full_path"], provides: :json) do
            pass unless equal_json_bodies?(expected_request["body"], request.body.read)
            expected_response["body"]
            status expected_response["code"]
          end
        end
      end
      @action_defined = true
    end
  end

  def call(env)
    puts "self: #{self}"
    self.define_actions
    @app.call(env)
  end
end