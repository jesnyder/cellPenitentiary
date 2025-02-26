// Monday January 13, 2025 
// Tried earlier prototype, too tall to focus 

fn_num = 10;

chip_x = 30;
chip_y = 30;
chip_z = 1.85;

chip_h = 1.75;
chip_r = chip_h;

well_D1 = 1.15;
well_d0 = .5;
well_h0 = .1;
well_H1 = 1.00;

multp_x = 0.85;
multp_y = 1;

wells_x = 8;
wells_y = 3;

window_height = .2; 

ii = floor(chip_x/multp_x/well_D1 - wells_x);
jj = floor(chip_y/multp_y/well_D1 - wells_y);

reservoir_x = (ii+0.75)*well_D1*multp_x;
reservoir_y = (jj+.5)*well_D1*multp_y;
reservoir_z = chip_z - well_H1 - window_height ;


make_chip();
//make_insert();
//color(c = [.3, .2, .6], alpha = .5) make_base();

module make_chip(){
  
    difference(){
        color(c = [.3, .2, .6], alpha = .5) make_base();
        make_insert(); 
    }}
    

// make inlets to introduce fluids 
module make_inlets(){
    
    rotate([0, 0, 0])
    for (i=[1:2]){
    translate([0,i/3*(chip_y-wells_y*well_D1+well_D1), well_H1 + reservoir_z/2])
    rotate([0, 100, 0])
    cylinder(h = 1.2*(chip_x-reservoir_x), r1 = reservoir_z, r2 = 3.5*reservoir_z/2, center = false, $fn = fn_num);
    
    }}
    


module make_base(){
    
    translate([chip_r, 0,0])
    cube([chip_x-chip_r*2, chip_y, chip_z], center = false); 
    
    for (i=[0:1]){ for (j=[0:1]){
        translate([chip_r + i*(chip_x-2*chip_r), chip_r + j*(chip_y-2*chip_r),0])
        cylinder(h = chip_z, r1 = chip_r, r2 = chip_r, center = false, $fn = fn_num);
        }
        
        translate([i*(chip_x-chip_r),chip_r,0])
        cube([chip_r, chip_y-2*chip_r, chip_z], center = false); 
        }
    }


module make_insert(){
    
    translate([well_D1, wells_y/2*well_D1/2,0])
    union(){
    make_reservoir();
    make_wells();
    
    translate([reservoir_x, 0, 0])
    make_inlets();
    
    make_holes();
       
    }}


module make_holes(){
    
    for (i=[0:2]){
        
     translate([chip_x - 3*chip_r/2, i*(chip_y/2 - chip_r) + chip_r/2, 0])
    
    cylinder(h = chip_z, r1 = chip_r/2, r2 = chip_h/2, center = false, $fn = fn_num);
    
    }}



//build reservoir 
module make_reservoir(){
    
    translate([well_D1/2*multp_x, well_D1/2*multp_y, well_H1])
    cube([reservoir_x, reservoir_y, reservoir_z], center = false);  
    }


// make an array of the wells
module make_wells(){
    
    translate([multp_x*well_D1/2, multp_y*well_D1, 0])
    for (i = [0:ii]){  for (j = [0:jj]){
        translate([multp_x*well_D1*(i), multp_y*well_D1/2*(2*j - i%2), 0])
        make_well();
    }}}


// make wells by revolving 
module make_well(){
    
     a=[[0,0],[well_d0/2, 0], [well_d0/2, well_h0], [well_D1/2, well_H1], [well_D1/2, well_H1 + reservoir_z], [0, well_H1 + reservoir_z]];
    
     aa=[[0,0],[well_d0/2, 0], [well_D1/2, well_H1], [well_D1/2, well_H1 + reservoir_z], [0, well_H1 + reservoir_z]];
    
    rotate_extrude($fn = 100)
    polygon(aa);
    
    b=[[0,0], [well_D1/2, 0], [well_D1/3, 1.1*window_height], [0, window_height]];
    translate([0,0, reservoir_z+well_H1])
    rotate_extrude($fn = 100) polygon(b); 
    
    }