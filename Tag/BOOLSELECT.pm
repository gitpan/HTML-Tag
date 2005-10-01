package HTML::Tag::BOOLSELECT;

use strict;
use warnings;

use base 'HTML::Tag';

use HTML::Tag::Lang qw(%bool_descr);

our $VERSION = '0.01';

use Class::Builder (
	'-methods' 	=> { constructor => 'create' },
	has_end_tag => { boolean => 1 }, 
	element			=> { string => 'BOOLSELECT'},
	tag 				=> { string => 'SELECT'},
	name 				=> { string => ''},
	tabindex		=> { number => ''},
	selected		=> { string => ''},
	value				=> { string => ''},
	maybenull		=> { boolean => 0},
	attributes 	=> { arrayref => ['name','tabindex'] },
	nobeforeyes => { boolean => 0},
 
);

sub inner {
	my $self 	= shift;
	my $ret		= '';
	$ret			.= qq|<option value=""></option>\n| if ($self->maybenull);
	my @values = $self->nobeforeyes ? (0,1) : (1,0);
	foreach (@values) {
		$ret		.= qq|<option value="$_"| . ($self->selected eq $_ ? ' selected' : '') .
								qq|>$bool_descr{$_}</option>\n|;
	}	
	return $ret;
}


1;

# vim: set ts=2:
