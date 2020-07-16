Gem::Specification.new do |spec|
  spec.name = %q{bootstrap_editor}
  spec.version = "0.0.0"
  spec.author = "Arthur"
  spec.date = %q{2020-07-07}
  spec.summary = %q{bootstrap_editor}

  spec.files += Dir['{public,lib}/**/*']
  spec.require_paths = ["lib"]

  spec.add_dependency 'hyper-component', '= 1.0.alpha1.5'
  spec.add_dependency 'hyper-router', '= 1.0.alpha1.5'
  spec.add_dependency 'hyper-state', '= 1.0.alpha1.5'
end
