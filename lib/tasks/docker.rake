# The Supplejack Worker code is Crown copyright (C) 2014, New Zealand Government, 
# and is licensed under the GNU General Public License, version 3. 
# See https://github.com/DigitalNZ/supplejack_worker for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ
# and the Department of Internal Affairs. http://digitalnz.org/supplejack

namespace :docker do
  desc 'Seed data with default user'
  task :seed => :environment do
    unless SupplejackApi::User.where(authentication_token: 'apikey').first
      user = SupplejackApi::User.create({
        name: 'SupplejackApi',
        email: 'info@digitalnz.org',
        password: 'password',
        password_confirmation: 'password',
        role: 'admin'
      })

      user.authentication_token = 'apikey'
      user.save
    end
  end
end
