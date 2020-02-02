include <yoyodyne.scad>;

//============================================

MM_TO_IN = 25.4;

CHASSIS_THICK = 2;
CHASSIS_INSET_W = 153;
CHASSIS_INSET_H = 103;

PANEL_COLOR = "gray";
PANEL_LIP = 5;
PANEL_THICK = 20;

PANEL_PCB_SIDE = 70;
PANEL_FRAME = 5;
PANEL_FRAME_THICK = 3;
PANEL_FRAME_RIM = 3;
LEFT_PANEL_W = 70;
RIGHT_PANEL_W = 71;
PANEL_SEPARATION = 6;
EPOXY_LIP = 3;

MOUNTING_LIP_DEPTH = 5;

CPU_W = 90;
CPU_H = 30;
CPU_D = 30;

KM_LOGO_SIZE = 19;
KM_LOGO_ROUND = 1.5;

LAMP_START_Y = 13.5;
LAMP_STEP_Y = 19;
STD_LABEL_X = 16;
STD_LABEL_W = 37;

MODE_SWITCH_X = 125;

//============================================

module heatset_reinforcement(thick=1,diameter=10){
      hull(){
        translate([0, 0, -FUDGE])
        cylinder(d=diameter, h=thick+FUDGE);

      translate([ 0, 4, -FUDGE ])
        cylinder(d=0.8*diameter, h=FUDGE);

    }
}

//============================================

module km_logo(cut=false){
  
  color(PANEL_COLOR)
  if (cut==true){

  translate([KM_LOGO_ROUND-(KM_LOGO_SIZE+PANEL_FRAME_RIM*2+2)/2+PANEL_FRAME_RIM,
             KM_LOGO_ROUND-(KM_LOGO_SIZE+PANEL_FRAME_RIM*2+2)/2+PANEL_FRAME_RIM,
             -FUDGE])

    rounded_cube(KM_LOGO_SIZE+2,
                 KM_LOGO_SIZE+2,
                 EPOXY_LIP*2,
                 KM_LOGO_ROUND);

  } else {
    
  translate([KM_LOGO_ROUND-(KM_LOGO_SIZE+PANEL_FRAME_RIM*2+2)/2,
             KM_LOGO_ROUND-(KM_LOGO_SIZE+PANEL_FRAME_RIM*2+2)/2,
             0])
  difference(){
  
    rounded_cube(KM_LOGO_SIZE+PANEL_FRAME_RIM*2+2,
                 KM_LOGO_SIZE+PANEL_FRAME_RIM*2+2,
                 EPOXY_LIP,
                 KM_LOGO_ROUND);

    translate([PANEL_FRAME_RIM, PANEL_FRAME_RIM, -FUDGE])
    rounded_cube(KM_LOGO_SIZE+2,
                 KM_LOGO_SIZE+2,
                 EPOXY_LIP+FUDGE*2,
                 KM_LOGO_ROUND);
  
  }
  }
  
}

//============================================

module panel_chassis(){
  color(PANEL_COLOR)
  difference(){
    
    hull(){
    translate([5-PANEL_LIP,
               5-PANEL_LIP,
               0])
      rounded_cube(CHASSIS_INSET_W+2*PANEL_LIP,
            CHASSIS_INSET_H+2*PANEL_LIP,
            CHASSIS_THICK+FUDGE,
            5);

    translate([5-PANEL_LIP+PANEL_FRAME,
               5-PANEL_LIP+PANEL_FRAME,
               PANEL_FRAME_THICK])
      rounded_cube(CHASSIS_INSET_W+2*PANEL_LIP-PANEL_FRAME*2,
            CHASSIS_INSET_H+2*PANEL_LIP-PANEL_FRAME*2,
            CHASSIS_THICK+FUDGE,
            5);

    }

    translate([5-PANEL_LIP+PANEL_FRAME+PANEL_FRAME_RIM,
               5-PANEL_LIP+PANEL_FRAME+PANEL_FRAME_RIM,
               CHASSIS_THICK])
      rounded_cube(
            LEFT_PANEL_W,
            CHASSIS_INSET_H+2*PANEL_LIP-PANEL_FRAME*2-PANEL_FRAME_RIM*2,
            CHASSIS_THICK+PANEL_FRAME_THICK,
            5);
    
    translate([5-PANEL_LIP+PANEL_FRAME+PANEL_FRAME_RIM+LEFT_PANEL_W+PANEL_SEPARATION,
               5-PANEL_LIP+PANEL_FRAME+PANEL_FRAME_RIM,
               CHASSIS_THICK])
      rounded_cube(
            RIGHT_PANEL_W,
            CHASSIS_INSET_H+2*PANEL_LIP-PANEL_FRAME*2-PANEL_FRAME_RIM*2,
            CHASSIS_THICK+PANEL_FRAME_THICK,
            5);
    
    translate([5-PANEL_LIP+PANEL_FRAME+PANEL_FRAME_RIM+LEFT_PANEL_W+PANEL_SEPARATION-8,
               (CHASSIS_INSET_H+2*PANEL_LIP-PANEL_FRAME*2)/2,
               CHASSIS_THICK])
      km_logo(cut=true);
    lamps(display=false,cut=true);
    manual_controls(cut=true);
    
  }

    translate([5-PANEL_LIP+PANEL_FRAME+PANEL_FRAME_RIM+LEFT_PANEL_W+PANEL_SEPARATION-8,
               (CHASSIS_INSET_H+2*PANEL_LIP-PANEL_FRAME*2)/2,
               CHASSIS_THICK])
      km_logo();
  
  lamps(display=false, cut=false);
  manual_controls(display=false, cut=false);
  
}

//============================================

module chassis_walls(){
  
