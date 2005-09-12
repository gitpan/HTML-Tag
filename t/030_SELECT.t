use strict;
use Test;
use Tie::IxHash;

# use a BEGIN block so we print our plan before MyModule is loaded
BEGIN { plan tests => 5 }

# load your module...
use HTML::Tag;

# Helpful notes.  All note-lines must start with a "#".
print "# I'm testing HTML::Tag::SELECT\n";

my $obj = HTML::Tag->new(element=>'SELECT', name=>'test');
use Tie::IxHash;

ok(defined $obj);

ok($obj->html,'<SELECT name="test"></SELECT>');

tie my %values, 'Tie::IxHash', 'k1' => 'v1','k2' => 'v2', 'k3' => 'v3';

$obj->value(\%values);

ok($obj->html,qr/^<SELECT\sname="test"><OPTION\svalue="k1">v1<\/OPTION>/);

$obj->selected('k2');

ok($obj->html,qr/<OPTION\svalue="k2"\sselected>v2<\/OPTION>/);

$obj->maybenull(1);

ok($obj->html,qr/^<SELECT\sname="test"><OPTION\svalue=""><\/OPTION>/);
