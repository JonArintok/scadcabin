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

floorx = ft(16); // from outside edge to outside edge
floory = ft(10); // from outside edge to outside edge

// P I E R S
module piers() {
  echo();
  echo("P I E R S");
  pierw  = 12;
  pierh = ft(3);
  origin = [0, 0, -pierh];
  echo(origin = origin);
  pier = [pierw, pierw, pierh];
  pierspacingx = (floorx-pierw)/3;
  pierspacingy = (floory-pierw)/2;
  translate(origin) {
    cubenspeak("pier", pier, [0,              0,              0]);
    cubenspeak("pier", pier, [pierspacingx,   0,              0]);
    cubenspeak("pier", pier, [pierspacingx*2, 0,              0]);
    cubenspeak("pier", pier, [pierspacingx*3, 0,              0]);
    cubenspeak("pier", pier, [0,              pierspacingy,   0]);
    cubenspeak("pier", pier, [pierspacingx*3, pierspacingy,   0]);
    cubenspeak("pier", pier, [0,              pierspacingy*2, 0]);
    cubenspeak("pier", pier, [pierspacingx,   pierspacingy*2, 0]);
    cubenspeak("pier", pier, [pierspacingx*2, pierspacingy*2, 0]);
    cubenspeak("pier", pier, [pierspacingx*3, pierspacingy*2, 0]);
  }
}

// F L O O R   B E A M S
floorbeamrise = b6x6[1];
module floorbeams() {
  echo();
  echo("FLOOR BEAMS");
  origin = [0,0,0];
  echo(origin = origin);
  floorbeamlboard = b6x6;
  floorbeamsboard = b6x6;
  floorbeamlboardw = floorbeamlboard[0];
  floorbeamlboardh = floorbeamlboard[1];
  floorbeamsboardw = floorbeamsboard[0];
  floorbeamsboardh = floorbeamsboard[1];
  floorbeaml = [floorx, floorbeamlboardw, floorbeamlboardh];
  floorbeams = [floorbeamsboardw, floory-floorbeamlboardw*2, floorbeamsboardh];
  cubenspeak("floorbeam", floorbeaml, origin);
  cubenspeak("floorbeam", floorbeaml, [0,                       floory-floorbeamlboardw, 0]);
  cubenspeak("floorbeam", floorbeams, [0,                       floorbeamlboardw,        0]);
  cubenspeak("floorbeam", floorbeams, [floorx-floorbeamsboardw, floorbeamlboardw,        0]);
}

// D I R T   C E I L I N G
dirtceilingelev = floorbeamrise;
dirtceilingrise = 1/4;
floorpanelw = ft(4);
module dirtceiling() {
  echo();
  echo("DIRT CEILING");
  origin = [0, 0, dirtceilingelev];
  echo(origin = origin);
  panel = [floorpanelw, floory, dirtceilingrise];
  translate(origin) {
    cubenspeak("OSB", panel, [0,             0, 0]);
    cubenspeak("OSB", panel, [floorpanelw,   0, 0]);
    cubenspeak("OSB", panel, [floorpanelw*2, 0, 0]);
  }
}

// F L O O R   J O I S T S
floorjoistelev = dirtceilingelev + dirtceilingrise;
floorjoistrise = b4x6[1];
module floorjoists() {
  echo();
  echo("FLOOR JOISTS");
  origin = [0, 0, floorjoistelev];
  echo(origin = origin);
  beamboard  = b4x6;
  joistboard = b2x6;
  capboard   = b4x6;
  beamw  = beamboard[0];
  beamh  = beamboard[1];
  joistw = joistboard[0];
  joisth = joistboard[1];
  capw   = capboard[0];
  caph   = capboard[1];
  beam  = [beamw, floory, beamh];
  joist = [joistw, floory-capw*2, joisth];
  cap   = [floorx-beamw*2, beamw, beamh];
  defaultspacing = 16;
  translate(origin) {
    cubenspeak("beam",  beam,  [0,                       0,    0]);
    cubenspeak("joist", joist, [defaultspacing,          capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*2,        capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*3-joistw, capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*3,        capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*4,        capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*5,        capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*6-joistw, capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*6,        capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*7,        capw, 0]);
    cubenspeak("joist", joist, [defaultspacing*8,        capw, 0]);
    cubenspeak("beam",  beam,  [defaultspacing*9-beamw,  0,    0]);
    echo();
    echo("FLOOR JOIST CAPS");
    cubenspeak("cap", cap,  [beamw, 0,           0]);
    cubenspeak("cap", cap,  [beamw, floory-capw, 0]);
  }
}

// S U B F L O O R
subfloorelev = floorjoistelev + floorjoistrise;
subfloorrise = 3/4;
module subfloor() {
  echo();
  echo("SUBFLOOR");
  origin = [0, 0, subfloorelev];
  echo(origin = origin);
  panel = [floorpanelw, floory, subfloorrise];
  translate(origin) {
    cubenspeak("OSB", panel, [0,             0, 0]);
    cubenspeak("OSB", panel, [floorpanelw,   0, 0]);
    cubenspeak("OSB", panel, [floorpanelw*2, 0, 0]);
  }
}

wallelev = subfloorelev + subfloorrise;
studz = ft(12);
doorroughopenw = 38.25;
doorroughopenh = 82;
windowroughopenw = 24;
windowroughopenh = 29;
studboard = b2x4;
studw = studboard[0];
studh = studboard[1];

// N O R T H   W A L L
module northwall() {
  echo();
  echo("NORTH WALL");
  origin = [0, 0, wallelev];
  echo(origin = origin);
  doorroughopenw = 38.25;
  doorroughopenh = 82;
  soleplate = [floorx, studboard[1], studboard[0]];
  stud  = [studboard[0], studboard[1], studz];
  cubenspeak("soleplate", soleplate, origin);
  defaultspacing = 16;
  cubenspeak("stud", stud, [origin[0],                  origin[1], origin[2]+studw]);
  cubenspeak("stud", stud, [origin[0]+defaultspacing,   origin[1], origin[2]+studw]);
  cubenspeak("stud", stud, [origin[0]+defaultspacing*2, origin[1], origin[2]+studw]);
  cubenspeak("stud", stud, [origin[0]+defaultspacing*3, origin[1], origin[2]+studw]);
  cubenspeak("stud", stud, [origin[0]+defaultspacing*4, origin[1], origin[2]+studw]);
  cubenspeak("stud", stud, [origin[0]+defaultspacing*5, origin[1], origin[2]+studw]);
  cubenspeak("stud", stud, [origin[0]+defaultspacing*6, origin[1], origin[2]+studw]);
  cubenspeak("stud", stud, [origin[0]+defaultspacing*7, origin[1], origin[2]+studw]);
  cubenspeak("stud", stud, [origin[0]+defaultspacing*8, origin[1], origin[2]+studw]);
  cubenspeak("stud", stud, [origin[0]+defaultspacing*9, origin[1], origin[2]+studw]);
}

// D R A W
piers();
floorbeams();
*dirtceiling();
*floorjoists();
*subfloor();
*northwall();
