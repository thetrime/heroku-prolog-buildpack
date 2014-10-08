heroku-prolog-buildpack
=======================

How hard can it be?

This is a very rough skeleton of a buildpack to enable SWI-Prolog-based applications to run on the Heroku service.

Your repository must contain a file swipl.manifest to indicate that it is a SWI-Prolog-buildpack application. If the file is empty, all the .pl files in the root directory of your repository will be compiled into a file called swipl-heroku.
If the file is not empty, the contents of the file will be compiled.

Your application must not define heroku/0 or heroku_db_connect/1. heroku_db_connect(-Connection) can be used to obtain a connection to the database connected to your instance. Currently only the primary database is supported (but it would not be
hard to add support for more).

If you have a file .preferred_swi_version in your root directory, then that version will be compiled (if possible). Otherwise you will get version 7.1.23.

Xpce and libarchive are not currently included because of missing dependencies, but most other packages (including CQL) are. GMP, unixodbc and psqlodbc are fetched and built if necessary.


To do:
------
Provide a mechanism for generating/upgrading a database schema based on facts. Currently you must create the database yourself (somehow?)
Is -c the best approach? Perhaps it'd be better to create a lot of qlfs in the cache, then have a process that combines them all into a PRA. This would be much more efficient for larger applications
Probably should provide libarchive - it's not likely to be that tricky

