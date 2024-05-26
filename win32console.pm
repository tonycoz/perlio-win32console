package PerlIO::win32console;
use strict;
use warnings;

our $VERSION = "0.001";

use XSLoader;
XSLoader::load(__PACKAGE__, __PACKAGE__->VERSION);

__END__

=head1 NAME

PerlIO::win32console - unicode console output on windows

=head1 SYNOPSIS

  binmode STDOUT, ":raw:win32console" if -t STDOUT;
  binmode STDERR, ":raw:win32console" if -t STDERR;

  # input not implemented
  binmode STDIN, ":raw:win32console" if -t STDIN;

  print "unicode characters\n";

  # not implemented yet
  # apply :win32console to STDOUT/STDERR if they're console output
  use PerlIO::win32console "-installout";
  # apply :win32console to STDIN if it's a console
  use PerlIO::win32console "-installin";
  # apply :win32console to any of STDIN, STDOUT, STDERR if they're
  # consoles
  use PerlIO::win32console "-install";

-head1 DESCRIPTION

Implements UTF-8 output to the Win32 console, using the wide character
console APIs.

Future possibilities:

=over

=item *

input from the console

=item *

handling ANSI escapes

=back

=head1 AUTHOR

Tony Cook <tony@develop-help.com>

=head1 SEE ALSO

Win32::Console::ANSI

=cut
