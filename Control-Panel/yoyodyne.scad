//===========================================

use <fontmetrics.scad>;

//===========================================

$fa = 1;
$fs = 0.5;

//===========================================

FUDGE = 0.01;

//===========================================

CLEARANCE = 2.5;

BOLT_MOD_SLIDE = 1.5;
BOLT_MOD_TAP = 0.5;

M25_BOLT_SIZE = 2.5;
M25_BOLT_HEAD_SIZE = 4.5;
M25_BOLT_HEAD_HEIGHT = 2.4;

M3_BOLT_SIZE = 3.0;
M3_BOLT_HEAD_SIZE = 6.5;
M3_BOLT_HEAD_HEIGHT = 3.0;

M4_COUNTERSINK_SIZE = 4;
M4_COUNTERSINK_HEAD_D = 8;
M4_COUNTERSINK_HEAD_HEIGHT = 2;

M3_AL_WASHER_DIAMETER = 8.75;
M3_AL_WASHER_THICK = 0.82;

NUT_CLEARANCE = 15;

EXTRUSION_SIZE = 20.2;
EXTRUSION_THICK = 2.0;
EXTRUSION_SLOT = 6.0;
EXTRUSION_SLOT_DEPTH = 6.25;
EXTRUSION_SLOT_W_MAX = 10.0;
EXTRUSION_SLOT_H_MAX = 1.5;
EXTRUSION_HOLE_DIA = 5.0;
EXTRUSION_MAX_TAB_INSERTION = 5;
EXTRUSION_MIN_TAB_INSERTION = .8;

HOSE_DIAMETER = 9.25;
HOSE_RIB_DIAMETER = 10.5;
HOSE_RIB_THICK = 1.6;
HOSE_RIB_SPACE = 0.9;

40_FAN_SIDE = 40.0;
40_FAN_DEPTH = 10.5;
40_FAN_HOLE_INTERVAL = 32.0;
40_FAN_HOLE_DIAMETER = 3.5;
40_FAN_INSET = (40_FAN_SIDE - 40_FAN_HOLE_INTERVAL)/2;

80_FAN_SIDE = 80.0;
80_FAN_DEPTH = 15.0;
80_FAN_HOLE_INTERVAL = 71.5;
80_FAN_HOLE_DIAMETER = 4.4;
80_FAN_INSET = (80_FAN_SIDE - 80_FAN_HOLE_INTERVAL)/2;

BREAKER_DEPTH = 74; // includes clearance for crimp connectors
BREAKER_WIDTH = 29.5;
BREAKER_HEIGHT = 14.5;
BREAKER_CUT_DIA = 9.6;
BREAKER_CUT_FLAT = 8.9;
BREAKER_CUT_DEPTH = 10.3;
BREAKER_BUTTON_DIA = 6.5;
BREAKER_BUTTON_DEPTH = 6.55; 

POWER_WIDTH = 19.0;
POWER_HEIGHT = 12.5;
POWER_DEPTH = 35; // includes clearance for crimp connectors
POWER_FLANGE_WIDTH = 21;
POWER_FLANGE_HEIGHT =15;
POWER_FLANGE_DEPTH = 2;
POWER_BUTTON_OUT = 2.5;

DC_INLET_DEPTH = 35;
DC_INLET_DIA = 10.9;
DC_INLET_LIP_DIA = 12.5;
DC_INLET_LIP_DEPTH = 2;

INDICATOR_DIAMETER = 6.85;
INDICATOR_DEPTH = 34; // includes wire clearance
INDICATOR_FLANGE_DIAMETER = 8.6;
INDICATOR_FLANGE_DEPTH = 2.5;

MAGNET_THICK = 3.1;

BUILD_PLATE_DIAMETER = 260;
BUILD_PLATE_THICK = 3;

BODY_SIDE = 474;
BODY_HEIGHT = BODY_SIDE * sin(60);

BED_THICK = 3;

CUT_CORNER = 164;  
CUT_HEIGHT = CUT_CORNER * sin(60);

BOTTOM_WIDTH = BODY_SIDE - 2*CUT_CORNER;
NUT_BORDER = 7;
NUT_SPACING = 87;
NUT_INSET = (BOTTOM_WIDTH - NUT_SPACING)/2;

ESTOP_MIN_DIAMETER = 16;
ESTOP_TOTAL_HEIGHT = 48;
ESTOP_LIP_DIAMETER = 20;
ESTOP_EXTERNAL_HEIGHT = 18;
ESTOP_BUTTON_DIAMETER = 24;
ESTOP_BUTTON_HEIGHT = 3;

SPOOL_MAX_DIAMETER = 200;
SPOOL_HOLE_DIAMETER = 50;
SPOOL_THICK = 8;
SPOOL_WIDTH = 85;

SPOOL_CONE_DIAMETER = 65;
SPOOL_CONE_HEIGHT = 30;
SPOOL_CONE_OFFSET = CLEARANCE*4.8;

SPOOL_KNOB_DIAMETER = 29.5;
SPOOL_KNOB_HEIGHT = 13;

SPOOL_ROD_LENGTH = 152.4;
SPOOL_ROD_DIAMETER = 7.0;

5_16_NUT_THICK = 7.5;
5_16_NUT_DIAMETER = 16.5;

LCD_HEIGHT = 108;
LCD_WIDTH = 181;
LCD_THICK = 13;
LCD_DISPLAY_HEIGHT = 88;
LCD_DISPLAY_WIDTH = 155;
LCD_DISPLAY_H_INSET = 13.5;
LCD_DISPLAY_V_INSET = 11.5;
LCD_PINS_HEIGHT = 51;
LCD_PINS_WIDTH = 6;
LCD_PINS_THICK = 9;
LCD_H_INSET = 1.85;
LCD_V_INSET = 28.5;
LCD_HOLE_V_OFFSET = 102;
LCD_HOLE_H_OFFSET = 175;
LCD_DRIVER_WIDTH = 65.5;
LCD_DRIVER_HEIGHT = 73;

//===========================================

module equal_triangle(side, depth){
  
  opposite = side * sin(60);
  
