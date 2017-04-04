import processing.sound.*;

SinOsc [] sin;
SawOsc [] osc;
PinkNoise [] noise;
float [] freq;
float [] amp;
float [] pan;
int num = 41;

JSONObject json, sensors;
JSONArray results;

int time;
float lat = 0.0;
float lon = 0.0;
float alt = 0.0;

int LENGTH;
String [][] csv;

int j;
int dtime;

void setup() {
  int csvWidth=0;
  String lines[] = loadStrings("INVADER_telemetry_selected.csv");

  //calculate max width of csv file
  for (int i=0; i < lines.length; i++) {
    String [] chars=split(lines[i], ',');
    if (chars.length>csvWidth) {
      csvWidth=chars.length;
    }
  }

  //create csv array based on # of rows and columns in csv file
  csv = new String [lines.length][csvWidth];
  LENGTH =lines.length; //
  println(LENGTH);
  //parse values into 2d array
  for (int i=0; i < lines.length; i++) {
    String [] temp = new String [lines.length];
    temp= split(lines[i], ',');
    for (int j=0; j < temp.length; j++) {
      csv[i][j]=temp[j];
    }
  }

  sin = new SinOsc[num];
  osc = new SawOsc[num];
  noise = new PinkNoise[num];
  freq = new float[num];
  amp = new float[num];
  pan = new float[num]; 
  for (int i=0; i<41; i++) {
    freq[i] = 0.0;
    amp[i] = 0.0;
    pan[i] = 0.0;
    sin[i] = new SinOsc(this);
    sin[i].freq(freq[i]);
    sin[i].amp(amp[i]);
    sin[i].pan(pan[i]);
    sin[i].play();
    osc[i] = new SawOsc(this);
    osc[i].freq(freq[i]);
    osc[i].amp(amp[i]);
    osc[i].pan(pan[i]);
    osc[i].play();
    noise[i] = new PinkNoise(this);
    noise[i].amp(amp[i]);
    noise[i].pan(pan[i]);
    noise[i].play();
  }
}

