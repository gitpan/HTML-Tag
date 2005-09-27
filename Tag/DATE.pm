package HTML::Tag::DATE;

use strict;
use warnings;

use base 'HTML::Tag';

$HTML::Tag::DATE::VERSION      = "0.03";

$HTML::Tag::DATE::js					 = '';


use Class::Builder (
	'-methods' 	=> { constructor => 'create' },
	has_end_tag => { boolean => 1 }, 
	element			=> { string => 'DATE'},
	tag 				=> { string => 'SELECT'},
	name 				=> { string => ''},
	tabindex		=> { number => ''},
	value				=> { string => ''},
	js					=> { string => 'html_tag_datetime_loader.js'},
	attributes 	=> { arrayref => ['name','tabindex'] },
 
);

sub html {
	my $self		= shift;
	my $name		= $self->name;
	my $value		= $self->value;
	my $js			= $HTML::Tag::DATE::js || $self->js;
	my @js_path_split = split('/',$js);
	pop @js_path_split;
	my $js_path = join('/',@js_path_split);
	$js_path = $js_path . '/' if (length($js_path) > 0);
	my $ret		=<<EOF;
	<!-- Propagate javascript path -->
  <script language="javascript">
	var html_tag_datetime_js_path = '$js_path';
	</script>
  <!-- Load the javascript functions if necessary -->
  <script type="text/javascript" src="$js"></script>
  <!-- the day field -->
  <select size="1" id="d_${name}_sel" onblur="datetime_keydown(event)" onkeydown="datetime_keydown(event)">
  <script language="javascript">html_days()</script>
  </select>
  <input type="text" id="d_${name}_txt" size="2" maxlength="2" onblur="datetime_keydown(event)" onkeydown="datetime_keydown(event)" style="display: none" />
  <!-- the month field -->
  <select size="1" id="m_${name}_sel" onblur="datetime_keydown(event)" onkeydown="datetime_keydown(event)">
  <script language="javascript">html_months()</script>
  </select>
  <input type="text" id="m_${name}_txt"  size="2" maxlength="2" onblur="datetime_keydown(event)" onkeydown="datetime_keydown(event)" style="display: none" />
  <!-- the year field -->
  <select size="1" id="y_${name}_sel" onblur="datetime_keydown(event)" onkeydown="datetime_keydown(event)">
  <script language="javascript">html_years()</script>
  </select>
  <input type="text"  id="y_${name}_txt" size="4" value="" maxlength="4" onkeydown="datetime_keydown(event)" onblur="datetime_keydown(event)" style="display: none" />
  <!-- the real hidden field -->
  <input type="hidden" id="${name}" name="${name}" value="$value" />
  <!-- the onload sync between hidden and visible field -->
  <script language="javascript">syncVisible('${name}')</script>
  <!-- the show calendar button -->
  <button id="trigger" type="button" onclick="return showCalendar(this,'${name}', '&#37;Y-&#37;m-&#37;d', false, true);">...</button>
EOF
	return $ret;
}



1;

# vim: set ts=2:
