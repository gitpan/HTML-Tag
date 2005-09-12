use strict;
use Test;
use Tie::IxHash;

# use a BEGIN block so we print our plan before MyModule is loaded
BEGIN { plan tests => 4 }

# load your module...
use HTML::Tag;

# Helpful notes.  All note-lines must start with a "#".
print "# I'm testing HTML::Tag::YEAR\n";

my $year = (localtime())[5]+1900;
my $obj = HTML::Tag->new(element=>'YEAR', name=>'test',from => $year);
use Tie::IxHash;

ok(defined $obj);

ok($obj->html,qr/<OPTION\svalue="$year"\sselected>$year<\/OPTION>/);

$year++;

$obj->selected($year);

ok($obj->html,qr/<OPTION\svalue="$year"\sselected>$year<\/OPTION>/);

$obj->maybenull(1);

ok($obj->html,qr/^<SELECT\sname="test"><OPTION\svalue=""><\/OPTION>/);
