require_relative 'task_helpers.rb'

namespace :auctions do

  desc 'End overdue auctions'
  task end_overdue: :environment do
    TaskHelpers::end_overdue_auctions
  end

end
