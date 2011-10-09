package MooseX::DefaultMethods;
use Moose;
use namespace::autoclean;

# ABSTRACT: Easier way to generate sane default methods for attributes

use Moose ();
use Moose::Exporter;

my %metaroles = (
    class_metaroles =>
        { attribute => ['MooseX::DefaultMethods::Meta::Trait::Attribute'], },
    role_metaroles =>
        { applied_attribute => ['MooseX::DefaultMethods::Meta::Trait::Attribute'], }
);

Moose::Exporter->setup_import_methods( %metaroles, );

__PACKAGE__->meta->make_immutable;
1;
__END__
