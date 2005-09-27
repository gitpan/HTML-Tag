package HTML::Tag::SPAN;

use base 'HTML::Tag';

$HTML::Tag::SPAN::VERSION = '0.02';

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
