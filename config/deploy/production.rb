set :pty, true
server 'ec2-18-220-198-32.us-east-2.compute.amazonaws.com',
  user: 'ec2-user',
  roles: %w{app db web},
  ssh_options: {
    keys: [File.expand_path('~/.ssh/wayo-production-01.pem')],
    forward_agent: true
  }

set :linked_dirs, %w{bin log tmp/backup tmp/pids tmp/sockets vendor/bundle}

set :unicorn_pid, "/var/www/app/somesys/shared/tmp/pids/unicorn.pid"
set :unicorn_exec, -> { "unicorn_rails" }
