#!/usr/bin/perl
use strict;
use Test::More;

{

    package MyApp;
    use Moose;
    use MooseX::DefaultMethods;

    has foo => (
        isa       => 'Str',
        is        => 'ro',
        lazy      => 1,
        clearer   => 1,
        builder   => 1,
        predicate => 1
    );

    sub _build_foo { ::pass('built foo'); 'foo' }
}

# test if we can do the right methods
can_ok( 'MyApp', $_ ) for ( 'foo', 'clear_foo', 'has_foo', );
my $attr = MyApp->meta->find_attribute_by_name('foo');
ok( $attr->has_predicate, "attribute has predicate" );
is( $attr->predicate, 'has_foo', 'right predicate name' );
ok( $attr->has_clearer, "attribute has clearer" );
is( $attr->clearer, 'clear_foo', 'right clearer name' );
ok( $attr->has_builder, 'has builder' );
is( $attr->{builder}, '_build_foo', 'right builder name' );

my $o = MyApp->new();
ok( !$o->has_foo, 'no foo yet' );
$o->foo;
ok( $o->has_foo,   'has foo' );
ok( $o->clear_foo, 'cleared foo' );
ok( !$o->has_foo,  'foo is gone' );

done_testing;
__END__
