import de.looksgood.ani.*;

String[] images = {
  "14150358928_e39ffe62d3_k.jpg",
  "14150359478_e9068c1bb0_k.jpg",
  "14150363748_15fc880fb5_k.jpg",
  "14150365358_0d4304a05c_k.jpg",
  "14150366448_ed7cd1d1a5_k.jpg",
  "14150368099_ca896719a3_k.jpg",
  "14150372658_62154f677c_k.jpg",
  "14150404490_8016758b1d_k.jpg",
  "14150405960_634206b2c9_k.jpg",
  "14150409510_a2d2513979_k.jpg",
  "14150410510_dd2bc28e30_k.jpg",
  "14150413850_501e87ab29_k.jpg",
  "14150414830_e7c2c6463e_k.jpg",
  "14150415010_4c9146f594_k.jpg",
  "14150415200_fd012b4bd3_k.jpg",
  "14150422810_8d1a564542_k.jpg",
  "14150533077_1ebed0b0d8_k.jpg",
  "14150534587_7fa21f1972_k.jpg",
  "14150534687_7fef87be81_k.jpg",
  "14150543547_f0c646a735_k.jpg",
  "14313883716_f7bdb887a1_k.jpg",
  "14313897186_df9708311a_k.jpg",
  "14333682191_cb8b168932_k.jpg",
  "14333684581_2f3ad497c5_k.jpg",
  "14333690961_6cab5abac9_k.jpg",
  "14335350162_02cd300895_k.jpg",
  "14335350662_418a4c9225_k.jpg",
  "14335351072_6f8cc1c1d0_k.jpg",
  "14335352842_735111fb12_k.jpg",
  "14336267914_f8833a689e_k.jpg",
  "14336270814_891ae0aa15_k.jpg",
  "14337016445_923bc0abf9_k.jpg",
  "14337022265_0e99ee4713_k.jpg",
  "14337026705_ab2ac044f5_k.jpg",
  "14337029665_e565809e94_k.jpg",
  "14357219413_dfc0310475_k.jpg",
  "14357220853_7576446bde_k.jpg",
  "14357228353_55c6bc0ff8_k.jpg"
};

int[][] corners = {
  {1493,1109},
  {507,561},
  {22,675},
  {1003,834},
  {881,1025},
  {1469,44},
  {1853,1244},
  {977,777},
  {297,652},
  {103,845},
  {431,886},
  {835,56},
  {1961,1048},
  {1674,24},
  {1701,127},
  {724,741},
  {1423,482},
  {1771,984},
  {160,487},
  {1225,24},
  {172,684},
  {757,848},
  {999,1263},
  {1978,893},
  {194,927},
  {677,598},
  {102,294},
  {776,1043},
  {1235,319},
  {1304,361},
  {1131,1067},
  {944,1300},
  {676,629},
  {991,734},
  {559,1089},
  {1857,392},
  {1167,1240},
  {642,998}
};

int[][] whs = {
  {67,108},
  {61,41},
  {68,47},
  {64,37},
  {88,51},
  {61,40},
  {60,42},
  {65,46},
  {65,88},
  {61,87},
  {60,35},
  {63,37},
  {76,44},
  {61,35},
  {82,48},
  {62,41},
  {65,38},
  {68,41},
  {98,56},
  {61,41},
  {79,50},
  {61,42},
  {82,51},
  {65,44},
  {63,37},
  {69,40},
  {63,29},
  {95,162},
  {69,48},
  {72,50},
  {61,35},
  {87,69},
  {99,143},
  {61,35},
  {60,41},
  {69,40},
  {75,44},
  {60,38}
};

boolean skip = true;

float aniDuration = 2.0;

PImage imgBig, imgSmall;

Ani zoomAni;

int opacity = 255;
int winWidth = 1000;
int winHeight = 1000;

int currentImage = 0;
int widthBig, widthSmall;

float minScale = 0.0001;

float ratioWinShrink, ratioSmall, ratioBig, scaleSmall=1, scaleBig=1, xSmall=0, ySmall=0, xBig=0, yBig=0, ratioSmallBig;
float xSmallRel = 0, ySmallRel = 0;

