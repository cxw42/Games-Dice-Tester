package Games::Dice::Tester;

use 5.014;
use strict;
use warnings;
use parent 'Exporter';

our $VERSION = '0.000001';  # TRIAL

our (@EXPORT, @EXPORT_OK, %EXPORT_TAGS);
BEGIN {
    @EXPORT = ();
    @EXPORT_OK = qw(chi_squared_test);
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

Quick summary of what the module does.

Perhaps a little code snippet.

    use Games::Dice::Tester;

    my $foo = Games::Dice::Tester->new();
    ...

=head1 EXPORT

Nothing by default; C<:all> for everything; otherwise, any of the functions
listed below.

=head1 FUNCTIONS

=cut

# }}}1

=head2 chi_squared_test

Return the probability that a given observed distribution was produced by a
random process with the given expected distribution.  Usage:

    my $prob = chi_squared_test(observed=>[...], expected=>[...]);

where the C<observed> and C<expected> arrays are the number of occurrences
in each category.

Written by L<amon|https://stackoverflow.com/users/1521179/amon>, posted
L<here|https://stackoverflow.com/a/21205042/2877364>.

=cut

sub chi_squared_test {
  my %args = @_;
  my $observed = delete $args{observed} // croak q(Argument "observed" required);
  my $expected = delete $args{expected} // croak q(Argument "expected" required);
  @$observed == @$expected or croak q(Input arrays must have same length);

  my $chi_squared = sum map {
    ($observed->[$_] - $expected->[$_])**2 / $expected->[$_];
  } 0 .. $#$observed;
  my $degrees_of_freedom = @$observed - 1;
  my $probability = chisqrprob($degrees_of_freedom, $chi_squared);
  return $probability;
} #chi_squared_test()

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
