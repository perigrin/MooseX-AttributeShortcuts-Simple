package MooseX::DefaultMethods::Meta::Trait::Attribute;
use Moose::Role;
use namespace::autoclean;

around _process_options => sub {
    my ( $next, $class, $name, $options ) = @_;
    $class->$next( $name, $options );
    $class->_process_builder_option( $name, $options );
    $class->_process_clearer_option( $name, $options );
    $class->_process_predicate_option( $name, $options );
};

sub _process_builder_option {
    my ( $class, $name, $options ) = @_;
    return unless $options->{builder};
    return unless $options->{builder} == 1;
    $options->{builder} = "_build_${name}";
}

sub _process_clearer_option {
    my ( $class, $name, $options ) = @_;
    return unless $options->{clearer};
    return unless $options->{clearer} == 1;
    if ( $name =~ /^_/ ) {
        $options->{clearer} = "_clear${name}";
    }
    else {
        $options->{clearer} = "clear_${name}";
    }
}

sub _process_predicate_option {
    my ( $class, $name, $options ) = @_;
    return unless $options->{predicate};
    return unless $options->{predicate} == 1;
    if ( $name =~ /^_/ ) {
        $options->{predicate} = "_has${name}";
    }
    else {
        $options->{predicate} = "has_${name}";
    }
}

package Moose::Meta::Attribute::Custom::Trait::DefaultMethods;
sub register_implementation {'MooseX::DefaultMethods::Meta::Trait::Attribute'}

1;
__END__
