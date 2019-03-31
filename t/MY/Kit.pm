#!perl
# Kit: Test kit for Games::Dice::Tester
package MY::Kit;

use 5.014;
use strict;
use warnings;
#use Test::Exception ();
#use Test::Fatal ();
use Test::More ();
use Test::Number::Delta ();

use Import::Into;

sub import {
    my $target = caller;
    $_->import::into($target) foreach
        qw(strict warnings Test::More Test::Number::Delta);
            # Test::Exception Test::Fatal
} #import()

1;
