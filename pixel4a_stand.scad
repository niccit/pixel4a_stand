// SPDX-License-Identifier: MIT

$fa = 1;
$fs = 0.4;

// pin library - pin_connectors by tbuser (https://github.com/tbuser/pin_connectors)
use<lib/pins.scad>;
use<lib/pin_joints.scad>;

// Parameters
base_diam=100;

// --- Modules ---

module stand() {
	difference() {
		cylinder(d=base_diam, h=6.5);
		translate([3, 0.25, 8])
			rotate([5, 0, 0])
				charging_node();
		// cable run
		translate([40, 0, 6])
		minkowski() {
			cube([50, 2.29, 9], center=true);
				cylinder(r=4, h=0.5);
		}
		// inset around cable management
		translate([50, -5, 1])
		minkowski() {
			cube([1, 10.29, 6.5]);
				cylinder(d=4, h=0.5);
		}
		translate([0, -30, 2])
			pinhole(h=4.5, r=4, lh=3, lt=1, t=0.3, tight=false);
		translate([0, 30, 2])
			pinhole(h=4.5, r=4, lh=3, lt=1, t=0.3, tight=false);
	}


}

module top() {
	union() {
		difference() {
			cylinder(d=base_diam, h=11);
			translate([0, 0.15, 4.5])
			rotate([5, 0, 0])
			minkowski() {
				cube([7.25, 2.5, 13], center=true);
					cylinder(r=4, h=0.5);
			}
			// cable run
			translate([32, 0, 3.25])
			minkowski() {
				cube([50, 6.29, 7], center=true);
					cylinder(d=4, h=0.5);
			}
			// inset around cable management
			translate([50, -5, -1])
			minkowski() {
				cube([1, 10.29, 8.5]);
					cylinder(d=4, h=0.5);
			}
			// Pinholes to join top to bottom
			translate([0, -30, 0])
				pinhole(h=4.5, r=4, lh=3, lt=1, t=0.3, tight=false);
			translate([0, 30, 0])
				pinhole(h=4.5, r=4, lh=3, lt=1, t=0.3, tight=false);
		}

		// phone rest
		translate([0, -19, 50])
		rotate([5, 0, 0])
			phone_rest();


	}
}

module charging_node() {
	difference() {
		$fn = 50;
		rotate([5, 0, 0])
		minkowski() {
			cube([18.08, 6.29, 14.12], center=true);
				cylinder(d=4, h=0.5);
		}
	}
	
}

module pins() {
	if (for_print == true) {
		translate([-60, 0, 0])  //Disable translate for printing
			pinpeg(h=8, r=4, lh=3, lt=1);
	}
	else {
		translate ([0, -26, 0])
			rotate([90, 0, 0])
				pinpeg(h=8, r=4, lh=3, lt=1);
		translate ([0, 34, 0])
			rotate([90, 0, 0])
				pinpeg(h=8, r=4, lh=3, lt=1);
	}
}


module phone_rest() {
	union() {
		difference() {
			minkowski() {
				cube([50, 3, 90], center=true);
					cylinder(r=6, h=0.6);
			}
		}
	}
}

// --- Stand Assembly --- 

// Options
show_base=true;
show_top=true;
show_pins=true;
for_print = false;  // set for_print to true for rendering just one pin to send to the 3D printer


if (show_base == true) {
	translate([0, 0, -6.5]) // to show as it will look assembled
	// translate([0, 0, -12.5])  // to show pieces
		stand();
}

if (show_top == true) {
	top();
}


if (show_pins == true) {
		pins();
}



