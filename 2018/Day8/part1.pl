#!/usr/bin/perl

open my $fh, '<', 'input.txt' or die "Can't open file $!";
my $string = do { local($/); <$fh> };
close($fh);

my @numbers = split / /, $string;

$totalMetadata = 0;
#while (scalar @numbers > 0) {
	@numbers = Recurse(\@numbers);
#}
printf("Total metadata: %d\n", $totalMetadata);

sub Recurse {
	my ($array_ref) = @_;
	my @array = @{ $array_ref };
	
	my $numChildNodes = int(@array[0]);
	printf("Num child nodes: %d\n", $numChildNodes);
	my $numMetadataEntries = int(@array[1]);
	printf("Num metadata entries: %d\n", $numMetadataEntries);
	my @restOfArray = @array[2..$#array];
	
	for (my $c = 0; $c < $numChildNodes; $c++) {
		@restOfArray = Recurse(\@restOfArray);
	}
	
	for (my $m = 0; $m < $numMetadataEntries; $m++) {
		$metadataEntry = int(@restOfArray[$m]);
		$totalMetadata += $metadataEntry;
		printf("Metadata entry: %d\n", $metadataEntry);
	}
	
	return @restOfArray[$numMetadataEntries..$#restOfArray];
}