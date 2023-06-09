# Plack::Middleware::Proxy::Connect::IO

[![CI](https://github.com/dex4er/perl-Plack-Middleware-Proxy-Connect-IO/actions/workflows/ci.yaml/badge.svg)](https://github.com/dex4er/perl-Plack-Middleware-Proxy-Connect-IO/actions/workflows/ci.yaml)
[![Trunk Check](https://github.com/dex4er/perl-Plack-Middleware-Proxy-Connect-IO/actions/workflows/trunk.yaml/badge.svg)](https://github.com/dex4er/perl-Plack-Middleware-Proxy-Connect-IO/actions/workflows/trunk.yaml)
[![CPAN](https://img.shields.io/cpan/v/Plack-Middleware-Proxy-Connect-IO)](https://metacpan.org/dist/Plack-Middleware-Proxy-Connect-IO)

## NAME

Plack::Middleware::Proxy::Connect::IO - CONNECT method

## SYNOPSIS


```perl

    # In app.psgi
    use Plack::Builder;
    use Plack::App::Proxy;

    builder {
        enable "Proxy::Connect::IO", timeout => 30;
        enable "Proxy::Requests";
        Plack::App::Proxy->new->to_app;
    };


```

## DESCRIPTION

This middleware handles the `CONNECT` method. It allows to connect to
`https` addresses.

The middleware runs on servers supporting `psgix.io` and provides own
event loop so does not work correctly with `psgi.nonblocking` servers.

The middleware uses only Perl's core modules: [IO::Socket::INET](https://metacpan.org/pod/IO%3A%3ASocket%3A%3AINET) and
[IO::Select](https://metacpan.org/pod/IO%3A%3ASelect).

## CONFIGURATION

- timeout

    Timeout for the socket. The default value is `5` seconds.

## SEE ALSO

[Plack](https://metacpan.org/pod/Plack), [Plack::App::Proxy](https://metacpan.org/pod/Plack%3A%3AApp%3A%3AProxy), [Plack::Middleware::Proxy::Connect](https://metacpan.org/pod/Plack%3A%3AMiddleware%3A%3AProxy%3A%3AConnect).

## BUGS

If you find the bug or want to implement new features, please report it at
[https://github.com/dex4er/perl-Plack-Middleware-Proxy-Connect-IO/issues](https://github.com/dex4er/perl-Plack-Middleware-Proxy-Connect-IO/issues)

The code repository is available at
[http://github.com/dex4er/perl-Plack-Middleware-Proxy-Connect-IO](http://github.com/dex4er/perl-Plack-Middleware-Proxy-Connect-IO)

## AUTHOR

Piotr Roszatycki <dexter@cpan.org>

## LICENSE

Copyright (c) 2014, 2016, 2023 Piotr Roszatycki <dexter@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

See [http://dev.perl.org/licenses/artistic.html](http://dev.perl.org/licenses/artistic.html)
