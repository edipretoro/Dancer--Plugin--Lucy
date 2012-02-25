use strict;
use warnings;
package Dancer::Plugin::Lucy;
use Dancer ':syntax';
use Dancer::Plugin;
use Lucy::Index::Indexer;
use Lucy::Plan::Schema;
use Lucy::Plan::FullTextType;
use Lucy::Analysis::PolyAnalyzer;

register indexer => sub {
    my $conf = ${ plugin_setting() }{indexer};
    my $schema = Lucy::Plan::Schema->new();

    my $polyanalyser = Lucy::Analysis::PolyAnalyzer->new(
        language => $conf->{polyanalyser}{language},
    );

    my $type = Lucy::Plan::FullTextType->new(
        analyser => $polyanalyser,
    );

    foreach my $field ( @{ $conf->{schema}{fields}} ) {
        $schema->spec_field( name => $field, type => $type );
    }

    my $indexer = Lucy::Index::Indexer->new(
        schema => $schema,
        index => ${ plugin_setting() }{index},
        create => $conf->{create},
    );

    return $indexer;
};

register searcher => sub {

};

register_plugin;

1;
