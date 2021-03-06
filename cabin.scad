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

function ft(feet = 0, inches = 0) = 12*feet + inches;
function greaterof(a, b) = a > b ? a : b;
function lesserof(a, b)  = a > b ? b : a;
function middleof(a, b, c) = (
  (a <= b) && (b <= c) ? b :
  (a <= c) && (c <= b) ? c :
  (b <= a) && (a <= c) ? a :
  (b <= c) && (c <= a) ? c :
  (c <= a) && (a <= b) ? a : b
);
module cubenspeak(name = "board", cuboid = [0,0,0], transtep = [0,0,0]) {
  sortedcuboid = [
    lesserof(lesserof(cuboid[0], cuboid[1]), lesserof(cuboid[0], cuboid[2])),
    middleof(cuboid[0], cuboid[1], cuboid[2]),
    greaterof(greaterof(cuboid[0], cuboid[1]), greaterof(cuboid[0], cuboid[2]))
  ];
  echo(name, sortedcuboid, transtep);
  translate(transtep) {
    cube(cuboid);
  }
}
module polyspeak(name, points, index, transtep = [0,0,0]) {
  echo(name);
  echo(points);
  echo(index);
  echo(transtep);
  translate(transtep) {
    polyhedron(points, index, 10);
  }
}

floorx = ft(16); // from outside edge to outside edge
floory = ft(10); // from outside edge to outside edge

module piers(color) {
  echo();
  echo("PIERS");
  pierw  = 12;
  pierh = ft(2);
  origin = [0, 0, -pierh];
  echo(origin = origin);
  pier = [pierw, pierw, pierh];
  pierspacingx = (floorx-pierw)/2;
  translate(origin) { color(color) {
    cubenspeak("pier", pier);
    cubenspeak("pier", pier, [pierspacingx,   0,            0]);
    cubenspeak("pier", pier, [pierspacingx*2, 0,            0]);
    cubenspeak("pier", pier, [0,              floory-pierw, 0]);
    cubenspeak("pier", pier, [pierspacingx,   floory-pierw, 0]);
    cubenspeak("pier", pier, [pierspacingx*2, floory-pierw, 0]);
  }}
}


joistboard = b2x8;
joistw     = joistboard[0];
joisth     = joistboard[1];
studboard  = b2x4;
studw      = studboard[0];
studh      = studboard[1];
studwalk   = 16;

floorjoistelev = 0;
floorjoistrise = b2x8[1];
module floorjoists(color) {
  echo();
  echo("FLOOR JOISTS");
  origin = [0, 0, floorjoistelev];
  echo(origin = origin);
  beamboard  = b2x8;
  capboard   = b2x8;
  beamw      = beamboard[0];
  beamh      = beamboard[1];
  capw       = capboard[0];
  caph       = capboard[1];
  joist      = [joistw, floory-capw*6, joisth];
  beam0      = [beamw, floory, beamh];
  beam1      = [beamw, floory-beamw*2, beamh];
  beam2      = [beamw, floory-beamw*4, beamh];
  cap0       = [floorx-beamw*2, capw, caph];
  cap1       = [floorx-beamw*4, capw, caph];
  cap2       = [floorx-beamw*6, capw, caph];
  studwalk   = 16;
  O          = -joistw/2;
  translate(origin) { color(color) {
    cubenspeak("beam",  beam0);
    cubenspeak("beam",  beam1, [beamw,          capw,          0]);
    cubenspeak("beam",  beam2, [beamw*2,        capw*2,        0]);
    cubenspeak("joist", joist, [O+studwalk,     capw*3,        0]);
    cubenspeak("joist", joist, [O+studwalk*2,   capw*3,        0]);
    cubenspeak("joist", joist, [O+studwalk*3,   capw*3,        0]);
    cubenspeak("joist", joist, [O+studwalk*4,   capw*3,        0]);
    cubenspeak("joist", joist, [O+studwalk*5,   capw*3,        0]);
    cubenspeak("joist", joist, [O+studwalk*6,   capw*3,        0]);
    cubenspeak("joist", joist, [O+studwalk*7,   capw*3,        0]);
    cubenspeak("joist", joist, [O+studwalk*8,   capw*3,        0]);
    cubenspeak("joist", joist, [O+studwalk*9,   capw*3,        0]);
    cubenspeak("joist", joist, [O+studwalk*10,  capw*3,        0]);
    cubenspeak("joist", joist, [O+studwalk*11,  capw*3,        0]);
    cubenspeak("beam",  beam2, [floorx-beamw*3, capw*2,        0]);
    cubenspeak("beam",  beam1, [floorx-beamw*2, capw,          0]);
    cubenspeak("beam",  beam0, [floorx-beamw,   0,             0]);
    cubenspeak("cap",   cap0,  [beamw,          0,             0]);
    cubenspeak("cap",   cap1,  [beamw*2,        capw,          0]);
    cubenspeak("cap",   cap2,  [beamw*3,        capw*2,        0]);
    cubenspeak("cap",   cap2,  [beamw*3,        floory-capw*3, 0]);
    cubenspeak("cap",   cap1,  [beamw*2,        floory-capw*2, 0]);
    cubenspeak("cap",   cap0,  [beamw,          floory-capw,   0]);
  }}
}


wallelev          = floorjoistelev + floorjoistrise;;
tallstudl         = ft(12);
doorroughopenw    = 38.25;
doorroughopenh    = 82;
lwindowroughopenw = 24;
lwindowroughopenh = 36;
uwindowroughopenw = 32;
uwindowroughopenh = 16;
headerboard       = b4x6;
headerboardw      = headerboard[0];
headerboardh      = headerboard[1];
c                 = -studw/2; // for centering north and south walls
windowdrop        = 8;
loftelev          = doorroughopenh + headerboardh;
headerz           = loftelev - headerboardh - windowdrop;
sillz             = headerz - lwindowroughopenh - studw - windowdrop;
lsillx            = studwalk*3 - studw - lwindowroughopenw; // on south wall
silly             = studwalk*3+studw*2;
s                 = (floory - studh*2 - studw*2 - studwalk*6)/2 + studw/2;
studelev          = wallelev + studw;
intsheatht        = 0.5;
upperfloorportdim = [studwalk*3-joistw*2-c-studw, studwalk*2+studh+s-studw];


module northwall(color) {
  echo();
  echo("NORTH WALL");
  origin = [0, 0, studelev];
  echo(origin = origin);
  soleplate       = [floorx, studh, studw];
  topplate0       = [floorx, studh, studw];
  topplate1       = [floorx-studh*2, studh, studw];
  tallstud        = [studw, studh, tallstudl];
  sidestud        = [studh, studw, tallstudl];
  trimmer         = [studw, studh, doorroughopenh];
  thicktrimmer    = [studh, studh, doorroughopenh];
  thicktrimmerw   = thicktrimmer[0];
  trimmerw        = trimmer[0];
  cripple         = [studw, studh, tallstudl-loftelev];
  doorhingebeamx  = studwalk*11 - thicktrimmerw;
  astudx          = doorhingebeamx - doorroughopenw - trimmerw;
  headerx         = studwalk*8 + studw;
  header          = [studwalk*3 - studw, headerboardw, headerboardh];
  translate(origin) { color(color) {
    cubenspeak("soleplate",    soleplate,    [0,                    0, -studw]);
    cubenspeak("tallstud",     tallstud);
    cubenspeak("sidestud",     sidestud,     [studw,                studh-studw, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk,           0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*2,         0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*3,         0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*4,         0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*5,         0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*6,         0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*7,         0, 0]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*8,         0, 0]);
    cubenspeak("trimmer",      trimmer,      [c+studwalk*8+studw,   0, 0]);
    cubenspeak("trimmer",      trimmer,      [c+astudx,             0, 0]);
    cubenspeak("thicktrimmer", thicktrimmer, [c+doorhingebeamx,     0, 0]);
    cubenspeak("header",       header,       [c+headerx,            0, doorroughopenh]);
    cubenspeak("cripple",      cripple,      [c+studwalk*9,         0, loftelev]);
    cubenspeak("cripple",      cripple,      [c+studwalk*10,        0, loftelev]);
    cubenspeak("tallstud",     tallstud,     [c+studwalk*11,        0, 0]);
    cubenspeak("tallstud",     tallstud,     [floorx-studw,         0, 0]);
    cubenspeak("sidestud",     sidestud,     [floorx-studw-studh,   studh-studw, 0]);
    cubenspeak("topplate0",    topplate0,    [0,                    0, tallstudl]);
    cubenspeak("topplate1",    topplate1,    [studh,                0, tallstudl+studw]);
  }}
}

