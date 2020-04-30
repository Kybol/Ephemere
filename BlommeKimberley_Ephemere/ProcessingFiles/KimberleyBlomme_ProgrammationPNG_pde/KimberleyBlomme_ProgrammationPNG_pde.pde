/**
 * NyARToolkit for proce55ing/3.0.5
 * (c)2008-2017 nyatla
 * airmail(at)ebony.plala.or.jp
 * 
 * マーカファイルの変わりにPNGを使います。
 * PNGは任意解像度の正方形である必要があります。
 * PNG画像にはエッジ部分を含めてください。
 * 全ての設定ファイルとマーカファイルはスケッチディレクトリのlibraries/nyar4psg/dataにあります。
 * 
 * This sketch uses a PNG image instead of the standard patt file.
 * The PNG image must be square form that includes edge.
 * Any pattern and configuration files are found in libraries/nyar4psg/data inside your sketchbook folder. 
 */
import processing.video.*;
import jp.nyatla.nyar4psg.*;

Capture cam;
MultiMarker nya;

PShape[] models;
//PShape lungs;

PImage corrupted;

void setup() {
  
  size(1280,720,P3D);
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);
  cam=new Capture(this,1280,720);
  nya=new MultiMarker(this,width,height,"../../data/camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker(loadImage("../../Images/Markers/HeartMarker.png"),16,25,80);
  nya.addARMarker(loadImage("../../Images/Markers/LungsMarker.png"),16,25,80);
  cam.start();
  
  models = new PShape[2];
  
  for (int m=1; m <= 1; m++){ 
    models[0]= loadShape("../../Model3D/Heart.obj");
    models[0].setTexture(cam);
    models[1]= loadShape("../../Model3D/Lungs.obj");
    models[1].setTexture(cam);
  /*heart = loadShape("../../Model3D/Heart.obj");
  heart.setTexture(cam);
  lungs = loadShape("../../Model3D/Lungs.obj");
  lungs.setTexture(cam);*/
}
  
  corrupted = loadImage ("../../Images/Corrupted.png");
}


void draw()
{
  if (cam.available() !=true) {
      return;
  }
  cam.read();
  nya.detect(cam);
  background(0);
  nya.drawBackground(cam);//frustumを考慮した背景描画
       
 /* 
  }*/
  for (int i = 0; i <2; i++) {
    if((!nya.isExist(i))){
    continue;}
  
    
  nya.beginTransform(i);
  //fill(0,0,255);
  //translate(0,0,20);
  //box(40);
  
    shape (models[i]);
    image (corrupted, 10, 10);
    image(corrupted, 20, 20, width/-3, height/3);
    
    shape (models[i]);
    /*image (corrupted, 10, 10);
    image(corrupted, 20, 20, width/-3, height/3);*/
    
  nya.endTransform();
}

}
