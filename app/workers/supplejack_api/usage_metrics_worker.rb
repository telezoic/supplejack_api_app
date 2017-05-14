# frozen_string_literal: true
# The majority of the Supplejack API code is Crown copyright (C) 2014, New Zealand Government, 
# and is licensed under the GNU General Public License, version 3.
# One component is a third party component. See https://github.com/DigitalNZ/supplejack_api for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and 
# the Department of Internal Affairs. http://digitalnz.org/supplejack

module SupplejackApi
  class UsageMetricsWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'default'

    def perform
      Rails.logger.level = 1 unless Rails.env.development?
      Rails.logger.info "UsageMetrics:[#{Time.now}]: worker start"
      SupplejackApi::UsageMetrics.build_metrics
      Rails.logger.info "UsageMetrics:[#{Time.now}]: worker complete"
    end
  end
end
