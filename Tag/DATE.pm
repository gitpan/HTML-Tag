package HTML::Tag::DATE;

use base 'HTML::Tag';

$HTML::Tag::DATE::VERSION      = "0.01";

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
	my $ret		=<<EOF;
	<!-- Propagate javascript path -->
  <script language="javascript">
	var html_tag_datetime_js_path = '$js_path';
	</script>
  <!-- Load the javascript functions if necessary -->
  <script type="text/javascript" src="$js"></script>
  <!-- the day field -->
  <select size="1" id="${name}_giorno" onchange="syncHidden('${name}')">
  <script language="javascript">html_days()</script>
  </select>
  <!-- the month field -->
  <select size="1" id="${name}_mese" onchange="syncHidden('${name}')">
  <script language="javascript">html_months()</script>
  </select>
  <!-- the year field -->
  <input type="text"  id="${name}_anno" size="4" value="" onchange="syncHidden('${name}')">
  <!-- the real hidden field -->
  <input type="hidden" id="${name}" name="${name}" value="$value" />
  <!-- the onload sync between hidden and visible field -->
  <script language="javascript">syncVisible('${name}')</script>
  <!-- the show calendar button -->
  <button id="trigger" onclick="return showCalendar(this,'${name}', '&#37;Y-&#37;m-&#37;d', false, true);">...</button>
EOF
	return $ret;
}



1;

# vim: set ts=2:
