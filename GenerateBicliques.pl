use strict;
use warnings;
#use File::ReadBackwards;
use Data::Dumper qw(Dumper);

print "Input n: ";
my $n = <STDIN>;
chomp $n;
print "Input m: ";
my $m = <STDIN>;
chomp $m;
print "Number of Bicliques: ";
my $numberBicliques = <STDIN>;
chomp $numberBicliques;
print "Ring (1) / Chain (2): ";
my $option = <STDIN>;
chomp $option;  
my $filename_output = "";
my $fho;

if($option eq "1")
{
	#Creating name of output file		
	$filename_output = "BCRing"."$n"."$m"."_bipartite.txt";
	#my $numberBicliques = 2*(($n*$m)+1)+100; #RING
	my $s = 0;	
	my $idRow = 0;	
	my $idCol = 0;	
	my $jumpRow = 0;
	my $jumpCol = 0;
	open($fho, '>:encoding(UTF-8)', $filename_output)or die "Could not open file '$filename_output' $!";	
	while($s < $numberBicliques)  
	{
		for(my $i=0;$i<$n;$i++)
		{
			$idRow = $jumpRow+$i; 
			for(my $j=0;$j<$m;$j++)
			{
				$idCol = ($n*$numberBicliques)+$j+$jumpCol;
				print $fho $idRow . "\t" . $idCol. "\t" . "1\n";
			}	
		}
		if($s != ($numberBicliques-1))
		{
			$idCol = $idCol +1;
		}
		else
		{
			$idCol = ($n*$numberBicliques);
		}
		print $fho $idRow . "\t" . $idCol. "\t" . "1\n";	
		$jumpRow = $jumpRow + $n;
		$jumpCol = $jumpCol + $m;
		$s = $s + 1;
	}
}
else
{
	#Creating name of output file		
	$filename_output = "BCChain"."$n"."$m"."_bipartite.txt";
	#my $numberBicliques = 2*($n*$m); #CHAIN
	my $lastIdV1 = (($numberBicliques/2)*$n)+(($numberBicliques/2)*$m);
	my $s = 0;	
	my $idRow = 0;	
	my $idCol = 0;	
	my $jumpRow = 0;
	my $jumpCol = 0;
	my $cli = $n;
	open($fho, '>:encoding(UTF-8)', $filename_output)or die "Could not open file '$filename_output' $!";	
	while($s < $numberBicliques)  
	{
		for(my $i=0;$i<$cli;$i++)
		{
			$idRow = $jumpRow+$i; 
			for(my $j=0;$j<$cli;$j++)
			{
				$idCol = $lastIdV1+$j+$jumpCol;
				print $fho $idRow . "\t" . $idCol. "\t" . "1\n";
			}	
		}
		if($s != ($numberBicliques-1))
		{
			$idCol = $idCol +1;
			print $fho $idRow . "\t" . $idCol. "\t" . "1\n";	
		}
		$jumpRow = $jumpRow + $cli;
		$jumpCol = $jumpCol + $cli;
		if($s == ($numberBicliques/2)-1)
		{
			$cli = $m;
			
		}
		$s = $s + 1;
	}
}

close $fho;
print "::: Preprocessing Complete :::";
