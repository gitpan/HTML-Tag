package HTML::Tag::YEAR;

use strict;
use warnings;

use base 'HTML::Tag::SELECT';

$HTML::Tag::YEAR::VERSION = '0.03';

use Class::Builder (
	'-methods' 	=> { constructor => 'create' },
	has_end_tag => { boolean => 1 }, 
	element			=> { string => 'YEAR'},
	tag 				=> { string => 'SELECT'},
	name 				=> { string => ''},
	from				=> { number => (localtime())[5] + 1800 },
	to					=> { number => (localtime())[5] + 2000 },
	tabindex		=> { number => ''},
	selected		=> { string => (localtime())[5] + 1900},
	maybenull		=> { boolean => 0},
	attributes 	=> { arrayref => ['name','tabindex'] },
 
);

sub inner {
	my $self 	= shift;
	my $ret		= '';
	$ret			.= qq|<option value=""></option>\n| if ($self->maybenull);
	my $year 	= (localtime())[5]+1900;
	foreach ($self->from..$self->to) {
		$_ = sprintf('%04d',$_);
		$ret		.= qq|<option value="$_"| . ($self->selected eq $_ ? ' selected' : '') .
								qq|>$_</option>\n|;
	}
	return $ret;
}


1;

# vim: set ts=2:
