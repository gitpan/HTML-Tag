package HTML::Tag::DATE;

use strict;
use warnings;

use Class::AutoAccess;
use base qw(Class::AutoAccess HTML::Tag);

our $VERSION = '1.02';

BEGIN {
	our $class_def	= {
							element			=> 'DATE',
							tag 				=> 'SELECT',
							js					=> 'html_tag_datetime_loader.js',
							value				=> '',
	}
}

sub html {
	my $self		= shift;
	my $name		= $self->name;
	my $value		= $self->value;

	$value 			= &_normalize_value($value);
	my $js			= $HTML::Tag::DATE::js || $self->js;
	my @js_path_split = split('/',$js);
	pop @js_path_split;
	my $js_path = join('/',@js_path_split);
	$js_path = $js_path . '/' if (length($js_path) > 0);
	my $rid			= &_random_id;
	my $ret		=<<EOF;
	<!-- Propagate javascript path -->
  <script language="javascript">
	var html_tag_datetime_js_path = '$js_path';
	</script>
  <!-- Load the javascript functions if necessary -->
  <script type="text/javascript" src="$js"></script>
  <!-- the day field -->
  <select size="1" id="d_${name}_${rid}_sel" onblur="datetime_keydown(event)" onkeydown="datetime_keydown(event)">
  <script language="javascript">html_days()</script>
  </select>
  <input type="text" id="d_${name}_${rid}_txt" size="2" maxlength="2" onblur="datetime_keydown(event)" onkeydown="datetime_keydown(event)" style="display: none" />
  <!-- the month field -->
  <select size="1" id="m_${name}_${rid}_sel" onblur="datetime_keydown(event)" onkeydown="datetime_keydown(event)">
  <script language="javascript">html_months()</script>
  </select>
  <input type="text" id="m_${name}_${rid}_txt"  size="2" maxlength="2" onblur="datetime_keydown(event)" onkeydown="datetime_keydown(event)" style="display: none" />
  <!-- the year field -->
  <select size="1" id="y_${name}_${rid}_sel" onblur="datetime_keydown(event)" onkeydown="datetime_keydown(event)">
  <script language="javascript">html_years()</script>
  </select>
  <input type="text"  id="y_${name}_${rid}_txt" size="4" value="" maxlength="4" onkeydown="datetime_keydown(event)" onblur="datetime_keydown(event)" style="display: none" />
  <!-- the real hidden field -->
  <input type="hidden" id="${name}_${rid}" name="${name}" value="$value" />
  <!-- the onload sync between hidden and visible field -->
  <script language="javascript">syncVisible('${name}_${rid}')</script>
  <!-- the show calendar button -->
  <button id="trigger" type="button" onclick="return showCalendar(this,'${name}_${rid}', '&#37;Y-&#37;m-&#37;d', false, true);">...</button>
EOF
	return $ret;
}

sub _random_id {
	# this generate a random string for id attribute
	my $ret;
	$ret =int(rand(10000));
	return $ret;
}

sub _normalize_value {
	my $value = shift;
	if ($value eq 'now') {
		my ($day,$month,$year) = (localtime())[3..5];
		$year += 1900;
		$month++; 
		$month 	= "0$month" if length($month) == 1;
		$day 		= "0$day" if length($day) == 1;
		$value 	= "$year-$month-$day";
	}
	return $value;
}


1;

# vim: set ts=2:
