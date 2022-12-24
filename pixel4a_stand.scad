$fa = 1;
$fs = 0.4;

base_height=15;
base_diam=100;
top_height=3;
top_diam=100;
base_power_height=15;
base_power_diam=base_diam / 4 ;
base_powerRun_height=10;
base_powerRun_diam=12;
usb_slot_length=31;
usb_slot_width=12;
usb_slot_height=15;
phone_rest_radius=20;

show_base=1;
show_top=1;
cable_left=0;

// Base of stand
if (show_base == 1) {
    difference() {
        stand_base();
        if (cable_left == 1) {
            translate([5, 6, base_height - 4])
                cube([usb_slot_length, usb_slot_width, usb_slot_height], center = true);
            // Wide opening for cable
            translate([30, 7, -2.5])
                cylinder(r = (base_power_diam / 2), h = base_power_height);
            // Cable run
            rotate([180, 90, 0])
                translate([-3, -7, -50])
                    cylinder(r = (base_powerRun_diam / 2), h = base_powerRun_height);
        }
        else {
            translate([-5, 6, base_height - 4])
                cube([usb_slot_length, usb_slot_width, usb_slot_height], center = true);
            // Wide opening for cable
            translate([-30, 7, -2.5])
                cylinder(r = (base_power_diam / 2), h = base_power_height);
            // Cable run
            rotate([0, 90, 0])
                translate([-3, 7, -50])
                    cylinder(r = (base_powerRun_diam / 2), h = base_powerRun_height);
        }
    }
}

// Top of stand
if (show_top == 1) {
    translate([0, - 125, 0])
        difference() {
            stand_top();
            if (cable_left == 1)
                translate([3.5, 5, top_height])
                    cube([20, 9, 2], center = true);
            else
                translate([-3.5, 5, top_height])
                    cube([20, 9, 2], center = true);
        }
    translate([0, - 136, phone_rest_radius + 11.95 - 0.001])
        rotate([85, 0, 180])
            phone_rest();
}

// Modules
module phone_rest() {
    linear_extrude(height=5)
        scale([1, 1.5])
            circle(r=phone_rest_radius);
}

module stand_base() {
    difference(){
        cylinder(r=base_diam / 2, h=base_height);
        translate([0, 0, base_height - 1.5])
            hollow_ring();
    }
}

// This creates the slot on the base into which the top snaps
module hollow_ring(){
    difference(){
        cylinder(r=(base_diam / 2) - 1, h=base_height);
        cylinder(r=(base_diam / 2) - 2, h=base_height + 1);
    }
}

module stand_top(){
    difference(){
        cylinder(r=(base_diam / 2) - 1, h=top_height);
        cylinder(r=(base_diam / 2) - 1.75, h=top_height - 1);
    }
}