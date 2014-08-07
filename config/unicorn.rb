worker_processes 2
user 'deployer', 'deployer'
preload_app true
timeout 30

project_name = 'simple_deployment'

working_directory "/var/www/#{ project_name }"

# Unicorn socket
listen "/tmp/sockets/unicorn.sock"#, :backlog => 64

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/var/www//#{ project_name }/tmp/pids/unicorn.pid"

stderr_path "/var/www/#{ project_name }/log/unicorn.stderr.log"
stdout_path "/var/www/#{ project_name }/log/unicorn.stdout.log"

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
    ENV["BUNDLE_GEMFILE"] = File.join(root, 'Gemfile')
end
