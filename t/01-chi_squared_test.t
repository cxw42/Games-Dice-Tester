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

done_testing;
