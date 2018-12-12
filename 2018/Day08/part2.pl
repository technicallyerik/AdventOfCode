#!/usr/bin/perl

open my $fh, '<', 'input.txt' or die "Can't open file $!";
my $string = do { local($/); <$fh> };
close($fh);

my @numbers = split / /, $string;

($rootValue, @numbers) = Recurse(\@numbers);

printf("Root value: %d\n", $rootValue);

sub Recurse {
	my ($array_ref) = @_;
	my @array = @{ $array_ref };
	
	my $numChildNodes = int(@array[0]);
	my $numMetadataEntries = int(@array[1]);
	my @restOfArray = @array[2..$#array];
	
	my $value = 0;
	
	my @childrenValues = [];
	for (my $c = 0; $c < $numChildNodes; $c++) {
		(my $childSum, @restOfArray) = Recurse(\@restOfArray);
		@childrenValues[$c] = $childSum;
	}
	
	for (my $m = 0; $m < $numMetadataEntries; $m++) {
		$metadataEntry = int(@restOfArray[$m]);
		if ($numChildNodes == 0) {
			$value += $metadataEntry;
		} else {
			$value += @childrenValues[$metadataEntry - 1];
		}
	}

	printf("Value: %d\n", $value);
	
	return ($value, @restOfArray[$numMetadataEntries..$#restOfArray]);
}