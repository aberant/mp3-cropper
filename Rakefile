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
  Dir["data/**/*.mp3"].each do |file|
    Mp3Cropper::Recording.create( :name => file )
  end
end