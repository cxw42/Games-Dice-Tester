# Games::Dice::Tester - Statistical tests of random-dice-rolling programs



Various statistical tests for use with dice-rolling programs.

# WHAT THIS MODULE IS NOT

A way to tell you whether your random-number generator is truly random!

# EXPORT

Nothing by default; `:all` for everything; otherwise, any of the functions
listed below.

# FUNCTIONS

## chi\_squared

Compute the chi-squared statistic V.  Usage:

    my ($chi_squared, $df) = chi_squared_test(observed=>[...], expected=>[...]);

where the `observed` and `expected` arrays are the number of occurrences
in each category.

As a shorthand for the common case of a fair die, you can pass a scalar for
`expected`.  The `expected` array will then be filled with copies of that
value equal in number to the size of the `observed` array.

As yet another alternative, you can call

    my ($chi_squared, $df) = chi_squared_test(generator=>sub { ... });

where `generator`, when called, returns the next `($observed, $expected)`
pair.  When the generator returns `undef`, the loop stops.

Returns the chi-squared statistic.  In list context, also returns
the number of degrees of freedom.

Original version by [ Lukas
Atkinson](https://stackoverflow.com/users/1521179/amon), posted
[here](https://stackoverflow.com/a/21205042/2877364).  Modified by CXW.

## chi\_squared\_test

Return the probability that a given observed distribution was produced by a
random process with the given expected distribution.  Parameters are as
["chi\_squared"](#chi_squared).

If I am reading Knuth correctly, a random sequence should generally have
probabilities on the range (0.1, 0.9).  TAOCP 3e, vol. 2, p. 47.

Original version by [ Lukas
Atkinson](https://stackoverflow.com/users/1521179/amon), posted
[here](https://stackoverflow.com/a/21205042/2877364).  Modified by CXW.

## chi\_squared\_maybe\_ok

Parameters as ["chi\_squared\_test"](#chi_squared_test).  Returns true iff the chi-squared result
is in the range (0.1, 0.9).

# SEE ALSO

- [http://blogs.perl.org/users/ovid/2014/01/testing-random-dice-rolls.html](http://blogs.perl.org/users/ovid/2014/01/testing-random-dice-rolls.html)
- [https://www.nu42.com/2014/01/randomness-and-statistical-concepts.html](https://www.nu42.com/2014/01/randomness-and-statistical-concepts.html)
- [http://oddgeek.info/code/gdp/](http://oddgeek.info/code/gdp/)

# BUGS

Please report any bugs or feature requests through the web interface at
[https://github.com/cxw42/Games-Dice-Tester/issues](https://github.com/cxw42/Games-Dice-Tester/issues).  I will be notified, and
then you'll automatically be notified of progress on your bug as I make
changes.

# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Dice::Tester

You can also look for information at:

- GitHub (main repository)

    [https://github.com/cxw42/Games-Dice-Tester](https://github.com/cxw42/Games-Dice-Tester)

- MetaCPAN

    [https://metacpan.org/release/Games-Dice-Tester](https://metacpan.org/release/Games-Dice-Tester)

- CPAN Ratings

    [https://cpanratings.perl.org/d/Games-Dice-Tester](https://cpanratings.perl.org/d/Games-Dice-Tester)

# LICENSE

Copyright 2019 Christopher White.
Some code Copyright 2014 Lukas Atkinson.

Licensed [CC-BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/).

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# POD ERRORS

Hey! **The above document had some coding errors, which are explained below:**

- Around line 72:

    L<> starts or ends with whitespace

- Around line 124:

    L<> starts or ends with whitespace
