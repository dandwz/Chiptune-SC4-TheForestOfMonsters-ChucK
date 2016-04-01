/*
==============================
Title: The forest of monsters 
Composed by KONAMI

Arranged and programmed by
Daniel Daowz
==============================
*/

//=====================
// Classes
//=====================
// Methods: NoteOn
//          volume

class SnareGen extends Chubgraph {

  Gain SnareGain => outlet;
  Noise noiseLay1 => ResonZ filt1 => ADSR SnareADLay1 => Gain Lay1 => SnareGain; 
  Noise noiseLay2 => ResonZ filt2 => ADSR SnareADLay2 => Gain Lay2 => SnareGain;

  //Default settings
  4 => filt1.Q;
  4 => filt2.Q;
  1000 => filt1.freq;
  SnareADLay1.set(3::ms, 5::ms, 0.6, 50::ms);
  SnareADLay2.set(5::ms, 5::ms, 1, 20::ms);
  0.5 => noiseLay1.gain;
  1 => noiseLay2.gain;
  0.8 => SnareGain.gain;

  fun void NoteOn (int IO){
    if (IO) {

      1 => SnareADLay1.keyOn;
      1 => SnareADLay2.keyOn;

      for (350 => int i; i > 20; i--){
	i => filt2.freq;
	0.3::ms => now;
      }
      1 => SnareADLay1.keyOff;
      1 => SnareADLay2.keyOff;
    }   
  }

  fun void volume (float volume){
    volume => SnareGain.gain;
  }
}

class HiTom extends Chubgraph {

  Gain HiTomGain => outlet;
  Noise NoiseLay => ResonZ Filt => ADSR NoiseADLay => Gain Lay1 => HiTomGain;
  TriOsc Gliss => ADSR GlissADLay => Gain Lay2 => HiTomGain;

  //Default Settings
  1 => Filt.Q;
  325 => Filt.freq;
  NoiseADLay.set(1::ms, 5::ms, 0.6, 50::ms);
  GlissADLay.set(1::ms, 1::ms, 1, 20::ms);
  0.5 => Lay2.gain;
  0.5 => HiTomGain.gain;

  fun void NoteOn (int IO){
    if (IO) {

      1 => NoiseADLay.keyOn;
      1 => GlissADLay.keyOn;

      for (280 => int i; i > 150; i--){
	i => Gliss.freq;
	0.7::ms => now;
      }
      1 => NoiseADLay.keyOff;
      1 => GlissADLay.keyOff;
    }   
  }

  fun void volume (float volume){
    volume => HiTomGain.gain;
  }
}

class LowTom extends Chubgraph {

  Gain LowTomGain => outlet;
  Noise NoiseLay => ResonZ Filt => ADSR NoiseADLay => Gain Lay1 => LowTomGain;
  TriOsc Gliss => ADSR GlissADLay => Gain Lay2 => LowTomGain;

  //Default Settings
  1 => Filt.Q;
  280 => Filt.freq;
  NoiseADLay.set(1::ms, 5::ms, 0.6, 50::ms);
  GlissADLay.set(1::ms, 1::ms, 1, 20::ms);
  0.5 => Lay2.gain;
  0.5 => LowTomGain.gain;

  fun void NoteOn (int IO){
    if (IO) {

      1 => NoiseADLay.keyOn;
      1 => GlissADLay.keyOn;

      for (200 => int i; i > 80; i--){
	i => Gliss.freq;
	0.7::ms => now;
      }
      1 => NoiseADLay.keyOff;
      1 => GlissADLay.keyOff;
    }   
  }

  fun void volume (float volume){
    volume => LowTomGain.gain;
  }
}

class BassDrum extends Chubgraph {

  Gain BassDrumGain => dac;
  Noise NoiseLay => ResonZ Filt => ADSR NoiseADLay => Gain Lay1 => BassDrumGain;
  TriOsc Gliss => ADSR GlissADLay => Gain Lay2 => BassDrumGain;

  //Default Settings
  1 => Filt.Q;
  150 => Filt.freq;
  NoiseADLay.set(1::ms, 5::ms, 0.6, 50::ms);
  GlissADLay.set(1::ms, 1::ms, 1, 20::ms);
  0.5 => Lay2.gain;
  0.5 => BassDrumGain.gain;

  fun void NoteOn (int IO){
    if (IO) {

      1 => NoiseADLay.keyOn;
      1 => GlissADLay.keyOn;

      for (80 => int i; i > 20; i--){
	i => Gliss.freq;
	0.7::ms => now;
      }
      1 => NoiseADLay.keyOff;
      1 => GlissADLay.keyOff;
    }   
  }

  fun void volume (float volume){
    volume => BassDrumGain.gain;
  }
}

//==================================
//Instruments declaration
//==================================

TriOsc Wind => ADSR TriADSR => Gain TriGain => dac;
SawOsc Bass => ADSR SawADSR => Gain SawGain => dac;

