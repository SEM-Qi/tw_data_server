tw_data_server
==============

## The Cowboy based data server for tagwars

### Installation

This is only valid for unix-like systems. You will need `make` and `git` on your system.

Start by cloning the repository:

	git clone https://github.com/SEM-Qi/tw_data_server.git

Go into the 'tw_data_server` directory.

	cd PATH_TO_DIR/tw_data_server

Once there type `make` into the command line.

There should be a long output as the project builds. Once it is finished (you should see a success message as your last output) enter the following to start up the program in an erlang shell. 

	sudo ./_rel/tw_data_server_release/bin/tw_data_server_release console

When you make changes you can run `make` again to rebuild.

### Currently valid http query paths


Top level - hosts static file crossdomain.xml - vital for ensureing Unity can connect

	/

Get the most recent list of avaialable tags as JSON

	/updatelist

Get a JSON object with the fudged 10 seconds of distribution for a tag (#music used as example).

	/tagattack?tag=music

Set Auth Key
	
	/setkey

Getuserinfo

	/getuserinfo

Update Auth Key
	
	/updatekey
	
Check if authorised

	/authorize


## Dependencies

### [tag_riak](https://github.com/SEM-Qi/tag_riak)
### [cowboy](https://github.com/ninenines/cowboy)

An erlang riak client.

## Author

* Team QI