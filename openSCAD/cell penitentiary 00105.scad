// Monday March 24, 2025 
// 

//$fn = 100; // Increase resolution
fn_num = 100;

xx = 75; 
yy = 30;
zz = 1.85; 

rr = zz/2;

//translate([0, 0, 10]) cube([xx, yy, zz]);


//translate([-rr,0,-zz/2]) cube([xx-2*rr, yy-2*rr, zz]);

//translate([-rr, yy-2*rr, 0]) rotate([90, 0, 0]) cylinder(h = yy-2*rr, r1 = zz/2, r2 = zz/2, center = false, $fn = fn_num);
 


//translate([2*rr, 2*rr, -zz/2]) cube([xx-4*rr, yy-2*rr, zz]);


for (i=[0:1]){
    translate([rr + i*(xx-2*rr), yy-2*rr, 0])
    rotate([90, 0, 0])
    cylinder(h = yy-(5*rr), r1 = rr, r2 = rr, center = false, $fn = fn_num);  
    }
    

for (i=[0:1]){
    translate([xx/2 + 0*rr, rr + i*(yy-1*rr), 0])
    rotate([0, 90, 0])
    cylinder(h = xx-(6*rr), r1 = rr, r2 = rr, center = true, $fn = fn_num);  

    //rotate([0, 90, 0])
    translate([rr, 2*rr, -rr]) cube([ zz,  yy-4*rr,  zz], center = false, $fn = fn_num);
    translate([xx-3*rr, 2*rr, -rr]) cube([ zz,  yy-4*rr,  zz], center = false, $fn = fn_num);
    translate([rr, rr, -rr]) cube([ xx-4*rr,  zz,  zz], center = false, $fn = fn_num);
    translate([2*rr, yy-2*rr, -rr]) cube([ xx-6*rr,  zz,  zz], center = false, $fn = fn_num);
    
    }


 
for (i=[0:1]){ for (j=[0:1]){
     
    translate([i*(xx-6*rr), j*(yy-5*rr), 0])
    translate([3*rr, 3*rr, 0])
     union(){

        cylinder(h = zz, r1 = 2*rr, r2 = 2*rr, center = true, $fn = fn_num);  

        rotate_extrude($fn = fn_num)
            translate([2*rr, 0]) // Move circle outward to create a ring
            circle(rr, $fn = fn_num); // Inner circle size
     }}}

module make_base(xx, yy, zz, rr, fn_num){
    
    translate([rr, rr, -rr]) cube([xx-2*rr, yy-2*rr, zz]);

    make_base(xx, yy, zz, rr, fn_num);

    translate([2*rr, 2*rr, 0])

    for (i=[0:1]){
        for (j=[0:1]){
            translate([i*(xx-4*rr), j*(yy-4*rr), 0])
            rotate_extrude()
                translate([rr, 0]) // Move circle outward to create a ring
                circle(rr); // Inner circle size
        }}


    translate([2*rr, 2*rr, -rr])

    for (i=[0:1]){
        for (j=[0:1]){
            translate([i*(xx-4*rr), j*(yy-4*rr), 0])
            rotate_extrude()
                translate([0, 0]) // Move circle outward to create a ring
                square([rr, 2*rr]); //circle(rr); // Inner circle size
        }}
        
        
 
    for (i=[0:1]){
        translate([rr + i*(xx-2*rr), yy/2, 0]) rotate([90, 0, 0])
        cylinder(h = yy-4*rr, r1 = zz/2, r2 = zz/2, center = true, $fn = fn_num);  
        }

    for (i=[0:1]){
        translate([xx/2, rr + i*(yy-2*rr), 0]) rotate([0, 90, 0])
        cylinder(h = xx-4*rr, r1 = zz/2, r2 = zz/2, center = true, $fn = fn_num);  
        }

}