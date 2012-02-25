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

};

register searcher => sub {

};

register_plugin;

1;
