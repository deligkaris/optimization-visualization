#! /usr/bin/perl -w 

#use diagnostics;
#use strict;

#definitions
my($file,$i,$j,$nofATOMS,$line,@parts,$atom,$x,$y,$z,$Fx,$Fy,$Fz,@hessian);

$nofATOMS = 3;

$file = $ARGV[0];

open OUTfile, "<", "$file";    

$i = 0;

while ($line = <OUTfile>) {
	if($line =~ m/ATOM      X            Y            Z        EXTENSION/) {
	
		$line = <OUTfile>;

		open XYZfile, ">", "relax"."$i".".xyz";
		printf XYZfile "%d\n", $nofATOMS;
		for ($j=1; $j<=$nofATOMS; $j++) {

			$line = <OUTfile>;
			@parts = split " ", $line;
			$atom = $parts[0];
			$x = $parts[1];
			$y = $parts[2];
			$z = $parts[3];
				
			if( $atom == 1 ) {
				printf XYZfile "%4s", "H";
			}
			elsif( $atom == 6 ) {
				printf XYZfile "%4s", "C";
			}
                        elsif( $atom == 7 ) {
                                printf XYZfile "%4s", "N";
                        }
                        elsif( $atom == 8 ) {
                                printf XYZfile "%4s", "O";
                        }

			printf XYZfile " %f %f %f\n",$x, $y, $z;
		}
		close XYZfile;

		$line = <OUTfile>;
		$line = <OUTfile>;

                open FORCESfile, ">", "forces"."$i".".vtk";
		printf FORCESfile "# vtk DataFile Version 2.0\nTest\nASCII\nDATASET POLYDATA\nPOINTS %d float\n", $nofATOMS;
		for ($j=1; $j<=$nofATOMS; $j++) {
			printf FORCESfile "%d 0 0\n", $j; 
		}
		printf FORCESfile "POINT_DATA %d\nVECTORS forces float\n", $nofATOMS ;
                for ($j=1; $j<=$nofATOMS; $j++)	{

                        $line = <OUTfile>;
                        @parts = split " ", $line;

                        $Fx = $parts[0];
                        $Fy = $parts[1];
                        $Fz = $parts[2];
			
			printf FORCESfile "%f %f %f\n",$Fx,$Fy,$Fz;
                }
                close FORCESfile;

		$line = <OUTfile>;

		open HESSIANSfile, ">", "hessians"."$i".".vtk";
		printf HESSIANSfile "# vtk DataFile Version 2.0\nTest\nASCII\nDATASET POLYDATA\nPOINTS %d float\n", $nofATOMS;
                for ($j=1; $j<=$nofATOMS; $j++) {
                        printf HESSIANSfile "%d 0 0\n", $j;
                }
		printf HESSIANSfile "POINT_DATA %d\nTENSORS hessian float\n", $nofATOMS;
		$nofLINES = ($nofATOMS*$nofATOMS*3*3)/5;
		if ( ($nofATOMS*$nofATOMS*3*3)%5 != 0 ) {
			$nofLINES = int($nofLINES) + 1;
		}
		@hessian = ();		
		for ($j=1; $j<=$nofLINES; $j++) {
			$line = <OUTfile>;
			@parts = split " ", $line;
			push @hessian, @parts;
		}
		for ($j=0; $j<$nofATOMS; $j++) {
			printf HESSIANSfile "%f %f %f\n", $hessian[9*$nofATOMS*$j+3*$j+0],$hessian[9*$nofATOMS*$j+3*$j+1],$hessian[9*$nofATOMS*$j+3*$j+2];
			printf HESSIANSfile "%f %f %f\n", $hessian[9*$nofATOMS*$j+3*$j+0+3*$nofATOMS],$hessian[9*$nofATOMS*$j+3*$j+1+3*$nofATOMS],$hessian[9*$nofATOMS*$j+3*$j+2+3*$nofATOMS];
			printf HESSIANSfile "%f %f %f\n\n", $hessian[9*$nofATOMS*$j+3*$j+0+2*3*$nofATOMS],$hessian[9*$nofATOMS*$j+3*$j+1+2*3*$nofATOMS],$hessian[9*$nofATOMS*$j+3*$j+2+2*3*$nofATOMS];
		}
		close HESSIANSfile;

	$i++;
	}
}


close OUTfile;


