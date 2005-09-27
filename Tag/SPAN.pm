package HTML::Tag::SPAN;

use strict;
use warnings;

use base 'HTML::Tag';

$HTML::Tag::SPAN::VERSION = '0.03';

use Class::Builder (
	'-methods' 	=> { constructor => 'create' },
	has_end_tag => { boolean => 1 }, 
	element			=> { string => 'SPAN'},
	tag 				=> { string => 'SPAN'},
	name 				=> { string => ''},
	value				=> { string => ''},
	inner				=> { string => ''},
	attributes 	=> { arrayref => ['name','value'] },
 
);


1;

# vim: set ts=2:
