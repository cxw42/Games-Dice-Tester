package Games::Dice::Tester;

use 5.014;
use strict;
use warnings;
use parent 'Exporter';

our $VERSION = '0.000001';  # TRIAL

our (@EXPORT, @EXPORT_OK, %EXPORT_TAGS);
BEGIN {
    @EXPORT = ();
    @EXPORT_OK = qw(chi_squared chi_squared_test chi_squared_maybe_ok);
    %EXPORT_TAGS = (
        default => [@EXPORT],
        all => [@EXPORT, @EXPORT_OK]
    );
}

use Carp qw< croak >;
use List::Util qw< sum >;
use Statistics::Distributions qw< chisqrprob >;

# Docs =================================================================== {{{1

=head1 NAME

Games::Dice::Tester - Statistical tests of random-dice-rolling programs

=head1 SYNOPSIS

Various statistical tests for use with dice-rolling programs.

=head1 WHAT THIS MODULE IS NOT

A way to tell you whether your random-number generator is truly random!

=head1 EXPORT

Nothing by default; C<:all> for everything; otherwise, any of the functions
listed below.

=head1 FUNCTIONS

=cut

# }}}1

=head2 chi_squared

Compute the chi-squared statistic V.  Usage:

    my ($chi_squared, $df) = chi_squared_test(observed=>[...], expected=>[...]);

where the C<observed> and C<expected> arrays are the number of occurrences
in each category.

As a shorthand for the common case of a fair die, you can pass a scalar for
C<expected>.  The C<expected> array will then be filled with copies of that
value equal in number to the size of the C<observed> array.

As yet another alternative, you can call

    my ($chi_squared, $df) = chi_squared_test(generator=>sub { ... });

where C<generator>, when called, returns the next C<($observed, $expected)>
pair.  When the generator returns C<undef>, the loop stops.

Returns the chi-squared statistic.  In list context, also returns
the number of degrees of freedom.

Original version by L< Lukas
Atkinson|https://stackoverflow.com/users/1521179/amon>, posted
L<here|https://stackoverflow.com/a/21205042/2877364>.  Modified by CXW.

=cut

sub chi_squared {
    my %args = @_;
    my ($observed, $expected, $generator);

    if($args{generator}) {
        croak "Generator must be a coderef" unless ref $args{generator} eq 'CODE';
        $generator = delete $args{generator};
        croak 'Generator must be the only parameter' if scalar keys %args;

    } else {
        my $idx = 0;
        $observed = delete $args{observed} // croak q(Argument "observed" required);
        $expected = delete $args{expected} // croak q(Argument "expected" required);
        $generator = sub { ++$idx; ($observed->[$idx-1], $expected->[$idx-1]) };

        # Shorthand syntax for $expected
        $expected = [($expected) x @$observed] unless ref $expected eq 'ARRAY';

        # Validate parameters
        @$observed == @$expected or croak q(Input arrays must have same length);
    }

    # Do the work
    my $count = 0;
    my $chi_squared;
    while(1) {
        my ($obs, $exp) = $generator->();
        last unless defined $obs;
        ++$count;
        $chi_squared += ($obs - $exp)**2 / $exp;
    }

    my $degrees_of_freedom = $count - 1;

    return wantarray ? ($chi_squared, $degrees_of_freedom) : $chi_squared;
} #chi_squared()

=head2 chi_squared_test

Return the probability that a given observed distribution was produced by a
random process with the given expected distribution.  Parameters are as
L</chi_squared>.

If I am reading Knuth correctly, a random sequence should generally have
probabilities on the range (0.1, 0.9).  TAOCP 3e, vol. 2, p. 47.

Original version by L< Lukas
Atkinson|https://stackoverflow.com/users/1521179/amon>, posted
L<here|https://stackoverflow.com/a/21205042/2877364>.  Modified by CXW.

=cut

sub chi_squared_test {
    my ($chi_squared, $degrees_of_freedom) = chi_squared(@_);
    my $probability = chisqrprob($degrees_of_freedom, $chi_squared);
    return $probability;
} #chi_squared_test()

=head2 chi_squared_maybe_ok

Parameters as L</chi_squared_test>.  Returns true iff the chi-squared result
is in the range (0.1, 0.9).

=cut

sub chi_squared_maybe_ok {
    my $prob = chi_squared_test(@_);
    return ($prob > 0.1) && ($prob < 0.9);
}

1; # End of Games::Dice::Tester
__END__

# Rest of docs =========================================================== {{{1

=head1 SEE ALSO

=over

=item *

L<http://blogs.perl.org/users/ovid/2014/01/testing-random-dice-rolls.html>

=item *

L<https://www.nu42.com/2014/01/randomness-and-statistical-concepts.html>

=item *

L<http://oddgeek.info/code/gdp/>

=back

=head1 BUGS

Please report any bugs or feature requests through the web interface at
L<https://github.com/cxw42/Games-Dice-Tester/issues>.  I will be notified, and
then you'll automatically be notified of progress on your bug as I make
changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Dice::Tester

You can also look for information at:

=over 4

=item * GitHub (main repository)

L<https://github.com/cxw42/Games-Dice-Tester>

=item * MetaCPAN

L<https://metacpan.org/release/Games-Dice-Tester>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/Games-Dice-Tester>

=back

=head1 LICENSE

Copyright 2019 Christopher White.
Some code Copyright 2014 Lukas Atkinson.

Licensed L<CC-BY-SA 3.0|https://creativecommons.org/licenses/by-sa/3.0/>.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

# }}}1
# vi: set fdm=marker: #
