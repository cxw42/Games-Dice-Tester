#!perl
use 5.006;
use strict;
use warnings;
use Test::More;

use_ok( 'Games::Dice::Tester' );

BAIL_OUT("Further tests rely on all modules compiling.")
    unless Test::Builder->new->is_passing;
# Thanks for this way of using BAIL_OUT to
# https://metacpan.org/source/TOBYINK/Type-Tiny-1.004004/t/01-compile.t
# (licensed the same as Perl 5 itself).

diag( "Testing Games::Dice::Tester $Games::Dice::Tester::VERSION, Perl $], $^X" );

done_testing;