module southwall(color) {
  echo();
  echo("SOUTH WALL");
  origin = [0, floory-studh, studelev];
  echo(origin = origin);
  soleplate       = [floorx, studh, studw];
  topplate0       = [floorx, studh, studw];
  topplate1       = [floorx-studh*2, studh, studw];
  tallstud        = [studw, studh, tallstudl];
  sidestud        = [studh, studw, tallstudl];
  trimmer         = [studw, studh, doorroughopenh-windowdrop];
  highcripple     = [studw, studh, tallstudl-loftelev+windowdrop];
  lheaderx        = studwalk + studw;
  header          = [studwalk*2 - studw, headerboardw, headerboardh];
  sill            = [lwindowroughopenw, studh, studw];
  rsillx          = studwalk*9+studw*2;
  lowcripple      = [studw, studh, sillz];
  lwindowastudx   = studwalk*3 - studw*2 - lwindowroughopenw;
  rwindowastudx   = studwalk*9 + studw*2 + lwindowroughopenw;
  translate(origin) { color(color) {
    cubenspeak("soleplate",   soleplate,   [0,                        0, -studw]);
    cubenspeak("tallstud",    tallstud,    [0,                        0,0]);
    cubenspeak("sidestud",    sidestud,    [studw,                    0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk,               0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+studwalk + studw,       0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+lwindowastudx,          0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+lwindowastudx+studw,    0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+studwalk*2,             0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+studwalk*3-studw*2,     0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+studwalk*3-studw,       0, 0]);
    cubenspeak("sill",        sill,        [c+lsillx,                 0, sillz]);
    cubenspeak("header",      header,      [c+studwalk + studw,       0, headerz]);
    cubenspeak("highcripple", highcripple, [c+studwalk*2,             0, loftelev-windowdrop]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*3,             0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*4,             0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*5,             0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*6,             0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*7,             0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*8,             0, 0]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*9,             0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+studwalk*9+studw,       0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+rsillx,                 0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+studwalk*10,            0, 0]);
    cubenspeak("lowcripple",  lowcripple,  [c+rwindowastudx-studw,    0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+rwindowastudx,          0, 0]);
    cubenspeak("trimmer",     trimmer,     [c+studwalk*11-studw,      0, 0]);
    cubenspeak("sill",        sill,        [c+rsillx,                 0, sillz]);
    cubenspeak("header",      header,      [c+studwalk*9+studw,       0, headerz]);
    cubenspeak("highcripple", highcripple, [c+studwalk*10,            0, loftelev-windowdrop]);
    cubenspeak("tallstud",    tallstud,    [c+studwalk*11,            0, 0]);
    cubenspeak("tallstud",    tallstud,    [floorx-studw,             0,0]);
    cubenspeak("sidestud",    sidestud,    [floorx-studw-studh,       0, 0]);
    cubenspeak("topplate0",   topplate0,   [0,                        0, tallstudl]);
    cubenspeak("topplate0",   topplate1,   [studh,                    0, tallstudl+studw]);
  }}
}

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
  highcripple = [studh, studw, tallstudl-loftelev+windowdrop];
  header      = [headerboardw, studwalk*2 - studw, headerboardh];
  sill        = [studh, lwindowroughopenw, studw];
  echo(s=s);
  translate(origin) { color(color) {
    cubenspeak("soleplate",   soleplate,   [0, 0,                    -studw]);
    cubenspeak("tallstud",    tallstud,    [0, 0,                    0]);
    cubenspeak("tallstud",    tallstud,    [0, s,                    0]);
    cubenspeak("tallstud",    tallstud,    [0, s+studwalk,           0]);
    cubenspeak("tallstud",    tallstud,    [0, s+studwalk*2,         0]);
    cubenspeak("tallstud",    tallstud,    [0, s+studwalk*3,         0]);
    cubenspeak("trimmer",     trimmer,     [0, s+studwalk*3+studw,   0]);
    cubenspeak("lowcripple",  lowcripple,  [0, s+studwalk*3+studw*2, 0]);
    cubenspeak("lowcripple",  lowcripple,  [0, s+studwalk*4,         0]);
    cubenspeak("lowcripple",  lowcripple,  [0, s+studwalk*3+lwindowroughopenw+studw,   0]);
    cubenspeak("trimmer",     trimmer,     [0, s+studwalk*3+lwindowroughopenw+studw*2, 0]);
    cubenspeak("trimmer",     trimmer,     [0, s+studwalk*5-studw,   0]);
    cubenspeak("sill",        sill,        [0, s+silly,              sillz]);
    cubenspeak("header",      header,      [0, s+studwalk*3+studw,   headerz]);
    cubenspeak("highcripple", highcripple, [0, s+studwalk*4,         loftelev-windowdrop]);
    cubenspeak("tallstud",    tallstud,    [0, s+studwalk*5,         0]);
    cubenspeak("tallstud",    tallstud,    [0, s+studwalk*6,         0]);
    cubenspeak("tallstud",    tallstud,    [0, soleplatel-studw,     0]);
    cubenspeak("topplate",    topplate,    [0, 0,                    tallstudl]);
  }}
}
module eastwall(color) {
  smallwall(color, "EAST WALL");
}
module westwall(color) {
  translate([floorx-studh, 0, 0]) {
    smallwall(color, "WEST WALL");
  }
}

