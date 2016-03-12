package WWW::Shorten::SnipURL;

use 5.006;
use strict;
use warnings;

use Carp ();
use URI;
use HTTP::Request::Common 'POST';
use Try::Tiny qw(try catch);

use base qw( WWW::Shorten::generic Exporter );
our @EXPORT  = qw(makeashorterlink makealongerlink);
our $VERSION = '2.020';
$VERSION = eval $VERSION;

sub makeashorterlink {
    my $url     = shift or Carp::croak('No URL passed to makeashorterlink');
    my $ua      = __PACKAGE__->ua();
    my $snipurl = 'http://snipurl.com/site/index';
    my $req     = POST $snipurl, [url => $url,];
    my $resp
        = try { return $ua->request($req); } catch { warn $_; return undef };
    return unless $resp;
    return unless $resp->is_success;

    if ($resp->content
        =~ m|<input name="SNIPPED" class="snipped textsnipped" type="text" value="(http://snipurl.com/\w+)"|
        )
    {
        return $1;
    }
    return;
}

sub makealongerlink {
    my $code = shift
        or Carp::croak('No SnipURL key / URL passed to makealongerlink');
    my $ua = __PACKAGE__->ua();
    $code = "http://snipurl.com/$code" unless ($code =~ m|^http://|i);

    my $resp = try { return $ua->get($code); } catch { warn $_; return undef };
    return unless $resp;
    return unless $resp->is_redirect;
    return $resp->header('Location');
}

1;

=head1 NAME

WWW::Shorten::SnipURL - Perl interface to SnipURL.com

=head1 SYNOPSIS

  use WWW::Shorten::SnipURL;

  use WWW::Shorten 'SnipURL';

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

=head1 DESCRIPTION

A Perl interface to the web service SnipURL.com. SnipURL maintains a
database of long URLs, each of which has a unique identifier or
nickname. For more features, please visit http://snipurl.com/features

=head1 Functions

=head2 makeashorterlink

The function C<makeashorterlink> will call the SnipURL web site passing it
your long URL and will return the shorter SnipURL version. If used in a
list context, then it will return both the Snip URL and the password.

=head2 makealongerlink

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full Snip URL or just the
SnipURL identifier.

If anything goes wrong, then either function will return C<undef>.

=head2 EXPORT

makeashorterlink, makealongerlink

=head1 SUPPORT, LICENCE, THANKS and SUCH

See the main L<WWW::Shorten> docs.

=head1 AUTHOR

Dave Cross <dave@mag-sol.com>

Original author Shashank Tripathi <shank@shank.com>.

=head1 SEE ALSO

L<WWW::Shorten>, L<perl>, L<http://snipurl.com/>

=cut
