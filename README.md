tw_data_server
==============

## The Cowboy based data server for tagwars

### Installation

* Please note. This installation procedure may not have been implemented yet. This is only valid for unix-like systems. You will need `make` and `git` on your system.

Start by cloning the repository:

	git clone https://github.com/SEM-Qi/tw_data_server.git

Go into the 'tw_data_server` directory.

	cd PATH_TO_DIR/tw_data_server

Once there type `make` into the command line.

There should be a long output as the project builds. Once it is finished enter the following to start up the program in an erlang shell.

	./_rel/tw_data_server_release/bin/tw_data_server_release console

When you make changes you can run `make` again to rebuild.

### Currently valid http query paths

* Currently a running implementation of the server can be found on [picard.chalmers.skip.se](picard.chalmers.skip.se)

Top level - will in next update serve either the main page or simply host crossdomain.xml. Currently says "Hi"

	/

Get the most recent list of avaialable tags as JSON

	/updatelist

Get a JSON object with the fudged 10 seconds of distribution for a tag (#music used as example).

	/tagattack?tag=music

Test POST handler - requires JSON object in body to match expected id value.

	/testpost

Test RESTful implementation

	/deeper


## Dependencies

### [tag_riak](https://github.com/SEM-Qi/tag_riak)
### [cowboy](https://github.com/ninenines/cowboy)

An erlang riak client.

## Author

* Team QI