module loft(color) {
  echo();
  echo("LOFT");
  origin = [0, 0, studelev+loftelev];
  echo(origin = origin);
  tallstud    = [studw, studh, tallstudl];
  joistw      = joistboard[0];
  joisth      = joistboard[1];
  joistl      = floory - studh*2 - joistw*2;
  joist       = [joistw, joistl, joisth];
  joisty      = studh + joistw;
  shortjoisty = studh + s + studwalk*2;
  shortjoist  = [joistboard[0], floory-shortjoisty-studh-joistw, joistboard[1]];
  rimjoist    = [floorx-studh*2, joistw, joisth];
  echo(shortjoisty=shortjoisty);
  crossjoist  = [studwalk*3-joistw*2-c, joistw, joisth];
  translate(origin) { color(color) {
    cubenspeak("rimjoist",   rimjoist,    [studh,                studh,               0]);
    cubenspeak("rimjoist",   rimjoist,    [studh,                floory-studh-joistw, 0]);
    cubenspeak("joist",      joist,       [studh,                joisty,              0]);
    cubenspeak("joist",      joist,       [c+studwalk,           joisty,              0]);
    cubenspeak("joist",      joist,       [c+studwalk*2,         joisty,              0]);
    cubenspeak("joist",      joist,       [c+studwalk*3,         joisty,              0]);
    cubenspeak("joist",      joist,       [c+studwalk*4,         joisty,              0]);
    cubenspeak("joist",      joist,       [c+studwalk*5,         joisty,              0]);
    cubenspeak("joist",      joist,       [c+studwalk*6,         joisty,              0]);
    cubenspeak("joist",      joist,       [c+studwalk*7,         joisty,              0]);
    cubenspeak("joist",      joist,       [c+studwalk*8,         joisty,              0]);
    cubenspeak("joist",      joist,       [c+studwalk*9,         joisty,              0]);
    cubenspeak("joist",      joist,       [c+studwalk*9+joistw,  joisty,              0]);
    cubenspeak("crossjoist", crossjoist,  [c+studwalk*9+studw*2, shortjoisty-joistw,  0]);
    cubenspeak("shortjoist", shortjoist,  [c+studwalk*10,        shortjoisty,         0]);
    cubenspeak("shortjoist", shortjoist,  [c+studwalk*11,        shortjoisty,         0]);
    cubenspeak("shortjoist", shortjoist,  [floorx-studh-studw,   shortjoisty,         0]);
  }}
}

wallpanelthickness = 1/2;
floorthickness     = 1/2;

module ladder(color) {
  echo();
  echo("LADDER");
  origin = [0, 0, studelev];
  echo(origin = origin);
  legboard  = b2x4;
  legboardw = legboard[0];
  legboardh = legboard[1];
  legheight = ft(13);
  rungboard  = b2x4;
  rungboardw = rungboard[0];
  rungboardh = rungboard[1];
  rungl      = ft(2);
  leg = [legboardh, legboardw, legheight];
  legx = floorx - studh - legboardh - wallpanelthickness;
  legyl = upperfloorportdim[1] - legboardw;
  legyr = upperfloorportdim[1] - rungl;
  rung = [rungboardw, rungl, rungboardh];
  rungx = legx - rungboardw;
  rungy = legyr;
  rungwalk = 12;
  translate(origin) { color(color) {
    cubenspeak("leg",  leg,   [legx,  legyl, 0]);
    cubenspeak("leg",  leg,   [legx,  legyr, 0]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk  -rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*2-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*3-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*4-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*5-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*6-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*7-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*8-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*9-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*10-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*11-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*12-rungboardh]);
    cubenspeak("rung", rung,  [rungx, rungy, rungwalk*13-rungboardh]);
  }}
}

