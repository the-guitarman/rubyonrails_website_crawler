# Place in /config/puma/production.rb

rails_env = "production"
environment rails_env

app_dir  = "#{ENV['HOME']}/www/website_crawler"
pid_file = "#{app_dir}/tmp/pids/puma.pid"
socket_file = "#{app_dir}/tmp/pids/puma.sock"
state_file  = "#{app_dir}/tmp/pids/puma.state"

bind "unix://#{socket_file}"
pidfile pid_file
state_path state_file
directory "#{app_dir}/"

stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true

workers 2
threads 1,2

daemonize true

activate_control_app "unix://#{socket_file}"

prune_bundler