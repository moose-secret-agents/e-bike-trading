require 'rufus-scheduler'
require_relative '../../lib/tasks/task_helpers'

s = Rufus::Scheduler.singleton

s.every '10s' do
  TaskHelpers::end_overdue_auctions
end