gableelv         = studelev + tallstudl + studw;
ridgeboardboard  = b1x8;
braceplateboard  = studboard;
braceplateboardw = braceplateboard[0];
braceplateboardh = braceplateboard[1];
braceplateendw   = sqrt(2*braceplateboardw*braceplateboardw);
ridgeboardw      = ridgeboardboard[0];
ridgeboardh      = ridgeboardboard[1];
ridgeboardy      = floory/2 - ridgeboardw/2;
ridgeboardz      = ridgeboardy - studh - braceplateendw;

module gable(color, name) {
  echo();
  echo(name);
  origin = [0, 0, gableelv+studw];
  echo(origin = origin);
  soleplate = [studh, floory, studw];
  braceplatelegl   = ridgeboardy - studh;
  braceplateside = [
    [0,braceplatelegl,braceplatelegl],
    [0,braceplatelegl,braceplatelegl-braceplateendw],
    [0,braceplateendw,0],
    [0,0,0]
  ];
  braceplate = [
    braceplateside[0],braceplateside[1],braceplateside[2],braceplateside[3],
    [studh, braceplateside[0][1], braceplateside[0][2]],
    [studh, braceplateside[1][1], braceplateside[1][2]],
    [studh, braceplateside[2][1], braceplateside[2][2]],
    [studh, braceplateside[3][1], braceplateside[3][2]]
  ];
  braceplatefaces = [[0,1,2,3],[4,5,6,7],[0,4,7,3],[1,5,6,2],[0,4,5,1],[2,6,7,3]];
  windowelev   = 12;
  sill   = [studh, uwindowroughopenw, studw];
  sillz  = windowelev-studw;
  windowy      = (floory - uwindowroughopenw)/2;
  headerboard  = b4x4;
  headerh      = headerboard[1];
  windowheader = [headerboard[0], uwindowroughopenw+studw*2, headerh];
  headerz      = windowelev+studw+uwindowroughopenh;
  headerside = [
    [0, floory-studh-braceplateendw-headerz-headerh, headerz+headerh],
    [0,        studh+braceplateendw+headerz+headerh, headerz+headerh],
    [0,        studh+braceplateendw+headerz,         headerz],
    [0, floory-studh-braceplateendw-headerz,         headerz]
  ];
  header = [
    headerside[0], headerside[1], headerside[2], headerside[3],
    [studh, headerside[0][1], headerside[0][2]],
    [studh, headerside[1][1], headerside[1][2]],
    [studh, headerside[2][1], headerside[2][2]],
    [studh, headerside[3][1], headerside[3][2]]
  ];
  headerfaces = [[0,1,2,3],[4,5,6,7],[0,4,7,3],[1,5,6,2],[0,4,5,1],[2,6,7,3]];
  ridgesupport = [studh, studh, ridgeboardz-headerh-headerz];
  studadjust = 3/4;
  translate(origin) { color(color) {
    cubenspeak("soleplate",   soleplate,   [0, 0, -studw]);
    polyspeak("braceplate", braceplate, braceplatefaces, [0,studh,0]);
    translate([studh,floory,0]) { rotate([0,0,180]) {
      polyspeak("braceplate", braceplate, braceplatefaces, [0,studh,0]);
    }}
    cubenspeak("stud",    [studh, studw, windowy-studwalk*2-studh-braceplateendw+studadjust], [0, windowy-studw-studwalk*2+studadjust, 0]);
    cubenspeak("stud",    [studh, studw, windowy-studwalk-studh-braceplateendw+studadjust], [0, windowy-studw-studwalk+studadjust, 0]);
    polyspeak("header",   header, headerfaces, [0, 0, 0]);
    cubenspeak("sill",    sill,                     [0, windowy, sillz]);
    cubenspeak("trimmer", [studh, studw, headerz],  [0, windowy-studw, 0]);
    cubenspeak("cripple", [studh, studw, sillz],    [0, windowy, 0]);
    cubenspeak("cripple", [studh, studw, sillz],    [0, windowy+uwindowroughopenw/2-studw/2, 0]);
    cubenspeak("cripple", [studh, studw, sillz],    [0, windowy+uwindowroughopenw-studw, 0]);
    cubenspeak("trimmer", [studh, studw, headerz],  [0, windowy+uwindowroughopenw, 0]);
    cubenspeak("stud",    [studh, studw, floory-studh-braceplateendw-windowy-uwindowroughopenw-studwalk+studadjust],   [0, windowy+uwindowroughopenw+studwalk-studadjust,   0]);
    cubenspeak("stud",    [studh, studw, floory-studh-braceplateendw-windowy-uwindowroughopenw-studwalk*2+studadjust], [0, windowy+uwindowroughopenw+studwalk*2-studadjust, 0]);
    cubenspeak("ridge support", ridgesupport,  [0, floory/2-studh/2, headerz+headerh]);
  }}
}

