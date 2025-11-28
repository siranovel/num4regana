require  'rake/javaextensiontask'

jars = Dir.glob("lib/*.jar")
Rake::JavaExtensionTask.new(name='num4regana')  do | ext |
  ext.release          = '23'
  ext.classpath        = jars.map { |x| File.expand_path x }.join ":"
end
task :default => [:compile]


