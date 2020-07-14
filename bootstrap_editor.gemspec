Gem::Specification.new do |spec|
  spec.name = %q{bootstrap_editor}
  spec.version = "0.0.0"
  spec.author = "Arthur"
  spec.date = %q{2020-07-07}
  spec.summary = %q{bootstrap_editor}
  # spec.files = [
  #   'lib/bootstrap_editor.rb',
  #   'lib/bootstrap_editor/hyper_component.rb',
  #   'lib/bootstrap_editor/input.rb',
  #   'lib/bootstrap_editor/editor.rb',
  #   'lib/bootstrap_editor/error_message.rb',
  #   'lib/bootstrap_editor/preview.rb',
  #   'lib/bootstrap_editor/app.rb',
  #   'lib/bootstrap_editor/variables_panel.rb',
  #   'lib/bootstrap_editor/sass.rb',
  #   'lib/assets/javascripts/download.js',
  #   'lib/assets/javascripts/popper.js',
  #   'lib/assets/javascripts/sass.js',
  #   'lib/assets/javascripts/sass.worker.js',
  #   'lib/assets/stylesheets/bootstrap_editor.scss'
  #  ]
  spec.files = Dir[
    'lib/**/*'
  ]
  spec.require_paths = ["lib"]

  spec.add_dependency 'hyper-component', '= 1.0.alpha1.5'
  spec.add_dependency 'hyper-router', '= 1.0.alpha1.5'
  spec.add_dependency 'hyper-state', '= 1.0.alpha1.5'
  spec.add_dependency 'bootstrap', '~> 4.5'
end
