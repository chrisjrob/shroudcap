// shroudcap.scad
// Turnbuckle Boot Caps
// 
// Copyright (C) 2013 Christopher Roberts
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.


// Global Parameters

// Top cone
r1 = 5.00;  // Radius of narrow point of cone
h1 = 22.00; // Height of cone

// Middle cone
r3 = 16.45; // Radius of inverted cone AND top cone
h3 = 4.00;  // Height of inverted cone

// Lower cylinder
r2 = 13.00; // Radius of lower cylinder
h2 = 14.00; // Height of lower cylinder

// Other
protrusion = 2.30;   // Size of protrusions
thickness   = 1.50;  // Thickness of skin
precision   = 20.00; // Circular precision

module shroudcap() {

    difference() {

        // Things that exist
        union() {

            // The base circle
            cylinder( h = h2, r = r2, $fn = precision );

            // The protrusions
            for (angle = [ 0 : 5 : 360 ] ) {
                rotate( a = 360/9 * angle ) {
                    minkowski() {
                        cube( size = [r2 + protrusion - 1.0, protrusion - 1.0, h2 + h3]);
                        cylinder( r = 1, h = 1 );
                    }
                }
            }

            // Inverted cone
            translate( v = [0,0,h2]) {
                cylinder( h = h3, r1 = r2, r2 = r3, $fn = precision);
            }

            // Base for cone
            translate( v = [0,0,h2 + h3]) {
                cylinder( h = h1, r1 = r3, r2 = r1, $fn = precision);
            }
        }

        // Things to be cut out
        union() {
            // The inside of the base circle
            cylinder( h = h2 + thickness, r = r2 - thickness, $fn = precision );

            // Base for cone
            translate( v = [0,0,h2 + h3]) {
                cylinder( h = h1, r1 = r3 - thickness, r2 = r1 - thickness, $fn = precision);
            }

            // Inverted cone
            translate( v = [0,0,h2 + thickness/2]) {
                cylinder( h = h3 - thickness/2, r1 = r2 - thickness, r2 = r3 - thickness, $fn = precision);
            }

            // Take slice out
            translate(v = [-thickness/2,0,0]) {
                rotate( a = [0, 0, 10]) {
                    cube( size = [thickness, r3 + thickness, h1+h2+h3]);
                }
            }

            // Cut-away to inspect insides
            // cube( size = [ 2 * (r3 + thickness), r3 + thickness, h1+h2+h3]);
        }
    }

}

//translate( v = [0,0,-h3-h2]) {
shroudcap();
//}
