include <M3.scad>
fn=30;
alto = 30;

module node() {
    color("darkblue")
    cube([26,34.20, 6.20]);
    
    translate([2.4,7.15,1.5])
    rotate([0,0,90])
    color("black")
    cube([21,2.4,8.5]);
    
    translate([26,7.15,1.5])
    rotate([0,0,90])
    color("black")
    cube([21,2.4,8.5]);
}

module stepdown() {
    color("darkblue")
    cube([21.26, 43.56, 13.18]);
}

module hcontroller() {
    color("darkblue")
    cube([23.59, 30, 12]);
}

module electronica() {

translate([55,0,0])
stepdown();

translate([29,5,0])
hcontroller();

translate([0,5,0])
node();
    
}

module nut_escuadra() {
    cylinder(d=3.5, h=15, $fn=fn);
    
    translate([0,0,12])
    NutM3();
    
    translate([0,0,11])
    rotate([0,0,45])
    cube([5.5,8,3], center=true);
}


module escuadra(x,y,z,w) {

    module a() {
        difference() {
            cube([x, y, z]);
            translate([w, w, 0])
            cube([x, y, z+0.1]);
        }

        translate([7,1,0])
        rotate([0,0,45])
        cube([4,9,z]);
    }
    
    difference() {
        a();
        translate([4,4,15])
        rotate([0,0,90])
        nut_escuadra();
    }
    
}


module escuadra_motor(x,y,z,w) {
    
    module agujeros() {
        translate([0,0,5])
        rotate([0,90,0])
        cylinder(d=3.5,h=10, center=true, $fn=fn);
        
        translate([4,0,5])
        rotate([0,90,0])
        NutM3();
        
        translate([0,-17.50,5])
        rotate([0,90,0])
        cylinder(d=3.5,h=10, center=true, $fn=fn);
        
        translate([8.5,-17.50,5])
        rotate([0,90,0])
        scale([1,1,3])
        NutM3();
    }
    
    difference() {
        escuadra(x,y,z,w);
        
        translate([0,26.3,5])
        agujeros();
        
        translate([0,12,15])
        cube([2, 11.5, 15]);
        
    }
}

module anclaje(x=4) {
    difference() {
        
        cube([10,13,15]);
        translate([0,3,5.5])
        cube([15,15,x]);
        fondo = 8;
        translate([5,fondo])
        cylinder(d=3.5, h=20, $fn=fn);
        
        translate([5,fondo,15])
        BoltM3();
        
        translate([5,fondo,2.325])
        NutM3();
    }
}

module rueda() {
    rotate([90,0,90])
    cylinder(d=20,h=5, $fn=fn);
}

module soporte_rueda() {
    difference() {
        union() {
            translate([0,0,-6])
            cube([10,10,16.5]);
            
            translate([0,5,-6])
            rotate([0,90,0])
            cylinder(d=10, h=10, $fn=fn);
        }
        
        translate([2.5,0,-15])
        cube([5,10,15]);
        
        translate([0,5,-6])
        rotate([0,90,0])
        cylinder(d=3.5, h=20, $fn=fn);
        
        translate([2.5,5,2.5])
        rueda();
    }
}

module rueda_pincho() {
    anclaje();
    
    translate([5,0,10.1])
    rotate([-17,0,0])
    rotate([90,45,0])
    pincho();
    
    translate([0,-10,10])
    rotate([0,90,0])
    cubito([10,10,10]);
    
    translate([0,-10,-10])
    soporte_rueda();
    

}

module cubito() {
    intersection() {
        
        cube([10,10,10]);
        translate([10,10,0])
        cylinder(r=10,h=10, $fn=fn);
    }
}

//cubito();


module redondeo(x,y) {
    difference() {
        
        cube([x,x,y]);
        translate([x,x,0])
        cylinder(r=x,h=y+0.1, $fn=fn);
    }
}

module pincho() {
    difference() {
        cylinder(d=14, d2=0, h=30, $fn=4);
        
        translate([0,0,15])
        cylinder(d=2, h=10, $fn=fn);
        
        translate([0,0,26.5])
        cube([4,4,8], center=true);
    }
    
}

module cone() {
    th = 4;
    glob_th = th;
    screw_dst = 8.75;
    screw_r = 3.5/2;

    cone_r = 15;
    cone_dst = 40;
    th = 2;
    gap_h = 15;
    h = 30;
    r=cone_r;
    pos = [-r,0,cone_dst-17];
    translate(pos)
    difference() {
        hull() {
            cylinder(r1=0, r2=r, h=h);
            //translate(-pos+[0,-((screw_r+th)*8)/2,cone_dst])
            //cube([0.0001,(screw_r+th)*8,13]);
            
            #translate(-pos) cube([th,(screw_r+glob_th)*2, 0.001], true);

        }
        
        translate([0,0,h/10+th])
        cylinder(r1=0, r2=r-th, h=h-th);
        
        translate([-18,0,0])
        cube([30,30,gap_h+th]*2, true);
        
        for (i = [0:2]) 
        translate([0,0,10-7*i]) rotate([0,90,0]) cylinder(r=screw_r, h=100, $fn=30);
        

    }
    
    translate([1,-5,4.5])
    rotate([-90,0,90])
    anclaje(5);
    
