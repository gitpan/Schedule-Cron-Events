use ExtUtils::MakeMaker;

# $Id: Makefile.PL,v 1.3 2002/09/11 23:40:35 piers Exp $

WriteMakefile(
	AUTHOR		=> 'P Kent (pause@selsyn.co.uk)',
	ABSTRACT	=> 'Find out the times at which a cron entry would run, past or future, relative to any given time',
	NAME		=> 'Schedule::Cron::Events',
	DISTNAME	=> 'Schedule-Cron-Events',
	dist		=> {
		COMPRESS	=> 'gzip',
		SUFFIX		=> '.gz',
	},
	VERSION_FROM	=> 'lib/Schedule/Cron/Events.pm',
	PREREQ_PM	=> {
				Date::Manip => 0,
				Time::Local => 0,
				Set::Crontab => 0,
			},
	EXE_FILES => [
		'cron_event_predict.plx',
	],
);

