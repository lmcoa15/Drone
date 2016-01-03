import processing.net.*; 
Server myServer;
Client myClient;

int dataIn; 
int rslt;
int count=0;
int count1=0;//x,y
int count2=0;//rotation
int count3=0;//sensor
int[] d1 = new int[1000];//x
int[] d1_1=new int[1000];//x1,x2,x3,x4...
int[] d2 = new int[1000];//y
int[] d2_1=new int[1000];//y1,y2,y3,y4...
int[] d3 = new int[1000];//rotation
int[] d4 = new int[1000];//data1
int[] d5 = new int[1000];//data2
int[] d6 = new int[1000];//data3
int[] d7 = new int[1000];//data4
int[] d8 = new int[1000];//data5
 
 PFont f;

// Variable to store text currently being typed
String typing = "";

// Variable to store saved text when return is hit
String saved = "";
 
void setup() { 
  size(600, 600); 
  myServer = new Server(this, 23);//192.168.43.238
  f = createFont("Arial",16,true);
} 
 
void draw() { 
    int indent = 25;
    textFont(f);
    fill(0);
    text("Click in this applet and type. \nHit return to save what you typed. ", indent, 40);
    text(typing,indent,90);
    fill(255);
  myClient = myServer.available();
  if (myClient !=null) {
    dataIn = myClient.read();
    
    
    int num = int(dataIn);
    //pushMatrix();
    translate(width/2, height/2);
    
    if(count == 0 && num == 60){
      count++;
    }
    
    else if(count == 1){
      count++;
    }
    
    else if(count == 2){
      d1[count1]=num;
      for(int i = 0; i<=count1; i++){
       d1_1[count1]+=d1[i];
      }
      
    //background(255);
    //rect(num, num, 20, 20);
  count++;
  }
  
   else if(count == 3){
      d2[count1]=num;
      for(int i = 0; i<=count1; i++){
       d2_1[count1]+=d2[i];
      }
      
    //background(255);
    //rect(num, num, 20, 20);
  count++;
  }
  
  else if(count == 4){
      d3[count2]=num;
    count++;
  }
  
  else if(count == 5){
    d4[count3]=num;
    count++;
  }
  
  else if(count == 6){
    d5[count3]=num;
    count3++;
    background(255);
    rect(-10, -10, 20, 20);
    for(int i=0; i<=count1 ; i++){
    rotate(radians(d3[i]));
    }
    for(int i=0; i<=count1 ; i++){
     translate(d1[i], d2[i]); 
    }
    for(int i=0; i<count3 ;i++){
      if(d4[i]>10)
    line(-10-d1_1[i], d4[i]-d2_1[i], 10-d1_1[i], d4[i]-d2_1[i]);
    }
    for(int i=0; i<count3 ;i++){
      if(d5[i]>10)
    line(-10-d1_1[i], -d5[i]-d2_1[i], 10-d1_1[i], -d5[i]-d2_1[i]);
    }
    count1++;
    count2++;
    count++;
  }
  
  else if(count == 7 && num == 62){
      count=0;
    }
  
  //popMatrix();
     println(num);
  }
}

void keyPressed() {
  // If the return key is pressed, save the String and clear it
  if (key == '\n' ) {
    saved = typing;
    myServer.write(saved);
    // A String can be cleared by setting it equal to ""
    typing = "";
   background(255); 
  } else {
    // Otherwise, concatenate the String
    // Each character typed by the user is added to the end of the String variable.
    typing = typing + key; 
  }
}