PulseOsc Organ => ADSR PulseADSR => Gain PulseGain => dac;
PulseOsc Organ2 => ADSR PulseADSR2 => Gain PulseGain2 => dac;

PulseOsc Oboe => ADSR OboeADSR => Gain OboeGain => dac;
PulseOsc Oboe2 => ADSR OboeADSR2 => Gain OboeGain2 => dac;

SawOsc Strings => ADSR StringsADSR => Gain StringsGain => dac;
PulseOsc StringsL => ADSR StringsADSRL => Gain StringsGainL => dac.left;
PulseOsc StringsR => ADSR StringsADSRR => Gain StringsGainR => dac.right;

SnareGen Snare => dac;
HiTom Tom1 => dac;
LowTom Tom2 => dac;
BassDrum Bombo => dac;

//=========================
//Default Settings
//=========================

TriADSR.set(500::ms, 400::ms, 0.6, 100::ms);
TriGain.gain(0.4);

SawADSR.set(30::ms, 30::ms, 0.3, 100::ms);
SawGain.gain(0.2);

PulseADSR.set(30::ms, 50::ms, 0.6, 100::ms);
PulseGain.gain(0.05);
Organ.width(0.4);

PulseADSR2.set(30::ms, 50::ms, 0.6, 100::ms);
PulseGain2.gain(0.02);
Organ2.width(0.2);

// Oboe
OboeADSR.set(300::ms, 300::ms, 0.6, 100::ms);
OboeGain.gain(0.08);
Oboe.width(0.25);

OboeADSR2.set(300::ms, 300::ms, 0.6, 100::ms);
OboeGain2.gain(0.03);
Oboe2.width(0.4);

// Strings
StringsADSR.set(300::ms, 300::ms, 0.6, 100::ms);
StringsGain.gain(0.09);

StringsADSRL.set(3000::ms, 300::ms, 0.6, 100::ms);
StringsGainL.gain(0.04);
StringsL.width(0.15);

StringsADSRR.set(3000::ms, 300::ms, 0.6, 100::ms);
StringsGainR.gain(0.04);
StringsR.width(0.1);

//====================
//MIDI Notes
//====================

24 => int c1;   36 => int c2;    48 => int c3;      60 => int c4;     72 => int c5;     84 => int c6;       96 => int c7;       108 => int c8;
25 => int cis1; 37 => int cis2;  49 => int cis3;    61 => int cis4;   73 => int cis5;   85 => int cis6;     97 => int cis7;     109 => int cis8;
26 => int d1;   38 => int d2;    50 => int d3;      62 => int d4;     74 => int d5;     86 => int d6;       98 => int d7;       110 => int d8;
27 => int dis1; 39 => int dis2;  51 => int dis3;    63 => int dis4;   75 => int dis5;   87 => int dis6;     99 => int dis7;     111 => int dis8;
28 => int e1;   40 => int e2;    52 => int e3;      64 => int e4;     76 => int e5;     88 => int e6;       100 => int e7;      112 => int e8;
29 => int f1;   41 => int f2;    53 => int f3;      65 => int f4;     77 => int f5;     89 => int f6;       101 => int f7;      113 => int f8;
30 => int fis1; 42 => int fis2;  54 => int fis3;    66 => int fis4;   78 => int fis5;   90 => int fis6;     102 => int fis7;    114 => int fis8;
31 => int g1;   43 => int g2;    55 => int g3;      67 => int g4;     79 => int g5;     91 => int g6;       103 => int g7;      115 => int g8;
32 => int gis1; 44 => int gis2;  56 => int gis3;    68 => int gis4;   80 => int gis5;   92 => int gis6;     104 => int gis7;    116 => int gis8;
33 => int a1;   45 => int a2;    57 => int a3;      69 => int a4;     81 => int a5;     93 => int a6;       105 => int a7;      117 => int a8;
34 => int ais1; 46 => int ais2;  58 => int ais3;    70 => int ais4;   82 => int ais5;   94 => int ais6;     106 => int ais7;    118 => int ais8;
35 => int b1;   47 => int b2;    59 => int b3;      71 => int b4;     83 => int b5;     95 => int b6;       107 => int b7;      119 => int b8;
0 => int r; // Rest

//==================================
//Tempo
//==================================
// It doesn't matter the number attached to the int as long as every one has it's own unique value.

100 => int tempo;

1  => int t1;   // Whole
2  => int t2;   // Half
4  => int t4;   // Quarter
8  => int t8;   // Eight
16 => int t16;  // 16th
32 => int t32;  // 32th

3  => int t2d;  // Dotted half
5  => int t4d;  // Dotted quarter
9  => int t8d;  // Dotted eigth
10 => int t1d;  // Dottd Whole

