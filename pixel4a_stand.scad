// SPDX-License-Identifier: MIT

$fa = 1;
$fs = 0.4;

// Parameters
base_height=18.44;
base_diam=100;
top_height=3;
top_diam=100;
phone_rest_radius=20;
usb_adapter_length = 21.72;
usb_adapter_height = 16.44;
usb_adapter_phone_connect_width = 9.44;
usb_adapter_base_usb_width = 12;
cable_run_diam = 12;

// Options
show_base=1;
show_top=1;
cable_left=1;


if (show_base == 1) {
    stand_base();
}

if (show_top == 1) {
    if (show_base == 1) {
        translate([0, -125, 0])
            stand_top();
    }
    else {
        stand_top();
    }
}


// -- Modules --
//
module phone_rest() {
    linear_extrude(height=5)
        scale([1, 1.5])
            circle(r=phone_rest_radius);
}

module stand_base() {
    difference(){
        stand();
        translate([0, 0, base_height - 3.5])
            hollow_ring();
    }
}

module stand_top() {
        if (cable_left == 1) {
            difference() {
                cylinder(r = (base_diam / 2) - 1, h = top_height);
                cylinder(r = (base_diam / 2) - 1.75, h = top_height - 1);
                // slot for usb adapter
                translate([- 3, - 5, top_height])
                    cube([usb_adapter_length, usb_adapter_phone_connect_width, usb_adapter_height], center = true);
            }
            translate([0, 10 , 32 - 0.001])
                rotate([- 85, 0, 180])
                    phone_rest();
        }
        else {
            difference() {
                cylinder(r = (base_diam / 2) - 1, h = top_height);
                cylinder(r = (base_diam / 2) - 1.75, h = top_height - 1);
                // slot for usb adapter
                translate([3, - 5, top_height])
                    cube([usb_adapter_length, usb_adapter_phone_connect_width, usb_adapter_height], center = true);
            }
            translate([0, 10 , 32 - 0.001])
                rotate([- 85, 0, 180])
                    phone_rest();
        }
}

module stand() {
    difference() {
        cylinder(r=base_diam / 2, h=usb_adapter_height);
        if (cable_left == 1) {
            // slot for usb adapter
            translate([-3, -5, base_height / 2 + 1])
                cube([usb_adapter_length, usb_adapter_base_usb_width , usb_adapter_height ], center=true);
            // opening for power cable
            rotate([90, 90, 90])
                translate([-usb_adapter_height / 2 - 0.5, -5, -base_diam / 2])
                    cylinder(d=cable_run_diam, h=40);
        }
        else {
            // slot for usb adapter
            // translate([3, -5, usb_adapter_height - 6.25])
            translate([3, -5, base_height / 2 + 1])
                cube([usb_adapter_length, usb_adapter_base_usb_width, usb_adapter_height ], center=true);
            // opening for power cable
            rotate([90, 90, 90])
                translate([-usb_adapter_height / 2 - 0.5, -5, base_diam / 2 - 39])
                    cylinder(d=cable_run_diam, h=40);
        }
    }
}

// This creates the slot on the base into which the top snaps
module hollow_ring(){
    difference(){
        cylinder(r=(base_diam / 2) - 1, h=base_height);
        cylinder(r=(base_diam / 2) - 2, h=base_height + 1);
    }
}


