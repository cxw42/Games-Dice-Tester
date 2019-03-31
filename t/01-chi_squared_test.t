#!perl
use 5.014;
use lib::relative '.';
use MY::Kit;

use Games::Dice::Tester 'chi_squared_test';

delta_ok(
    chi_squared_test(observed => [16, 5, 9, 7, 6, 17], expected => [(10) x 6]),
    0.018360,
    'chi-squared example from https://stackoverflow.com/a/21205042/2877364'
);

delta_ok(chi_squared_test(observed=>[50,2,2,2,2,2], expected => [(10) x 6]),
    0,
    'wildly improbable observed gives very small chi-squared result'
);  # On my machine, 0.0000000000000000000000000000000000000014600 :)

# Alternative invocation syntax
delta_ok(
    chi_squared_test(observed => [16, 5, 9, 7, 6, 17], expected => 10),
    0.018360,
    'chi-squared example from https://stackoverflow.com/a/21205042/2877364 (alt. inv.)'
);

delta_ok(chi_squared_test(observed=>[50,2,2,2,2,2], expected => 10),
    0,
    'wildly improbable observed gives very small chi-squared result (alt. inv.)'
);  # On my machine, 0.0000000000000000000000000000000000000014600 :)

done_testing;

__END__

Command-line example:

$ perl -Ilib -MData::Dump -MGames::Dice::Tester=:all -MGames::Dice::Advanced -E 'my @rolls; my $d6 = Games::Dice::Advanced->new('d6'); for (1..12000) { my $r = $d6->roll; ++$rolls[$r]; } ; shift @rolls; dd \@rolls; say chi_squared_maybe_ok(observed=>\@rolls, expected=>2000)?q(yes):q(no)'
[2011, 2037, 1916, 1959, 2023, 2054]
yes