  linear_extrude(height=depth){
     polygon(points=[[0,0],[side,0],[side/2,opposite]], paths=[[0,1,2]]);
  }
  
}

//===========================================

module donut(out_dia, in_dia, thick){
  
    difference(){
    
      cylinder( d=out_dia, h=thick );
  
      translate([0,0,-FUDGE])
        cylinder( d=in_dia, h=thick+2*FUDGE );
    
  }
  
}

//===========================================

module taper_box(big_w, big_h, sm_w, sm_h, depth){
  
  hull(){
    
    cube([FUDGE, big_w, big_h]);

    translate([ depth,
                (big_w-sm_w)/2,
                (big_h-sm_h)/2 ])
      cube([FUDGE, sm_w, sm_h]);
  
  }
  
}

//===========================================

module rounded_cube( wide, tall, deep, rad, rholes=0, cut_holes=false ){
  
  difference(){
  
    hull(){
      cylinder( d=rad*2, h=deep );

      translate( [wide-2*rad,0,0] )
        cylinder( d=rad*2, h=deep );
  
      translate( [0,tall-2*rad,0] )
        cylinder( d=rad*2, h=deep );
  
      translate( [wide-2*rad,tall-2*rad,0] )
        cylinder( d=rad*2, h=deep );
    } // hull
  
    union(){
      if (rholes > 0){
        translate( [0, 0, -deep/2] )
          cylinder(r=rholes,h=deep*2);
        translate( [wide-2*rad, 0, -deep/2] )
          cylinder(r=rholes,h=deep*2);
        translate( [0, tall-2*rad, -deep/2] )
          cylinder(r=rholes,h=deep*2);
        translate( [wide-2*rad, tall-2*rad, -deep/2] )
          cylinder(r=rholes,h=deep*2);
      }
    } // union
  
  } // difference

  if (rholes > 0){
      if (cut_holes==true){            
          translate( [0, 0, deep-200] )
              cylinder(r=rholes,h=200);
          translate( [wide-2*rad, 0, deep-200] )
              cylinder(r=rholes,h=200);
          translate( [0, tall-2*rad, deep-200] )
              cylinder(r=rholes,h=200);
          translate( [wide-2*rad, tall-2*rad, deep-200] )
              cylinder(r=rholes,h=200);
      } // cut holes
  } // rholes
  
  
}

//===========================================

//--- INPUT PARAMETERS:
//--- N: Number of points
//--  h: Height
//-- ri: Inner radius
//-- ro: outer radius
module parametric_star(N=5, h=3, ri=15, re=30) {

  //-- Calculate and draw a 2D tip of the star
 //-- INPUT: 
 //-- n: Number of the tip (from 0 to N-1)
  module tipstar(n) {
     i1 =  [ri*cos(-360*n/N+360/(N*2)), ri*sin(-360*n/N+360/(N*2))];
    e1 = [re*cos(-360*n/N), re*sin(-360*n/N)];
    i2 = [ri*cos(-360*(n+1)/N+360/(N*2)), ri*sin(-360*(n+1)/N+360/(N*2))];
    polygon([ i1, e1, i2]);
  }

  //-- Draw the 2D star and extrude
  
   //-- The star is the union of N 2D tips. 
   //-- A inner cylinder is also needed for filling
   //-- A flat (2D) star is built. The it is extruded
    linear_extrude(height=h) 
    union() {
      for (i=[0:N-1]) {
         tipstar(i);
      }
      rotate([0,0,360/(2*N)]) circle(r=ri+ri*0.01,$fn=N);
    }
}

//===========================================

module M3_bolt( length=10,
                pad=CLEARANCE,
                head_extend=0,
                slide=0,
                tap=0,
                nut_clear=false ){
  
  // head
  color("Black")
  cylinder( h=M3_BOLT_HEAD_HEIGHT+head_extend,
            d=M3_BOLT_HEAD_SIZE+pad,
            center=false);
  // bolt
  color("Black")
  translate([0,0,-length]){
    cylinder( h=length+FUDGE,
              d=M3_BOLT_SIZE-tap+slide,
              center=false);
              
  if (nut_clear==true){
    translate([0,0,0])
      cylinder( h=EXTRUSION_MAX_TAB_INSERTION + 2*FUDGE,
                r=NUT_CLEARANCE/2,
                center=false );
  }
  
  }

}


//===========================================

module M4_countersink_bolt( length=10,
                            pad=CLEARANCE,
                            head_extend=0,
                            slide=0 ){

  union(){
  // bolt
  color("Black")
  translate([0,0,FUDGE-M4_COUNTERSINK_HEAD_HEIGHT-length]){
      cylinder( h=length+FUDGE,
                d=M4_COUNTERSINK_SIZE+slide,
                center=false );
  }
  
  // head
  color("Black")
  translate([0,0,FUDGE-M4_COUNTERSINK_HEAD_HEIGHT])
      cylinder( h=M4_COUNTERSINK_HEAD_HEIGHT,
                d1=M4_COUNTERSINK_SIZE+slide,
                d2=M4_COUNTERSINK_HEAD_D+pad,
                center=false );
              
  if (head_extend>0){
      color("Black")
      translate([ 0, 0, -FUDGE ])
          cylinder( h=head_extend+FUDGE,
                    d=M4_COUNTERSINK_HEAD_D+pad );
  }
  } // union
              
}                            

//===========================================

module M3_bolt_boss( height=10,
                     pad=CLEARANCE,
                     extend=5,
                     capture=false,
                     protrude=0,
                     show_bolt=false,
                     show_boss=true ){

// HEIGHT of boss
// boss PAD beyond bolt head diameter
// bolt EXTEND beyond boss
// CAPTURE the bolt?
// head PROTRUDE beyond boss
  
  if (show_boss==true){
    difference(){
  
      color("Yellow")    
      cylinder(h=height, d=M3_BOLT_HEAD_SIZE+pad+CLEARANCE);
      
      color("Yellow")
      translate([0,0,height-M3_BOLT_HEAD_HEIGHT+protrude+FUDGE])
        if (capture==true){
          M3_bolt( length=height-M3_BOLT_HEAD_HEIGHT+extend,
                   tap=BOLT_MOD_TAP );
        } else { // capture = true
          M3_bolt( length=height-M3_BOLT_HEAD_HEIGHT+extend,
                   slide=BOLT_MOD_SLIDE );
        } // capture = false
    } // difference
  } // show_boss
  
  if (show_bolt==true){
    translate([0,0,height-M3_BOLT_HEAD_HEIGHT+protrude+FUDGE])
      if (capture==true){
        M3_bolt( length=height-M3_BOLT_HEAD_HEIGHT+extend,
                 pad=0, tap=BOLT_MOD_TAP );
      } else { // capture = true
        M3_bolt( length=height-M3_BOLT_HEAD_HEIGHT+extend,
                 pad=0, slide=BOLT_MOD_SLIDE, nut_clear=true );
      } // capture = false
  }
  
}

