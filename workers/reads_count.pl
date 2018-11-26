#!/usr/bin/env perl

use strict;
use warnings;
use autodie;
use feature 'say';
use Getopt::Long;
use Pod::Usage;
use Bio::Perl;

main();

# --------------------------------------------------
sub main {
    my %args = get_args();

    if ($args{'help'} || $args{'man'}) {
        pod2usage({
            -exitval => 0,
            -verbose => $args{'man'} ? 2 : 1
        });
    } 

    my $file = $args{'filelist'} or pod2usage('Missing input file');
    my $indir = $args{'indir'} or pod2usage('Missing input directory'); 
    my $outdir = $args{'outdir'} or pod2usage('Missing output directory');

    open my $in_fh, "<", $file;
    open my $out_fh, ">", "$outdir/reads_count.csv";

    while (my $line = <$in_fh>) {
          chomp $line;
	  my $count = `grep ">" $indir/$line | wc -l`;
          chomp $count;
          say $out_fh $count, ",", $line;  
    }
    close($in_fh);
    
}

# --------------------------------------------------
sub get_args {
    my %args;
    GetOptions(
        \%args,
        'filelist=s',
        'indir=s',
        'outdir=s',
        'help',
        'man',
    ) or pod2usage(2);

    return %args;
}

__END__

# --------------------------------------------------

=pod

=head1 NAME

ratio_csv_maker.pl - a script

=head1 SYNOPSIS

  ratio_csv_maker.pl 

Options:

  --help   Show brief help and exit
  --man    Show full documentation

=head1 DESCRIPTION

Describe what the script does, what input it expects, what output it
creates, etc.

=head1 SEE ALSO

perl.

=head1 AUTHOR

xiangl1 E<lt>xiangl1@email.arizona.eduE<gt>.

=head1 COPYRIGHT

Copyright (c) 2015 xiangl1

This module is free software; you can redistribute it and/or
modify it under the terms of the GPL (either version 1, or at
your option, any later version) or the Artistic License 2.0.
Refer to LICENSE for the full license text and to DISCLAIMER for
additional warranty disclaimers.

=cut
