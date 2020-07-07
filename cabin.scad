// all lengths are measured in inches

// ACTUAL LUMBER DIMENSIONS
b1x2  = [0.75, 1.5];
b1x3  = [0.75, 2.5];
b1x4  = [0.75, 3.5];
b1x5  = [0.75, 4.5];
b1x6  = [0.75, 5.5];
b1x8  = [0.75, 7.25];
b1x10 = [0.75, 9.25];
b1x12 = [0.75, 11.25];
b2x2  = [1.5, 1.5];
b2x3  = [1.5, 2.5];
b2x4  = [1.5, 3.5];
b2x6  = [1.5, 5.5];
b2x8  = [1.5, 7.25];
b2x10 = [1.5, 9.25];
b2x12 = [1.5, 11.25];
b4x4  = [3.5, 3.5];
b4x6  = [3.5, 5.5];
b6x6  = [5.5, 5.5];

// TOOLS
function ft(feet = 1, inches = 0) = 12*feet + inches;


floorx = ft(12); // from outside edge to outside edge
floory = ft(10); // from outside edge to outside edge

// F L O O R   B E A M S
floorbeamcount = 2;
floorbeam = b6x6;
floorbeamspacing = (floory-floorbeam[0])/(floorbeamcount-1); // center to center
cube([floorx, floorbeam[0], floorbeam[1]]);

// D I R T   C E I L I N G
dirtceilingthickness = 1/4;
floorpanelw = ft(4);