//===========================================

module M3_AL_washer(){
  
  difference(){
    
    cylinder(h=M3_AL_WASHER_THICK, d=M3_AL_WASHER_DIAMETER);
  
    translate([0,0,-1])
      cylinder(h=2+M3_AL_WASHER_THICK, d=3.28);
    
  }
    
}

//===========================================

module single_extrusion(length=10, clearance=0, top_slot=true, bottom_slot=true, left_slot=true, right_slot=true){
 
  color("DarkSlateGray")
  difference(){
    
    translate([-clearance/2,0,-clearance/2])
    cube([ EXTRUSION_SIZE+clearance, length, EXTRUSION_SIZE+clearance ]);

    union(){

      if (top_slot==true){
      translate([ EXTRUSION_SIZE/2 - (EXTRUSION_SLOT-clearance)/2,
                 -FUDGE,
                  EXTRUSION_SIZE-EXTRUSION_SLOT_DEPTH+clearance+FUDGE ])
        cube([ EXTRUSION_SLOT-clearance,
               length + FUDGE*2,
               EXTRUSION_SLOT_DEPTH+FUDGE ]);

      if (clearance==0){
        hull(){
          translate([ EXTRUSION_SIZE/2 - EXTRUSION_SLOT/2, -FUDGE, EXTRUSION_SIZE-EXTRUSION_SLOT_DEPTH+FUDGE ])
            cube([ EXTRUSION_SLOT, length + FUDGE*2, EXTRUSION_SLOT_DEPTH-EXTRUSION_THICK ]);
    
          translate([ EXTRUSION_SIZE/2 - EXTRUSION_SLOT_W_MAX/2, -FUDGE, EXTRUSION_SIZE-EXTRUSION_SLOT_H_MAX-EXTRUSION_THICK-FUDGE ])
            cube([EXTRUSION_SLOT_W_MAX, length + FUDGE*2, EXTRUSION_SLOT_H_MAX+FUDGE ]);
        }
      }
      } // end if

      if (bottom_slot==true){
      translate([ EXTRUSION_SIZE/2 - (EXTRUSION_SLOT-clearance)/2,
                 -FUDGE,
                 -FUDGE-clearance ])
        cube([ EXTRUSION_SLOT-clearance,
               length + FUDGE*2,
               EXTRUSION_SLOT_DEPTH + FUDGE ]);

      if (clearance==0){
        hull(){
          translate([ EXTRUSION_SIZE/2 - EXTRUSION_SLOT/2, -FUDGE, EXTRUSION_THICK ])
            cube([ EXTRUSION_SLOT, length + FUDGE*2, EXTRUSION_SLOT_DEPTH-EXTRUSION_THICK ]);
    
          translate([ EXTRUSION_SIZE/2 - EXTRUSION_SLOT_W_MAX/2, -FUDGE, EXTRUSION_THICK ])
            cube([EXTRUSION_SLOT_W_MAX, length + FUDGE*2, EXTRUSION_SLOT_H_MAX+FUDGE ]);
        }
      }
      } // end if
 
      if (left_slot==true){
      translate([ -FUDGE-clearance,
                  -FUDGE,
                   EXTRUSION_SIZE/2 - EXTRUSION_SLOT/2 + clearance/2 ])
        cube([ EXTRUSION_SLOT_DEPTH + FUDGE,
               length + FUDGE*2,
               EXTRUSION_SLOT-clearance ]);

      if (clearance==0){
        hull(){
          translate([ EXTRUSION_THICK, -FUDGE, EXTRUSION_SIZE/2 - EXTRUSION_SLOT/2 ])
            cube([ EXTRUSION_SLOT_DEPTH - EXTRUSION_THICK + FUDGE, length + FUDGE*2, EXTRUSION_SLOT ]);
    
          translate([ EXTRUSION_THICK, -FUDGE, EXTRUSION_SIZE/2 - EXTRUSION_SLOT_W_MAX/2 ])
            cube([EXTRUSION_SLOT_H_MAX+FUDGE, length + FUDGE*2, EXTRUSION_SLOT_W_MAX ]);
        }
      }
      } // end if
 
      if (right_slot==true){
      translate([ EXTRUSION_SIZE+FUDGE-EXTRUSION_SLOT_DEPTH+clearance,
                 -FUDGE,
                  EXTRUSION_SIZE/2 - EXTRUSION_SLOT/2 + clearance/2 ])
        cube([ EXTRUSION_SLOT_DEPTH + FUDGE,
               length + FUDGE*2,
               EXTRUSION_SLOT-clearance ]);

      if (clearance==0){
        hull(){
          translate([ EXTRUSION_SIZE+FUDGE-EXTRUSION_SLOT_DEPTH, -FUDGE, EXTRUSION_SIZE/2 - EXTRUSION_SLOT/2 ])
            cube([ EXTRUSION_SLOT_DEPTH - EXTRUSION_THICK + FUDGE, length + FUDGE*2, EXTRUSION_SLOT ]);
    
          translate([ EXTRUSION_SIZE-EXTRUSION_THICK-EXTRUSION_SLOT_H_MAX, -FUDGE, EXTRUSION_SIZE/2 - EXTRUSION_SLOT_W_MAX/2 ])
            cube([EXTRUSION_SLOT_H_MAX+FUDGE, length + FUDGE*2, EXTRUSION_SLOT_W_MAX ]);
        }
      }
      } // end if

      // hole
      if (clearance==0){
        translate([EXTRUSION_SIZE/2, length+FUDGE, EXTRUSION_SIZE/2])
        rotate([90,0,0])
          cylinder(h=length+2*FUDGE, d=EXTRUSION_HOLE_DIA, center=false);
      }
        
    }
    
  }
  
}

