use strict;
use lib 'lib';
use Chado::Builder;
use Data::Dumper;

my $VERSION    = 0.01;
my $conf       = shift;
my $m          = Chado::Builder->new(
  dist_name    => 'Chado', 
  dist_version => $VERSION, 
  load_conf    => $conf,
);

print "initializing load scripts...\n";
# populates tt2 templates specified in load.conf
$m->dispatch('tokenize');

# can test by issuing a dispatch...
#$m->dispatch('refseq');

$m->create_build_script;