module eastgable(color) {
  gable(color, "EAST GABLE");
}
module westgable(color) {
  translate([floorx-studh, 0, 0]) {
    gable(color, "WEST GABLE");
  }
}

module ridgeboard(color) {
  echo();
  echo("RIDGEBOARD");
  origin = [0, 0, gableelv+studw];
  echo(origin = origin);
  ridgeboardext    = 12;
  ridgeboardl      = floorx + ridgeboardext*2;
  ridgeboard       = [ridgeboardl, ridgeboardw, ridgeboardh];
  translate(origin) { color(color) {
    cubenspeak("ridgeboard",   ridgeboard,   [-ridgeboardext, ridgeboardy, ridgeboardz]);
  }}
}


module roof(color) {
  echo();
  echo("ROOF");
  origin = [0, 0, gableelv+studw];
  echo(origin = origin);
  rafterboard  = b1x6;
  rafterboardw = rafterboard[0];
  rafterboardh = rafterboard[1];
  rafterendw   = sqrt(rafterboardh*rafterboardh*2);
  roofext      = 48;
  //rafterside = [
  ///*  0    7   */ [0, ridgeboardy, ridgeboardy-studh+rafterendw],
  ///*  1    8   */ [0, ridgeboardy, ridgeboardy-studh],
  ///* 2 3  9 10 */      [0, studh, 0], [0, 0, 0],
  ///*  4    11  */                     [0, 0, -studh],
  ///*  5    12  */                                     [0,-roofext,-roofext-studh+rafterendw],
  ///*  6    13  */                                     [0,-roofext,-roofext-studh]
  //];

  rafterside = [
  /*  0    7   */ [0, ridgeboardy, ridgeboardy-studh+rafterendw],
  /*  1    8   */ [0, ridgeboardy, ridgeboardy-studh],
  /* 2 3  9 10 */      [0, studh, 0], [0, 0, 0],
  /*  4    11  */                     [0, 0, -studh],
  /*  5    12  */                                     [0,-roofext,-roofext-studh+rafterendw],
  /*  6    13  */                                     [0,-roofext,-roofext-studh]
  ];
  rafter = [
    rafterside[0],rafterside[1],rafterside[2],rafterside[3],rafterside[4],rafterside[5],rafterside[6],
    [rafterboardw, rafterside[0][1], rafterside[0][2]],
    [rafterboardw, rafterside[1][1], rafterside[1][2]],
    [rafterboardw, rafterside[2][1], rafterside[2][2]],
    [rafterboardw, rafterside[3][1], rafterside[3][2]],
    [rafterboardw, rafterside[4][1], rafterside[4][2]],
    [rafterboardw, rafterside[5][1], rafterside[5][2]],
    [rafterboardw, rafterside[6][1], rafterside[6][2]]
  ];
  rafterfaces = [
    [0, 1, 2, 3, 4, 6, 5],
    [7, 8, 9,10,11,13,12],
    [0, 7, 8, 1],
    [1, 8, 9, 2],
    [2, 9,10, 3],
    [3,10,11, 4],
    [4,11,13, 6],
    [5,12,13, 6],
    [0, 7,13, 6]
  ];
  translate(origin) { //color(color) {
    ///
    ///
    ///
    //raftersidefaces = [[0,1,2,3,4,6,5]];
    //color("red") polyspeak("rafterside", rafterside, raftersidefaces, [0,0,0]);
    ///
    ///
    ///

    color("red") polyspeak("rafter", rafter, rafterfaces, [0,0,0]);
    translate([rafterboardw,floory,0]) { rotate([0,0,180]) {
      color("lime") polyspeak("rafter", rafter, rafterfaces, [0,0,0]);
    }}

  }//}
}

