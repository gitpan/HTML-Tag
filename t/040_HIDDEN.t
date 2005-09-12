use strict;
use Test;

# use a BEGIN block so we print our plan before MyModule is loaded
BEGIN { plan tests => 4 }

# load your module...
use HTML::Tag;

# Helpful notes.  All note-lines must start with a "#".
print "# I'm testing HTML::Tag:HIDDEN\n";

my $obj = HTML::Tag->new(element=>'HIDDEN');

ok(defined $obj);

ok($obj->html,'<INPUT type="hidden" />');

$obj->name('test');

ok($obj->html,'<INPUT type="hidden" name="test" />');

$obj->value('tv');

ok($obj->html,'<INPUT type="hidden" name="test" value="tv" />');
