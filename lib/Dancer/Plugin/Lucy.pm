# ABSTRACT: Lucy interface for Dancer applications

use strict;
use warnings;
package Dancer::Plugin::Lucy;
use Dancer ':syntax';
use Dancer::Plugin;

use Lucy::Index::Indexer;
use Lucy::Plan::Schema;
use Lucy::Plan::FullTextType;
use Lucy::Analysis::PolyAnalyzer;

use Lucy::Search::IndexSearcher;

register indexer => sub {
    my $conf = plugin_setting();
    my $schema = Lucy::Plan::Schema->new();

    my $polyanalyser = Lucy::Analysis::PolyAnalyzer->new(
        language => $conf->{polyanalyser}{language},
    );

    my $type = Lucy::Plan::FullTextType->new(
        analyzer => $polyanalyser,
    );

    foreach my $field ( @{ $conf->{schema}{fields}} ) {
        $schema->spec_field( name => $field, type => $type );
    }

    my $indexer = Lucy::Index::Indexer->new(
        schema => $schema,
        index => $conf->{index},
        create => $conf->{create} || 0,
        truncate => $conf->{truncate} || 0,
    );

    return $indexer;
};

register searcher => sub {
    my $conf = plugin_setting();
    my $searcher = Lucy::Search::IndexSearcher->new(
        index => $conf->{index},
    );

    return $searcher;
};

register_plugin;

1;
