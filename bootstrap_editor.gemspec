Gem::Specification.new do |spec|
  spec.name = %q{bootstrap_editor}
  spec.version = "0.0.0"
  spec.author = "Arthur"
  spec.date = %q{2020-07-07}
  spec.summary = %q{bootstrap_editor}
  spec.files = [
    'lib/bootstrap_editor.rb',
    'lib/bootstrap_editor/hyper_component.rb',
    'lib/bootstrap_editor/input.rb',
    'lib/bootstrap_editor/editor.rb',
   ]
  spec.require_paths = ["lib"]

  spec.add_dependency 'hyper-component', '= 1.0.alpha1.5'

end
