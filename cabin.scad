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
module ALERT(message = "!!  !!  !!  !!") {
  echo(message);
}

floorx = ft(16); // from outside edge to outside edge
floory = ft(10); // from outside edge to outside edge

// P I E R S
module piers(color) {
  echo();
  echo("P I E R S");
  pierw  = 12;
  pierh = ft(3);
  origin = [0, 0, -pierh];
  echo(origin = origin);
  pier = [pierw, pierw, pierh];
  pierspacingx = (floorx-pierw)/3;
  pierspacingy = (floory-pierw)/2;
  translate(origin) { color(color) {
    cubenspeak("pier", pier);
    cubenspeak("pier", pier, [pierspacingx,   0,              0]);
    cubenspeak("pier", pier, [pierspacingx*2, 0,              0]);
    cubenspeak("pier", pier, [pierspacingx*3, 0,              0]);
    cubenspeak("pier", pier, [0,              pierspacingy,   0]);
    cubenspeak("pier", pier, [pierspacingx*3, pierspacingy,   0]);
    cubenspeak("pier", pier, [0,              pierspacingy*2, 0]);
    cubenspeak("pier", pier, [pierspacingx,   pierspacingy*2, 0]);
    cubenspeak("pier", pier, [pierspacingx*2, pierspacingy*2, 0]);
    cubenspeak("pier", pier, [pierspacingx*3, pierspacingy*2, 0]);
  }}
}

// F L O O R   B E A M S
floorbeamrise = b6x6[1];
module floorbeams(color) {
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
  cubenspeak("floorbeam", floorbeaml);
  cubenspeak("floorbeam", floorbeaml, [0,                       floory-floorbeamlboardw, 0]);
  cubenspeak("floorbeam", floorbeams, [0,                       floorbeamlboardw,        0]);
  cubenspeak("floorbeam", floorbeams, [floorx-floorbeamsboardw, floorbeamlboardw,        0]);
}

// D I R T   C E I L I N G
dirtceilingelev = floorbeamrise;
dirtceilingrise = 1/4;
floorpanelw = ft(4);
module dirtceiling(color) {
  echo();
  echo("DIRT CEILING");
  origin = [0, 0, dirtceilingelev];
  echo(origin = origin);
  panel = [floorpanelw, floory, dirtceilingrise];
  translate(origin) { color(color) {
    cubenspeak("OSB", panel);
    cubenspeak("OSB", panel, [floorpanelw,   0, 0]);
    cubenspeak("OSB", panel, [floorpanelw*2, 0, 0]);
    cubenspeak("OSB", panel, [floorpanelw*3, 0, 0]);
  }}
}

// F L O O R   J O I S T S
floorjoistelev = dirtceilingelev + dirtceilingrise;
floorjoistrise = b4x6[1];
module floorjoists(color) {
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
  studwalk = 16;
  translate(origin) { color(color) {
    cubenspeak("beam",  beam);
    cubenspeak("beam",  beam,  [floorx-beamw,      0,    0]);
    cubenspeak("joist", joist, [studwalk,          capw, 0]);
    cubenspeak("joist", joist, [studwalk*2,        capw, 0]);
    cubenspeak("joist", joist, [studwalk*3-joistw, capw, 0]);
    cubenspeak("joist", joist, [studwalk*3,        capw, 0]);
    cubenspeak("joist", joist, [studwalk*4,        capw, 0]);
    cubenspeak("joist", joist, [studwalk*5,        capw, 0]);
    cubenspeak("joist", joist, [studwalk*6-joistw, capw, 0]);
    cubenspeak("joist", joist, [studwalk*6,        capw, 0]);
    cubenspeak("joist", joist, [studwalk*7,        capw, 0]);
    cubenspeak("joist", joist, [studwalk*8,        capw, 0]);
    cubenspeak("joist", joist, [studwalk*9-joistw, capw, 0]);
    cubenspeak("joist", joist, [studwalk*9,        capw, 0]);
    cubenspeak("joist", joist, [studwalk*10,       capw, 0]);
    cubenspeak("joist", joist, [studwalk*11,       capw, 0]);
    cubenspeak("cap", cap,  [beamw, 0,           0]);
    cubenspeak("cap", cap,  [beamw, floory-capw, 0]);
  }}
}