module bed(color) {
  echo();
  echo("bed");
  origin = [0, 0, studelev+loftelev+joistboard[1]+floorthicknes];
  echo(origin = origin);
  bedw = 54;
  bedl = 75;
  supportboard = b2x8;
  platboard = b1x4;
  supportboardw = supportboard[0];
  supportboardh = supportboard[1];
  platboardw    = platboard[0];
  platboardh    = platboard[1];
  mattresselev  = supportboardh+platboardw;
  mattressthickness = 8;
  support    = [supportboardw, bedw, supportboardh];
  plat       = [bedl, platboardh, platboardw];
  mattress   = [bedl, bedw, mattressthickness];
  shearboard = [bedl, b1x6[0], b1x6[1]];
  supportcount = 5;
  platcount = 13;
  bedy = studh + 1;
  bedx = studh + 1;
  translate(origin) { color(color) {
    for (i = [0:supportcount-2]) {
      x = bedx + i*((bedl-supportboardw)/(supportcount-1));
      cubenspeak("support", support, [x, bedy, 0]);
    }
    cubenspeak("support", support, [studh+1+bedl-supportboardw, bedy, 0]);
    for (i = [0:platcount-2]) {
      y = bedy + i*((bedw-platboardh)/(platcount-1));
      cubenspeak("plat", plat, [bedx, y, supportboardh]);
    }
    cubenspeak("plat", plat, [bedx, bedy+bedw-platboardh, supportboardh]);
    cubenspeak("mattress", mattress, [bedx, bedy, supportboardh+platboardw]);
    cubenspeak("shearboard", shearboard, [bedx, bedy-shearboard[1], 1]);
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
piers     (colors[0]);
floorjoists(colors[2]);
*northwall  (colors[5]);
*southwall  (colors[7]);
*eastwall   (colors[6]);
*westwall   (colors[8]);
loft       (colors[9]);
ladder     ("salmon");
bed        ("navy");
*eastgable  (colors[6]);
*westgable  (colors[8]);
*ridgeboard (colors[1]);
roof       (colors[3]);

lowerfloordim     = [floorx-studh, floory-studh];
lowerfloorarea    = lowerfloordim[0]*lowerfloordim[1];
upperfloorarea    = lowerfloorarea - upperfloorportdim[0]*upperfloorportdim[1];
totalfloorarea    = lowerfloorarea + upperfloorarea;
lowerheadroom     = loftelev+studw;
floorthicknes     = 1;
upperwallheight   = tallstudl - loftelev - joisth - floorthicknes;
upperheadroom     = upperwallheight + lowerfloordim[1]/2;
windowarea        = lwindowroughopenw*lwindowroughopenh*4 + uwindowroughopenw*uwindowroughopenh*2;
doorarea          = doorroughopenw*doorroughopenh;
totalintwallarea  = lowerfloordim[0]*tallstudl*2 + lowerfloordim[1]*tallstudl*2 + (lowerfloordim[1]*lowerfloordim[1])/2 - windowarea - doorarea;
totalsidingarea   = floorx*tallstudl*2 + floory*tallstudl*2 + (floory*floory)/2 - windowarea - doorarea;
totalroofarea     = 0;

echo("");
echo(str("lower floor space: ", lowerfloordim[0], " by ", lowerfloordim[1]));
echo(str("port size        : ", upperfloorportdim[0], " by ", upperfloorportdim[1]));
echo(str("lowerfloorarea   : ", lowerfloorarea, " in2, or ", lowerfloorarea/144, " ft2"));
echo(str("upperfloorarea   : ", upperfloorarea, " in2, or ", upperfloorarea/144, " ft2"));
echo(str("totalfloorarea   : ", totalfloorarea, " in2, or ", totalfloorarea/144, " ft2"));
echo(str("lowerheadroom    : ", lowerheadroom, " in, or ", lowerheadroom/12, " ft"));
echo(str("floorthicknes    : ", floorthicknes, " in"));
echo(str("upperwallheight  : ", upperwallheight, " in, or ", upperwallheight/12, " ft"));
echo(str("upperheadroom    : ", upperheadroom, " in, or ", upperheadroom/12, " ft"));
echo(str("totalintwallarea : ", totalintwallarea, " in2, or ", totalintwallarea/144, " ft2"));
echo(str("totalsidingarea  : ", totalsidingarea, " in2, or ", totalsidingarea/144, " ft2"));
echo(str("totalroofarea    : ", totalroofarea, " in2, or ", totalroofarea/144, " ft2"));
