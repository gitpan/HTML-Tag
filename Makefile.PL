## -*- Perl -*-

use ExtUtils::MakeMaker;

WriteMakefile(
		NAME	  			=> "HTML::Tag",
	  VERSION_FROM 	=> "Tag.pm",
	 	PREREQ_PM     => {
                     },
	      ($] >= 5.005 ?
	       (
		ABSTRACT   => "Another HTML Widget system",
		AUTHOR	   => "Emiliano Bruni <info\@ebruni.it>") : ()),
	      );

# vim: set ts=2:
