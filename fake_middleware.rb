class FakeMiddleware
  def initialize(app)
    @app = app
  end

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

  def call(env)
    @file_path ||= @app.settings.file_path
    self.define_actions
    @app.call(env)
  end
end