//===========================================

module extrusion(length=10, units=1, clearance=0, top_slot=true, bottom_slot=true, left_slot=true, right_slot=true){
  
  difference(){
  
    union()
      for (u=[0:units-1]){
        translate([(EXTRUSION_SIZE-FUDGE)*u,0,0])
          single_extrusion(length, clearance, top_slot=top_slot, bottom_slot=bottom_slot, left_slot=left_slot, right_slot=right_slot);
      }
        
    union()
      for (s=[1:units]){
        if (clearance==0){
          if (s<units){
            SNIP = EXTRUSION_SIZE - (EXTRUSION_SLOT_W_MAX + 2*EXTRUSION_THICK);
            translate([   EXTRUSION_SIZE*s - SNIP/2,
                         -FUDGE,
                          EXTRUSION_THICK  ])
              color("DarkSlateGray")
              cube([  SNIP,
                      length+2*FUDGE,
                      EXTRUSION_SIZE-2*EXTRUSION_THICK]);
          }
        }  
      }
  }
}

//===========================================

module hose(length=100, clearance=0, extend=0){

  color("DarkSlateGray")  
  //hull(){

    if (clearance==0){

      cylinder(h=length,
               d=HOSE_DIAMETER,
               center=false);
      
      for (c=[0:round(length/(HOSE_RIB_SPACE+HOSE_RIB_THICK))]){
        translate([0,0,(HOSE_RIB_SPACE+HOSE_RIB_THICK)*c])
          cylinder(h=HOSE_RIB_THICK,
                   d=HOSE_RIB_DIAMETER,
                   center=false);
          echo("rib");
      } // for
    } else {
      echo("CUT");
      cylinder(h=length,
               d=HOSE_RIB_DIAMETER+2*clearance,
               center=false);
      
    } // clearance

  if (extend>0){
      translate([0,extend,0])
      cylinder(h=length,
               d=HOSE_RIB_DIAMETER+2*clearance,
               center=false);
  }

//  } // hull
  
}

//===========================================

module build_plate(){
  
    cylinder(h=BUILD_PLATE_THICK, d=BUILD_PLATE_DIAMETER);
  
}

//===========================================

module fan_40(cut=false, low_wire=false, high_wire=false){

  if (cut==true){
    
    union(){
    
    translate([ 0,
                -CLEARANCE/2,
                -CLEARANCE/2 ])
    cube([ 40_FAN_DEPTH,
           40_FAN_SIDE+CLEARANCE,
           40_FAN_SIDE+CLEARANCE ]);

        // fan hole
        translate([-40_FAN_DEPTH*2+FUDGE,40_FAN_SIDE/2,40_FAN_SIDE/2])
        rotate([0,90,0])
        cylinder(h=40_FAN_DEPTH*2, d=40_FAN_SIDE-40_FAN_HOLE_DIAMETER*2);
        
        if (high_wire==true){
          translate([-40_FAN_DEPTH/2,40_FAN_SIDE-40_FAN_DEPTH,40_FAN_SIDE-16])
            cube([40_FAN_DEPTH,40_FAN_DEPTH,3]);
        }
        
        if (low_wire==true){
          translate([-40_FAN_DEPTH/2,40_FAN_SIDE-40_FAN_DEPTH,8])
            cube([40_FAN_DEPTH,40_FAN_DEPTH,3]);
        }
    
        // bottom left hole
        translate([40_FAN_DEPTH,40_FAN_INSET,40_FAN_INSET])
        rotate([0,90,0])
        M3_bolt(length=40_FAN_DEPTH*3);

        // top left hole
        translate([40_FAN_DEPTH,40_FAN_INSET,40_FAN_SIDE-40_FAN_INSET])
        rotate([0,90,0])
        M3_bolt(length=40_FAN_DEPTH*3);
  
        // bottom right hole
        translate([40_FAN_DEPTH,40_FAN_SIDE-40_FAN_INSET,40_FAN_INSET])
        rotate([0,90,0])
        M3_bolt(length=40_FAN_DEPTH*3);
  
        // top right hole
        translate([40_FAN_DEPTH,40_FAN_SIDE-40_FAN_INSET,40_FAN_SIDE-40_FAN_INSET])
        rotate([0,90,0])
        M3_bolt(length=40_FAN_DEPTH*3);
    
    } // union  
    
  } else {

    // frame
    difference(){
  
      color("red")
      cube([40_FAN_DEPTH, 40_FAN_SIDE, 40_FAN_SIDE]);
  
      color("red")
      union(){
  
        // fan hole
        translate([-FUDGE,40_FAN_SIDE/2,40_FAN_SIDE/2])
        rotate([0,90,0])
        cylinder(h=40_FAN_DEPTH+FUDGE*2, d=40_FAN_SIDE-40_FAN_HOLE_DIAMETER*2);
  
        // bottom left hole
        translate([-FUDGE,40_FAN_INSET,40_FAN_INSET])
        rotate([0,90,0])
        cylinder(h=40_FAN_DEPTH+FUDGE*2, d=40_FAN_HOLE_DIAMETER);
  
        // top left hole
        translate([-FUDGE,40_FAN_INSET,40_FAN_SIDE-40_FAN_INSET])
        rotate([0,90,0])
        cylinder(h=40_FAN_DEPTH+FUDGE*2, d=40_FAN_HOLE_DIAMETER);
  
        // bottom right hole
        translate([-FUDGE,40_FAN_SIDE-40_FAN_INSET,40_FAN_INSET])
        rotate([0,90,0])
        cylinder(h=40_FAN_DEPTH+FUDGE*2, d=40_FAN_HOLE_DIAMETER);
  
        // top right hole
        translate([-FUDGE,40_FAN_SIDE-40_FAN_INSET,40_FAN_SIDE-40_FAN_INSET])
        rotate([0,90,0])
        cylinder(h=40_FAN_DEPTH+FUDGE*2, d=40_FAN_HOLE_DIAMETER);
  
      } // union
      
    } // difference
      
      
    // fan
    color("red")
    translate([40_FAN_DEPTH/2-40_FAN_DEPTH/6,40_FAN_SIDE/2,40_FAN_SIDE/2])
    rotate([0,90,0])
    cylinder(h=40_FAN_DEPTH/3, d=40_FAN_SIDE/2);
    
  } // else
    
}