// S U B F L O O R
subfloorelev = floorjoistelev + floorjoistrise;
subfloorrise = 3/4;
module subfloor(color) {
  echo();
  echo("SUBFLOOR");
  origin = [0, 0, subfloorelev];
  echo(origin = origin);
  panel = [floorpanelw, floory, subfloorrise];
  translate(origin) { color(color) {
    cubenspeak("OSB", panel);
    cubenspeak("OSB", panel, [floorpanelw,   0, 0]);
    cubenspeak("OSB", panel, [floorpanelw*2, 0, 0]);
    cubenspeak("OSB", panel, [floorpanelw*3, 0, 0]);
  }}
}

wallelev         = subfloorelev + subfloorrise;
tallstudl        = ft(12);
studboard        = b2x4;
studw            = studboard[0];
studh            = studboard[1];
studwalk         = 16;
doorroughopenw   = 38.25;
doorroughopenh   = 82;
windowroughopenw = 24;
windowroughopenh = 39;
headerboard      = b4x6;
headerboardw     = headerboard[0];
headerboardh     = headerboard[1];
c                = -studw/2; // for centering north and south walls
windowdrop       = 8;
shortstudl       = doorroughopenh + headerboardh;
headerz          = shortstudl - headerboardh - windowdrop;
sillz            = headerz - windowroughopenh - studw - windowdrop;
lsillx           = studwalk*3 - studw - windowroughopenw; // on south wall
studelev         = wallelev + studw;
intsheatht       = 0.5;

// N O R T H   W A L L
module northwall(color) {
  echo();
  echo("NORTH WALL");
  origin = [0, 0, studelev];
  echo(origin = origin);
  soleplate       = [floorx, studh, studw];
  topplate        = [floorx, studh, studw];
  cornerstudboard = b4x4;
  cornerstud      = [cornerstudboard[0], cornerstudboard[1], tallstudl];
  cornerstudw     = cornerstudboard[0];
  tallstud        = [studw, studh, tallstudl];
  shortstudl      = doorroughopenh+headerboardh;
  shortstud       = [studw, studh, shortstudl];
  trimmer         = [studw, studh, doorroughopenh];
  thicktrimmer    = [studh, studh, doorroughopenh];
  thicktrimmerw   = thicktrimmer[0];
  trimmerw        = trimmer[0];
  cripple         = [studw, studh, tallstudl-shortstudl];
  doorhingebeamx  = studwalk*11 - thicktrimmerw;
  astudx          = doorhingebeamx - doorroughopenw - trimmerw;
  headerx         = studwalk*8 + studw;
  header          = [studwalk*3 - studw, headerboardw, headerboardh];
  translate(origin) { color(color) {
    cubenspeak("soleplate",    soleplate,    [0,                  0, -studw]);
    cubenspeak("cornerstud",   cornerstud);
    cubenspeak("tallstud",     tallstud,     [c+studwalk,           0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk*2-studw,   0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*2,         0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk*2+studw,   0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk*3-studw,   0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*3,         0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk*4-studw,   0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*4,         0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk*5-studw,   0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*5,         0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk*6-studw,   0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*6,         0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk*6+studw,   0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*7,         0, 0]);
    cubenspeak("shortstud",    shortstud,    [c+studwalk*7+studw,   0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*8,         0, 0]);
    cubenspeak("trimmer",      trimmer,      [c+studwalk*8+studw,   0, 0]);
    cubenspeak("trimmer",      trimmer,      [c+astudx,             0, 0]);
    cubenspeak("thicktrimmer", thicktrimmer, [c+doorhingebeamx,     0, 0]);
    cubenspeak("header",       header,       [c+headerx,            0, doorroughopenh]);
    cubenspeak("cripple",      cripple,      [c+studwalk*9,         0, shortstudl]);
    cubenspeak("cripple",      cripple,      [c+studwalk*10,        0, shortstudl]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*11,        0, 0]);
    cubenspeak("cornerstud",   cornerstud,   [floorx-cornerstudw, 0, 0]);
    cubenspeak("topplate",     topplate,     [0,                  0, tallstudl]);
  }}
}

