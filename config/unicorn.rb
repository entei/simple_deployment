worker_processes 2
user 'deployer', 'deployer'
preload_app true
timeout 30

project_name = 'simple_deployment'

root = "/var/www/#{ project_name }/current"

working_directory root

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "#{root}/tmp/pids/unicorn.pid"

# Unicorn socket
listen "/tmp/sockets/unicorn.sock"#, :backlog => 64

stderr_path "#{root}/log/unicorn.stderr.log"
stdout_path "#{root}/log/unicorn.stdout.log"

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
    ENV["BUNDLE_GEMFILE"] = File.join(root, 'Gemfile')
end
