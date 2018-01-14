lock '3.10.1'

set :application, 'v_studio'
set :repo_url, 'git@github.com:youhei19880130/wayo-batch.git'
set :deploy_to, '/var/www/app/somesys'
set :pty, true
set :linked_files, %w{ config/database.yml config/secrets.yml }
set :git
set :rbenv_ruby, '2.3.1'
set :rbenv_path, '/home/ec2-user/.rbenv'
set :rbenv_type, :system

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  # linked_files で使用するファイルをアップロードするタスク
  # deployが行われる前に実行する必要がある。
  desc 'upload important files'
  task :upload do
    on roles(:app) do |host|
      execute :mkdir, '-p', "#{shared_path}/config"
      upload!('config/database.yml',"#{shared_path}/config/database.yml")
      upload!('config/secrets.yml',"#{shared_path}/config/secrets.yml")
    end
  end
end
