#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

use Test::TCP;
use IO::Socket::INET;
use Plack::Loader;

use Plack::Middleware::Proxy::Connect::IO;

test_tcp(
    client => sub {
        my $port_proxy = shift;
        test_tcp(
            client => sub {
                my $port_orig = shift;
                my $sock = IO::Socket::INET->new(PeerPort => $port_proxy, PeerAddr => '127.0.0.1', Proto => 'tcp',)
                    or die $!;

                # Perform the handshake.
                print $sock "CONNECT 127.0.0.1:$port_orig HTTP/1.0\015\012", "\015\012";
                like scalar <$sock>, qr(^HTTP/1\.[01] 2\d\d ), "response";
                while ($_ = <$sock>) { /^\015\012$/ and last; }

                # Send ping to the original server.
                print $sock "PING\015\012";
                is scalar <$sock>, "PONG\015\012", "response";

                $sock->close;
            },
            server => sub {
                my $port_orig = shift;

                # Run a ping-pong server.
                my $sock = IO::Socket::INET->new(
                    LocalPort => $port_orig,
                    LocalAddr => '127.0.0.1',
                    Proto     => 'tcp',
                    Listen    => 1,
                    (($^O eq 'MSWin32') ? () : (ReuseAddr => 1)),
                ) or die $!;

                while (my $remote = $sock->accept) {
                    if (my $data = scalar <$remote>) {
                        if ($data =~ /^PING/) {
                            print $remote "PONG\015\012";
                        }
                    }
                }
            },
        );
    },
    server => sub {
        my $port = shift;
        my $server = Plack::Loader->auto(port => $port, host => '127.0.0.1');
        $server->run(
            Plack::Middleware::Proxy::Connect::IO->wrap(sub { [200, ['Content-Type' => 'plain/text'], ['Hi']] }));
    },
);

done_testing;
