# frozen_string_literal: true
# The majority of the Supplejack API code is Crown copyright (C) 2014, New Zealand Government, 
# and is licensed under the GNU General Public License, version 3.
# One component is a third party component. See https://github.com/DigitalNZ/supplejack_api for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and 
# the Department of Internal Affairs. http://digitalnz.org/supplejack

module SupplejackApi
  class StoreUserActivityWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'default'

    def perform
      Rails.logger.info "[StoreUserActivityWorker][#{Time.now}] Starting Execution"

      begin
        SupplejackApi::User.all.no_timeout.each do |user|
          user.user_activities << SupplejackApi::UserActivity.build_from_user(user.daily_activity) unless user.daily_activity_stored
          user.calculate_last_30_days_requests
          user.reset_daily_activity
          user.save
        end


        Rails.logger.info "[StoreUserActivityWorker][#{Time.now}] Generating SiteActivity"
        SupplejackApi::SiteActivity.generate_activity
        Rails.logger.info "[StoreUserActivityWorker][#{Time.now}] Completed SiteActivity"
      rescue => e
        Rails.logger.info "[StoreUserActivityWorker][#{Time.now}] Exception (#{e})"
      end
    end
  end
end
