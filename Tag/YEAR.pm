package HTML::Tag::YEAR;

use base 'HTML::Tag::SELECT';

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
	$ret			.= qq|<OPTION value=""></OPTION>\n| if ($self->maybenull);
	my $year 	= (localtime())[5]+1900;
	foreach ($self->from..$self->to) {
		$_ = sprintf('%04d',$_);
		$ret		.= qq|<OPTION value="$_"| . ($self->selected eq $_ ? ' selected' : '') .
								qq|>$_</OPTION>\n|;
	}
	return $ret;
}


1;

# vim: set ts=2:
