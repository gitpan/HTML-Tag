package HTML::Tag::HIDDEN;

$HTML::Tag::HIDDEN::VERSION = '0.02';

use base 'HTML::Tag';

use Class::Builder (
	'-methods' 	=> { constructor => 'create' },
	has_end_tag => { boolean => 0 }, 
	element			=> { string => 'HIDDEN'},
	tag 				=> { string => 'INPUT'},
	type 				=> { string => 'hidden'},
	name 				=> { string => ''},
	value				=> { string => ''},
	attributes 	=> { arrayref => ['type','name','value'] },
 
);


1;

# vim: set ts=2:
