worker_processes 2
user 'deployer', 'deployer'
preload_app true
timeout 30

project_name = 'simple_deployment'

working_directory "/var/www/#{ project_name }"

listen "/tmp/sockets/unicorn.sock"#, :backlog => 64
pid "/var/www//#{ project_name }/tmp/pids/unicorn.pid"

stderr_path "/var/www/#{ project_name }/log/unicorn.stderr.log"
stdout_path "/var/www/#{ project_name }/log/unicorn.stdout.log"
