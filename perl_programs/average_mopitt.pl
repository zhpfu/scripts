#!/usr/bin/perl -w
#
# Script for averaging MOPITT month data
#

$rundir = "/MOPITT/V7T/Archive/L3/";
#------------------------------------
# create tracer list of tagged tracers to extract
#------------------------------------
$tracerlist = "RetrievedCOTotalColumnDay,RetrievedCOTotalColumnNight,RetrievedCOMixingRatioProfileDay,RetrievedCOSurfaceMixingRatioDay,SurfacePressureDay,Latitude,Longitude";
    print "Selected extracted tracers: $tracerlist\n";
    print "\n";
    #------------------------------------
    # concatenate files
    #------------------------------------
    for  $i (2001..2016) {
         $to_combine = "";
         print"$to_combine\n";
         for  $j (11..11) {
          $dateval = $i.sprintf("%02d",$j);
          chomp($fname = `ls $rundir$dateval/month/*.he5`);
          $to_combine = $to_combine.$fname." ";
         }
         print "\n";

         #$outfile = $i."_dummy.nc";
         $outfile = $dateval."_dummy.nc";
         #print "$outfile\n";
         #chomp(`ls $rundir$i*/month/*.he5`);
         print "Averaging $i\n";

        # note ncra requires a time dimension in files, nces requires no time dimension
         print "nces -O -v $tracerlist $to_combine$outfile\n";
        `nces -O -v $tracerlist $to_combine$outfile`;
     }

     chomp(@final_average = `ls *dummy.nc`);
         print "Averaging all\n";
         print "nces -O -v $tracerlist @final_average MOPITT_ASON_2001_2016.nc\n";
         `nces -O -v $tracerlist @final_average MOPITT_ASON_2001_2016.nc`;