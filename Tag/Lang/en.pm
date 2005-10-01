package HTML::Tag::Lang::en;
use strict;
use warnings;
our $VERSION = 0.01;

use base qw(Exporter);
our (@EXPORT_OK, %bool_descr);
@EXPORT_OK = qw(%bool_descr);

%bool_descr = (
								0	=> 'No',
								1 => 'Yes'
							);

1;