  color(PANEL_COLOR)
  difference(){
  union(){
  difference(){

    union(){
          
      translate([0, 0, -PANEL_THICK])
        cube([CHASSIS_INSET_W,
              CHASSIS_INSET_H,
              PANEL_THICK]);

      translate([0, 0, -PANEL_PCB_SIDE ])
        cube([CHASSIS_INSET_W,
              CHASSIS_THICK,
              PANEL_PCB_SIDE ]);

      hull(){
        translate([0, 0, -PANEL_PCB_SIDE ])
          cube([CHASSIS_THICK,
                CHASSIS_THICK,
                PANEL_PCB_SIDE ]);

        translate([0, CHASSIS_INSET_H-PANEL_THICK, -PANEL_THICK ])
          cube([CHASSIS_THICK,
                CHASSIS_THICK,
                PANEL_THICK ]);
      }

      hull(){
        translate([CHASSIS_INSET_W-CHASSIS_THICK, 0, -PANEL_PCB_SIDE ])
          cube([CHASSIS_THICK,
                CHASSIS_THICK,
                PANEL_PCB_SIDE ]);

        translate([CHASSIS_INSET_W-CHASSIS_THICK, CHASSIS_INSET_H-PANEL_THICK, -PANEL_THICK ])
          cube([CHASSIS_THICK,
                CHASSIS_THICK,
                PANEL_THICK ]);
      }

      // bottom mounting lip
      translate([0, 0, -CHASSIS_THICK])
      hull(){
        cube([CHASSIS_INSET_W,
              FUDGE,
              FUDGE]);
        translate([0, -MOUNTING_LIP_DEPTH, -MOUNTING_LIP_DEPTH/2])      
        cube([CHASSIS_INSET_W,
              MOUNTING_LIP_DEPTH,
              FUDGE]);
        translate([0, -MOUNTING_LIP_DEPTH, -MOUNTING_LIP_DEPTH])      
        cube([CHASSIS_INSET_W,
              MOUNTING_LIP_DEPTH,
              FUDGE]);
      }

    } // positive union

    translate([CHASSIS_THICK*3,
               CHASSIS_THICK*3,
               FUDGE-PANEL_THICK])
      cube([CHASSIS_INSET_W-6*CHASSIS_THICK,
            CHASSIS_INSET_H-6*CHASSIS_THICK,
            PANEL_THICK+2*FUDGE]);

    translate([CHASSIS_THICK,
               CHASSIS_THICK,
              -PANEL_THICK-CHASSIS_THICK-FUDGE])
      cube([CHASSIS_INSET_W-2*CHASSIS_THICK,
            CHASSIS_INSET_H-2*CHASSIS_THICK,
            PANEL_THICK+2*FUDGE]);

    } // difference

    // heatset reinforcement
      translate([ CHASSIS_INSET_W/2,
                  CHASSIS_INSET_H-2,
                 -3*PANEL_THICK/4 ])
      rotate([90,0,0])
        heatset_reinforcement();

      translate([ CHASSIS_INSET_W/2-2.2*MM_TO_IN,
                  CHASSIS_THICK,
                 -0.7*PANEL_PCB_SIDE ])
      rotate([90,0,180])
        heatset_reinforcement();

      translate([ CHASSIS_INSET_W/2,
                  CHASSIS_THICK,
                 -0.7*PANEL_PCB_SIDE ])
      rotate([90,0,180])
        heatset_reinforcement();

      translate([ CHASSIS_INSET_W/2+2.2*MM_TO_IN,
                  CHASSIS_THICK,
                 -0.7*PANEL_PCB_SIDE ])
      rotate([90,0,180])
        heatset_reinforcement();
        
      translate([ CHASSIS_INSET_W/3,
                  CHASSIS_THICK,
                 -0.3*PANEL_PCB_SIDE ])
      rotate([90,0,180])
        heatset_reinforcement(diameter=5);

      translate([ 2*CHASSIS_INSET_W/3,
                  CHASSIS_THICK,
                 -0.3*PANEL_PCB_SIDE ])
      rotate([90,0,180])
        heatset_reinforcement(diameter=5);

  } // union
  
              
    translate([ CHASSIS_INSET_W/2,
                CHASSIS_INSET_H+1.2*CHASSIS_THICK,
               -3*PANEL_THICK/4 ])
    rotate([90, 0, 0])
      cylinder(d=4.1, h=3*CHASSIS_THICK);
  
  
    translate([ CHASSIS_INSET_W/2-2.2*MM_TO_IN,
                2*CHASSIS_THICK,
               -0.7*PANEL_PCB_SIDE ])
    rotate([90, 0, 0])
      cylinder(d=4.1, h=3*CHASSIS_THICK);
      
    translate([ CHASSIS_INSET_W/2,
                2*CHASSIS_THICK,
               -0.7*PANEL_PCB_SIDE ])
    rotate([90, 0, 0])
      cylinder(d=4.1, h=3*CHASSIS_THICK);
      
    translate([ CHASSIS_INSET_W/2+2.2*MM_TO_IN,
                2*CHASSIS_THICK,
               -0.7*PANEL_PCB_SIDE ])
    rotate([90, 0, 0])
      cylinder(d=4.1, h=3*CHASSIS_THICK);
  
  } // difference

}

//============================================

module mounting_bracket(){

  color(PANEL_COLOR)
  union(){
  // bevel
  hull(){
    translate([ CHASSIS_INSET_W/4,
                CHASSIS_INSET_H,
               -CHASSIS_THICK*4 ])
      cube([CHASSIS_INSET_W/2,
            CHASSIS_THICK,
            CHASSIS_THICK]);
  
    translate([ CHASSIS_INSET_W/4,
                CHASSIS_INSET_H,
               -CHASSIS_THICK*2 ])
      cube([CHASSIS_INSET_W/2,
            MOUNTING_LIP_DEPTH,
            CHASSIS_THICK]);
  }

  // plate
  difference(){
    hull(){
      translate([ CHASSIS_INSET_W/4,
                  CHASSIS_INSET_H,
                 -CHASSIS_THICK*4 ])
        cube([CHASSIS_INSET_W/2,
              CHASSIS_THICK,
              CHASSIS_THICK]);
  
      translate([ CHASSIS_INSET_W/2,
                  CHASSIS_INSET_H+CHASSIS_THICK,
                 -3*PANEL_THICK/4 ])
      rotate([90, 0, 0])
        cylinder(d=10, h=CHASSIS_THICK);
    }

    translate([ CHASSIS_INSET_W/2,
                CHASSIS_INSET_H+1.5*CHASSIS_THICK,
               -3*PANEL_THICK/4 ])
    rotate([90, 0, 0])
      cylinder(d=3.2, h=2*CHASSIS_THICK);

  }
  } // union
  
}

//============================================

module lamp(display=true, led_color="red", label="FOO", cut=false, label_w=0){
    
  if ((display==true) || (cut==true)){
    led_indicator(led_color, cut);
    if (label!="FOO"){
      translate([7, -LABEL_TAPE_HEIGHT/2, 0])
        small_brother_label(label,cut=cut,label_inset_w=label_w);
    }
  }
      
  if ((display==false) && (cut==false)){
    color(PANEL_COLOR)
    difference(){
      translate([0, 0, -FUDGE])
        cylinder(r=7.5,h=EPOXY_LIP);
      translate([0, 0, -2*FUDGE])
        cylinder(r1=5,r2=6,h=EPOXY_LIP+FUDGE*2);
    }    
  }
  
}

//============================================

module lamps(display=false, cut=false){

  translate([STD_LABEL_X, LAMP_START_Y+4*LAMP_STEP_Y, CHASSIS_THICK])
    lamp(display,
         cut ? PANEL_COLOR : "green",
         "READY",
         cut,
         label_w=STD_LABEL_W);
  translate([STD_LABEL_X, LAMP_START_Y+3*LAMP_STEP_Y, CHASSIS_THICK])
    lamp(display,
         cut ? PANEL_COLOR : "green",
         "AIR",
         cut,
         label_w=STD_LABEL_W);
  translate([STD_LABEL_X, LAMP_START_Y+2*LAMP_STEP_Y, CHASSIS_THICK])
    lamp(display,
         cut ? PANEL_COLOR : "red",
         "E-STOP",
         cut,
         label_w=STD_LABEL_W);
  translate([STD_LABEL_X, LAMP_START_Y+LAMP_STEP_Y, CHASSIS_THICK])
    lamp(display,
         cut ? PANEL_COLOR : "red",
         "DOOR AJAR",
         cut,
         label_w=STD_LABEL_W);
  translate([STD_LABEL_X, LAMP_START_Y, CHASSIS_THICK])
    lamp(display,
         cut ? PANEL_COLOR : "red",
         "COOLANT",
         cut,
         label_w=STD_LABEL_W);

}

//============================================

module manual_controls(display=false, cut=false){

  if ((display==false) && (cut==false)){

    // toggle switch
    color(PANEL_COLOR)
    translate([MODE_SWITCH_X, 83, CHASSIS_THICK])
      donut(17,14,EPOXY_LIP);
    
    // fire button
    color(PANEL_COLOR)
    translate([MODE_SWITCH_X, 51, CHASSIS_THICK])
    translate([KM_LOGO_ROUND-(KM_LOGO_SIZE+3+2)/2,
               KM_LOGO_ROUND-(KM_LOGO_SIZE+3+2)/2,
               0])
    difference(){
  
      rounded_cube(KM_LOGO_SIZE+3+2,
                   KM_LOGO_SIZE+3+2,
                   EPOXY_LIP,
                   KM_LOGO_ROUND);

      translate([1.5, 1.5, -FUDGE])
      rounded_cube(KM_LOGO_SIZE+2,
                   KM_LOGO_SIZE+2,
                   EPOXY_LIP+FUDGE*2,
                   KM_LOGO_ROUND);
    }
    
    // power knob ring
    color(PANEL_COLOR)
    translate([MODE_SWITCH_X, 21, CHASSIS_THICK])
      donut(20,17,EPOXY_LIP);
    
  } else {
    
  translate([79, 87, CHASSIS_THICK])
    small_brother_label("AUTO",cut=cut,label_inset_w=STD_LABEL_W);

  translate([MODE_SWITCH_X, 83, 0])
  rotate([0, 0, 90])
    toggle_switch(cut=cut, display=display);

  translate([79, 73, CHASSIS_THICK])
    small_brother_label("MANUAL",cut=cut,label_inset_w=STD_LABEL_W);


  translate([MODE_SWITCH_X, 51, CHASSIS_THICK])
    medium_panel_mount_momentary_switch(cut=cut);

  translate([89, 48, CHASSIS_THICK])
    small_brother_label("FIRE",cut=cut,label_inset_w=22.6);


  translate([MODE_SWITCH_X, 21, -FUDGE])
    panel_mount_potentiometer(display=display, cut=cut);
  
  translate([79, 18, CHASSIS_THICK])
    small_brother_label("POWER",cut=cut,label_inset_w=34.5);
    
  }
  
}

//============================================

module assembly(){
  
  panel_chassis();
  chassis_walls();
  mounting_bracket();
  lamps(display=true);
  manual_controls(display=true);
  
}

//============================================

module cpu_controls(display=false,cut=false){
  
  if ((display==true) || (cut==true)){
    translate([15, 15, 0])
      panel_mount_momentary_switch(cut=cut);
    translate([75, 15, 0])
      panel_mount_momentary_switch(cut=cut);
  }
  
  translate([35, 15, 0])
    lamp(display,
         "red",
         cut=cut);

  translate([55, 15, 0])
    lamp(display,
         "green",
         cut=cut);
  
}

module cpu_control_panel(){
  
  color(PANEL_COLOR)
  difference(){
    translate([0, 0, -CHASSIS_THICK])
      cube([CPU_W, CPU_H, CHASSIS_THICK]);
    cpu_controls(cut=true); 
  }
  cpu_controls();

  color(PANEL_COLOR)
  translate([0, 0, -CPU_D])
    cube([CPU_W, CHASSIS_THICK, CPU_D]);
    
  color(PANEL_COLOR)
  hull(){
    translate([0, 0, -CHASSIS_THICK])
      cube([CHASSIS_THICK, CPU_H/2, CHASSIS_THICK]);
    translate([0, 0, -CPU_D/2])
    cube([CHASSIS_THICK, CHASSIS_THICK, CPU_D/2]);
  }

  color(PANEL_COLOR)
  translate([CPU_W-CHASSIS_THICK, 0, 0])
  hull(){
    translate([0, 0, -CHASSIS_THICK])
      cube([CHASSIS_THICK, CPU_H/2, CHASSIS_THICK]);
    translate([0, 0, -CPU_D/2])
    cube([CHASSIS_THICK, CHASSIS_THICK, CPU_D/2]);
  }


}

//============================================

// heatset_reinforcement();

// lamp(cut=true);
// lamp(cut=false, label="E-STOP");
// lamp(display=false, cut=false);

// panel_chassis();
chassis_walls();
// mounting_bracket();

// lamps(display=true);
// lamps(display=false);
// lamps(cut=true);

// manual_controls(display=true);
// manual_controls(cut=true);

// toggle_switch();
// toggle_switch(cut=true);

// panel_mount_momentary_switch();
// panel_mount_momentary_switch(cut=true);

// panel_mount_potentiometer(display=true);

// km_logo();
// km_logo(cut=true);

// assembly();

// cpu_controls(display=true);
// cpu_control_panel();

//============================================
