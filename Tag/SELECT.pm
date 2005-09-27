package HTML::Tag::SELECT;

use base 'HTML::Tag';

$HTML::Tag::SELECT::VERSION = '0.02';

use Class::Builder (
	'-methods' 	=> { constructor => 'create' },
	has_end_tag => { boolean => 1 }, 
	element			=> { string => 'SELECT'},
	tag 				=> { string => 'SELECT'},
	name 				=> { string => ''},
	value				=> { hashref => {}},
	tabindex		=> { number => ''},
	selected		=> { string => ''},
	maybenull		=> { boolean => 0},
	attributes 	=> { arrayref => ['name','tabindex'] },
 
);

sub inner {
	my $self 	= shift;
	my $ret		= '';
	$ret			.= qq|<option value=""></option>\n| if ($self->maybenull);
	while (my ($k,$v) = each %{$self->value}) {
		$ret		.= qq|<option value="$k"| . ($self->selected eq $k ? ' selected' : '') .
								qq|>$v</option>\n|;
	}
	return $ret;
}


1;

# vim: set ts=2:
