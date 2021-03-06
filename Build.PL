# =========================================================================
# THIS FILE IS AUTOMATICALLY GENERATED BY MINILLA.
# DO NOT EDIT DIRECTLY.
# =========================================================================

use 5.008_001;

use strict;
use warnings;
use utf8;

BEGIN { push @INC, '.' }
use builder::MyBuilder;
use File::Basename;
use File::Spec;

my %args = (
    license              => 'perl_5',
    dynamic_config       => 0,

    configure_requires => {
        'Module::Build' => '0.4005',
    },

    requires => {
        'Scalar::Util' => '1.14',
        'XSLoader' => '0.02',
        'perl' => '5.008005',
    },

    recommends => {
    },

    suggests => {
    },

    build_requires => {
    },

    test_requires => {
        'Test::Exception' => '0',
        'Test::Fatal' => '0',
        'Test::LeakTrace' => '0',
        'Test::More' => '0.88',
        'Test::Output' => '0',
        'Test::Requires' => '0',
        'Try::Tiny' => '0',
    },

    name            => 'Mouse',
    module_name     => 'Mouse',
    allow_pureperl => 1,

    script_files => [glob('script/*'), glob('bin/*')],
    c_source     => [qw()],
    PL_files => {},

    test_files           => ((-d '.git' || $ENV{RELEASE_TESTING}) && -d 'xt') ? 't/ xt/' : 't/',
    recursive_test_files => 1,


);
if (-d 'share') {
    $args{share_dir} = 'share';
}

my $builder = builder::MyBuilder->subclass(
    class => 'MyBuilder',
    code => q{
        sub ACTION_distmeta {
            die "Do not run distmeta. Install Minilla and `minil install` instead.\n";
        }
        sub ACTION_installdeps {
            die "Do not run installdeps. Run `cpanm --installdeps .` instead.\n";
        }
    }
)->new(%args);
$builder->create_build_script();