//===========================================

module fan_80(cut=false, low_wire=false, high_wire=false){

  if (cut==true){
    
    union(){
    
    translate([ 0,
                -CLEARANCE/2,
                -CLEARANCE/2 ])
    cube([ 80_FAN_DEPTH,
           80_FAN_SIDE+CLEARANCE,
           80_FAN_SIDE+CLEARANCE ]);

        // fan hole
        translate([-80_FAN_DEPTH*2+FUDGE,80_FAN_SIDE/2,80_FAN_SIDE/2])
        rotate([0,90,0])
        cylinder(h=80_FAN_DEPTH*2, d=80_FAN_SIDE-80_FAN_HOLE_DIAMETER*2);
        
        if (high_wire==true){
          translate([-80_FAN_DEPTH/2,80_FAN_SIDE-80_FAN_DEPTH,80_FAN_SIDE-16])
            cube([80_FAN_DEPTH,80_FAN_DEPTH,3]);
        }
        
        if (low_wire==true){
          translate([-80_FAN_DEPTH/2,80_FAN_SIDE-80_FAN_DEPTH,8])
            cube([80_FAN_DEPTH,80_FAN_DEPTH,3]);
        }
    
        // bottom left hole
        translate([80_FAN_DEPTH,80_FAN_INSET,80_FAN_INSET])
        rotate([0,90,0])
        M3_bolt(length=80_FAN_DEPTH*3);

        // top left hole
        translate([80_FAN_DEPTH,80_FAN_INSET,80_FAN_SIDE-80_FAN_INSET])
        rotate([0,90,0])
        M3_bolt(length=80_FAN_DEPTH*3);
  
        // bottom right hole
        translate([80_FAN_DEPTH,80_FAN_SIDE-80_FAN_INSET,80_FAN_INSET])
        rotate([0,90,0])
        M3_bolt(length=80_FAN_DEPTH*3);
  
        // top right hole
        translate([80_FAN_DEPTH,80_FAN_SIDE-80_FAN_INSET,80_FAN_SIDE-80_FAN_INSET])
        rotate([0,90,0])
        M3_bolt(length=80_FAN_DEPTH*3);
    
    } // union  
    
  } else {

    // frame
    difference(){
  
      color("red")
      cube([80_FAN_DEPTH, 80_FAN_SIDE, 80_FAN_SIDE]);
  
      color("red")
      union(){
  
        // fan hole
        translate([-FUDGE,80_FAN_SIDE/2,80_FAN_SIDE/2])
        rotate([0,90,0])
        cylinder(h=80_FAN_DEPTH+FUDGE*2, d=80_FAN_SIDE-80_FAN_HOLE_DIAMETER*2);
  
        // bottom left hole
        translate([-FUDGE,80_FAN_INSET,80_FAN_INSET])
        rotate([0,90,0])
        cylinder(h=80_FAN_DEPTH+FUDGE*2, d=80_FAN_HOLE_DIAMETER);
  
        // top left hole
        translate([-FUDGE,80_FAN_INSET,80_FAN_SIDE-80_FAN_INSET])
        rotate([0,90,0])
        cylinder(h=80_FAN_DEPTH+FUDGE*2, d=80_FAN_HOLE_DIAMETER);
  
        // bottom right hole
        translate([-FUDGE,80_FAN_SIDE-80_FAN_INSET,80_FAN_INSET])
        rotate([0,90,0])
        cylinder(h=80_FAN_DEPTH+FUDGE*2, d=80_FAN_HOLE_DIAMETER);
  
        // top right hole
        translate([-FUDGE,80_FAN_SIDE-80_FAN_INSET,80_FAN_SIDE-80_FAN_INSET])
        rotate([0,90,0])
        cylinder(h=80_FAN_DEPTH+FUDGE*2, d=80_FAN_HOLE_DIAMETER);
  
      } // union
      
    } // difference
      
      
    // fan
    color("red")
    translate([80_FAN_DEPTH/2-80_FAN_DEPTH/6,80_FAN_SIDE/2,80_FAN_SIDE/2])
    rotate([0,90,0])
    cylinder(h=80_FAN_DEPTH/3, d=80_FAN_SIDE/2);
    
  } // else
    
}

//===========================================

module breaker(){

  translate( [ -BREAKER_WIDTH/2, 0, -BREAKER_HEIGHT/2 ] ){
    
    cube( [ BREAKER_WIDTH, BREAKER_DEPTH, BREAKER_HEIGHT ] );
    
    translate([ BREAKER_WIDTH/2, -FUDGE, BREAKER_HEIGHT/2 ])
    rotate([ 90, 0, 0 ])
      cylinder( d=BREAKER_CUT_DIA, h=BREAKER_CUT_DEPTH );
    
    translate([ BREAKER_WIDTH/2, -BREAKER_CUT_DEPTH-FUDGE, BREAKER_HEIGHT/2 ])
    rotate([ 90, 0, 0 ])
      cylinder( d=BREAKER_BUTTON_DIA, h=BREAKER_BUTTON_DEPTH );

  }
  
}

//===========================================

module power_switch(){

  translate([0,-POWER_FLANGE_DEPTH-POWER_BUTTON_OUT,0])
  cube([ POWER_WIDTH,
         POWER_DEPTH+POWER_FLANGE_DEPTH+POWER_BUTTON_OUT,
         POWER_HEIGHT ]);
  
  translate([ -(POWER_FLANGE_WIDTH-POWER_WIDTH)/2,
              -POWER_FLANGE_DEPTH,
              -(POWER_FLANGE_HEIGHT-POWER_HEIGHT)/2 ])
  cube([ POWER_FLANGE_WIDTH, POWER_FLANGE_DEPTH, POWER_FLANGE_HEIGHT ]);
  
}

