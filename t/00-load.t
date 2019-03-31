#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Games::Dice::Tester' ) || print "Bail out!\n";
}

diag( "Testing Games::Dice::Tester $Games::Dice::Tester::VERSION, Perl $], $^X" );
