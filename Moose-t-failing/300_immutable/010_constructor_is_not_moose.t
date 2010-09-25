#!/usr/bin/perl
# This is automatically generated by author/import-moose-test.pl.
# DO NOT EDIT THIS FILE. ANY CHANGES WILL BE LOST!!!
use t::lib::MooseCompat;

use strict;
use warnings;

use Test::More;
$TODO = q{Mouse is not yet completed};

use Test::Requires {
    'Test::Output' => '0.01', # skip all if not installed
};

{
    package NotMouse;

    sub new {
        my $class = shift;

        return bless { not_moose => 1 }, $class;
    }
}

{
    package Foo;
    use Mouse;

    extends 'NotMouse';

    ::stderr_like(
        sub { Foo->meta->make_immutable },
        qr/\QNot inlining 'new' for Foo since it is not inheriting the default Mouse::Object::new\E\s+\QIf you are certain you don't need to inline your constructor, specify inline_constructor => 0 in your call to Foo->meta->make_immutable/,
        'got a warning that Foo may not have an inlined constructor'
    );
}

is(
    Foo->meta->find_method_by_name('new')->body,
    NotMouse->can('new'),
    'Foo->new is inherited from NotMouse'
);

{
    package Bar;
    use Mouse;

    extends 'NotMouse';

    ::stderr_is(
        sub { Bar->meta->make_immutable( replace_constructor => 1 ) },
        q{},
        'no warning when replace_constructor is true'
    );
}

is(
    Bar->meta->find_method_by_name('new')->package_name,
   'Bar',
    'Bar->new is inlined, and not inherited from NotMouse'
);

{
    package Baz;
    use Mouse;

    Baz->meta->make_immutable;
}

{
    package Quux;
    use Mouse;

    extends 'Baz';

    ::stderr_is(
        sub { Quux->meta->make_immutable },
        q{},
        'no warning when inheriting from a class that has already made itself immutable'
    );
}

{
    package My::Constructor;
    use base 'Mouse::Meta::Method';
}

{
    package CustomCons;
    use Mouse;

    CustomCons->meta->make_immutable( constructor_class => 'My::Constructor' );
}

{
    package Subclass;
    use Mouse;

    extends 'CustomCons';

    ::stderr_is(
        sub { Subclass->meta->make_immutable },
        q{},
        'no warning when inheriting from a class that has already made itself immutable'
    );
}

done_testing;
