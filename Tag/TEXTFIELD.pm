package HTML::Tag::TEXTFIELD;

use base 'HTML::Tag';

$HTML::Tag::TEXTFIELD::VERSION = '0.02';

use Class::Builder (
	'-methods' 	=> { constructor => 'create' },
	has_end_tag => { boolean => 0 }, 
	element			=> { string => 'TEXTFIELD'},
	tag 				=> { string => 'INPUT'},
	type 				=> { string => 'text'},
	name 				=> { string => ''},
	value				=> { string => ''},
	tabindex		=> { number => ''},
	attributes 	=> { arrayref => ['type','name','value','tabindex'] },
 
);


1;

# vim: set ts=2:
