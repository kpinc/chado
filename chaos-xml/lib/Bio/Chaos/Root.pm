# $Id: Root.pm,v 1.1 2004-06-16 02:46:50 cmungall Exp $
#
#

=head1 NAME

  Bio::Chaos::Root     - root utility class for chaos objects

=head1 SYNOPSIS

  package Bio::Chaos::SomeClass;
  use base qw(Bio::Chaos::Root);
  1;

=cut

=head1 DESCRIPTION

Root class for chaos objects

this class inherits from L<Bio::Root::Root>, so you get all that juicy stuff too

=head2 INHERITANCE

=over

=item Bio::Root::Root

=back

=cut

package Bio::Chaos::Root;

use Exporter;
use Bio::Root::Root;
@ISA = qw(Bio::Root::Root Exporter);

use strict;

# Constructor

=head2 load_module

 Title   : load_module
 Usage   :
 Function:
 Example : $self->load_module("Bio::Tools::Blah");
 Returns : 
 Args    :


=cut

sub load_module {

    my $self = shift;
    my $classname = shift;
    my $mod = $classname;
    $mod =~ s/::/\//g;

    if ($main::{"_<$mod.pm"}) {
    }
    else {
        require "$mod.pm";
        if ($@) {
            print $@;
        }
    }
}

sub freak {
    my $self = shift;
    my $msg = shift;
    my @stags = @_;
    foreach my $stag (@stags) {
	eval {
	    print STDERR $stag->sxpr;
	};
	if ($@) {
	    print STDERR "[$stag]\n";
	}
    }
    $self->throw($msg);
}

sub dd {
    my $self = shift;
    my $obj = shift;
    use Data::Dumper;
    return Dumper($obj);
}
*dump = \&dd;

1;