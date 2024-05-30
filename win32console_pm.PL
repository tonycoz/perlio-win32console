use strict;
use warnings;
my $is_win32 = $^O eq "MSWin32";

my $outname = shift
    or die "No output name supplied\n";

open my $fh, ">", $outname
    or die "Cannot create '$outname': $!\n";
binmode $fh;

print $fh <<'EOS';
package PerlIO::win32console;
use strict;
use warnings;
use Carp ();

our $VERSION = "0.001";
EOS

if ($is_win32) {
    print $fh <<'EOS';
use XSLoader;
XSLoader::load(__PACKAGE__, __PACKAGE__->VERSION);

EOS
}

print $fh <<'EOS';
sub import {
    # only something to do on windows
    my ($class, @args) = @_;
    while (@args) {
	my $arg = shift @args;
	if ($arg eq "-installout") {
EOS
if ($is_win32) {
    print $fh <<'EOS';
            binmode STDOUT, ":raw:win32console" if -t STDOUT;
	    binmode STDERR, ":raw:win32console" if -t STDERR;
EOS
}
else {
    print $fh <<'EOS';
            # only active on windows
EOS
}
print $fh <<'EOS';
	}
	else {
	    Carp::croak("$class: unknown import $arg");
	}
    }
}

__END__

=head1 NAME

PerlIO::win32console - unicode console output on windows

=head1 SYNOPSIS

  binmode STDOUT, ":raw:win32console" if -t STDOUT;
  binmode STDERR, ":raw:win32console" if -t STDERR;

  # input not implemented
  binmode STDIN, ":raw:win32console" if -t STDIN;

  print "unicode characters\n";

  # apply :win32console to STDOUT/STDERR if they're console output
  use PerlIO::win32console "-installout";

  # the following isn't implemented yet
  # apply :win32console to STDIN if it's a console
  use PerlIO::win32console "-installin";
  # apply :win32console to any of STDIN, STDOUT, STDERR if they're
  # consoles
  use PerlIO::win32console "-install";

=head1 DESCRIPTION

Implements UTF-8 output to the Win32 console, using the wide character
console APIs.

You can load the module with C<-installout> to automatically push this
layer onto STDOUT/STDERR on Windows:

  use PerlIO::win32console "-installout";

but do nothing on non-Windows.

When this layer is pushed this module attempts to enable ANSI escapes
for that console.

The PerlIO layer is only ever available on Windows.

Future possibilities:

=over

=item *

text input from the console

=item *

non-text (mouse, resizes) input from the console

=back

=head1 AUTHOR

Tony Cook <tony@develop-help.com>

=head1 SEE ALSO

Win32::Console::ANSI

=cut

EOS