void draw() {
  for (int i = 0; i < LENGTH-1; i++) {

    time = int(Float.parseFloat(csv[i][1]));
    getAPI(time);

    println(i);

    j = 1;
    freq[j] = alt;
    amp[j] = 0.1;
    pan[j] = 0.0;
    sin[j].freq(freq[j]*20);
    sin[j].amp(amp[j]);
    sin[j].pan(pan[j]);

    j = 2;
    freq[j] = Float.parseFloat(csv[i][j]);
    amp[j] = 0.1;
    pan[j] = sin(radians(lon));
    sin[j].freq(freq[j]*100);
    sin[j].amp(amp[j]);
    sin[j].pan(pan[j]);

    j = 3;
    freq[j] = Float.parseFloat(csv[i][j]);
    amp[j] = 0.1;
    pan[j] = sin(radians(lat));
    sin[j].freq(freq[j]*100);
    sin[j].amp(amp[j]);
    sin[j].pan(pan[j]);

    j = 4;
    freq[j] = Float.parseFloat(csv[i][j]);
    amp[j] = Float.parseFloat(csv[i][30]);
    pan[j] = 0.0;
    sin[j].freq(freq[j]*0.5);
    sin[j].amp((amp[j]+50)/200);
    sin[j].pan(pan[j]);

    j = 20;
    freq[j] = Float.parseFloat(csv[i][j]);
    amp[j] = Float.parseFloat(csv[i][15]);
    pan[j] = 0.0;
    osc[j].freq((freq[j]+50)*10);
    osc[j].amp(amp[j]/2000.0);
    osc[j].pan(pan[j]);

    j = 21;
    freq[j] = Float.parseFloat(csv[i][j]);
    amp[j] = Float.parseFloat(csv[i][14]);
    pan[j] = 0.0;
    osc[j].freq((freq[j]+50)*10);
    osc[j].amp(amp[j]/2000);
    osc[j].pan(pan[j]);

    j = 26;
    freq[j] = Float.parseFloat(csv[i][j])+Float.parseFloat(csv[i][j+1]);
    amp[j] = Float.parseFloat(csv[i][11]);
    pan[j] = -1.0;
    osc[j].freq((freq[j]+100)*5);
    osc[j].amp(amp[j]/2000.0);
    osc[j].pan(pan[j]);

    j = 28;
    freq[j] = Float.parseFloat(csv[i][j])+Float.parseFloat(csv[i][j+1]);
    amp[j] = Float.parseFloat(csv[i][10]);
    pan[j] = -1.0;
    osc[j].freq((freq[j]+100)*5);
    osc[j].amp(amp[j]/2000.0);
    osc[j].pan(pan[j]);

    j = 22;
    freq[j] = Float.parseFloat(csv[i][j])+Float.parseFloat(csv[i][j+1]);
    amp[j] = Float.parseFloat(csv[i][9])+Float.parseFloat(csv[i][13]);
    pan[j] = 1.0;
    osc[j].freq((freq[j]+100)*5);
    osc[j].amp(amp[j]/2000.0);
    osc[j].pan(pan[j]);

    j = 24;
    freq[j] = Float.parseFloat(csv[i][j])+Float.parseFloat(csv[i][j+1]);
    amp[j] = Float.parseFloat(csv[i][8])+Float.parseFloat(csv[i][12]);
    pan[j] = 1.0;
    osc[j].freq((freq[j]+100)*5);
    osc[j].amp(amp[j]/2000.0);
    osc[j].pan(pan[j]);

    j = 17;
    amp[j] = Float.parseFloat(csv[i][j]);
    pan[j] = -1.0;
    noise[j].amp((amp[j]+10)/2000.0);
    noise[j].pan(pan[j]);

    j = 18;
    amp[j] = Float.parseFloat(csv[i][j]);
    pan[j] = 0.0;
    noise[j].amp((amp[j]+10)/2000.0);
    noise[j].pan(pan[j]);

    j = 19;
    amp[j] = Float.parseFloat(csv[i][j]);
    pan[j] = 1.0;
    noise[j].amp((amp[j]+10)/2000.0);
    noise[j].pan(pan[j]);

    j = 35;
    freq[j] = Float.parseFloat(csv[i][j]);
    amp[j] = Float.parseFloat(csv[i][38]);
    pan[j] = -1.0;
    sin[j].freq(abs(freq[j])*10.0);
    sin[j].amp(abs(amp[j])/500.0);
    sin[j].pan(pan[j]);

    j = 36;
    freq[j] = Float.parseFloat(csv[i][j]);
    amp[j] = Float.parseFloat(csv[i][39]);
    pan[j] = 0.0;
    sin[j].freq(abs(freq[j])*10.0);
    sin[j].amp(abs(amp[j])/500.0);
    sin[j].pan(pan[j]);

    j = 37;
    freq[j] = Float.parseFloat(csv[i][j]);
    amp[j] = Float.parseFloat(csv[i][40]);
    pan[j] = 1.0;
    sin[j].freq(abs(freq[j])*10.0);
    sin[j].amp(abs(amp[j])/500.0);
    sin[j].pan(pan[j]);


    dtime = (int)(Float.parseFloat(csv[i+1][1])-Float.parseFloat(csv[i][1]));
    println(dtime);
    delay((int)(dtime*2));
  }
}

void getAPI(int t) { 
  json = loadJSONObject("http://api.artsat.jp/invader/sensor_data.json?sensor=lat,lon,alt&time="+str(t));

  results = json.getJSONArray("results");
  sensors = results.getJSONObject(0).getJSONObject("sensors");
  time = results.getJSONObject(0).getInt("time");

  lat = sensors.getFloat("lat");
  lon = sensors.getFloat("lon");
  alt = sensors.getFloat("alt");
}