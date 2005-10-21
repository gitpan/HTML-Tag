use strict;
use Test;

# use a BEGIN block so we print our plan before MyModule is loaded
BEGIN { plan tests => 5 }

# load your module...
use HTML::Tag;

# Helpful notes.  All note-lines must start with a "#".
print "# I'm testing HTML::Tag::DATE\n";

my $year = (localtime())[5]+1900;
my $obj = HTML::Tag->new(element=>'DATE', name=>'test');

ok(defined $obj);

ok($obj->html,qr/<script language=\"javascript\">\n\tvar html_tag_datetime_js_path = '';/ 
					&& qr/onclick=\"return showCalendar\(this/);
$obj = HTML::Tag->new(element=>'DATE', name=>'value_test', value=>"1969-07-21");
ok($obj->html,qr/<input type=\"hidden\" id=\"value_test_\d+\" name=\"value_test\" value=\"1969-07-21\" \/>/);

$obj = HTML::Tag->new(element=>'DATE', name=>'another_test', value=>"");
ok($obj->html,qr/<input type=\"hidden\" id=\"another_test_\d+\" name=\"another_test\" value=\"\" \/>/);

$obj = HTML::Tag->new(element=>'DATE', name=>'ya_test', value=>"77868");
ok($obj->html,qr/<input type=\"hidden\" id=\"ya_test_\d+\" name=\"ya_test\" value=\"77868\" \/>/);