//===========================================

module dc_inlet(){
 
   translate( [0, DC_INLET_DEPTH-FUDGE, 0] )
   rotate( [ 90, 0, 0 ] )
     cylinder( d=DC_INLET_DIA, h=DC_INLET_DEPTH );
  
   translate( [0, 0, 0] )
   rotate( [ 90, 0, 0 ] )
     cylinder( d=DC_INLET_LIP_DIA, h=DC_INLET_LIP_DEPTH );
  
}

//===========================================

module indicator(){
  
  color("Red")
  translate( [-INDICATOR_DEPTH+FUDGE, 0, 0] )
  rotate( [0, 90, 0] )
    cylinder( d=INDICATOR_DIAMETER, h=INDICATOR_DEPTH );

  color("Red")  
  translate( [0, 0, 0] )
  rotate( [0, 90, 0] )
    cylinder( d=INDICATOR_FLANGE_DIAMETER, h=INDICATOR_FLANGE_DEPTH );
  
}

//===========================================

module ac_inlet(ac_inlet_cut=false){
  
  if (ac_inlet_cut==true){
    
    translate([-CUT_D,(FACE_W-CUT_W)/2,(FACE_H-CUT_H)/2])
      cube([CUT_D, CUT_W, CUT_H]);
      
  } else {
  
    difference(){
      
      union(){
  
        color("DarkSlateGray")  
        translate([0,0,0])
          cube([FACE_D, FACE_W, FACE_H]);
          
        color("DarkSlateGray")
        translate([-CUT_D,(FACE_W-CUT_W)/2,(FACE_H-CUT_H)/2])
          cube([CUT_D, CUT_W, CUT_H]);
    
      }

      color("DarkSlateGray")        
      translate([FUDGE-FACE_CUT_D+FACE_D,(FACE_W-FACE_CUT_W)/2,(FACE_H-FACE_CUT_H)/2])
        cube([FACE_CUT_D, FACE_CUT_W, FACE_CUT_H]);
        
      } // difference

      // left prong
      color("Silver")
      translate([ -FACE_CUT_D-FUDGE,
                  7.3,
                  11.5 ])
        cube([15, 2, 4]);

      // right prong
      color("Silver")
      translate([ -FACE_CUT_D-FUDGE,
                  21.6,
                  11.5 ])
        cube([15, 2, 4]);

      // bottom prong
      color("Silver")
      translate([ -FACE_CUT_D-FUDGE,
                  14.6,
                  7.2 ])
        cube([18, 2, 4]);

  } // else
  
}

//===========================================

module magnet(){
 
   cylinder(h=MAGNET_THICK, d=6.4);
  
}

//===========================================

module estop(){
  
  translate( [0,0,-(ESTOP_TOTAL_HEIGHT-ESTOP_EXTERNAL_HEIGHT)] ){
    
  cylinder( d=ESTOP_MIN_DIAMETER, h=ESTOP_TOTAL_HEIGHT );

  translate( [0,0,ESTOP_TOTAL_HEIGHT-ESTOP_EXTERNAL_HEIGHT] )
    cylinder( d=ESTOP_LIP_DIAMETER, h=ESTOP_EXTERNAL_HEIGHT );
  
  color("Red")
  translate( [0,0,ESTOP_TOTAL_HEIGHT-ESTOP_BUTTON_HEIGHT+FUDGE] )
    cylinder( d=ESTOP_BUTTON_DIAMETER, h=ESTOP_BUTTON_HEIGHT );
  
  }
    
}

//===========================================

module print_bed(cut=false,with_magnets=false){
    
   translate([-BODY_SIDE/2,-(BODY_HEIGHT-CUT_HEIGHT)/2,-BED_THICK]){
     
     color("DarkSlateGray")
     difference(){
       
       equal_triangle( side=BODY_SIDE, depth=BED_THICK );
  
       union(){
         
         translate( [-FUDGE, -FUDGE, -1])
           equal_triangle( side=CUT_CORNER, depth=5 );
         
         translate( [ BODY_SIDE/2 - CUT_CORNER/2,
                             BODY_HEIGHT-CUT_HEIGHT+FUDGE, -1])
           equal_triangle( side=CUT_CORNER, depth=5 );
  
         translate( [ BODY_SIDE-CUT_CORNER+FUDGE,
                             -FUDGE,
                           -1])
           equal_triangle( side=CUT_CORNER, depth=5 );
  
       } // union
       
     } // difference

     translate([ CUT_CORNER+NUT_INSET,
                        NUT_BORDER,
                        BED_THICK-FUDGE ])
       M3_AL_washer();
     
     translate([ CUT_CORNER+NUT_INSET,
                        NUT_BORDER,
                        BED_THICK+M3_AL_WASHER_THICK-2*FUDGE ])
      M3_bolt(length=10, nut_clear=0);
       
      translate([ CUT_CORNER+BOTTOM_WIDTH-NUT_INSET,
                        NUT_BORDER,
                        BED_THICK-FUDGE ])
       M3_AL_washer();

     translate([ CUT_CORNER+BOTTOM_WIDTH-NUT_INSET,
                        NUT_BORDER,
                        M3_BOLT_HEAD_HEIGHT+M3_AL_WASHER_THICK-2*FUDGE ])
       M3_bolt(length=10, nut_clear=0);
     
     if (with_magnets==true){

       translate([ CUT_CORNER+NUT_INSET,
                          NUT_BORDER,
                          M3_BOLT_HEAD_HEIGHT+M3_AL_WASHER_THICK+MAGNET_THICK+1.5 ])
         magnet();

       translate([ CUT_CORNER+BOTTOM_WIDTH-NUT_INSET,
                          NUT_BORDER,
                          M3_BOLT_HEAD_HEIGHT+M3_AL_WASHER_THICK+MAGNET_THICK+1.5 ])
         magnet();

     }
   
     if (cut==true){
       
         translate([ CUT_CORNER+NUT_INSET,
                            NUT_BORDER,
                            BED_THICK ])
         cylinder(d=10, h=4);

         translate([ CUT_CORNER+BOTTOM_WIDTH-NUT_INSET,
                            NUT_BORDER,
                            BED_THICK ])
         cylinder(d=10, h=4);
       
     }
   
   } // translate
   
}

