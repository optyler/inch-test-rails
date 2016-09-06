# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ENV['IMPORT_FTP_PATH'] = 'ftp'
ENV['IMPORT_PERSON_CSV_FILE'] = 'person.csv'
ENV['IMPORT_BUILDING_CSV_FILE'] = 'buildings.csv'
