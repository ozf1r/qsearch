#!/usr/bin/perl
use strict;
use warnings;
use XML::LibXML;

my $module = "FinPR";

# Check if a tag argument is provided
if (@ARGV != 1) {
    die "Usage: $0 <tag>\n";
}

my $tag_to_find = $ARGV[0];

# Parse the XML file
my $xml_file = '/home/user/perl/qbiblia/topics.xml';  # Replace with the actual XML file name
my $parser = XML::LibXML->new;
my $doc = $parser->parse_file($xml_file);

# Find tags matching the provided tag content
my @matching_tags = $doc->findnodes("/tags/tag[\@content='$tag_to_find']");

# Print verses for matching tags
foreach my $tag (@matching_tags) {
    my $content = $tag->getAttribute('content');
    print "Tag: $content\n";

    my @verses = $tag->findnodes('verse');
    foreach my $verse (@verses) {
        my $verse_text = $verse->textContent;
        # print "  $verse_text\n";
        my $output = `diatheke -b $module -k $verse_text`;
        print $output . "\n";
    }
}

# If no matching tags were found
if (!@matching_tags) {
    print "No matching tags found for '$tag_to_find'.\n";
}
