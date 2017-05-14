# use this file to easily define all of your cron jobs.
#
# it's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/cron

# example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "mymodel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "anothermodel.prune_old_records"
# end

# learn more: http://github.com/javan/whenever

set :environment, :development if ENV['RAILS_ENVIRONMENT'] == 'development' || ENV['RAILS_ENVIRONMENT'] == nil
set :output, {:error => 'log/whenever.stderr.log', :standard => 'log/whenever.stdout.log'}

every '*/5 * * * *' do
  runner 'SupplejackApi::InteractionMetricsWorker.perform_async'
end

every '*/1 * * * *' do
  runner 'SupplejackApi::ClearIndexBuffer.perform_async'
end

every '57 23 * * *' do
  runner 'SupplejackApi::DailyMetricsWorker.perform_async'
end

every '30 23 * * *' do
  runner 'SupplejackApi::StoreSserActivityWorker.perform_async'
end
