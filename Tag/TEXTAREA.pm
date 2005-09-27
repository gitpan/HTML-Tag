package HTML::Tag::TEXTAREA;

use base 'HTML::Tag';

$HTML::Tag::TEXTAREA::VERSION = '0.02';

use Class::Builder (
	'-methods' 	=> { constructor => 'create' },
	has_end_tag => { boolean => 1 }, 
	element			=> { string => 'TEXTAREA'},
	tag 				=> { string => 'TEXTAREA'},
	name 				=> { string => ''},
	value				=> { string => ''},
	tabindex		=> { number => ''},
	cols				=> { number => 22 },
	rows				=> { number => 3 },
	attributes 	=> { arrayref => ['name','cols','rows','tabindex'] },
 
);

sub inner {
	return $_[0]->value;
}


1;

# vim: set ts=2:
