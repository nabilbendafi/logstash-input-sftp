Gem::Specification.new do |s|
  s.name = 'logstash-input-sftp'
  s.version = '0.0.1'
  s.licenses = ['Apache-2.0']
  s.summary = "This input plugin sync remote file using SFTP at a definable interval. LogStash::Inputs::File is then used to follow updates."
  s.description = "This gem is a Logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/logstash-plugin install gemname. This gem is not a stand-alone program"
  s.authors = ["Nabil Bendafi"]
  s.email = 'nabil@bendafi.fr'
  #s.homepage = "http://nabilbendafi.github.io/logstash-input-shftp"
  s.require_paths = ["lib"]

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "input" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core", ">= 2.0.0", "< 3.0.0"
  s.add_runtime_dependency 'logstash-codec-plain'
  s.add_runtime_dependency 'stud', '>= 0.0.22'
  s.add_runtime_dependency "net-sftp", ">= 2.1.2"
  s.add_runtime_dependency '', '>= 0.0.22'
  s.add_development_dependency 'logstash-devutils', '>= 0.0.16'
end