// S O U T H   W A L L
module southwall(color) {
  echo();
  echo("SOUTH WALL");
  origin = [0, floory-studh, studelev];
  echo(origin = origin);
  soleplate       = [floorx, studh, studw];
  topplate        = [floorx, studh, studw];
  cornerstudboard = b4x4;
  cornerstud      = [cornerstudboard[0], cornerstudboard[1], tallstudl];
  cornerstudw     = cornerstudboard[0];
  tallstud        = [studw, studh, tallstudl];
  shortstud       = [studw, studh, shortstudl];
  dropstud        = [studw, studh, windowdrop];
  trimmer         = [studw, studh, doorroughopenh-windowdrop];
  highcripple     = [studw, studh, tallstudl-shortstudl+windowdrop];
  lheaderx        = studwalk + studw;
  header          = [studwalk*2 - studw, headerboardw, headerboardh];
  sill            = [windowroughopenw, studh, studw];
  rsillx          = studwalk*9+studw*2;
  lowcripple      = [studw, studh, sillz];
  lwindowastudx   = studwalk*3 - studw*2 - windowroughopenw;
  rwindowastudx   = studwalk*9 + studw*2 + windowroughopenw;
  translate(origin) { color(color) {
    cubenspeak("soleplate",   soleplate,   [0,                        0, -studw]);
    cubenspeak("cornerstud",  cornerstud);
    cubenspeak("shortstud",   shortstud,   [cornerstudw,              0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk,               0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+studwalk + studw,       0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+lwindowastudx,          0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+lwindowastudx+studw,    0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+studwalk*2,             0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+studwalk*3-studw*2,     0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+studwalk*3-studw,       0, 0]);
    cubenspeak("sill",        sill,        [c+lsillx,                 0, sillz]);
    cubenspeak("header",      header,      [c+studwalk + studw,       0, headerz]);
    cubenspeak("dropstud",    dropstud,    [c+studwalk + studw,       0, shortstudl-windowdrop]);
    cubenspeak("dropstud",    dropstud,    [c+studwalk*2-studw,       0, shortstudl-windowdrop]);
    cubenspeak("highcripple", highcripple, [c+studwalk*2,             0, shortstudl-windowdrop]);
    cubenspeak("dropstud",    dropstud,    [c+studwalk*2+studw,       0, shortstudl-windowdrop]);
    cubenspeak("dropstud",    dropstud,    [c+studwalk*3-studw,       0, shortstudl-windowdrop]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*3,             0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+studwalk*4-studw,       0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*4,             0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+studwalk*5-studw,       0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*5,             0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+studwalk*6-studw,       0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*6,             0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+studwalk*6+studw,       0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*7,             0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+studwalk*7+studw,       0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*8,             0, 0]);
    cubenspeak("shortstud",   shortstud,   [c+studwalk*8+studw,       0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*9,             0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+studwalk*9+studw,       0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+rsillx,                 0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+studwalk*10,            0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+rwindowastudx-studw,    0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+rwindowastudx,          0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+studwalk*11-studw,      0, 0]);
    cubenspeak("sill",        sill,        [c+rsillx,                 0, sillz]);
    cubenspeak("header",      header,      [c+studwalk*9+studw,       0, headerz]);
    cubenspeak("dropstud",    dropstud,    [c+studwalk*9+studw,       0, shortstudl-windowdrop]);
    cubenspeak("dropstud",    dropstud,    [c+studwalk*10-studw,      0, shortstudl-windowdrop]);
    cubenspeak("highcripple", highcripple, [c+studwalk*10,            0, shortstudl-windowdrop]);
    cubenspeak("dropstud",    dropstud,    [c+studwalk*10+studw,      0, shortstudl-windowdrop]);
    cubenspeak("dropstud",    dropstud,    [c+studwalk*11-studw,      0, shortstudl-windowdrop]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*11,            0, 0]);
    cubenspeak("shortstud",   shortstud,   [floorx-cornerstudw-studw, 0, 0]);
    cubenspeak("cornerstud",  cornerstud,  [floorx-cornerstudw,       0, 0]);
    cubenspeak("topplate",    topplate,    [0,                        0, tallstudl]);
  }}
}


