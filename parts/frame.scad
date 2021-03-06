


	//--------------Variables:------------------


//note on variables: 	mirror locations refer to center of mirror
//						laser locations in Y and Z direction are to center of laser
//				 		other distances are to nearest edge

//measured variables:
//(3mm)  :
laserCutWidth=.16;				//thickness of plastic removed when cutting (diameter rather than radius)
//acetate:
//laserCutWidth=.7;

sheet=2.96;						//thickness of sheet
sheet_A=sheet-laserCutWidth;	//corrected for laser cut



mirrorThick=.7;		//thickness of mirrors

	//controlled variables:
	freeThread=10;		//length of thread free to rotate/stretch on each side (between mirrors/magnets and frame)

	mirrorWidth=5;		//mirrors dimensions: 	
	mirrorLength=10;	//						(both mirrors are mirrorWidth by mirrorLength)

	threadhookThin=0;		//thinner part of threadhook
	threadhookThick=1.2;	//thicker part of threadhook


	frameThick=3.5;		   			//strength of frame

	frameInsideWidth=13;					//inside width of frame

	mirrorBHolderWidth=3;			//strength on a weak part of the mirror B holder
	dampenerToBase_Z=10;				//distance from dynamic dampener to the base in Z direction

	


		//alignment variables:
		mirrorsToBase_Z=max(mirrorLength/2,sin(45)*(frameInsideWidth/2+frameThick+sheet_A+threadhookThin+mirrorThick)+mirrorBHolderWidth);
										//distance from mirrors to the base in z direction

		//End of Variables




//-------------- Frame:------------------------

magnetToBase_Z=dampenerToBase_Z+10;
frameLengthInside=freeThread*2+mirrorLength/2+mirrorsToBase_Z+sheet+magnetToBase_Z;

tighterSheet=.07;


module Frame(ridge_X=2.3,ridge_Y=.9){
	//(counterclockwise starting at left middle)
	square([frameThick,ridge_X]);
	translate([0,-tighterSheet/2])
		square([ridge_Y*1.7+frameThick,ridge_X+tighterSheet/2]);
	translate([0,-sheet_A])
		square([frameThick,sheet_A]);
	translate([0,-sheet_A-ridge_X])
		square([frameThick+ridge_Y*1.7,ridge_X+tighterSheet/2]);
	
	//left to bottom:
	translate([0,-sheet-magnetToBase_Z- freeThread])
		square([frameThick,magnetToBase_Z+freeThread]);


	offset=1.8-.5-1.7;
	translate([frameThick+offset,-sheet*8.5-14.4/2]) {
				translate([-offset,0-.8])square([offset+0.5,14.4+1.6]);
				translate([.5,0-.8]) square([1.3,2]);
				translate([.5,14.4-2+.8]) square([1.3,2]);
				translate([2.6-.8,0-.8]) square([1.9,2.6]);
				translate([2.6-.8,14.4-3+.8+.4]) square([1.9,2.6]);
		
	}

	//bottom:
	difference() {
		translate([0,-sheet-magnetToBase_Z- freeThread- frameThick+.01])
			square([frameThick*2+frameInsideWidth,frameThick]);

		//notches for thread

		
		translate([frameThick+frameInsideWidth/2-0.005,-sheet-magnetToBase_Z- freeThread- frameThick])
			square([0.01,.9]);

		
	}


	
	//right:

	difference(){
		union(){
            translate([frameThick*1+frameInsideWidth,-sheet-magnetToBase_Z- freeThread])
                square([frameThick,frameLengthInside/2+3.4-frameThick]);
			translate([frameThick+frameInsideWidth,-sheet-magnetToBase_Z- freeThread+frameLengthInside/2-2.4])
				square([frameThick,frameLengthInside/2+2.4]);	
        }		
				translate([frameThick*2-.9+frameInsideWidth,-20]) rotate(0)
					square([2,.2]);
				translate([frameThick*2-.9+frameInsideWidth,+15])rotate(0)
					square([2,.2]);
		

	}

	//base ridges
	translate([frameThick+frameInsideWidth- ridge_Y*1.7,-tighterSheet/2])	
		square([ridge_Y*1.7,ridge_X+tighterSheet/2]);
	translate([frameThick+frameInsideWidth -ridge_Y*1.7,-sheet_A-ridge_X])
		square([ridge_Y*1.7,ridge_X+tighterSheet/2]);


	//top:
	difference() {
		union(){
			translate([frameThick/2+frameInsideWidth/2,mirrorsToBase_Z+mirrorLength/2+freeThread])
				square([frameInsideWidth/2+frameThick*1.5,frameThick]);
		//	translate([0,mirrorsToBase_Z+mirrorLength/2+freeThread -frameThick/2])
		//		square([frameThick, frameThick/2]);
		}
		//notches for thread


		translate([frameThick+frameInsideWidth/2-0.005,mirrorsToBase_Z+mirrorLength/2+freeThread+frameThick-.6])
			square([0.01,.6]);
	}

	


}

//linear_extrude(3) Frame();
Frame();


	
