package HTML::Tag;

use strict;
use warnings;

$HTML::Tag::VERSION = '0.03';

sub new {
	my $class 		= shift;
	my %opt				= @_;
	my $element   = $opt{element} || 'SPAN';
	
	require 'HTML/Tag/' . $element . '.pm';
	my $self  = "HTML::Tag::$element"->create(@_);
	die "Unable to create HTML::Tag::$element object" unless ($self);
	return $self;
}

sub html {
	my $self	= shift;
	return $self->_build_start_tag . ($self->can('inner') ? $self->inner : '') . $self->_build_end_tag;
}

sub _build_start_tag {
	my $self		= shift;
	my $ret			= '';
	$ret				.= "<" . lc($self->tag);
	foreach (@{$self->attributes}) {
		my @attr_value = $self->get($_); 
		my $attr_value = $attr_value[0];
		if ("$attr_value" ne '') {
			$ret .= " " . $self->_build_attribute($_,$attr_value);
		}
	}
	$ret .= $self->has_end_tag ? '>' : ' />';
	return $ret;
}

sub _build_end_tag {
	my $self		= shift;
	return '' unless $self->has_end_tag;
	return "</" . lc($self->tag) . ">";
}

sub _build_attribute {
	my $self	= shift;
	my $name	= shift;
	my $value	= shift;
	return qq|$name="$value"|;
}

sub inner {
	return '';
}



1;

# vim: set ts=2:
