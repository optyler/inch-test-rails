# general information

* Default configuration 

	- by default, files will be searched in `/ftp` folder
	- by default, the client task will look for a file named `person.csv` in the ftp folder
	- by default, the buildings task will look for a file named `buildings.csv` in the ftp folder
	
* Customize imports 

	- You can change the folder or the csv filenames configuration by changing environment variable located in `/config/environment.rb`

* Launch import tasks
Go to your root application folder then launch one of these tasks

	- `rake importcsv:all` to import all kind of files
	- `rake importcsv:person` to import only persons
	- `rake importcsv:buildings` to import only buildings

# TODO

* tests
* optimisation
* doc
