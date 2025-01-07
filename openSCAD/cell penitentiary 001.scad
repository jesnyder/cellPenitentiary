
chip_x = 40; 
chip_y = 20;
chip_z = 6;
chip_r = 3;

well_Do = 1.5;
well_di = 0.3;
well_h = well_Do*2;

multp_x = 0.85;

ii = floor(chip_x/well_Do/multp_x-8);
jj = floor(chip_y/well_Do-4);

reservoir_x = ii*well_Do*multp_x;
reservoir_y = jj*well_Do + well_Do*1.5;
reservoir_z = chip_z - well_h - 1;

// mounting holes 
mount_D = 2; 

color([.1, .3, .3, .25]) build_chip();

//mounting_holes();

//integrate_manifold();
//color([.1, .3, .3, .25]) build_base();

//union(){
//build_crate();
//build_reservoir();
//build_inserts();
//}

module build_chip(){
    
    difference(){
        build_base();
        integrate_manifold();
        mounting_holes();
        } 
    }

module mounting_holes(){
    
     a=[[0,0],[mount_D, 0], [mount_D/2, mount_D/2], [mount_D/2, chip_z-mount_D/2],[mount_D, chip_z], [0, chip_z]];
    
    for (i = [0:1]){ 
        translate ([(chip_x - 2*chip_r), i*(chip_y - 2*chip_r), 0])
        rotate_extrude($fn = 100)
        polygon(a);
    }}

module integrate_manifold(){
    
    color([.6, .1, .1, .5])
    union(){
        
        
        build_inserts();
        build_reservoir();
        build_crate();
        }
    
    }


module build_base(){
    
    translate([-2*well_Do, -2*well_Do, 0])
    union(){
    translate([2*well_Do, 0, 0])
    cube([chip_x - 2*chip_r , chip_y, chip_z], center=false);
    
    for (i = [0:1]){ for (j = [0:1]){      
    translate([i*(chip_x - 2*chip_r) + chip_r , j*(chip_y - 2*chip_r) + chip_r ,0])
    cylinder(h = chip_z, r1 = chip_r, r2 = chip_r, center = false, $fn = 100); 
    }
    translate([i*(chip_x - chip_r), chip_r, 0])
    cube([chip_r , chip_y-2*chip_r , chip_z], center=false);
    
    }}} 


module build_inserts(){
    
    
    for (i = [1:2]){  
    translate([0, 0, well_h+reservoir_z/2])
    translate([0, i*reservoir_y/3 ,0])
    rotate([0,90,0])
    cylinder(h = chip_x, r1 = reservoir_z/2, r2 = reservoir_z/2, center = false, $fn = 100); 
 
    
    }}


module build_reservoir(){
    
    translate([0, -well_Do/2, well_h])
    union(){
    cube([reservoir_x , reservoir_y , reservoir_z], center=false);
    
    for (i = [0:1]){ for (j = [0:1]){      
    translate([i*reservoir_x , j*(reservoir_y-well_Do) +well_Do/2 ,0])
    cylinder(h = reservoir_z, r1 = well_Do/2, r2 = well_Do/2, center = false, $fn = 100); 
    }
    translate([i*reservoir_x-well_Do/2,well_Do/2,0])
    cube([well_Do , reservoir_y-well_Do , reservoir_z], center=false);
    
    }}}

module build_crate(){
    
     for (i = [0:ii]){ for (j = [0:jj]){   
     
     translate([i*well_Do*multp_x, j*well_Do + i%2*well_Do/2,0])
     
     union(){
     cylinder(h = well_h, r1 = well_di/2, r2 = well_Do/2, center = false, $fn = 100); 
         
     translate([0,0,well_h])
     cylinder(h = chip_z-well_h+1, r1 = well_Do/2, r2 = well_di, center = false, $fn = 100); 
        
    }}}}