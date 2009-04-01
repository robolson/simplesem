# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{simplesem}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rob Olson"]
  s.date = %q{2009-04-01}
  s.default_executable = %q{simplesem}
  s.description = %q{SIMPLESEM Interpreter}
  s.email = %q{rko618@gmail.com}
  s.executables = ["simplesem"]
  s.extra_rdoc_files = ["LICENSE", "README.textile", "bin/simplesem", "lib/simplesem/arithmetic.treetop", "lib/simplesem/arithmetic_node_classes.rb", "lib/simplesem/simple_sem.treetop", "lib/simplesem/simplesem_program.rb", "lib/simplesem.rb"]
  s.files = ["LICENSE", "Manifest", "README.textile", "Rakefile", "bin/simplesem", "lib/simplesem/arithmetic.treetop", "lib/simplesem/arithmetic_node_classes.rb", "lib/simplesem/simple_sem.treetop", "lib/simplesem/simplesem_program.rb", "lib/simplesem.rb", "sample_programs/case-statement.txt", "sample_programs/gcd.txt", "sample_programs/hello-world.txt", "sample_programs/while-loop.txt", "simplesem.gemspec", "simplesem.tmproj", "test/simplesem_test.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/robolson/simplesem}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Simplesem", "--main", "README.textile"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{simplesem}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{SIMPLESEM Interpreter}
  s.test_files = ["test/simplesem_test.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<treetop>, [">= 1.2.4"])
    else
      s.add_dependency(%q<treetop>, [">= 1.2.4"])
    end
  else
    s.add_dependency(%q<treetop>, [">= 1.2.4"])
  end
end
