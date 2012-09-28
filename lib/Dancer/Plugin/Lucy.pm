# ABSTRACT: Lucy interface for Dancer applications

use strict;
use warnings;
package Dancer::Plugin::Lucy;
use Dancer ':syntax';
use Dancer::Plugin;

use Lucy::Simple;

register indexer => sub {
    my $conf = plugin_setting();

    my $indexer = Lucy::Simple->new(
        index => $conf->{index},
        language => $conf->{polyanalyser}{language},
    );

    return $indexer;
};

register searcher => sub {
    my $conf = plugin_setting();
    my $searcher = Lucy::Simple->new(
        index => $conf->{index},
    );

    return $searcher;
};

register_plugin;

1;
