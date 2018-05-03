heroku-prolog-buildpack
=======================

How hard can it be?

This is a very rough skeleton of a buildpack to enable SWI-Prolog-based applications to run on the Heroku service.

Your repository must contain a file swipl.manifest to indicate that it is a SWI-Prolog-buildpack application. If the file is empty, all the .pl files in the root directory of your repository will be compiled into a file called swipl-heroku.
If the file is not empty, the contents of the file will be compiled.

Your application must not define heroku/0 or heroku_db_connect/1. heroku_db_connect(-Connection) can be used to obtain a connection to the database connected to your instance. Currently only the primary database is supported (but it would not be
hard to add support for more). The server will automatically attach to the heroku HTTP stack. You can just define http-handlers and start processing requests!

Your Procfile should look like this:
web:    /app/swipl-heroku

If you have a file .preferred_swi_version in your root directory, then that version will be used (if possible). Otherwise you will get version 7.1.23.

Xpce is not currently included because of missing dependencies, but most other packages (including clib, libarchive, odbc, zlib, CQL) are. GMP, unixodbc and psqlodbc are included in builds. For reasons of practicality, you must use a precompiled build of the environment. This is because compilation of slugs is limited to 15 minutes, and the time taken to fetch and build SWI-Prolog and all its dependencies would frequently exceed this on the hobby tier.

An example app is available at https://github.com/thetrime/prolog-getting-started

You can compile other precompiled binaries using Docker and https://github.com/thetrime/heroku-build-swipl.git

To do:
------
   * Provide a mechanism for generating/upgrading a database schema based on facts. Currently you must create the database yourself (somehow?)
   * Is -c the best approach? Perhaps it'd be better to create a lot of qlfs in the cache, then have a process that combines them all into a PRA. This would be much more efficient for larger applications

