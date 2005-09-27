/* Javascript Loader for HTML::Tag::Date and HTML::Tag::Datetime */

var html_tag_datetime_loaded;
if (!html_tag_datetime_loaded) {
	html_tag_datetime_loaded = 1;
	with (document) {
		writeln('<style type="text/css">@import url(' + html_tag_datetime_js_path + 'jscalendar/skins/aqua/theme.css);</style>');
		writeln('<script type="text/javascript" src="' + html_tag_datetime_js_path + 'jscalendar/calendar.js"></script>');
		writeln('<script type="text/javascript" src="' + html_tag_datetime_js_path + 'jscalendar/lang/calendar-it.js"></script>');
		writeln('<script type="text/javascript" src="' + html_tag_datetime_js_path + 'jscalendar/calendar-setup.js"></script>');
		writeln('<script type="text/javascript" src="' + html_tag_datetime_js_path + 'validator.js"></script>');
		writeln('<script type="text/javascript" src="' + html_tag_datetime_js_path + 'html_tag_datetime.js"></script>');
	}
}