//===========================================

module filament_spool(){
  
  color("LightGrey")
  difference(){

    donut( SPOOL_MAX_DIAMETER, SPOOL_HOLE_DIAMETER, SPOOL_WIDTH );
  
    union(){

     difference(){

        translate( [0,0,-FUDGE/2] )
        donut( SPOOL_MAX_DIAMETER-EXTRUSION_SIZE*2,
                    SPOOL_HOLE_DIAMETER+EXTRUSION_SIZE*2,
                    SPOOL_WIDTH+FUDGE );

        union(){
          translate([-SPOOL_MAX_DIAMETER/2, -EXTRUSION_SIZE/2, 0])
          cube([SPOOL_MAX_DIAMETER, EXTRUSION_SIZE, SPOOL_WIDTH+FUDGE]);  
          
          translate([ -EXTRUSION_SIZE/2, -SPOOL_MAX_DIAMETER/2,0])
          cube([EXTRUSION_SIZE, SPOOL_MAX_DIAMETER, SPOOL_WIDTH+FUDGE]);  
          
        }
      
     } // difference
       
      translate( [0,0,SPOOL_THICK] )
      donut( SPOOL_MAX_DIAMETER+FUDGE, SPOOL_HOLE_DIAMETER+CLEARANCE, SPOOL_WIDTH-2*SPOOL_THICK );
       
    } // union
      
  } // difference
    
  color("Orange")
  translate( [0,0,SPOOL_THICK] )
    donut( 2*SPOOL_MAX_DIAMETER/3,
                SPOOL_HOLE_DIAMETER+CLEARANCE,
                SPOOL_WIDTH-2*SPOOL_THICK );
  
}

//===========================================

module spool_cone(){

  color("DimGray")
  translate( [-SPOOL_CONE_DIAMETER/2, 
                       SPOOL_CONE_DIAMETER/2, 
                       0 ] )
    rotate( [90,90,0] )
  import("spool_holder/cone.stl");
  
}

//===========================================

module spool_knob(){
  
  color("DimGray")
  translate([-SPOOL_KNOB_DIAMETER/2,
                    -SPOOL_KNOB_DIAMETER/2, 
                      0])
  rotate( [-90,0,0] )
  import("spool_holder/knob.stl");
  
}

//===========================================

module spool_holder(){

  translate([0,0,5_16_NUT_THICK+SPOOL_CONE_OFFSET]){
    
  filament_spool();
  
  translate([0,0,SPOOL_WIDTH+SPOOL_CONE_OFFSET])
  spool_cone();

  translate([0,0,-SPOOL_CONE_OFFSET])
  rotate([180,0,0])
  spool_cone();
  
  translate([0,0,SPOOL_WIDTH+SPOOL_CONE_HEIGHT-CLEARANCE*2])
  spool_knob();
  
  color("LightCyan")
  translate([0,0,-SPOOL_CONE_HEIGHT*1.3])
  cylinder( d=SPOOL_ROD_DIAMETER, h=SPOOL_ROD_LENGTH);
  
  translate([0,0,-5_16_NUT_THICK*2-CLEARANCE*2])
  5_16_nut();
  
  }
    
}

//===========================================

module 5_16_nut(){
  
  difference(){
   
     union(){ 
       $fn = 6;
       cylinder( d=5_16_NUT_DIAMETER, h=5_16_NUT_THICK);
     }
     
     union(){
       $fn=0;
       translate([0,0,-SPOOL_ROD_LENGTH/2])
       cylinder(d=SPOOL_ROD_DIAMETER, h=SPOOL_ROD_LENGTH);
     }

  }
  
}

//===========================================

INDICATOR_D = 9;
INDICATOR_H = 2;
INDICATOR_SHAFT_D = 7;
INDICATOR_INSET = 30;

module led_indicator(led_color, cut_clearance=1.0, cut=false){

  color(led_color){
    if (cut==false){
      cylinder(d=INDICATOR_D, h=INDICATOR_H);
    } else {
      cylinder(d=INDICATOR_D+cut_clearance, h=INDICATOR_H*10);
    }
    translate(v=[0,0,-INDICATOR_INSET])
      cylinder(r=INDICATOR_SHAFT_D/2, h=INDICATOR_INSET+FUDGE);
  }
  

}

//===========================================

LABEL_TAPE_HEIGHT = 6.35;
LABEL_TAPE_THICK = 0.1;
LABEL_TEXT_FONT = "Liberation Sans";

module small_brother_label(
  caption = "FOO",
  tape_color = "black",
  text_color = "white",
  text_pad = 1.0,
  label_inset = 0.5,
  label_inset_w = 0,
  cut = false
  ){
  
  text_size= LABEL_TAPE_HEIGHT-2*text_pad;
  
  m = measureTextBounds(caption, font=LABEL_TEXT_FONT, size=text_size, spacing=1., valign="baseline", halign="left");
  w = m[1][0];
  h = m[1][1];
  //echo("TEXT SIZE: w:", w, " h:", h);

  if (cut==true){
    translate([0, 0, -label_inset])
      if (label_inset_w == 0){
        cube([w+2*text_pad, LABEL_TAPE_HEIGHT, LABEL_TAPE_THICK+label_inset]);
      } else {
        cube([label_inset_w, LABEL_TAPE_HEIGHT, LABEL_TAPE_THICK+label_inset]);
      }
  } else {
    color(tape_color)
      cube([w+2*text_pad, LABEL_TAPE_HEIGHT, LABEL_TAPE_THICK]);
    color(text_color)
    translate([text_pad, text_pad, LABEL_TAPE_THICK])
    linear_extrude(height=LABEL_TAPE_THICK)
      text(caption, text_size, valign="baseline", halign="left", spacing=1.);
  }
  
}

//===========================================

module toggle_switch(
  body_width = 13.2,
  body_depth = 13,
  body_height = 9.7,
  collar_d = 5.9,
  collar_height = 8.7,
  handle_d = 3,
  handle_length = 10,
  terminal_clearance = 3.2,
  cut_clearance = 1.0,
  cut = false,
  panel_thick = 2,
  display = false,
  nut_d = 9,
  nut_thick = 1.6,
  washer_d = 11,
  washer_thick = 0.6
  ){

  if (cut==true){

    translate([ 0, 0, -FUDGE ])
      cylinder( d=collar_d+cut_clearance, h=collar_height+FUDGE );
    
  } else {

    color("silver")
    translate([ 0, 0, collar_height ])
    rotate([ 0, 15, 0 ])
      cylinder( d=handle_d, h=handle_length );

    color("silver")
      cylinder( d=collar_d, h=collar_height );

    color("deepskyblue")       
    translate([ -body_width/2, -body_depth/2, -body_height ])
      cube([ body_width, body_depth, body_height ]);
  
    color("silver")
    translate([ -body_width/2, -body_depth/2, -body_height-terminal_clearance ])
      cube([ body_width, body_depth, terminal_clearance ]);
  
    if (display==true){
      color("silver")
      translate([ 0, 0, panel_thick ])
        cylinder(d=washer_d, h=washer_thick);
      color("silver")
      translate([ 0, 0, panel_thick+washer_thick ])
        cylinder($fn=6, d=nut_d, h=nut_thick);
    }
  
  }
  
}

//===========================================

module panel_mount_momentary_switch(
  button_d = 8.8,
  button_h = 3.3,
  collar_d = 13.8,
  collar_h = 2.5,
  collar_min_h = 1.1,
  body_d = 12.3,
  body_h = 15.2,
  terminal_clearance = 5.8,
  cut_clearance = 1.0,
  cut = false
  ){
  
  if (cut==true){

    translate([ 0, 0, -body_h ])
      cylinder( d=body_d+cut_clearance,
                h=2*body_h );

  } else {
    
    color("red")
    translate([ 0, 0, collar_h ])
      cylinder(d=button_d, h=button_h);
  
    color("darkslategray")
    translate([ 0, 0, collar_min_h ])
      cylinder( d1=collar_d,
                d2=button_d+collar_min_h,
                h=collar_h-collar_min_h );
    
    color("darkslategray")
      cylinder( d=collar_d,
                h=collar_min_h );

    color("darkslategray")
    translate([ 0, 0, -body_h ])
      cylinder( d=body_d,
                h=body_h );

    color("silver")
    translate([ 0, 0, -body_h-terminal_clearance ])
      cylinder( d=body_d-collar_min_h,
                h=terminal_clearance );
    
  }
  
}

//===========================================

module medium_panel_mount_momentary_switch(
  button_d = 13.1,
  button_h = 3.2,
  collar_size = 17.9,
  min_collar_size = 15,
  collar_h = 2.5,
  collar_min_h = 1.1,
  body_d = 15,
  body_h = 18.5,
  terminal_clearance = 5.9,
  cut_clearance = 1.0,
  cut = false
  ){
  
  if (cut==true){

    translate([ 0, 0, -body_h ])
      cylinder( d=body_d+cut_clearance,
                h=2*body_h );

  } else {
    
    color("red")
    translate([ 0, 0, collar_h ])
      cylinder(d=button_d, h=button_h);
  
    color("darkslategray")
    union(){
      translate([ -collar_size/2, -collar_size/2, 0 ])
        cube([ collar_size, collar_size, collar_min_h ]);
      hull(){
        translate([ -min_collar_size/2, -min_collar_size/2, collar_h-FUDGE ])
          cube([ min_collar_size, min_collar_size, FUDGE ]);
        translate([ -collar_size/2, -collar_size/2, collar_min_h ])
          cube([ collar_size, collar_size, FUDGE ]);
      }
    }
     
    color("darkslategray")
    translate([ 0, 0, -body_h ])
      cylinder( d=body_d,
                h=body_h );

    color("silver")
    translate([ 0, 0, -body_h-terminal_clearance ])
      cylinder( d=body_d-collar_min_h,
                h=terminal_clearance );
    
  }
  
}

//===========================================

module potentiometer_knob(
  knob_d1 = 17.9,
  knob_d2 = 17.9,
  knob_h = 17.3,
  shaft_d = 6,
  shaft_h = 8.6
  ){
    
  difference(){
    
    cylinder(d1=knob_d1, d2=knob_d2, h=knob_h);
    
    translate([ 0, 0, -FUDGE ])
      cylinder(d=shaft_d, h=shaft_h);

  }
}

module panel_mount_potentiometer(
  body_d = 24.5,
  body_thick = 11.6,
  bump_d = 37.5,
  bump_w = 20.1,
  collar_d = 7.8,
  collar_h = 7.2,
  knob_d = 6,
  knob_h = 8.6,
  washer_d = 13,
  washer_thick = 0.6,
  nut_d = 12.3,
  nut_thick = 2.1,
  panel_thick = 2,
  display = false,
  cut_clearance = 1.0,
  cut = false
  ){
  
  if (cut==true){
  
    cylinder( d = collar_d + cut_clearance,
              h = collar_h );
  
  } else {
    
    color("sienna")
    translate([ 0, 0, -body_thick ])
      cylinder(d=body_d, h=body_thick);

    color("sienna")  
    translate([ 0, 0, -body_thick ])
    intersection(){
      cylinder(d=bump_d, h=body_thick);
      translate([ -bump_w/2, -bump_d, 0 ])
        cube([ bump_w, bump_d, body_thick ]);
    }

    color("silver")
    cylinder(d=collar_d, h=collar_h);

    color("gainsboro")
    translate([ 0, 0, collar_h ])
      cylinder(d=knob_d, h=knob_h);

    if (display==true){

      color("gainsboro")      
      translate([ 0, 0, panel_thick ])
        cylinder(d=washer_d, h=washer_thick);
  
      color("gainsboro")      
      translate([ 0, 0, panel_thick+washer_thick ])
        cylinder($fn=6, d=nut_d, h=nut_thick);
        
      color("darkslategray")
      translate([ 0, 0, panel_thick + 2 ])
        potentiometer_knob();
        
    }

  }
  
}

//===========================================
