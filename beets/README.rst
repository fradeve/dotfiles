If you are moving the music collection to a new directory, the following SQLite
command will update the path for all the files:

.. code-block:: sql

   UPDATE items SET path = replace( path, '/home/fradeve/oldfolder', '/home/fradeve/newfolder');