    translate([-2,5,4.5])
    rotate([0,-90,90])
    redondeo(12,10);
}
//cone();

module escuadras() {
    
    translate([0,0,0])
    escuadra(20,13,alto,4);

    translate([90,0,0])
    rotate([0,0,90])
    escuadra(13,20,alto,4);

    translate([0, 60, 0])
    scale([1,-1,1])
    escuadra_motor(20,30,alto,4);

    translate([90, 60, 0])
    rotate([0,0,180])
    escuadra_motor(20,30,alto,4);
}

//escuadras();

module tapa_superior() {
    
    module agujeros_pilas() {
        translate([0,0,0])
        cylinder(d=3.5, h=10, center=true);
        
        translate([0,15,0])
        cylinder(d=3.5, h=10, center=true);
        
        translate([0,30,0])
        cylinder(d=3.5, h=10, center=true);
        
        translate([0,0,0])
        cylinder(d=3.5, h=10, center=true);
    }
    module a() {
    difference() {

        color("yellow")
        cube([90, 60, 4]);
        
        translate([0,0,-alto+1])
        escuadras();
        
        translate([4,4])
        cylinder(d=3.5, h=10, $fn=fn);
        
        translate([90-4,4])
        cylinder(d=3.5, h=10, $fn=fn);
        
        translate([90-4,60-4])
        cylinder(d=3.5, h=10, $fn=fn);
        
        translate([4,60-4])
        cylinder(d=3.5, h=10, $fn=fn);
        
        translate([4,4,5.5])
        BoltM3();
        
        translate([90-4,4,5.5])
        BoltM3();
        
        translate([90-4,60-4,5.5])
        BoltM3();
        
        translate([4,60-4,5.5])
        BoltM3();
        
        translate([45,30,0])
        cube([58,48.5,14], center=true);
        
        
        translate([0,36.5,0])
        cube([2, 11.5, 5]);
        
        translate([88,36.5,0])
        cube([2, 11.5, 5]);
    }
    
    difference() {
        
        translate([45,30,2])
        cube([10,60,4], center=true);
        

    }
    
    
    }
    difference(){
        a();
        
        translate([45,7.5,0])
        for (i = [0:15:45]) {
            translate([0,i,0])
            cylinder(d=3.5, h=10, center=true, $fn=fn);
            translate([0,i,2.3])
            NutM3();
        }
    }
    
   
}
//tapa_superior();

module tapa_inferior() {
    
    difference() {
        cube([90, 60, 4]);
        
        for (i = [10:10:80]) {
            for (j = [15:10:50]) {
            translate([i,j])
            cylinder(d=3.5, h=10, $fn=fn);
            }
            
        }
        
        for (i = [25:10:65]) {
        translate([i,5])
        cylinder(d=3.5, h=10, $fn=fn);
        }
        
        for (i = [25:10:65]) {
        translate([i,55])
        cylinder(d=3.5, h=10, $fn=fn);
        }
    }
    
    
}

module goma(diametro, diametro_goma){
    rotate_extrude(angle=360, convexity=2, $fn=fn) {
        
    translate([diametro/2,0])
    circle(d=diametro_goma, $fn=fn);
    }
}


module rueda(d, d_goma) {
    module a() {
        translate([0,0,1.5])
        cylinder(d=d, h=1.5, $fn=fn, center=true);

        cylinder(d=d-d_goma/2, h=1.5, $fn=fn, center=true);

        translate([0,0,-1.5])
        cylinder(d=d, h=1.5, $fn=fn, center=true);
    }
    
    difference() {
        a();
        cylinder(d=3.5, h=10, $fn=fn, center=true);
        
        for (i = [0:90:360]) {
            rotate([0,0,i])
            translate([7.5,0,0])
            cylinder(d=5, h=10, $fn=fn, center=true);
        }
        for (i = [0:90:360]) {
            rotate([0,0,45+ i])
            translate([9,0,0])
            cylinder(d=3, h=10, $fn=fn, center=true);
        }
    }
}


module fightbot(){

    translate([5,7.5,0])
    electronica();

    color("yellow")
    translate([0,0,-4])
    tapa_inferior();


    translate([0,0,alto])
    tapa_superior();

    translate([0,0,0])
    escuadra(20,13,alto,4);

    translate([90,0,0])
    rotate([0,0,90])
    escuadra(13,20,alto,4);

    translate([0, 60, 0])
    scale([1,-1,1])
    escuadra_motor(20,30,alto,4);

    translate([90, 60, 0])
    rotate([0,0,180])
    escuadra_motor(20,30,alto,4);

    translate([40,-3,-10])
    rueda_pincho();

    translate([45,58.5,-8.5])
    rotate([0,90,90])
    cone();


    translate([45,-8,-26])
    rotate([0,90,0])
    rueda(20, 3.53);


}

module imprimir_base() {
    //color("yellow")
//translate([0,0,-4])
//tapa_inferior();
    
    translate([0,0,0])
escuadra(20,13,alto,4);

translate([90,0,0])
rotate([0,0,90])
escuadra(13,20,alto,4);

translate([0, 60, 0])
scale([1,-1,1])
escuadra_motor(20,30,alto,4);

translate([90, 60, 0])
rotate([0,0,180])
escuadra_motor(20,30,alto,4);
    
}





//rueda_pincho();
//rueda(28, 3.53);

fightbot();