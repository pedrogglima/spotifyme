# frozen_string_literal: true

# Testing for empty resources
# load './db/seeds/1_users.rb'

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }
