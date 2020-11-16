include <Parametric_Modular_Hose_Library_v02/modularHoseLibrary.scad>

/* [Box Options] */
// Dimension: Box outer X-Size [mm] 72
box_Size_X          = 78;
// Dimension: Box outer Y-Size [mm]
box_Size_Y          = 95;
// Dimension: Box Inner height [mm]
box_Inner_Height    = 25;
// Box bottom/top thickness
box_BottomTop_Thickness =  2.6; // [0.6:0.2:3]
// Edge corner radius 
box_Screw_Corner_Radius   =  6; // [2:1:10]
// four outer screw hole diameters
box_Screw_Diameter     =  3.1; // [2:0.2:4]
// Box wall thickness
box_Wall_Thickness     =  3.6; // [0.4:0.2:3.2]
/* [Top Barrier Options] */
// Box barrier thickness
barrier_Thickness  =  1.2; // [0.4:0.2:3.2]
// Box barrier height
barrier_Height     =  2;   // [1.0:0.2:8]
// Additional width on the lid to correct for badly calibrated printers
barrier_Tolerance  =  0.8; // [0.0:0.1:1]
/* [Mouting Screw Nose Options] */
// Number of screw noses
screwnose_Number        = 2; // [0:No noses, 2: one top/one bottom, 4: two top/two bottom]
// Diameter of the noses' screw holes
screwnose_Diameter      = 4; // [2:0.2:8]
// Height of the noses
screwnose_Height        = 5; // [2:0.2:10]
// Wall thickness
screwnose_Wall_Thickness = 2.8; // [2:0.2:5]

// Solar panel
panel_Size_X            = 58;

panel_Size_Y            = 73;

panel_Height            = 2.5;
// **************************
// ** Calculated globals
// **************************
boxHeight = box_Inner_Height+box_BottomTop_Thickness;

module box() {
	barrier_Thickness = box_Wall_Thickness-barrier_Thickness;
	difference() {
		union() {
			// solid round box, corners
			translate([box_Screw_Corner_Radius, box_Screw_Corner_Radius, 0]) cylinder(r=box_Screw_Corner_Radius, h=boxHeight, $fn=definition); // bottom left
			translate([box_Size_X-box_Screw_Corner_Radius, box_Screw_Corner_Radius, 0]) cylinder(r=box_Screw_Corner_Radius, h=boxHeight, $fn=definition); // bottom right
			translate([box_Screw_Corner_Radius, box_Size_Y-box_Screw_Corner_Radius, 0]) cylinder(r=box_Screw_Corner_Radius, h=boxHeight, $fn=definition); // top left
			translate([box_Size_X-box_Screw_Corner_Radius, box_Size_Y-box_Screw_Corner_Radius, 0]) cylinder(r=box_Screw_Corner_Radius, h=boxHeight, $fn=definition); // bottom right
			// solid round box, inner filling
			translate([0, box_Screw_Corner_Radius, 0]) cube([box_Size_X, box_Size_Y-2*box_Screw_Corner_Radius, boxHeight]);
			translate([box_Screw_Corner_Radius, 0, 0]) cube([box_Size_X-2*box_Screw_Corner_Radius, box_Size_Y, boxHeight]);
			// solid round box, top border
			translate([barrier_Thickness, box_Screw_Corner_Radius+barrier_Thickness, 0]) cube([box_Size_X-2*barrier_Thickness, box_Size_Y-2*box_Screw_Corner_Radius-2*barrier_Thickness, boxHeight+barrier_Height]);
			translate([box_Screw_Corner_Radius+barrier_Thickness, barrier_Thickness, 0]) cube([box_Size_X-2*box_Screw_Corner_Radius-2*barrier_Thickness, box_Size_Y-2*barrier_Thickness, boxHeight+barrier_Height]);
		}
		// inner cut-out
		translate([box_Wall_Thickness, box_Screw_Corner_Radius+box_Wall_Thickness, box_BottomTop_Thickness]) cube([box_Size_X-2*box_Wall_Thickness, box_Size_Y-2*box_Screw_Corner_Radius-2*box_Wall_Thickness, boxHeight+barrier_Height]);
		translate([box_Screw_Corner_Radius+box_Wall_Thickness, box_Wall_Thickness, box_BottomTop_Thickness]) cube([box_Size_X-2*box_Screw_Corner_Radius-2*box_Wall_Thickness, box_Size_Y-2*box_Wall_Thickness, boxHeight+barrier_Height]);
		// Screw holes
		translate([(box_Screw_Corner_Radius+box_Wall_Thickness)/2,(box_Screw_Corner_Radius+box_Wall_Thickness)/2,-0.25]) cylinder(r=box_Screw_Diameter/2, h=boxHeight+0.5, $fn=definition);
		translate([(box_Screw_Corner_Radius+box_Wall_Thickness)/2,box_Size_Y-(box_Screw_Corner_Radius+box_Wall_Thickness)/2,-0.25]) cylinder(r=box_Screw_Diameter/2, h=boxHeight+0.5, $fn=definition);
		translate([box_Size_X-(box_Screw_Corner_Radius+box_Wall_Thickness)/2,(box_Screw_Corner_Radius+box_Wall_Thickness)/2,-0.25]) cylinder(r=box_Screw_Diameter/2, h=boxHeight+0.5, $fn=definition);
		translate([box_Size_X-(box_Screw_Corner_Radius+box_Wall_Thickness)/2,box_Size_Y-(box_Screw_Corner_Radius+box_Wall_Thickness)/2,-0.25]) cylinder(r=box_Screw_Diameter/2, h=boxHeight+0.5, $fn=definition);
		// **************************
		// ** YOUR OWN CUTOUTS HERE!
		// **************************
        // bottom
		cRadius = 7.8;
        yDisp = 1.5;
		translate([box_Size_X/2,(box_Wall_Thickness+0.1), box_Wall_Thickness+((boxHeight-box_Wall_Thickness)/2)+yDisp]) rotate([90,00,0]) cylinder(r=cRadius2, h=box_Wall_Thickness+0.3,$fn=definition);
        // top
		cRadius2 = 3.2;
		translate([box_Size_X/2,box_Size_Y+0.1, box_Wall_Thickness+((boxHeight-box_Wall_Thickness)/2)+yDisp]) rotate([90,00,0]) cylinder(r=cRadius, h=box_Wall_Thickness+0.2,$fn=definition);
        //cRadius3 = 6.1;
		//translate([box_Size_X/2,box_Size_Y+2.5, box_Wall_Thickness+((boxHeight-box_Wall_Thickness)/2)+yDisp]) rotate([90,00,0]) cylinder(r=cRadius3, h=box_Wall_Thickness+0.2,$fn=definition);
		// **************************
		// ** / CUTOUTS
		// **************************
	}
    translate([box_Size_X/2-12.05,box_Size_Y-box_Wall_Thickness,boxHeight/2-7]) cube([5,box_Wall_Thickness, 18]);
	// Lower nose(s)
	if (screwnose_Number==2) translate([box_Size_X/2, 0.001, 0]) mirror([0,1,0]) screwNose(screwnose_Diameter, screwnose_Height);
	if (screwnose_Number==4) {
		translate([box_Size_X*0.25, 0.001, 0]) mirror([0,1,0]) screwNose(screwnose_Diameter, screwnose_Height);
		translate([box_Size_X*0.75, 0.001, 0]) mirror([0,1,0]) screwNose(screwnose_Diameter, screwnose_Height);
	}
	// Upper nose(s)
	if (screwnose_Number==2) translate([box_Size_X/2, box_Size_Y-0.001, 0]) screwNose(screwnose_Diameter, screwnose_Height);
	if (screwnose_Number==4) {
		translate([box_Size_X*0.25, box_Size_Y-0.001, 0]) screwNose(screwnose_Diameter, screwnose_Height);
		translate([box_Size_X*0.75, box_Size_Y-0.001, 0]) screwNose(screwnose_Diameter, screwnose_Height);
	}
}

module lid() {
	boxHeight = box_BottomTop_Thickness+barrier_Height+2;
    difference() {
        union () {
        difference() {
            union() {
                // solid round box, corners
                translate([box_Screw_Corner_Radius, box_Screw_Corner_Radius, 0]) cylinder(r=box_Screw_Corner_Radius, h=boxHeight, $fn=definition); // bottom left
                translate([box_Size_X-box_Screw_Corner_Radius, box_Screw_Corner_Radius, 0]) cylinder(r=box_Screw_Corner_Radius, h=boxHeight, $fn=definition); // bottom right
                translate([box_Screw_Corner_Radius, box_Size_Y-box_Screw_Corner_Radius, 0]) cylinder(r=box_Screw_Corner_Radius, h=boxHeight, $fn=definition); // top left
                translate([box_Size_X-box_Screw_Corner_Radius, box_Size_Y-box_Screw_Corner_Radius, 0]) cylinder(r=box_Screw_Corner_Radius, h=boxHeight, $fn=definition); // bottom right
                // solid round box, inner filling
                translate([0, box_Screw_Corner_Radius, 0]) cube([box_Size_X, box_Size_Y-2*box_Screw_Corner_Radius, boxHeight]);
                translate([box_Screw_Corner_Radius, 0, 0]) cube([box_Size_X-2*box_Screw_Corner_Radius, box_Size_Y, boxHeight]);
                // solid round box, top border
            }
            // inner cut-out X direction
            translate([
                box_Wall_Thickness-(barrier_Thickness+barrier_Tolerance),
                box_Screw_Corner_Radius+box_Wall_Thickness-(barrier_Thickness+barrier_Tolerance),
                box_BottomTop_Thickness
            ]) cube([
                box_Size_X-2*(box_Wall_Thickness)+2*(barrier_Thickness+barrier_Tolerance),
                box_Size_Y-2*box_Screw_Corner_Radius-2*(box_Wall_Thickness)+2*(barrier_Thickness+barrier_Tolerance),
                box_BottomTop_Thickness+barrier_Height
            ]);
            // inner cut-out Y direction
            translate([
                box_Screw_Corner_Radius+box_Wall_Thickness-(barrier_Thickness+barrier_Tolerance),
                box_Wall_Thickness-(barrier_Thickness+barrier_Tolerance),
                box_BottomTop_Thickness
            ]) cube([
                box_Size_X-2*box_Screw_Corner_Radius-2*(box_Wall_Thickness)+2*(barrier_Thickness+barrier_Tolerance),
                box_Size_Y-2*(box_Wall_Thickness)+2*(barrier_Thickness+barrier_Tolerance),
                box_BottomTop_Thickness+barrier_Height
            ]);
            
            // Screw holes
            translate([(box_Screw_Corner_Radius+box_Wall_Thickness)/2,(box_Screw_Corner_Radius+box_Wall_Thickness)/2,0]) cylinder(r=box_Screw_Diameter/2, h=boxHeight, $fn=definition);
            translate([(box_Screw_Corner_Radius+box_Wall_Thickness)/2,box_Size_Y-(box_Screw_Corner_Radius+box_Wall_Thickness)/2,0]) cylinder(r=box_Screw_Diameter/2, h=boxHeight, $fn=definition);
            translate([box_Size_X-(box_Screw_Corner_Radius+box_Wall_Thickness)/2,(box_Screw_Corner_Radius+box_Wall_Thickness)/2,0]) cylinder(r=box_Screw_Diameter/2, h=boxHeight, $fn=definition);
            translate([box_Size_X-(box_Screw_Corner_Radius+box_Wall_Thickness)/2,box_Size_Y-(box_Screw_Corner_Radius+box_Wall_Thickness)/2,0]) cylinder(r=box_Screw_Diameter/2, h=boxHeight, $fn=definition);
            
            
        }

        // inner add X direction
        translate([box_Wall_Thickness+barrier_Tolerance, box_Screw_Corner_Radius+box_Wall_Thickness+barrier_Tolerance, box_BottomTop_Thickness])
            cube([box_Size_X-2*(box_Wall_Thickness+barrier_Tolerance), box_Size_Y-2*(box_Screw_Corner_Radius+box_Wall_Thickness+barrier_Tolerance), barrier_Height+2]);
        // inner add Y direction
        translate([box_Screw_Corner_Radius+box_Wall_Thickness+barrier_Tolerance, box_Wall_Thickness+barrier_Tolerance, box_BottomTop_Thickness])
            cube([box_Size_X-2*(box_Screw_Corner_Radius+box_Wall_Thickness+barrier_Tolerance), box_Size_Y-2*(box_Wall_Thickness+barrier_Tolerance), barrier_Height+2]);
        }
    // solar panel holes
        translate([box_Size_X/2, box_Size_Y/2-7.5,0]) cylinder(r=box_Screw_Diameter, h=boxHeight+10, $fn=20);
        translate([box_Size_X/2, box_Size_Y/2+7.5,0]) cylinder(r=box_Screw_Diameter, h=boxHeight+10, $fn=definition);
        translate([box_Size_X/2-box_Screw_Diameter/4, box_Size_Y/2-7.5,0]) cube([box_Screw_Diameter/2,15,boxHeight]);
        translate([box_Size_X/2, box_Size_Y/2,0]) cube([panel_Size_X,panel_Size_Y,panel_Height], center = true);
    // logos
    // utad
        translate([box_Size_X/2-8, 2,0]) 
        rotate([0,180,0])
        scale(0.22)
        linear_extrude(height = 5.1, center = true)
		import(file = "utad.svg");
    // inesc tec
        translate([box_Size_X/2+28, 2,0]) 
        rotate([0,180,0])
        scale(0.24)
        linear_extrude(height = 5.1, center = true)
		import(file = "inesctec.svg");
        
    }
}

module batterySpacer() {
    battery_Height = 8;
        translate([box_Wall_Thickness+barrier_Tolerance, box_Screw_Corner_Radius+box_Wall_Thickness+barrier_Tolerance, 0])
            cube([box_Size_X-2*(box_Wall_Thickness+barrier_Tolerance), box_Size_Y-2*(box_Screw_Corner_Radius+box_Wall_Thickness+barrier_Tolerance), barrier_Height+2]);
        // inner add Y direction
        translate([box_Screw_Corner_Radius+box_Wall_Thickness+barrier_Tolerance, box_Wall_Thickness+barrier_Tolerance, 0])
            cube([box_Size_X-2*(box_Screw_Corner_Radius+box_Wall_Thickness+barrier_Tolerance), box_Size_Y-2*(box_Wall_Thickness+barrier_Tolerance)-box_Screw_Corner_Radius, barrier_Height+2]);
    // spacers
    translate([box_Wall_Thickness+barrier_Tolerance+2.5, box_Screw_Corner_Radius+box_Wall_Thickness+barrier_Tolerance+2.5, barrier_Height+2])
            cylinder(r=2, h=battery_Height, $fn=20);
    translate([box_Wall_Thickness+barrier_Tolerance-2.5+box_Size_X-2*(box_Wall_Thickness+barrier_Tolerance), box_Screw_Corner_Radius+box_Wall_Thickness+barrier_Tolerance+2.5, barrier_Height+2])
            cylinder(r=2, h=battery_Height, $fn=20);
       translate([box_Wall_Thickness+barrier_Tolerance+2.5, box_Screw_Corner_Radius+box_Wall_Thickness+barrier_Tolerance-2.5+box_Size_Y-2*(box_Screw_Corner_Radius+box_Wall_Thickness+barrier_Tolerance), barrier_Height+2])
            cylinder(r=2, h=battery_Height, $fn=20);
          translate([box_Wall_Thickness+barrier_Tolerance-2.5+box_Size_X-2*(box_Wall_Thickness+barrier_Tolerance), box_Screw_Corner_Radius+box_Wall_Thickness+barrier_Tolerance-2.5+box_Size_Y-2*(box_Screw_Corner_Radius+box_Wall_Thickness+barrier_Tolerance), barrier_Height+2])
            cylinder(r=2, h=battery_Height, $fn=20);
}


module screwNose(screwholeDiameter=4, noseHeight=5) {
	additionalDistanceFromWall = 1;
	translate([0,screwholeDiameter/2+screwnose_Wall_Thickness+additionalDistanceFromWall, 0]) difference() {
		union() {
			translate([-(screwholeDiameter/2+screwnose_Wall_Thickness), -(screwholeDiameter/2+screwnose_Wall_Thickness+additionalDistanceFromWall),0]) cube([(screwholeDiameter/2+screwnose_Wall_Thickness)*2, screwholeDiameter/2+screwnose_Wall_Thickness+additionalDistanceFromWall, noseHeight]);
			cylinder(r=(screwholeDiameter/2)+screwnose_Wall_Thickness, h=noseHeight, $fn=60);
		}
		cylinder(r=screwholeDiameter/2, h=2*noseHeight+0.1, $fn=60, center=true);
	}
}

//union(){
box();
//translate([32.5,0,20]) rotate([90, 0, 0]) modularHoseBasePlate(i4);}

//modularHoseSensorModule(i4);

    translate([2*box_Size_X+5, 0, box_BottomTop_Thickness+barrier_Height+2]) rotate([0, 180, 0]) lid();
//    
//    translate([10,box_Size_Y+10,0]) modularHoseSegment(i4);
//    
//    translate([50,box_Size_Y+10,0]) modularHoseSegment(i4);
//    
//    translate([70,box_Size_Y+10,0]) modularHoseSegment(i4);
//    
//    translate([90,box_Size_Y+10,0]) modularHoseSegment(i4);
//    
//    translate([30,box_Size_Y+30,0]) modularHoseSegment(i4);
//    
//    translate([50,box_Size_Y+30,0]) modularHoseSegment(i4);
//    
//    translate([70,box_Size_Y+30,0]) modularHoseSegment(i4);
//    
//    translate([90,box_Size_Y+30,0]) modularHoseSegment(i4);
//    
//    translate([10,box_Size_Y+30,0]) modularHoseSensorModule(i4);

//if (box_Size_X>box_Size_Y) {
//	translate([0, box_Size_Y+5+screwnose_Diameter+screwnose_Wall_Thickness, 0]) lid();	
//} else {
//    
//    translate([box_Size_X, 0, box_BottomTop_Thickness+barrier_Height+2]) rotate([0, 180, 0]) lid();	
//	//translate([box_Size_X+5, 0, 0]) lid();	
//}
//    //translate([box_Size_X+5, box_Size_Y+5, 0]) batterySpacer();
