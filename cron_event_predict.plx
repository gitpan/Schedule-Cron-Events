#!/usr/local/bin/perl -w
use strict;
use lib './lib';
use Schedule::Cron::Events;
use Getopt::Std;
use Time::Local;
use vars qw($opt_f $opt_h $opt_p);
getopts('p:f:h');

if ($opt_h) { usage(); }
my $filename = shift || usage();

my $future = 2;
if (defined $opt_f) { $future = $opt_f; }
my $past = 0;
if (defined $opt_p) { $past = $opt_p; }

open (IN, $filename) || die "Unable to open '$filename' for read: $!";
while(<IN>) {
	my $obj = new Schedule::Cron::Events($_) || next;
	chomp;
	print "# Original line: $_\n";

	if ($future) {
		for (1..$future) {
				my $date = localtime( timelocal($obj->nextEvent) );
				print "$date - predicted future event\n";
		}
	}
	$obj->resetCounter;
	if ($past) {
		for (1..$past) {
				my $date = localtime( timelocal($obj->previousEvent) );
				print "$date - predicted past event\n";
		}
	}
	print "\n";
}
close IN;


sub usage {
	print qq{
SYNOPSIS

$0 [ -h ] [ -f number ] [ -p number ] <crontab-filename>

Reads the crontab specified and iterates over every line in it, predicting when 
each cron event in the crontab will run. Defaults to predicting the next 2 events.

	-h - show this help
	-f - how many events predited in the future. Default is 2
	-p - how many events predicted for the past. Default is 0.

EXAMPLE

$0 -f 2 -p 2 ~/my.crontab

\$Revision\$

};
	exit;
}