// Monday March 24, 2025 
// 

//$fn = 100; // Increase resolution
fn_num = 100;
xx = 75; 
yy = 30;
zz = 1.85; 
rr = zz/2;




offsetx = 10;
offsety = 4;
dh = 5;
dt = 2;
db = 1; 


translate([0,0,zz/2]) make_base(xx, yy, zz, rr, fn_num);
holes(offsetx, offsety, dt, db);

scale([(xx-offsetx)/xx, (yy-offsety)/yy, 1]) translate([offsety/2,dt,10]) make_base(xx, yy, zz, rr, fn_num);

module holes(dh, offsetx, offsety, dt, db){

    ii = floor((xx-10)/dt);
    jj = floor((yy-offsety)/dt);
    
    shift = dt/2; 
  

    for (i=[1:ii]){ for (j=[1:jj]){
        
        offseti = (i+1)%2;
        
        translate([i*dt+offsetx-offsety/2, j*dt + offsety/2-dt/2 + (i+1)%2*dt/2, 0])
        cylinder(h = dh, r1 = db/2, r2 = dt/2, center = false, $fn = fn_num);
        }}
    }

//translate([0, 0, 10]) cube([xx, yy, zz]);


//translate([-rr,0,-zz/2]) cube([xx-2*rr, yy-2*rr, zz]);

//translate([-rr, yy-2*rr, 0]) rotate([90, 0, 0]) cylinder(h = yy-2*rr, r1 = zz/2, r2 = zz/2, center = false, $fn = fn_num);
 
module make_base(xx, yy, zz, rr, fn_num){

    translate([2*rr, 2*rr, -zz/2]) cube([xx-4*rr, yy-2*rr, zz]);


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
        translate([rr, 3*rr, -rr]) cube([ zz,  yy-5*rr,  zz], center = false, $fn = fn_num);
        translate([xx-3*rr, 3*rr, -rr]) cube([ zz,  yy-5*rr,  zz], center = false, $fn = fn_num);
        translate([4*rr, rr, -rr]) cube([ xx-8*rr,  zz,  zz], center = false, $fn = fn_num);
        translate([4*rr, yy-2*rr, -rr]) cube([ xx-8*rr,  zz,  zz], center = false, $fn = fn_num);
        
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

     }
     
 