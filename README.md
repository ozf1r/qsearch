# qsearch
A short Perl script to search the www.openbible.info topical Bible database for topics.

The database from https://www.openbible.info/topics/ has been converted to XML. XML makes more sense to me.

You need to have diatheke installed to print the Bible verses and need XML::LibXML in Perl.

You need to edit the path to topics.xml and set my $module = "FinPR"; to the diatheke module you want to see results from.

# usage

./qsearch.pl topic

Use qadd.pl to add topics to the database, if you want.

# that's all!
