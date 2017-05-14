# frozen_string_literal: true
# The majority of the Supplejack API code is Crown copyright (C) 2014, New Zealand Government, 
# and is licensed under the GNU General Public License, version 3.
# One component is a third party component. See https://github.com/DigitalNZ/supplejack_api for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and 
# the Department of Internal Affairs. http://digitalnz.org/supplejack

 module SupplejackApi
  class FlushOldRecordsWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'low'

    def perform(source_id, job_id)
      ::Record.flush_old_records(source_id, job_id)
    end
  end
end
