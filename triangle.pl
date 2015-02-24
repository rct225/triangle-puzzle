#!/usr/bin/perl                                                                                       
# Robert C. Tuck                                                                                      
# code the determine maximum path in "triangle" graph                                                 
#                                                                                                     
# an iterative bottom-up approach                                                                     
#                                                                                                     


use strict;
use warnings;

#open the file                                                                                        
my $file = 'triangle.txt';
open my $data, $file or die "Can't open $file\n";

#initialize triangle array to load data file                                                          
my @triangle;

#load rows from file into triangle array                                                              
while ( my $current_row = <$data>) {
    # remove the new line                                                                             
    chomp($current_row);
    # split the line into array elements                                                              
    my @row = split(/ /, $current_row);
    #push each row onto array                                                                         
    push(@triangle, [@row]);
}

# start at 2nd row from bottom of triangle array (2-d array)                                          
# find the local max value of each sub-tree (node + max value child)                                  
# replace value at each node with the maximum value                                                   
# move up one row until you get to the top                                                            
# final answer will be found at root node                                                             
# this method reduces the number of items at each iteration    
        
for (my $i = (@triangle)-2; $i >= 0; $i--) {
    for (my $j = $i; $j >= 0; $j--) {
        $triangle[$i][$j] = maxsum($i, $j);
    }
}

print "$triangle[0][0]\n";

# sub to return the maximum value of node and child                                                   
sub maxsum {
    my $m = shift;
    my $n = shift;

    # add left child value to current node value                                                      
    my $ls = $triangle[$m][$n] + $triangle[$m+1][$n];
      # add right child value to current node value                                                     
    my $rs = $triangle[$m][$n] + $triangle[$m+1][$n+1];

    if ($ls > $rs) {
        return $ls;
    } else {
        return $rs;
    }
}