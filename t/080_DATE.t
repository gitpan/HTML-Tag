use strict;
use Test;

# use a BEGIN block so we print our plan before MyModule is loaded
BEGIN { plan tests => 1 }

# load your module...
use HTML::Tag;

# Helpful notes.  All note-lines must start with a "#".
print "# I'm testing HTML::Tag::DATE\n";

my $year = (localtime())[5]+1900;
my $obj = HTML::Tag->new(element=>'DATE', name=>'test');

ok(defined $obj);

#print $obj->html;

#$obj = HTML::Tag->new(element=>'DATE', name=>'value_test', value=>"1969-07-21");
#print $obj->html;
#
#$obj = HTML::Tag->new(element=>'DATE', name=>'another_test', value=>"");
#print $obj->html;
#
#$obj = HTML::Tag->new(element=>'DATE', name=>'ya_test', value=>"77868");
#print $obj->html;
