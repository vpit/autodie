#!/usr/bin/perl -w
use strict;
use Fatal qw(open);
use Test::More tests => 2;
use constant NO_SUCH_FILE => "xyzzy_this_file_is_not_here";

TODO: {

    local $TODO = "Backwards compatibility not yet supported under 5.8"
       if $] < 5.010;

    eval {
	open(my $fh, '<', NO_SUCH_FILE);
    };

    my $old_msg = qr{Can't open\(GLOB\(0x[0-9a-f]+\), <, xyzzy_this_file_is_not_here\): .* at \(eval \d+\) line \d+\s+main::__ANON__\('GLOB\(0x[0-9a-f]+\)', '<', 'xyzzy_this_file_is_not_here'\) called at \S+ line \d+\s+eval \Q{...}\E called at \S+ line \d+};

    like($@,$old_msg,"Backwards compat ugly messages");
    ok(!ref($@), "Exception is a string, not an object");
}
