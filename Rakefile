task :default => [:clear, :specs, :cukes_domain, :cukes_web]
task "clear" do
  sh "clear"
end
desc "run the specs"
task "specs" do
  sh "rspec --color"
end

desc "run the cukes (web)"
task "cukes_web" do
  sh "cucumber -f progress"
end

desc "run the cukes (domain)"
task "cukes_domain" do
  sh "cucumber -f progress DOMAIN=1"
end