1111 => int t2t8;     // Half + Eight
3333 => int t2t16;    // Half + 16th
2222 => int t4t;      // Quarter Triplets
4444 => int t1t2d;    // Whole + Half dotted
5555 => int t1t1;     // Whole + Whole
6666 => int t2t4dt16; // Half + Quarter dotted + 16th
7777 => int t2dt16;   // Half dotted + 16th
8888 => int t4dt16;   // Quarter dotted + 16th
9999 => int t1t2dt8d; // Whole + Half dotted + eight dotted

fun dur duration(int figure) {
    if (figure == t2d )
        return duration(t2) + duration(t4);
    else if (figure == t4d)
        return duration(t4) + duration(t8);
    else if (figure == t8d)
        return duration(t8) + duration(t16);
    else if (figure == t1d)
      return duration(t1) + duration(t2);
    else if (figure == t2t8)
        return duration(t2) + duration(t8);
    else if (figure == t4t)
        return duration(t2)/3;
    else if (figure == t2t16)
        return duration(t2) + duration(t16);
    else if (figure == t1t2d)
      return duration(t1) + duration(t2d);
    else if (figure == t1t1)
      return duration(t1) * 2;
    else if (figure == t2t4dt16)
      return duration(t2) + duration(t4d) + duration(t16);
    else if (figure == t2dt16)
      return duration(t2d) + duration(t16);
    else if (figure == t4dt16)
      return duration(t4d) + duration (t16);
    else if (figure == t1t2dt8d)
      return duration(t1) + duration(t2d) + duration(t8d);
    else
        return 240000::ms / ( figure * tempo );
    // 60 sec / BPM  = BPM in seconds
    // BPM = tempo
    // All note values are considering the Whole note as a 4 beats note.
    // Therefore:
    // (4 * 60 sec) / (figure * tempo) = value in seconds of the given note rhythm.
}

