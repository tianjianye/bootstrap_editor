return if RUBY_ENGINE == 'opal'


module BootstrapEditor
  class Engine < ::Rails::Engine
    isolate_namespace BootstrapEditor
    initializer "static assets" do |app|
      app.middleware.insert_before(::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public")
    end
  end
end