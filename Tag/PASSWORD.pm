package HTML::Tag::PASSWORD;

use base 'HTML::Tag';

$HTML::Tag::PASSWORD::VERSION = '0.02';

use Class::Builder (	
	'-methods' 	=> { constructor => 'create' },
	has_end_tag => { boolean => 0 }, 
	element			=> { string => 'PASSWORD'},
	tag 				=> { string => 'INPUT'},
	type 				=> { string => 'password'},
	name 				=> { string => ''},
	value				=> { string => ''},
	tabindex		=> { number => ''},
	attributes 	=> { arrayref => ['type','name','value','tabindex'] },
);


1;

# vim: set ts=2:
