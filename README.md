# NAME

WWW::Shorten::SnipURL  - [![Build Status](https://travis-ci.org/p5-shorten/www-shorten-snipurl.svg?branch=master)](https://travis-ci.org/p5-shorten/www-shorten-snipurl)

# SYNOPSIS

```perl
use strict;
use warnings;

use WWW::Shorten 'SnipURL'; # recommended
# use WWW::Shorten::SnipURL; # also available

my $long_url = 'http://www.foo.com/bar/';
my $short_url = makeashorterlink($long_url);

$long_url  = makealongerlink($short_url);
```

# DESCRIPTION

**WARNING:** [http://shorl.com](http://shorl.com) does not provide an API.  We must scrape the
resulting HTML.

- Also, their service has been up and down quite a bit lately.  We have disabled live tests due to this.
- You have been warned.  We suggest using another [WWW::Shorten](https://metacpan.org/pod/WWW::Shorten) service.

A Perl interface to the web service [http://SnipURL.com](http://snipurl.com). The service maintains a
database of long URLs, each of which has a unique identifier or
nickname. For more features, please visit [http://snipurl.com/features](http://snipurl.com/features).

# Functions

[WWW::Shorten::SnipURL](https://metacpan.org/pod/WWW::Shorten::SnipURL) makes the following functions available.

## makeashorterlink

```perl
my $short = makeashorterlink('http://www.example.com/');
```

The function ```makeashorterlink``` will call use the web service, passing it
your long URL and will return the shorter version.

## makealongerlink

```perl
my $long = makealongerlink('ablkjadf2314sfd');
my $long = makealongerlink('http://snipurl.com/ablkjadf2314sfd');
```

The function ```makealongerlink``` does the reverse. ```makealongerlink```
will accept as an argument either the full URL or just the identifier.

If anything goes wrong, then either function will return ```undef```.

# AUTHOR

Shashank Tripathi shank@shank.com

# CONTRIBUTORS

- Chase Whitener capoeirab@cpan.org -- Current maintainer
- Dave Cross dave@perlhacks.com

# COPYRIGHT AND LICENSE

See the main [WWW::Shorten](https://metacpan.org/pod/WWW::Shorten) docs.

# SEE ALSO

[WWW::Shorten](https://metacpan.org/pod/WWW::Shorten), [http://snipurl.com](http://snipurl.com)
