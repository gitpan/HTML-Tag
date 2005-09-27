package HTML::Tag::MONTH;

use base 'HTML::Tag::SELECT';

$HTML::Tag::MONTH::VERSION = '0.02';

use Class::Builder (
	'-methods' 	=> { constructor => 'create' },
	has_end_tag => { boolean => 1 }, 
	element			=> { string => 'MONTH'},
	tag 				=> { string => 'SELECT'},
	name 				=> { string => ''},
	tabindex		=> { number => ''},
	selected		=> { string => ''},
	value		=> { string => ''},
	maybenull		=> { boolean => 0},
	attributes 	=> { arrayref => ['name','tabindex'] },
 
);

my @month  = qw/Gennaio Febbraio Marzo Aprile Maggio Giugno Luglio Agosto
								Settembre Ottobre Novembre Dicembre/;

sub inner {
	my $self 	= shift;
	my $ret		= '';
	$ret			.= qq|<option value=""></option>\n| if ($self->maybenull);
	my @cmonth = localtime();
	my $cmonth = $cmonth[4]+1;
	foreach ($cmonth..12) {
		$_ = sprintf('%02d',$_);
		$ret		.= qq|<option value="$_"| . ($self->selected eq $_ ? ' selected' : '') .
								qq|>$_ - $month[$_-1]</option>\n|;
	}	
	unless ($cmonth == 1) {
		foreach (1..$cmonth-1) {
			$_ = sprintf('%02d',$_);
			$ret		.= qq|<option value="$_"| . ($self->selected eq $_ ? ' selected' : '') .
									qq|>$_ - $month[$_-1]</option>\n|;
		}
	}
	return $ret;
}


1;

# vim: set ts=2:
