require 'spec/rake/spectask'
$:.unshift 'lib'

require 'mp3_cropper'

task :default => :spec

Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

desc "task to import the new files"
task :import do
  Mp3Cropper::Recording.import!
end