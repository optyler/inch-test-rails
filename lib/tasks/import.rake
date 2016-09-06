require 'CSV'
require 'Utils'

namespace :importcsv do


	desc "import buildings from CSV file"
	task buildings: :environment do
		filename = File.join Rails.root, ENV['IMPORT_FTP_PATH'], ENV['IMPORT_BUILDING_CSV_FILE']
		Utils.import_generic(Building, filename)
	end

	desc "import persons from CSV file"
	task person: :environment do
		filename = File.join Rails.root, ENV['IMPORT_FTP_PATH'], ENV['IMPORT_PERSON_CSV_FILE']
		Utils.import_generic(Person, filename)
	end

	desc "import persons and buildings from CSV file"
	task all: :environment do
	  Rake::Task["importcsv:person"].invoke
	  Rake::Task["importcsv:buildings"].invoke
	end

end