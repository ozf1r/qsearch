#!/usr/bin/perl
use strict;
use warnings;
use XML::LibXML;

# Check if the correct number of arguments is provided
if (@ARGV < 2) {
    die "Usage: $0 <tag_content> <verse1> [<verse2> ...]\n";
}

my $tag_content = shift @ARGV;
my @verses = @ARGV;

# XML file path
my $xml_file = 'topics.xml';  # Replace with the actual XML file name

# Create or load the XML document
my $parser = XML::LibXML->new;
my $doc;
if (-e $xml_file) {
    $doc = $parser->parse_file($xml_file);
} else {
    $doc = XML::LibXML::Document->new('1.0', 'UTF-8');
    my $root = $doc->createElement('tags');
    $doc->setDocumentElement($root);
}

# Create a new tag element
my $new_tag = $doc->createElement('tag');
$new_tag->setAttribute('content', $tag_content);

# Add verses to the new tag
foreach my $verse_text (@verses) {
    my $verse = $doc->createElement('verse');
    $verse->appendTextNode($verse_text);
    $new_tag->appendChild($verse);
}

# Add the new tag to the document
$doc->documentElement->appendChild($new_tag);

# Save the modified XML document back to the file
$doc->toFile($xml_file, 1);

print "Tag '$tag_content' added successfully.\n";
