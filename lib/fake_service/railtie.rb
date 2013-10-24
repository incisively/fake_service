module Rails
  class FakeServiceRailtie < Rails::Railtie
    rake_tasks do
      load "tasks/fake_service.rake"
    end
  end
end
