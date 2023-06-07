#!/usr/bin/perl -c

# starlight proxy.psgi

use lib '../lib', 'lib';

use Plack::Builder;
use Plack::App::Proxy;

builder {
    enable 'AccessLog';
    enable 'Proxy::Connect::IO', timeout=>666;
    enable 'Proxy::Requests';
    Plack::App::Proxy->new(backend => 'HTTP::Tiny')->to_app;
};
