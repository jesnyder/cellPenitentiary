

//$fn = 100; // Increase resolution
fn_num = 20;
xx = 75; 
yy = 60;
zz = 1.85; 
rr = 4;

offsetx = 16;
offsety = 6;
compressiony = 0.9;
dh = zz+.2;
dt = 3;
db = .75; 

// Reservoir height 
rh = 0.5;
ro = 0.2;


// Inlet parameters 
ih = 3*2; 
ir = 2.5;

ii = floor((xx-offsetx)/dt);
jj = floor((yy-offsety)/compressiony/dt);




// create slide 
difference(){
    
    color([0,0.9,0.9]) base_and_inlets();  
    color([0.8, 0, 0]) create_manifold();
    
  }

//color([0, .7, .7]) base_without_inlets_and_wells();

//color([.7,.7,0])  make_wells();

//translate([0, 0, -2*ro-rh/2]) make_reservoir();

//translate([0, 0, -rh-ro])
//color([0,0.5,0.2]) reservoir_and_inlets();


module create_manifold(){
    
    union(){
        
        //base_and_inlets(); 
        
        make_wells();
        translate([0, 0, -rh-.2]) make_inlets_holes();
        translate([0, 0, -2*ro-rh]) make_reservoir();
        
        }
    
    }



module base_and_inlets(){
    
    union(){
        
        make_base(); 
        make_inlets();
        
        }
    
    }


module reservoir_and_inlets(){
    
    union(){
        make_reservoir();
        make_inlets_holes();
        
        }
    
    }



module make_inlets_holes(){
    
        for (i=[0:1]) { 
        translate([1,i*yy/3+yy/3,ih/2-0])
        translate([rr, 0, ih/2+zz])
        rotate_extrude( angle=360, $fn = fn_num)
        translate([ir/4,0,0])
        square([ir/2,2*ih], center=true, $fn = fn_num);
    }}



module make_inlets(){
    
        for (i=[0:1]) { 
        translate([1,i*yy/3+yy/3,0])
        translate([rr, 0, ih/2+zz])
        rotate_extrude( angle=360, $fn = fn_num)
        translate([ir/2,0,0])
        square([ir,ih], center=true, $fn = fn_num);
    }}



module make_reservoir(){
    
    union(){

    translate([offsetx/2, offsety/2, 1.8]) cube([(ii+1)*dt, (jj)*dt*compressiony, .5]);
    translate([2, offsety/2, 1.8]) cube([(ii+1)*dt, (jj)*dt*compressiony, rh]);

    }}


// make wells 
module make_wells(){
    

    for (i=[1:ii]) { for (j=[1:jj]) {
        translate([i*dt*1,j*dt*compressiony-dt/2,-zz/2-.1])
        translate([j%2*dt/2, 0, 0])
        translate([offsetx/2, offsety/2, zz/2])
        cylinder(h = dh, r1 = db/2, r2 = dt/2, center = false, $fn = fn_num);
        }}
    }


// make base 
module make_base(){
    
    union(){
        
    translate([zz/2, zz/2+rr/2, 0]) cube([xx-zz, yy-zz-rr, zz]);
    translate([zz/2 + rr/2, zz/2, 0]) cube([xx-zz-rr, yy-zz, zz]);
 
    
    for (i=[0:1]) { for (j=[0:1]) {
        translate([i*(xx-rr-2*zz),j*(yy-rr-2*zz),0])
        translate([rr, rr, zz/2])
        rotate_extrude( angle=360, $fn = fn_num)
        translate([rr-zz/2,0,0])
        circle([zz], center=true);
        
    }}
 
 
    for (i=[0:1]) { for (j=[0:1]) {
        translate([i*(xx-rr-2*zz),j*(yy-rr-2*zz),0])
        translate([rr, rr, zz/2])
        rotate_extrude( angle=360, $fn = fn_num)
        translate([zz,0,0])
        square([zz,zz], center=true, $fn = fn_num);
        
    }}
    
    
     for (i=[0:1]){
        translate([i*(xx-zz), 0, 0])
        translate([zz/2, yy/2, zz/2]) rotate([90, 0, 0])
        cylinder(h = yy-rr*2, r1 = zz/2, r2 = zz/2, center = true, $fn = fn_num);       
    }  
    
    for (i=[0:1]){
        translate([0, i*(yy-zz), 0])
        translate([xx/2, zz/2, zz/2]) rotate([0, 90, 0])
        cylinder(h = xx-rr*2, r1 = zz/2, r2 = zz/2, center = true, $fn = fn_num);       
    }
    
    }
    }