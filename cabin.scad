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
function ft(feet = 0, inches = 0) = 12*feet + inches;
module cubenspeak(name = "board", cuboid = [0,0,0], transtep = [0,0,0]) {
  translate(transtep) {
    cube(cuboid);
  }
  echo(name, cuboid, transtep);
}
module announceorigin(origin) {echo(origin = origin);}

floorx = ft(12); // from outside edge to outside edge
floory = ft(10); // from outside edge to outside edge
floorbeamboard = b6x6;
floorbeamspacing = floory - floorbeamboard[0]; // center to center

// P I E R S
module piers() {
  echo();
  echo("P I E R S");
  pierwidth  = 18;
  pierheight = ft(4);
  pier = [pierwidth, pierwidth, pierheight];
  origin = [0, -pierwidth/2 + floorbeamboard[1]/2, -pierheight];
  announceorigin(origin);
  translate(origin) {
    cubenspeak("pier", pier, [0,                               0, 0]);
    cubenspeak("pier", pier, [0,                floorbeamspacing, 0]);
    cubenspeak("pier", pier, [floorx-pierwidth, floorbeamspacing, 0]);
    cubenspeak("pier", pier, [floorx-pierwidth,                0, 0]);
  }
}

// F L O O R   B E A M S
floorbeamrise = floorbeamboard[1];
module floorbeams() {
  echo();
  echo("F L O O R   B E A M S");
  floorbeam = [floorx, floorbeamboard[0], floorbeamboard[1]];
  origin = [0,0,0];
  announceorigin(origin);
  cubenspeak("floorbeam", floorbeam, origin);
  cubenspeak("floorbeam", floorbeam, [0, floorbeamspacing, 0]);
}

// D I R T   C E I L I N G
dirtceilingelev = floorbeamrise;
dirtceilingrise = 1/4;
floorpanelw = ft(4);
module dirtceiling() {
  echo();
  echo("D I R T   C E I L I N G");
  origin = [0, 0, dirtceilingelev];
  announceorigin(origin);
  panel = [floorpanelw, floory, dirtceilingrise];
  cubenspeak("OSB", panel, [origin[0],               origin[1], origin[2]]);
  cubenspeak("OSB", panel, [origin[0]+floorpanelw,   origin[1], origin[2]]);
  cubenspeak("OSB", panel, [origin[0]+floorpanelw*2, origin[1], origin[2]]);
}

// F L O O R   J O I S T S
floorjoistelev = dirtceilingelev + dirtceilingrise;
floorjoistrise = b4x6[1];
module floorjoists() {
  echo();
  echo("F L O O R   J O I S T S");
  origin = [0, 0, floorjoistelev];
  announceorigin(origin);
  beamboard = b4x6;
  joistboard = b2x6;
  beam  = [beamboard[0], floory, beamboard[1]];
  joist = [joistboard[0], floory-joistboard[0]*2, joistboard[1]];
  beamw  = beam[0];
  joistw = joist[0];
  defaultspacing = 16;
  cubenspeak("beam",  beam,  [origin[0],                         origin[1],        origin[2]]);
  cubenspeak("joist", joist, [origin[0]+defaultspacing,          origin[1]+joistw, origin[2]]);
  cubenspeak("joist", joist, [origin[0]+defaultspacing*2,        origin[1]+joistw, origin[2]]);
  cubenspeak("joist", joist, [origin[0]+defaultspacing*3-joistw, origin[1]+joistw, origin[2]]);
  cubenspeak("joist", joist, [origin[0]+defaultspacing*3,        origin[1]+joistw, origin[2]]);
  cubenspeak("joist", joist, [origin[0]+defaultspacing*4,        origin[1]+joistw, origin[2]]);
  cubenspeak("joist", joist, [origin[0]+defaultspacing*5,        origin[1]+joistw, origin[2]]);
  cubenspeak("joist", joist, [origin[0]+defaultspacing*6-joistw, origin[1]+joistw, origin[2]]);
  cubenspeak("joist", joist, [origin[0]+defaultspacing*6,        origin[1]+joistw, origin[2]]);
  cubenspeak("joist", joist, [origin[0]+defaultspacing*7,        origin[1]+joistw, origin[2]]);
  cubenspeak("joist", joist, [origin[0]+defaultspacing*8,        origin[1]+joistw, origin[2]]);
  cubenspeak("beam",  beam,  [origin[0]+defaultspacing*9-beamw,  origin[1],        origin[2]]);
}


// D R A W
piers();
floorbeams();
dirtceiling();
floorjoists();