// S M A L L   W A L L
module smallwall(color, name) {
  echo();
  echo(name);
  origin = [0, studh, studelev];
  echo(origin = origin);
  soleplatel  = floory-studh*2;
  soleplate   = [studh, soleplatel, studw];
  topplate    = [studh, floory-studh*2, studw];
  tallstud    = [studh, studw, tallstudl];
  lowcripple  = [studh, studw, sillz];
  trimmer     = [studh, studw, doorroughopenh-windowdrop];
  highcripple = [studh, studw, tallstudl-shortstudl+windowdrop];
  shortstud   = [studh, studw, shortstudl];
  studwalk    = 16;
  header      = [headerboardw, studwalk*2 - studw, headerboardh];
  sill        = [studh, windowroughopenw, studw];
  silly       = studwalk*4+studw*2;
  s           = floory-silly-windowroughopenw-lsillx; // shift
  echo(s=s);
  translate(origin) { color(color) {
    cubenspeak("soleplate",   soleplate,   [0, 0,                    -studw]);
    cubenspeak("tallstud",    tallstud,    [0, 0,                    0]);
    cubenspeak("tallstud",    tallstud,    [0, s,                    0]);
    cubenspeak("tallstud",    tallstud,    [0, s+studwalk,           0]);
    cubenspeak("shortstud",   shortstud,   [0, s+studwalk*2-studw,   0]);
    cubenspeak("tallstud",    tallstud,    [0, s+studwalk*2,         0]);
    cubenspeak("tallstud",    tallstud,    [0, s+studwalk*3,         0]);
    cubenspeak("tallstud",    tallstud,    [0, s+studwalk*4,         0]);
    cubenspeak("trimmer",     trimmer,     [0, s+studwalk*4+studw,   0]);
    cubenspeak("lowcripple",  lowcripple,  [0, s+studwalk*4+studw*2, 0]);
    cubenspeak("lowcripple",  lowcripple,  [0, s+studwalk*5,         0]);
    cubenspeak("lowcripple",  lowcripple,  [0, s+studwalk*4+windowroughopenw+studw,   0]);
    cubenspeak("trimmer",     trimmer,     [0, s+studwalk*4+windowroughopenw+studw*2, 0]);
    cubenspeak("trimmer",     trimmer,     [0, s+studwalk*6-studw,   0]);
    cubenspeak("sill",        sill,        [0, s+silly,              sillz]);
    cubenspeak("header",      header,      [0, s+studwalk*4+studw,   headerz]);
    cubenspeak("highcripple", highcripple, [0, s+studwalk*5,         shortstudl-windowdrop]);
    cubenspeak("tallstud",    tallstud,    [0, s+studwalk*6,         0]);
    cubenspeak("tallstud",    tallstud,    [0, soleplatel-studw,     0]);
    cubenspeak("topplate",    topplate,    [0, 0,                    tallstudl]);
  }}
}
// E A S T   W A L L
module eastwall(color) {
  smallwall(color, "EAST WALL");
}
// W E S T   W A L L
module westwall(color) {
  translate([floorx-studh, 0, 0]) {
    smallwall(color, "WEST WALL");
  }
}

// L O F T
module loft(color) {
  echo();
  echo("LOFT");
  origin = [0, 0, studelev+shortstudl];
  echo(origin = origin);
  tallstud    = [studw, studh, tallstudl];
  shortstudl  = doorroughopenh+headerboardh;
  joistboard  = b2x6;
  joistw      = joistboard[0];
  joisth      = joistboard[1];
  joist       = [joistw, floory, joisth];
  s           = 6.5; // see "smallwall"
  shortjoist  = [joistboard[0], floory-studwalk*2-s-studh, joistboard[1]];
  shortjoisty = studwalk*2+studh+s;
  crossjoist  = [studwalk*2-joistw*2-c, joistw, joisth];
  translate(origin) { color(color) {
    cubenspeak("shortjoist", shortjoist,  [studh,                 shortjoisty,        0]);
    cubenspeak("shortjoist", shortjoist,  [c+studwalk  +studw,    shortjoisty,        0]);
    cubenspeak("crossjoist", crossjoist,  [0,                     shortjoisty-joistw, 0]);
    cubenspeak("joist",      joist,       [c+studwalk*2-studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*2+studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*3-studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*4-studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*5-studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*6-studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*6+studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*7+studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*8+studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*9+studw,    0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*10-studw,   0,                  0]);
    cubenspeak("joist",      joist,       [c+studwalk*10+studw,   0,                  0]);
    cubenspeak("crossjoist", crossjoist,  [c+studwalk*10+studw*2, shortjoisty-joistw, 0]);
    cubenspeak("shortjoist", shortjoist,  [floorx-studh-studw,    shortjoisty,        0]);
    cubenspeak("shortjoist", shortjoist,  [c+studwalk*11-studw,   shortjoisty,        0]);
  }}
}



colors = [
  "#f29e4c",
  "#f1c453",
  "#efea5a",
  "#b9e769",
  "#83e377",
  "#16db93",
  "#0db39e",
  "#048ba8",
  "#2c699a",
  "#54478c"
];

// D R A W
piers      (colors[0]);
floorbeams (colors[1]);
dirtceiling(colors[4]);
floorjoists(colors[3]);
subfloor   (colors[2]);
northwall  (colors[5]);
southwall  (colors[7]);
eastwall   (colors[6]);
westwall   (colors[8]);
loft       (colors[9]);