void setup() {
  size(winWidth, winHeight);
  background(255);
  Ani.init(this);
  loadNext();
}

void draw() {
  background(0);
  // calculate stuff
  // draw big image
  tint(255, 255);
  drawImage(imgBig, widthBig, xBig, yBig);
  // draw small image
  tint(255, opacity);
  drawImage(imgSmall, widthSmall, xSmall, ySmall);
}

void drawImage(PImage img, float w, float x, float y) {
  if (w > winWidth) {
    float tmpRatio = (float)img.width/w;
    int newx = (int)(abs(x) * tmpRatio);
    int newy = (int)(abs(y) * tmpRatio);
    int neww = (int)(winWidth * tmpRatio)+1;
    int newh = (int)(winHeight * tmpRatio)+1;
    PImage tmp = img.get(newx, newy, neww, newh);
    tmp.resize(winWidth, 0);
    image(tmp, 0, 0);
    if (millis()%500<10) println(img.width, tmpRatio, newx, newy, neww, newh);
  } else {
    if (w<=0) return;
    img.resize((int)w, 0);
    image(img, x, y);
  }
}

void loadNext() {
  int bigIndex;
  opacity = 255;
  if (currentImage+1 < images.length) {
    bigIndex = currentImage+1;
  } else {
    bigIndex = 0;
  }
  imgSmall = loadImage(images[currentImage]);
  imgBig = loadImage(images[bigIndex]);
  ratioSmall = (float)imgSmall.width/imgSmall.height;
  ratioBig = (float)imgBig.width/imgBig.height;
  int[] corner = corners[currentImage];
  int[] wh = whs[currentImage];
  ratioSmallBig = (float)wh[0]/imgBig.width;
  ratioWinShrink = (float)winWidth/wh[0];
  xSmallRel = (float)corner[0]/imgBig.width;
  ySmallRel = (float)corner[1]/imgBig.height;
  xSmall = 0;
  ySmall = 0;
  xBig = -corner[0]*ratioWinShrink;
  yBig = -corner[1]*ratioWinShrink;
  widthSmall = winWidth;
  widthBig = (int)(ratioWinShrink*imgBig.width);
  // println(ratioSmall,ratioBig,ratioSmallBig,ratioWinShrink,xSmallRel,ySmallRel);
  // println(widthBig, widthSmall);
  // println("xBig:",xBig, "yBig:", yBig,corner[0],corner[1],wh[0],wh[1]);
  currentImage++;
  if (currentImage >= images.length) {
    currentImage = 0;
  }
}

void calculateTween() {
  float f;
}

void mouseReleased() {
  if (skip) {
    skip = false;
    makeAni();
  } else {
    loadNext();
    skip = true;
  }
}

void aniEnded() {
  loadNext();
  makeAni();
}

void makeAni() {
  float xSm = (float)xSmallRel*winWidth;
  float ySm = (float)ySmallRel*(winWidth/ratioBig);
  float wSm = (float)winWidth*ratioSmallBig;
  // println(xSm, ySm, wSm);
  // xSmall = xSm;
  // ySmall = ySm;
  // xBig = 0;
  // yBig = 0;
  // widthSmall = (int)wSm;
  // widthBig = winWidth;
  Ani.to(this, aniDuration, "xSmall", xSm, Ani.CUBIC_OUT);
  Ani.to(this, aniDuration, "ySmall", ySm, Ani.CUBIC_OUT);
  Ani.to(this, aniDuration, "xBig", 0, Ani.CUBIC_OUT);
  Ani.to(this, aniDuration, "yBig", 0, Ani.CUBIC_OUT);
  Ani.to(this, aniDuration, "widthBig", winWidth, Ani.CUBIC_OUT, "onEnd:aniEnded");
  Ani.to(this, aniDuration, "widthSmall", (int)wSm, Ani.CUBIC_OUT);
  Ani.to(this, aniDuration, "opacity", 128, Ani.CUBIC_OUT);
}