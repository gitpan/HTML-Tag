use strict;
use Test;

# use a BEGIN block so we print our plan before MyModule is loaded
BEGIN { plan tests => 4 }

# load your module...
use HTML::Tag;

# Helpful notes.  All note-lines must start with a "#".
print "# I'm testing HTML::Tag:TEXTAREA\n";

my $obj = HTML::Tag->new(element=>'TEXTAREA');

ok(defined $obj);

ok($obj->html,'<TEXTAREA cols="22" rows="3"></TEXTAREA>');

$obj->name('test');

ok($obj->html,'<TEXTAREA name="test" cols="22" rows="3"></TEXTAREA>');

$obj->value('tv');

ok($obj->html,'<TEXTAREA name="test" cols="22" rows="3">tv</TEXTAREA>');
