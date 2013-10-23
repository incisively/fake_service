# This middleware allows to define all methods from yaml file once.
module FakeService
  class Middleware
    def initialize(app)
      @app = app
    end

    # defines actions for each request in yaml file.
    def define_actions
      unless @action_defined
        hash = YAML.load(File.read(@file_path))
        hash.each do |k, v|
          v.each do |key, value|
            @app.class.define_action!(value["request"], value["response"])
          end
        end
        @action_defined = true
      end
    end

    # Rack call interface.
    def call(env)
      @file_path ||= @app.settings.file_path
      self.define_actions
      @app.call(env)
    end
  end
end