//==============
//Score
//==============

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//Wind
[
 // Intro
 [0,t1],
 [0,t1],
 [f3,t1t2d], [ais3,t4], // This particular line is two bar long
 [a3, t1t2d],[c4,t4],  // This particular line is two bar long
 [gis3,t1t1],  // This particular line is two bar long
 [a3,t1t1],
 // A
 [f3,t1t2d], [ais3,t4], // This particular line is two bar long
 [a3, t1t2d],[c4,t4],  // This particular line is two bar long
 [gis3,t1t1],  // This particular line is two bar long
 [a3,t1t1],
 //B
 [f3,t1t2d], [ais3,t4], // This particular line is two bar long
 [a3, t1t2d],[c4,t4],  // This particular line is two bar long
 [g3,t1t1],  // This particular line is two bar long
 [a3,t1t1],
 //C
 [f3,t1t2d], [ais3,t4], // This particular line is two bar long
 [a3, t1t2d],[c4,t4],  // This particular line is two bar long
 [g3,t1t1],  // This particular line is two bar long
 [a3,t1t1],
 //D
 [0,t1],[0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],[0,t1]

 ] @=> int windScore[][];

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//Organ
[
 // Intro
 [0,t1],[0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],[0,t1],
 // A
 [g4,t16],[d5,t16],[g4,t16],[d5,t16],[c5,t16],[g4,t16],[d5,t16],[g4,t16],
 [d5,t16],[g4,t16],[c5,t16],[g4,t16],[e5,t16],[g4,t16],[d5,t16],[g4,t16],
 [g4,t16],[d5,t16],[g4,t16],[c5,t16],[g4,t16],[c5,t16],[g4,t16],[d5,t16],
 [g4,t16],[d5,t16],[g4,t8],[g4,t16],[c5,t16],[d5,t16],[g4,t16],
 [a4,t8],[e5,t16],[a4,t16],[d5,t16],[a4,t16],[e5,t16],[a4,t16],
 [e5,t16],[d5,t16],[a4,t16],[e5,t16],[a4,t16],[e5,t16],[d5,t16],[a4,t16],
 [e5,t16],[a4,t16],[d5,t16],[e5,t16],[a4,t16],[d5,t16],[e5,t16],[a4,t16],
 [e5,t16],[a4,t16],[d5,t16],[a4,t16],[e5,t16],[d5,t16],[a4,t16],[d5,t16],
 [c5,t8],[g5,t16],[c5,t16],[f5,t16],[c5,t16],[g5,t16],[c5,t16],
 [f5,t16],[g5,t16],[c5,t16],[f5,t16],[g5,t16],[c5,t16],[g5,t16],[c5,t16],
 [f5,t8],[g5,t16],[c5,t16],[f5,t16],[c5,t16],[g5,t16],[c5,t16],
 [f5,t16],[c5,t16],[g5,t16],[c5,t16],[f5,t16],[g5,t16],[c5,t16],[f5,t16],
 [g4,t16],[d5,t16],[g4,t16],[d5,t16],[c5,t16],[g4,t16],[d5,t16],[g4,t16],
 [d5,t16],[g4,t16],[c5,t16],[g4,t16],[e5,t16],[g4,t16],[d5,t16],[g4,t16],
 [g4,t16],[d5,t16],[g4,t16],[c5,t16],[g4,t16],[c5,t16],[g4,t16],[d5,t16],
 [g4,t16],[d5,t16],[g4,t16],[d5,t16],[g4,t16],[c5,t16],[d5,t16],[g5,t16],
 //B
 [0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],
 //C
 [0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],
 [g4,t16],[d5,t16],[g4,t16],[d5,t16],[c5,t16],[g4,t16],[d5,t16],[g4,t16],
 [d5,t16],[g4,t16],[c5,t16],[g4,t16],[e5,t16],[g4,t16],[d5,t16],[g4,t16],
 [g4,t16],[d5,t16],[g4,t16],[c5,t16],[g4,t16],[c5,t16],[g4,t16],[d5,t16],
 [g4,t16],[d5,t16],[g4,t16],[d5,t16],[a4,t16],[f5,t16],[e5,t16],[c4,t16],
 //D
 [a4,t16],[f5,t16],[e5,t16],[c4,t16],[0,t2d],
 [0,t1],[0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],
 [g4,t16],[d5,t16],[g4,t16],[d5,t16],[c5,t16],[g4,t16],[d5,t16],[g4,t16],
 [d5,t16],[g4,t16],[c5,t16],[g4,t16],[e5,t16],[g4,t16],[d5,t16],[g4,t16],
 [g4,t16],[d5,t16],[g4,t16],[c5,t16],[g4,t16],[c5,t16],[g4,t16],[d5,t16],
 [g4,t16],[d5,t16],[g4,t16],[d5,t16],[g4,t16],[c5,t16],[d5,t16],[g5,t16]

 ] @=> int organScore[][];

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//Organ2 (Echo)
[
 // Intro
 [0,t16],
 [0,t1],[0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],[0,t1],
 // A
 [g4,t16],[d5,t16],[g4,t16],[d5,t16],[c5,t16],[g4,t16],[d5,t16],[g4,t16],
 [d5,t16],[g4,t16],[c5,t16],[g4,t16],[e5,t16],[g4,t16],[d5,t16],[g4,t16],
 [g4,t16],[d5,t16],[g4,t16],[c5,t16],[g4,t16],[c5,t16],[g4,t16],[d5,t16],
 [g4,t16],[d5,t16],[g4,t8],[g4,t16],[c5,t16],[d5,t16],[g4,t16],
 [a4,t8],[e5,t16],[a4,t16],[d5,t16],[a4,t16],[e5,t16],[a4,t16],
 [e5,t16],[d5,t16],[a4,t16],[e5,t16],[a4,t16],[e5,t16],[d5,t16],[a4,t16],
 [e5,t16],[a4,t16],[d5,t16],[e5,t16],[a4,t16],[d5,t16],[e5,t16],[a4,t16],
 [e5,t16],[a4,t16],[d5,t16],[a4,t16],[e5,t16],[d5,t16],[a4,t16],[d5,t16],
 [c5,t8],[g5,t16],[c5,t16],[f5,t16],[c5,t16],[g5,t16],[c5,t16],
 [f5,t16],[g5,t16],[c5,t16],[f5,t16],[g5,t16],[c5,t16],[g5,t16],[c5,t16],
 [f5,t8],[g5,t16],[c5,t16],[f5,t16],[c5,t16],[g5,t16],[c5,t16],
 [f5,t16],[c5,t16],[g5,t16],[c5,t16],[f5,t16],[g5,t16],[c5,t16],[f5,t16],
 [g4,t16],[d5,t16],[g4,t16],[d5,t16],[c5,t16],[g4,t16],[d5,t16],[g4,t16],
 [d5,t16],[g4,t16],[c5,t16],[g4,t16],[e5,t16],[g4,t16],[d5,t16],[g4,t16],
 [g4,t16],[d5,t16],[g4,t16],[c5,t16],[g4,t16],[c5,t16],[g4,t16],[d5,t16],
 [g4,t16],[d5,t16],[g4,t16],[d5,t16],[g4,t16],[c5,t16],[d5,t16],[g5,t16],
 //B
 [0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],
 //C
 [0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],
 [g4,t16],[d5,t16],[g4,t16],[d5,t16],[c5,t16],[g4,t16],[d5,t16],[g4,t16],
 [d5,t16],[g4,t16],[c5,t16],[g4,t16],[e5,t16],[g4,t16],[d5,t16],[g4,t16],
 [g4,t16],[d5,t16],[g4,t16],[c5,t16],[g4,t16],[c5,t16],[g4,t16],[d5,t16],
 [g4,t16],[d5,t16],[g4,t16],[d5,t16],[a4,t16],[f5,t16],[e5,t16],[c4,t16],
 //D
 [a4,t16],[f5,t16],[e5,t16],[c4,t16],[0,t2d],
 [0,t1],[0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],
 [g4,t16],[d5,t16],[g4,t16],[d5,t16],[c5,t16],[g4,t16],[d5,t16],[g4,t16],
 [d5,t16],[g4,t16],[c5,t16],[g4,t16],[e5,t16],[g4,t16],[d5,t16],[g4,t16],
 [g4,t16],[d5,t16],[g4,t16],[c5,t16],[g4,t16],[c5,t16],[g4,t16],[d5,t16],
 [g4,t16],[d5,t16],[g4,t16],[d5,t16],[g4,t16],[c5,t16],[d5,t16],[r,t16]

 ] @=> int organ2Score[][];

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//Oboe
[
 //Intro
 [0,t1],[0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],[0,t1],
 //A
 [0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],
 //B
 [a3,t4],[b3,t4],[c4,t4],[e4,t8d],[d4,t2t4dt16],
 [a3,t16],[b3,t16],[c4,t1t1],
 [b3,t4],[c4,t4],[d4,t4],[e4,t8d],[d4,t2t4dt16],
 [a3,t16],[b3,t16],[c4,t1t1],
 //C
 [0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],
 //D
 [0,t4d],[a4,t16],[d5,t16],[g5,t8d],[f5,t8d],[ais5,t8],
 [a5,t2d],[f5,t16],[g5,t8],[a5,t16],
 [d5,t2d],[e5,t16],[f5,t8],[a5,t16],
 [d5,t2dt16],[f5,t16],[e5,t16],[c5,t4dt16],[e5,t16],[d5,t16],
 [g5,t8d],[f5,t8d],[ais5,t8],[a5,t2d],
 [f5,t16],[g5,t8],[a5,t2t4dt16],[g5,t16],[a5,t16],
 [c6,t2],[ais5,t2],
 [0,t1],[0,t1],[0,t1]

 ] @=> int oboeScore[][];

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//Oboe Echo
[
 //Intro
 [0,t8],
 [0,t1],[0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],[0,t1],
 //A
 [0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],
 //B
 [a3,t4],[b3,t4],[c4,t4],[e4,t8d],[d4,t2t4dt16],
 [a3,t16],[b3,t16],[c4,t1t1],
 [b3,t4],[c4,t4],[d4,t4],[e4,t8d],[d4,t2t4dt16],
 [a3,t16],[b3,t16],[c4,t1t1],
 //C
 [0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],
 //D
 [0,t4d],[a4,t16],[d5,t16],[g5,t8d],[f5,t8d],[ais5,t8],
 [a5,t2d],[f5,t16],[g5,t8],[a5,t16],
 [d5,t2d],[e5,t16],[f5,t8],[a5,t16],
 [d5,t2dt16],[f5,t16],[e5,t16],[c5,t4dt16],[e5,t16],[d5,t16],
 [g5,t8d],[f5,t8d],[ais5,t8],[a5,t2d],
 [f5,t16],[g5,t8],[a5,t2t4dt16],[g5,t16],[a5,t16],
 [c6,t2],[ais5,t2],
 [0,t1],[0,t1],[0,t1]

 ] @=> int oboeEchoScore[][];

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//Strings
[
 //Intro
 [0,t1],[0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],[0,t1],
 //A
 [0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],
 //B
 [0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],
 //C
 [a3,t4],[b3,t4],[c4,t4],[e4,t8d],[d4,t2t4dt16],
 [a3,t16],[b3,t16],[c4,t1t1],
 [b3,t4],[c4,t4],[d4,t4],[e4,t8d],[d4,t1],[0,t1],[0,t16],
 [0,t1],
 //D
 [a3,t1],
 [ais3,t1],
 [c4,t1],
 [d4,t1],
 [a3,t1],
 [ais3,t1],
 [c4,t1],
 [d4,t1],
 [a3,t1t1]

 ] @=> int stringsScore[][];

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//Strings Echo
[
 //Intro
 [0,t16],
 [0,t1],[0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],[0,t1],
 //A
 [0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],
 //B
 [0,t1],[0,t1],[0,t1],[0,t1],
 [0,t1],[0,t1],[0,t1],[0,t1],
 //C
 [a3,t4],[b3,t4],[c4,t4],[e4,t8d],[d4,t2t4dt16],
 [a3,t16],[b3,t16],[c4,t1t1],
 [b3,t4],[c4,t4],[d4,t4],[e4,t8d],[d4,t1],[0,t1],[0,t16],
 [0,t1],
 //D
 [a3,t1],
 [ais3,t1],
 [c4,t1],
 [d4,t1],
 [a3,t1],
 [ais3,t1],
 [c4,t1],
 [d4,t1],
 [a3,t1t2dt8d],[r,t16]

 ] @=> int stringsEchoScore[][];

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//Bass
[
 // Intro
 [0,t1],
 [0,t2d],[e2, t16],[a1, t16],[d2, t16],[g1,t16],

 [a1,t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[0,t16],[a1,t16],[g1,t16],[0,t16],[g1,t16],[a1,t16],[0,t16],
 [a1,t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[g1,t16],[a2,t16],[d3,t8],[0,t16],[e3,t16],[0,t16],
 [a1, t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[0,t16],[a2, t16],[g2, t8],[0,t16],[a2, t16],[0,t16],
 [a1, t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[g1,t16],[0,t16],[d2,t16],[0,t16],[ais1,t16],[ais1,t16],[c2,t16],
 [g1,t16],[0,t16],[g1,t16],[0,t16],[f1,t16],[0,t16],[f1,t16],[0,t16],[g1,t16],[f1,t16],[g1,t16],[c1,t8],[0,t16],[d1,t16],[0,t16],
 [g1,t16],[0,t16],[g1,t16],[0,t16],[f1,t16],[0,t16],[f1,t16],[0,t16],[g1,t16],[f1,t16],[g1,t16],[c2,t8],[0,t16],[ais1,t16],[0,t16],
 [a1,t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[g1,t16],[a1,t16],[g2,t8],[0,t16],[a2,t16],[0,t16],
 [a1,t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[g1,t16],[a1,t16],[d1,t8],[0,t16],[e1,t16],[0,t16],
 // A
 [a1,t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[0,t16],[a1,t16],[g1,t16],[0,t16],[g1,t16],[a1,t16],[0,t16],
 [a1,t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[g1,t16],[a2,t16],[d2,t8],[0,t16],[e2,t16],[0,t16],
 [a1, t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[0,t16],[a2, t16],[g2, t8],[0,t16],[a2, t16],[0,t16],
 [a1, t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[g1,t16],[0,t16],[d2,t16],[0,t16],[ais1,t16],[ais1,t16],[c2,t16],
 [g1,t16],[0,t16],[g1,t16],[0,t16],[f1,t16],[0,t16],[f1,t16],[0,t16],[g1,t16],[f1,t16],[g1,t16],[c1,t8],[0,t16],[d1,t16],[0,t16],
 [g1,t16],[0,t16],[g1,t16],[0,t16],[f1,t16],[0,t16],[f1,t16],[0,t16],[g1,t16],[f1,t16],[g1,t16],[c2,t8],[0,t16],[ais1,t16],[0,t16],
 [a1,t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[g1,t16],[a1,t16],[g2,t8],[0,t16],[a2,t16],[0,t16],
 [a1,t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[g1,t16],[a1,t16],[d1,t8],[0,t16],[e1,t16],[0,t16],
 // B
 [a1,t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[0,t16],[a1,t16],[g1,t16],[0,t16],[0,t16],[a1,t16],[0,t16],
 [a1,t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[g1,t16],[a2,t16],[d2,t8],[0,t16],[e2,t16],[0,t16],
 [a1, t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[0,t16],[a2, t16],[g2, t8],[0,t16],[a2, t16],[0,t16],
 [a1, t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[g1,t16],[0,t16],[d2,t16],[0,t16],[ais1,t16],[ais1,t16],[c2,t16],
 [g1,t16],[0,t16],[g1,t16],[0,t16],[f1,t16],[0,t16],[f1,t16],[0,t16],[g1,t16],[f1,t16],[g1,t16],[c1,t8],[0,t16],[d1,t16],[0,t16],
 [g1,t16],[0,t16],[g1,t16],[0,t16],[f1,t16],[0,t16],[f1,t16],[0,t16],[g1,t16],[f1,t16],[g1,t16],[c2,t8],[0,t16],[ais1,t16],[0,t16],
 [a1,t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[g1,t16],[a1,t16],[g1,t8],[0,t16],[a1,t16],[0,t16],
 [a1,t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[g1,t16],[a1,t16],[d1,t8],[0,t16],[e1,t16],[0,t16],
 //C
 [a1,t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[0,t16],[a1,t16],[g1,t16],[0,t16],[g1,t16],[a1,t16],[0,t16],
 [a1,t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[g1,t16],[a2,t16],[d2,t8],[0,t16],[e2,t16],[0,t16],
 [a1, t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[0,t16],[a2, t16],[g2, t8],[0,t16],[a2, t16],[0,t16],
 [a1, t16],[0,t16],[a1,t16],[0,t16],[g1,t16],[0,t16],[g1,t16],[0,t16],[a1,t16],[g1,t16],[0,t16],[d2,t16],[0,t16],[ais1,t16],[ais1,t16],[c2,t16],
 [g1,t16],[0,t16],[g1,t16],[0,t16],[f1,t16],[0,t16],[f1,t16],[0,t16],[g1,t16],[f1,t16],[g1,t16],[c1,t8d],[d1,t16],[0,t16],
 [g1,t16],[0,t16],[g1,t16],[0,t16],[f1,t16],[0,t16],[f1,t16],[0,t16],[g1,t16],[f1,t16],[g1,t16],[c2,t8],[0,t16],[ais1,t16],[0,t16],

 [a1,t16],[a1,t16],[a2,t8d],[a1,t16],[a1,t16],[0,t16],[a1,t16],[a1,t8],[a1,t8d],[a2,t8],
 [a1,t16],[a1,t8d],[a1,t8],[a1,t8],[a1,t16],[a2,t16],[a1,t16],[a1,t16],[e2,t16],[a2,t16],[g2,t16],[e2,t16],
 //D
 [d1,t8],[a1,t16],[d1,t16],[g1,t16],[d1,t16],[a1,t16],[d1,t8d],
 [a1,t16],[d1,t16],[g1,t8],[a1,t8], //
 [d1,t8],[a1,t16],[d1,t16],[g1,t16],[d1,t16],[a1,t16],[c2,t8d],
 [a1,t16],[d1,t16],[g1,t16],[d1,t16],[a1,t16],[d1,t16],//
 [d1,t8],[a1,t16],[d1,t16],[g1,t16],[d1,t16],[a1,t16],[d1,t8d],
 [a1,t16],[d1,t16],[g1,t16],[d1,t16],[a1,t8],//
 [d1,t8],[a1,t16],[d1,t16],[g1,t16],[d1,t16],[a1,t16],[d1,t8d],
 [a1,t16],[d1,t16],[g1,t16],[d1,t16],[a1,t8],//
 [d1,t8],[a1,t16],[d1,t16],[g1,t16],[d1,t16],[a1,t16],[d1,t8d],
 [a1,t16],[d1,t16],[g1,t8],[a1,t8],//
 [d1,t8],[a1,t16],[d1,t16],[g1,t16],[d1,t16],[a1,t16],[c2,t8d],
 [a1,t16],[d1,t16],[g1,t16],[d1,t16],[a1,t16],[d1,t16],//
 [d1,t8],[a1,t16],[d1,t16],[g1,t16],[d1,t16],[a1,t16],[d1,t8d],
 [a1,t16],[d1,t16],[g1,t16],[d1,t16],[a1,t8],//
 [d1,t8],[a1,t16],[d1,t16],[g1,t16],[d1,t16],[a1,t16],[d1,t8d],
 [a1,t16],[d1,t16],[g1,t16],[d1,t16],[a1,t8],//

 [a1,t16],[a1,t16],[a1,t8d],[g1,t16],[g1,t8],
 [a1,t16],[g1,t16],[a1,t16],[g1,t8d],[a1,t8],
 [a1,t16],[a1,t8d],[g1,t8],[g1,t8],
 [a1,t16],[g1,t16],[a1,t16],[e2,t16],[a1,t16],[d2,t16],[g1,t16],[e1,t16]

 ] @=> int bass[][];

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//Drums
[
 // Intro
 [1, t16],[1, t16],[1, t16],[1, t16],[2, t8],[1, t16],[1, t16],[1, t16],[3,t16],[1, t16],[2,t16],[1, t16],[1, t16],[1, t16],[3,t16],
 [1, t16],[2, t16],[1, t16],[2,t16],[3,t16],[1,t16],[2,t16],[1, t16],[1, t16],[1, t16],[2,t8],[1, t16],[1, t16],[1, t16],[1, t16],
 
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t16],[1,t16],[4,t16],[1,t16],[1,t16],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[1,t8],[4,t16],[1,t8], //
 // A
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t16],[4,t16],[1,t16],[1,t8d],[1,t8],//
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [1,t16],[1,t16],[1,t16],[1,t16],[4,t8],[1,t16],[1,t16],[1,t8],[1,t8],[1,t16],[1,t16],[4,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[1,t8],[1,t8],[1,t16],[1,t16],[1,t16],[1,t16],
 // B
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t16],[1,t8],[4,t16],[1,t8],[4,t16],[1,t16],
 // C
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [4, t8],[1,t8],[4,t16],[4,t16],[1,t8],[4,t8],[1,t16],[4,t8],[4,t16],[1,t8],
 [1,t16],[1,t16],[1,t16],[1,t16],[4,t8],[1,t16],[1,t16],[1,t8],[1,t8],[1,t16],[1,t16],[4,t8],//
 [1,t16],[1,t8],[1,t8],[1,t8],[1,t16], [1,t16],[1,t16],[1,t8],[1,t8],[1,t16],[1,t16],
 // E 
 [1,t16],[4,t16],[4,t16],[1,t16],[4,t8],[1,t16],[4,t16],[r,t16],[4,t16],[1,t16],[4,t16],[r,t16],[1,t8d],
 [4,t16],[4,t16],[1,t16],[4,t16],[r,t16],[4,t16],[1,t8],[4,t16],[4,t16],[1,t16],[4,t16],[r,t16],[4,t16],[4,t8],
 [4,t8],[1,t8],[4,t8],[1,t16],[4,t16],[r,t16],[4,t16],[1,t16],[4,t16],[r,t16],[4,t16],[4,t8],
 [4,t16],[4,t16],[1,t16],[4,t16],[r,t16],[4,t16],[1,t8],[4,t16],[4,t16],[1,t16],[4,t16],[r,t16],[4,t16],[4,t8],
 [1,t16],[4,t8],[1,t16],[4,t8],[1,t16],[4,t16],[r,t16],[4,t16],[1,t16],[4,t16],[r,t16],[4,t16],[r,t8],
 [4,t16],[4,t16],[1,t16],[4,t16],[r,t16],[4,t16],[1,t8],[4,t16],[4,t16],[1,t16],[4,t16],[r,t16],[4,t16],[4,t8],
 [4,t8],[1,t8],[4,t8],[1,t16],[4,t16],[r,t16],[4,t16],[1,t16],[4,t16],[r,t16],[4,t16],[4,t8],
 [4,t16],[4,t16],[1,t16],[4,t16],[r,t16],[4,t16],[1,t8],[4,t16],[4,t16],[1,t16],[4,t16],[r,t16],[4,t16],[4,t8],

 [1,t16],[1,t16],[1,t16],[1,t16],[r,t8],[1,t16],[1,t16],[1,t16],[4,t16],[1,t8],[1,t16],[1,t16],[1,t16],[4,t16],
 [4,t8],[1,t16],[4,t8],[4,t16],[1,t16],[4,t16],[1,t16],[4,t16],[1,t8],[1,t16],[1,t16],[1,t16],[1,t16]
 
 ] @=> int drumdrum[][];

//==================================
//Play functions
//==================================

// Arguments:
// Drum score, start point, all the drums individually, loop point
fun void PlayDrum (int drumScore[][], int ini, SnareGen Drum1, HiTom Drum2, LowTom Drum3, BassDrum Drum4, int ret){
  for (ini => int i; i < drumScore.cap(); i++){
    if (drumScore[i][0] == 1){
      spork ~ Drum1.NoteOn(1);
    }
    else if (drumScore[i][0] == 2){
      spork ~ Drum2.NoteOn(1);
    }
    else if (drumScore[i][0] == 3){
      spork ~ Drum3.NoteOn(1);
    }
    else if (drumScore[i][0] == 4){
      spork ~ Drum4.NoteOn(1);
    }
    duration( drumScore[i][1] ) => now;
    
    if (i == drumScore.cap()-1) {
        ret => ini;
        PlayDrum(drumScore,ini,Drum1,Drum2,Drum3,Drum4,ret);
    }
  }
}

// Arguments:
// Ugen instrument, score, adsr, start point, loop point
fun void play(SawOsc osc, int voztemp[][], ADSR z, int ini, int ret){
  for( ini => int i; i < voztemp.cap(); i++){
      if (voztemp[i][0] > 0 ) {
        Std.mtof(voztemp[i][0]) => osc.freq;
        1 => z.keyOn;
    }
      if (voztemp[i][0] == 0) {
        1 => z.keyOff;
    }
      duration( voztemp[i][1] ) => now;
      if (i == voztemp.cap()-1) {
        ret => ini;
        play(osc, voztemp, z, ini, ret);
    }
  }
}

fun void playTri(TriOsc osc, int voztemp[][], ADSR z, int ini, int ret){
  for( ini => int i; i < voztemp.cap(); i++){
      if (voztemp[i][0] > 0 ) {
        Std.mtof(voztemp[i][0]) => osc.freq;
        1 => z.keyOn;
    }
      if (voztemp[i][0] == 0) {
        1 => z.keyOff;
    }
      duration( voztemp[i][1] ) => now;
      if (i == voztemp.cap()-1) {
        ret => ini;
        playTri(osc, voztemp, z, ini, ret);
    }
  }
}

fun void playPulse(PulseOsc osc, int voztemp[][], ADSR z, int ini, int ret){
  for( ini => int i; i < voztemp.cap(); i++){
      if (voztemp[i][0] > 0 ) {
        Std.mtof(voztemp[i][0]) => osc.freq;
        1 => z.keyOn;
    }
      if (voztemp[i][0] == 0) {
        1 => z.keyOff;
    }
      duration( voztemp[i][1] ) => now;
      if (i == voztemp.cap()-1) {
        ret => ini;
        playPulse(osc, voztemp, z, ini, ret);
    }
  }
}

//=====================
// Sporking
//=====================

Event flowOfTime;

spork ~ PlayDrum(drumdrum, 0, Snare, Tom1, Tom2, Bombo, 30);
spork ~ play(Bass, bass, SawADSR,0,6); 
spork ~ playTri(Wind,windScore,TriADSR,0,2);

spork ~ playPulse(Organ,organScore,PulseADSR,0,2);
spork ~ playPulse(Organ2,organ2Score,PulseADSR2,0,3);

spork ~ playPulse(Oboe,oboeScore,OboeADSR,0,3);
spork ~ playPulse(Oboe2,oboeEchoScore,OboeADSR2,0,4);

spork ~ play(Strings,stringsScore,StringsADSR,0,2);
spork ~ playPulse(StringsL,stringsEchoScore,StringsADSRL,0,3);
spork ~ playPulse(StringsR,stringsEchoScore,StringsADSRR,0,3);

flowOfTime => now;
