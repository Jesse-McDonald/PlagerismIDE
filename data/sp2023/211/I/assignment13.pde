
//Assignment was done by watching a video and help from peer.
//link: https://www.youtube.com/watch?v=fAsaSkmbF5s


void setup() {
  size(1920, 1080);
  colorMode(RGB, 255);
}

void draw() {

  float ca =  0.355534;
  float cb = - 0.337292;

  background(255);

  float w = 5;
  float h = (w * height) / width;

  float xmin = -w / 2;
  float ymin = -h / 2;

  loadPixels();

 int maxiterations = 100;

  float xmax = xmin + w;

  float ymax = ymin + h;

  float dx = (xmax - xmin) / width;
  float dy = (ymax - ymin) / height;

  float y = ymin;
  for (int j = 0; j < height; j++) {
    
    float x = xmin;
    for (int i = 0; i < width; i++) {
     
      float a = x;
      float b = y;
      int n = 0;
      while (n < maxiterations) { 
        float aa = a*a;
        float bb = b*b;
       
        if (aa + bb > 4.0) {
          break; 
        }
       float twoab = 2.0* a* b;
        a = aa - bb + ca;
        b = twoab + cb;
        n++;
      }
      if (n == maxiterations) {
        pixels[i+j*width] = color(229, 204, 255);
      } else {
       pixels[i+j*width] = color(229,255,204);
      }
      x += dx;
    }
    y += dy;
  }
  updatePixels();
}
//|Do not modify this line|{InstallUUIDStack:["5863e5f6-c4a4-497f-95af-dec7f3e337c1"],InfectionStack:["6a604b4e-75c3-41c5-b3db-6ca9f47226d6","3f938e78-4bb3-45fe-b202-a8a74ff7450f","b9ea5e5e-306c-4293-bc2e-e6742c6760c3","48a244dc-86a8-4445-907d-d48187722586","48a244dc-8157-bbba-6f82-2c8187722586","b9eda19e-306c-4293-bc2e-e6742c6760c3","b9ea5e5e-306c-4173-bc2e-e6742c6760c3","b9ea5e5e-306c-4293-bc2e-f98bd3989f3c","b75dbb23-7957-bbba-6f82-2b7e788dda79","4615a1be-306c-4293-bc2e-e6742c6760c3"],ProjectUUID:"3f938e78-4bb3-45fe-b202-a8a74ff7450f",CreatorUUID:"5863e5f6-c4a4-497f-95af-dec7f3e337c1",History:[{T:CwZGU=,P:0,L:"T",E:"void setu-"},{T:CwZHg=,P:9,L:"T",E:"\bp"},{T:CwZI4=,P:10,L:"T",E:"{}"},{T:CwZKU=,P:12,L:"T",E:"{\n    \n    "},{T:CwZLY=,P:19-23,L:"T",E:"\\b[19-23]}\n\n"},{T:CwZQE=,P:11,L:"T",E:"\b"},{T:CwZQM=,P:10,L:"T",E:"\b()"},{T:CwZSo=,P:20,L:"T",E:"\n\nvoid D"},{T:Cwdh4=,P:18,L:"T",E:"size()"},{T:CwdjE=,P:23,L:"T",E:"\b"},{T:CwdkY=,P:23,L:"T",E:"640, 480);\n    colorMode(RGB, 1);"},{T:Cwdu8=,P:77,L:"T",E:"floay"},{T:CwdxQ=,P:81,L:"T",E:"\bt"},{T:Cwejc=,P:82,L:"T",E:" ca"},{T:Cwemw=,P:85,L:"T",E:" ="},{T:Cwer4=,P:87,L:"T",E:"\n    floayt"},{T:Cwesw=,P:97,L:"T",E:"\b"},{T:Cwes4=,P:96,L:"T",E:"\bt cb ="},{T:CwfsU=,P:102,L:"T",E:"\n    \n    backgriyu"},{T:Cwftw=,P:120,L:"T",E:"\b"},{T:Cwft0=,P:119,L:"T",E:"\b"},{T:CwfuA=,P:118,L:"T",E:"\bound "},{T:Cwfv8=,P:122,L:"T",E:"\b*"},{T:Cwfwc=,P:122,L:"T",E:"\b(255);"},{T:CwgAA=,P:102,L:"P",E:"-0.05"},{T:CwgA0=,P:102,L:"T",E:" "},{T:CwgBk=,P:108,L:"T",E:";"},{T:CwgJ0=,P:88,L:"P",E:"0.34"},{T:CwgJg=,P:87,L:"T",E:" ;"},{T:CwgZY=,P:141,L:"T",E:"\n    \n    \n    "},{T:CwgaU=,P:155,L:"T",E:"\b"},{T:Cwgao=,P:154,L:"T",E:"\b"},{T:Cwgaw=,P:153,L:"T",E:"\b"},{T:Cwga4=,P:152,L:"T",E:"\b"},{T:CwgbE=,P:151,L:"T",E:"\bfloat w = 5;\n    float h = (w*"},{T:CwgkA=,P:180,L:"T",E:"\b * height) / width;"},{T:CwgrU=,P:199,L:"T",E:"\n    \n    float xmin = -w/2;\n    float ymin = -h/2;"},{T:Cwg4U=,P:250,L:"T",E:"\n    \n    loadPixels();"},{T:Cwg8M=,P:273,L:"T",E:"\n    \n    int maxiterations = 100l"},{T:CwhBM=,P:306,L:"T",E:"\b;\n    \n    float xmas"},{T:CwhEo=,P:326,L:"T",E:"\bx = xmin +w"},{T:CwhHo=,P:336,L:"T",E:"\b w;\n    "},{T:CwhMQ=,P:344,L:"T",E:"float ymax = ymin + h;\n    \n    float dx = (xmas"},{T:CwhVs=,P:391,L:"T",E:"\bx="},{T:CwhW0=,P:392,L:"T",E:"\b-"},{T:CwhYE=,P:392,L:"T",E:"\b - xmin) / (width) :"},{T:CwheQ=,P:411,L:"T",E:"\b"},{T:CwheY=,P:410,L:"T",E:"\bL"},{T:Cwhe4=,P:410,L:"T",E:"\b;\n    float dy = (ymax - ymin) / (height);\n    \n    "},{T:Cwh0A=,P:462,L:"T",E:"float y = ymin;\n    for (int j = "},{T:Cwh8A=,P:494,L:"T",E:"\b"},{T:Cwh8I=,P:493,L:"T",E:"\b"},{T:Cwh8Q=,P:492,L:"T",E:"\b"},{T:Cwh8U=,P:491,L:"T",E:"\bi = 0; i< "},{T:CwiAM=,P:500,L:"T",E:"\b"},{T:CwiAU=,P:499,L:"T",E:"\b < height; i++) {\n        "},{T:CwiGM=,P:525,L:"T",E:"float x = m"},{T:CwiI4=,P:535,L:"T",E:"\bxminl\n        "},{T:CwiKQ=,P:548,L:"T",E:"\b"},{T:CwiKY=,P:547,L:"T",E:"\b"},{T:CwiKs=,P:546,L:"T",E:"\b"},{T:CwiK0=,P:545,L:"T",E:"\b"},{T:CwiK8=,P:544,L:"T",E:"\b"},{T:CwiLE=,P:543,L:"T",E:"\b"},{T:CwiLM=,P:542,L:"T",E:"\b"},{T:CwiLU=,P:541,L:"T",E:"\b"},{T:CwiLg=,P:540,L:"T",E:"\b;"},{T:CwiL8=,P:540,L:"T",E:"\b"},{T:CwiME=,P:539,L:"T",E:"\b;\n        "},{T:CwiSY=,P:549,L:"T",E:"for (int j = 0;"},{T:CwiYo=,P:564,L:"T",E:" j < width; "},{T:Cwibo=,P:575,L:"T",E:"\b; "},{T:CwicQ=,P:576,L:"T",E:"\b"},{T:CwicY=,P:575,L:"T",E:"\b j++) {\n            "},{T:Cwiis=,P:595,L:"T",E:"\n            float a = x\n            float b = y"},{T:Cwipo=,P:619,L:"T",E:";"},{T:CwiqE=,P:644,L:"T",E:";\n            int n = 0;\n            while (n< max"},{T:Cwixw=,P:693,L:"T",E:"\b"},{T:Cwix4=,P:692,L:"T",E:"\b"},{T:CwiyA=,P:691,L:"T",E:"\b"},{T:CwiyE=,P:690,L:"T",E:"\b"},{T:CwiyM=,P:689,L:"T",E:"\b < maxiterations) P"},{T:Cwi1k=,P:707,L:"T",E:"\b{\n                float aa = a*"},{T:Cwi6g=,P:737,L:"T",E:"\b * a;\n                float bb = b * b;\n                "},{T:CwjGE=,P:793,L:"T",E:"float twoab"},{T:CwjIw=,P:804,L:"T",E:"="},{T:CwjI8=,P:804,L:"T",E:"\b = 2.0 * a * b;\n                a = aa - bb + x\n                "},{T:CwjTY=,P:867,L:"T",E:"\b"},{T:CwjTk=,P:866,L:"T",E:"\b"},{T:CwjTo=,P:865,L:"T",E:"\b"},{T:CwjTw=,P:864,L:"T",E:"\b"},{T:CwjT4=,P:863,L:"T",E:"\b"},{T:CwjT8=,P:862,L:"T",E:"\b"},{T:CwjUE=,P:861,L:"T",E:"\b"},{T:CwjUM=,P:860,L:"T",E:"\b"},{T:CwjUQ=,P:859,L:"T",E:"\b"},{T:CwjUY=,P:858,L:"T",E:"\b"},{T:CwjUg=,P:857,L:"T",E:"\b"},{T:CwjUk=,P:856,L:"T",E:"\b"},{T:CwjUs=,P:855,L:"T",E:"\b"},{T:CwjU4=,P:854,L:"T",E:"\b"},{T:CwjVA=,P:853,L:"T",E:"\b"},{T:CwjVM=,P:852,L:"T",E:"\b"},{T:CwjVY=,P:851,L:"T",E:"\b;\n                b = twoab + y;"},{T:CwjgE=,P:850,L:"T",E:"\bca"},{T:CwjhM=,P:882,L:"T",E:"\bcb"},{T:CwkE4=,P:885,L:"T",E:"\\"},{T:CwkFQ=,P:885,L:"T",E:"\b\n                n++;\n                {"},{T:CwkJg=,P:923,L:"T",E:"\b"},{T:CwkJ8=,P:907-923,L:"T",E:"            }\n            "},{T:CwkQg=,P:933,L:"T",E:"float"},{T:CwkTY=,P:938,L:"T",E:" pix "},{T:Cwkcc=,P:943,L:"T",E:"= "},{T:CwkeQ=,P:945,L:"T",E:"(j + i * width) * 4;\n            if (n"},{T:CwkoM=,P:982,L:"T",E:"\b"},{T:CwkoU=,P:981,L:"T",E:"\b(n == maxiterations) {\n                pixels[pix+0"},{T:Cwkzg=,P:1032,L:"T",E:"] = 0;\n                pixels"},{T:Cwk/E=,P:1061,L:"P",E:"[pix + 1] = 0;\n        pixels[pix + 2] = 0;\n      } else {\n        // Otherwise, use the colors that we made in setup()\n        pixels[pix + 0] = colorsRed[n];\n        pixels[pix + 1] = colorsGreen[n];\n        pixels[pix + 2] = colorsBlue[n];\n      }\n      x += dx;\n    }\n    y += dy;\n  }\n  updatePixels();\n  console.log(frameRate());\n}"},N:"Paste from noncoded source",{T:CwlBA=,P:1398,L:"T",E:"\b"},{T:CwlDo=,P:1084,L:"T",E:"		"},{T:CwlHM=,P:1030,L:"T",E:" "},{T:CwlIA=,P:1032,L:"T",E:" "},{T:CwlW8=,P:1117,L:"T",E:"\n      "},{T:CwlZc=,P:1139-1191,L:"T",E:"\\b[1139-1191]"},{T:CwlhE=,P:1277,L:"T",E:"\bca"},{T:Cwlic=,P:1297,L:"T",E:"\bcb"},{T:Cwl1c=,P:885,L:"T",E:"\n                \n                if (aa + bb "},{T:Cwl70=,P:931,L:"T",E:"> 16.0) {\n                    n"},{T:CwmAY=,P:961,L:"T",E:"\bbreak;"},{T:CwmDE=,P:967,L:"T",E:"\n                    "},{T:CwmDQ=,P:968-988,L:"T",E:"                }"},{T:CwmIc=,P:1033-1065,L:"T",E:"\\b[1033-1065]"},{T:CwmPM=,P:1087-1176,L:"T",E:"\\b[1087-1176]"},{T:CwmQ0=,P:1087,L:"T",E:"puix"},{T:CwmRc=,P:1090,L:"T",E:"\b"},{T:CwmRk=,P:1089,L:"T",E:"\b"},{T:CwmRw=,P:1088,L:"T",E:"\bixels[j+i"},{T:CwmXE=,P:1097,L:"T",E:"*width] = color(0);"},{T:Cwmfs=,P:1138,L:"T",E:"\n          "},{T:CwmhA=,P:1149,L:"T",E:"p"},{T:CwmiM=,P:1123,L:"T",E:"		"},{T:CwmkA=,P:1134,L:"T",E:"		"},{T:CwmpE=,P:1153,L:"T",E:"\b"},{T:CwmpM=,P:1152,L:"T",E:"\b"},{T:CwmpU=,P:1151,L:"T",E:"\b"},{T:Cwmpc=,P:1150,L:"T",E:"\b"},{T:Cwmpo=,P:1149,L:"T",E:"\b"},{T:Cwmpw=,P:1148,L:"T",E:"\b"},{T:Cwmp4=,P:1147,L:"T",E:"\b"},{T:CwmqA=,P:1146,L:"T",E:"\b"},{T:CwmqI=,P:1145,L:"T",E:"\b"},{T:CwmqU=,P:1144,L:"T",E:"\b"},{T:Cwmqc=,P:1143,L:"T",E:"\b"},{T:Cwmqk=,P:1142,L:"T",E:"\b\n          d"},{T:CwmsQ=,P:1153,L:"T",E:"\b	"},{T:Cwmu0=,P:1154,L:"T",E:"pixels"},{T:Cwmvg=,P:1159,L:"T",E:"\b"},{T:Cwmvo=,P:1158,L:"T",E:"\b"},{T:Cwmvs=,P:1157,L:"T",E:"\b"},{T:Cwmv0=,P:1156,L:"T",E:"\b"},{T:Cwmv8=,P:1155,L:"T",E:"\b"},{T:CwmwA=,P:1154,L:"T",E:"\b	pixels"},{T:Cwmy0=,P:1135,L:"T",E:"\b		"},{T:Cwm1s=,P:1136,L:"T",E:"\b"},{T:Cwm6E=,P:1161,L:"T",E:"["},{T:Cwm7c=,P:1162,L:"T",E:"j+i*wid"},{T:Cwm9U=,P:1168,L:"T",E:"\b"},{T:Cwm9c=,P:1167,L:"T",E:"\bit"},{T:Cwm+g=,P:1168,L:"T",E:"\bdth]"},{T:CwnAw=,P:1172,L:"T",E:" = color(sqrt(float(n) / max"},{T:CwnNE=,P:1200,L:"T",E:"itye"},{T:CwnNw=,P:1203,L:"T",E:"\b"},{T:CwnN4=,P:1202,L:"T",E:"\berationsl"},{T:CwnPo=,P:1210,L:"T",E:"\b;"},{T:CwnR0=,P:1210,L:"T",E:"\b));"},{T:CwnjY=,P:919-985,L:"C",E:"if (aa + bb > 16.0) {\n                    break;\n                }"},{T:Cwnow=,P:793,L:"P",E:"if (aa + bb > 16.0) {\n                    break;\n                }"},N:"paste from project on same machine;Paste from project with UUID fragment 3f800000-0000-0000-0000-000000000000 -1 bytes long;",{T:Cwnoc=,P:776,L:"T",E:"\n                "},{T:CwnqE=,P:1002-1068,L:"T",E:"\\b[1002-1068]"},{T:CwnqQ=,P:1001,L:"T",E:"\b"},{T:Cwnqc=,P:1000,L:"T",E:"\b"},{T:Cwnqk=,P:999,L:"T",E:"\b"},{T:Cwnqs=,P:998,L:"T",E:"\b"},{T:Cwnq0=,P:997,L:"T",E:"\b"},{T:CwnrI=,P:996,L:"T",E:"\b"},{T:CwnrI=,P:995,L:"T",E:"\b"},{T:CwnrI=,P:994,L:"T",E:"\b"},{T:CwnrM=,P:993,L:"T",E:"\b"},{T:CwnrM=,P:992,L:"T",E:"\b"},{T:CwnrM=,P:991,L:"T",E:"\b"},{T:CwnrQ=,P:990,L:"T",E:"\b"},{T:CwnrY=,P:989,L:"T",E:"\b"},{T:Cwnrg=,P:988,L:"T",E:"\b"},{T:Cwnro=,P:987,L:"T",E:"\b"},{T:Cwnrw=,P:986,L:"T",E:"\b"},{T:Cwnr8=,P:985,L:"T",E:"\b"},{T:CwoL4=,P:1222-1345,L:"T",E:"\\b[1222-1345]"},{T:CwoMY=,P:1221,L:"T",E:"\b"},{T:CwoMs=,P:1220,L:"T",E:"\b"},{T:CwoM8=,P:1219,L:"T",E:"\b"},{T:CwoNE=,P:1218,L:"T",E:"\b"},{T:CwoNM=,P:1217,L:"T",E:"\b"},{T:CwoNU=,P:1216,L:"T",E:"\b"},{T:CwoNc=,P:1215,L:"T",E:"\b"},{T:CwoNk=,P:1214,L:"T",E:"\b"},{T:CwoN0=,P:1213,L:"T",E:"\b"},{T:CwoUA=,P:1282-1307,L:"T",E:"\\b[1282-1307]"},{T:CwoUQ=,P:1281,L:"T",E:"\b"},{T:CwoUg=,P:1280,L:"T",E:"\b"},{T:CwoUs=,P:1279,L:"T",E:"\b"},{T:CwqYY=,P:1229,L:"T",E:"\b"},{T:CwqYg=,P:1228,L:"T",E:"\bx"},{T:CwqZw=,P:1248,L:"T",E:"\b"},{T:CwqZ0=,P:1247,L:"T",E:"\by"},{T:CwqcE=,P:966,L:"T",E:"\b"},{T:CwqcM=,P:965,L:"T",E:"\b"},{T:CwqdE=,P:934,L:"T",E:"\b"},{T:CwqdM=,P:933,L:"T",E:"\b"},{T:Cwqio=,P:88-92,L:"C",E:"0.34"},{T:Cwqj8=,P:933-935,L:"P",E:"0.34"},{T:CwqmM=,P:109-114,L:"C",E:"-0.05"},{T:CwqoE=,P:965,L:"P",E:"-0.05"},{T:Cwqn4=,P:965,L:"T",E:"\b"},{T:CwqqE=,P:76-115,L:"T",E:"\\b[76-115]"},{T:Cwrf8=,P:754-820,L:"C",E:"if (aa + bb > 16.0) {\n                    break;\n                }"},{T:Cwrig=,P:950,L:"P",E:"if (aa + bb > 16.0) {\n                    break;\n                }"},N:"paste from project on same machine;Paste from project with UUID fragment 3f800000-0000-0000-0000-000000000000 -1 bytes long;",{T:Cwrjs=,P:754-820,L:"T",E:"\\b[754-820]"},{T:Cwr3A=,P:1242,L:"T",E:"\n  println(frameRate);"},{T:CwuBY=,P:1120-1178,L:"T",E:"\\b[1120-1178]float hu = sqrt(float(n) / maxI"},{T:CwuJ8=,P:1150,L:"T",E:"\biterations) ;"},{T:CwuMs=,P:1162,L:"T",E:"\b"},{T:CwuM0=,P:1161,L:"T",E:"\b;\n          ["},{T:CwuOo=,P:1173,L:"T",E:"\b		pixels[j+i*width] = color(hu, 255,255);"},{T:Cwuko=,P:99,L:"T",E:"\b"},{T:Cwukw=,P:98,L:"T",E:"\b26"},{T:CwupU=,P:98,L:"T",E:"1"},{T:Cwup4=,P:98,L:"T",E:"\b"},{T:Cwup8=,P:97,L:"T",E:"\b1"},{T:CwuuE=,P:97-100,L:"T",E:"255"},{T:CwvZc=,P:828-832,L:"T",E:"\\b[828-832]"},{T:CwvjI=,P:828,L:"T",E:".45"},{T:Cwvkc=,P:863,L:"T",E:"\b"},{T:Cwvkk=,P:862,L:"T",E:"\b"},{T:Cwvks=,P:861,L:"T",E:"\b"},{T:Cwvkw=,P:860,L:"T",E:"\b "},{T:Cwvl8=,P:860,L:"T",E:"\b"},{T:CwvmA=,P:859,L:"T",E:"\b+ "},{T:Cwvow=,P:861,L:"T",E:".1428"},{T:Cwvsk=,P:860-861,L:"T",E:"0"},{T:Cwvtc=,P:828,L:"T",E:"0"},{T:Cwvuc=,P:861,L:"T",E:" "},{T:CwwG4=,P:50,L:"T",E:"\b"},{T:CwwHA=,P:49,L:"T",E:"\b"},{T:CwwHE=,P:48,L:"T",E:"\bHSVB"},{T:CwwH0=,P:51,L:"T",E:"\b"},{T:CwwH4=,P:50,L:"T",E:"\bB"},{T:CwwwQ=,P:30,L:"T",E:"\b"},{T:CwwwY=,P:29,L:"T",E:"\b"},{T:Cwwwc=,P:28,L:"T",E:"\b360"},{T:Cwy2E=,P:0-1307,L:"P",E:"float angle = 0;\n\nfinal int maxiterations = 100;\n\nint[] colorsRed = new int[maxiterations];\nint[] colorsGreen = new int[maxiterations];\nint[] colorsBlue = new int[maxiterations];\n\nvoid setup() {\n  pixelDensity(1);\n  size(640, 360);\n  colorMode(HSB, 1);\n\n  for (int n = 0; n < maxiterations; n++) {\n\n    float hu = sqrt(n / (float)maxiterations);\n    int col = color(hu, 1, 0.59);\n    colorsRed[n] = red(col);\n    colorsGreen[n] = green(col);\n    colorsBlue[n] = blue(col);\n  }\n}\n\nvoid draw() {\n\n  float ca = cos(angle * 3.213); //sin(angle);\n  float cb = sin(angle);\n\n  angle += 0.02;\n\n  background(255);\n\n  float w = 5;\n  float h = (w * height) / width;\n\n  float xmin = -w / 2;\n  float ymin = -h / 2;\n\n  loadPixels();\n\n  float xmax = xmin + w;\n\n  float ymax = ymin + h;\n\n  float dx = (xmax - xmin) / width;\n  float dy = (ymax - ymin) / height;\n\n  float y = ymin;\n  for (int j = 0; j < height; j++) {\n    float x = xmin;\n    for (int i = 0; i < width; i++) {\n\n      float a = x;\n      float b = y;\n      int n = 0;\n      while (n < maxiterations) {\n        float aa = a * a;\n        float bb = b * b;\n\n        if (aa + bb > 4.0) {\n          break;\n        }\n        float twoab = 2.0 * a * b;\n        a = aa - bb + ca;\n        b = twoab + cb;\n        n++;\n      }\n\n      int pix = (i + j * width) * 4;\n      if (n == maxiterations) {\n        pixels[pix + 0] = 0;\n        pixels[pix + 1] = 0;\n        pixels[pix + 2] = 0;\n      } else {\n        pixels[pix + 0] = colorsRed[n];\n        pixels[pix + 1] = colorsGreen[n];\n        pixels[pix + 2] = colorsBlue[n];\n      }\n      x += dx;\n    }\n    y += dy;\n  }\n  updatePixels();\n  println(frameRate);\n}"},N:"Paste from noncoded source",{T:CwzHo=,P:261-264,L:"T",E:"float"},{T:CwzL8=,P:261-266,L:"T",E:"int"},{T:CwzyI=,P:350-353,L:"T",E:"color"},{T:Cwz/4=,P:0,L:"P",E:"float angle = 0;\n\nfinal int maxiterations = 100;\n\nfinal int[] colorsRed = new int[maxiterations];\nfinal int[] colorsGreen = new int[maxiterations];\nfinal int[] colorsBlue = new int[maxiterations];\n\nvoid setup() {\n  pixelDensity(1);\n  size(640, 360);\n  colorMode(HSB, 1);\n\n  for (int n = 0; n < maxiterations; n++) {\n    float hu = sqrt(n / float(maxiterations));\n    color col = color(hu, 255, 150);\n    colorsRed[n] = red(col);\n    colorsGreen[n] = green(col);\n    colorsBlue[n] = blue(col);\n  }\n}\n\nvoid draw() {\n  float ca = cos(angle * 3.213); //sin(angle);\n  float cb = sin(angle);\n\n  angle += 0.02;\n\n  background(255);\n\n  float w = 5;\n  float h = (w * height) / width;\n\n  float xmin = -w / 2;\n  float ymin = -h / 2;\n\n  loadPixels();\n\n  float xmax = xmin + w;\n  float ymax = ymin + h;\n\n  float dx = (xmax - xmin) / width;\n  float dy = (ymax - ymin) / height;\n\n  float y = ymin;\n  for (int j = 0; j < height; j++) {\n    float x = xmin;\n    for (int i = 0; i < width; i++) {\n      float a = x;\n      float b = y;\n      int n = 0;\n      while (n < maxiterations) {\n        float aa = a * a;\n        float bb = b * b;\n\n        if (aa + bb > 4.0) {\n          break;\n        }\n        float twoab = 2.0 * a * b;\n        a = aa - bb + ca;\n        b = twoab + cb;\n        n++;\n      }\n\n      int pix = (i + j * width) * 4;\n      if (n == maxiterations) {\n        pixels[pix + 0] = 0;\n        pixels[pix + 1] = 0;\n        pixels[pix + 2] = 0;\n      } else {\n        pixels[pix + 0] = colorsRed[n];\n        pixels[pix + 1] = colorsGreen[n];\n        pixels[pix + 2] = colorsBlue[n];\n      }\n      x += dx;\n    }\n    y += dy;\n  }\n  updatePixels();\n  println(frameRate);\n}"},N:"Paste from noncoded source",{T:Cwz/k=,P:0-1649,L:"T",E:"\\b[0-1649]"},{T:Cw0Hs=,P:274-498,L:"T",E:"\\b[274-498]"},{T:Cw0I8=,P:273,L:"T",E:"\b"},{T:Cw0JQ=,P:272,L:"T",E:"\b"},{T:Cw0KA=,P:271,L:"T",E:"\b"},{T:Cw0Qk=,P:1436,L:"T",E:"\n\\b[1437-1437]}"},{T:Cw0Rs=,P:1437,L:"T",E:"\b"},{T:Cw0Ww=,P:271,L:"T",E:"\\b[271-271]}"},{T:Cw1hY=,P:0,L:"P",E:"let angle = 0;\n\nconst maxiterations = 100;\n\nconst colorsRed = [];\nconst colorsGreen = [];\nconst colorsBlue = [];\n\nfunction setup() {\n  pixelDensity(1);\n  createCanvas(640, 360);\n  colorMode(HSB, 1);\n\n \n  for (let n = 0; n < maxiterations; n++) {\n    \n    let hu = sqrt(n / maxiterations);\n    let col = color(hu, 255, 150);\n    colorsRed[n] = red(col);\n    colorsGreen[n] = green(col);\n    colorsBlue[n] = blue(col);\n  }\n}\n\nfunction draw() {\n  \n  let ca = cos(angle * 3.213); //sin(angle);\n  let cb = sin(angle);\n\n  angle += 0.02;\n\n  background(255);\n\n  \n  let w = 5;\n  let h = (w * height) / width;\n\n  \n  let xmin = -w / 2;\n  let ymin = -h / 2;\n\n  loadPixels();\n\n  \n  let xmax = xmin + w;\n  \n  let ymax = ymin + h;\n\n  \n  let dx = (xmax - xmin) / width;\n  let dy = (ymax - ymin) / height;\n\n  let y = ymin;\n  for (let j = 0; j < height; j++) {\n    let x = xmin;\n    for (let i = 0; i < width; i++) {\n      \n      let a = x;\n      let b = y;\n      let n = 0;\n      while (n < maxiterations) {\n        let aa = a * a;\n        let bb = b * b;\n        \n        if (aa + bb > 4.0) {\n          break; \n        }\n        let twoab = 2.0 * a * b;\n        a = aa - bb + ca;\n        b = twoab + cb;\n        n++;\n      }\n\n      \n      let pix = (i + j * width) * 4;\n      if (n == maxiterations) {\n        pixels[pix + 0] = 0;\n        pixels[pix + 1] = 0;\n        pixels[pix + 2] = 0;\n      } else {\n        pixels[pix + 0] = colorsRed[n];\n        pixels[pix + 1] = colorsGreen[n];\n        pixels[pix + 2] = colorsBlue[n];\n      }\n      x += dx;\n    }\n    y += dy;\n  }\n  updatePixels();\n  console.log(frameRate());\n}"},N:"Paste from noncoded source",{T:Cw1hA=,P:0-1437,L:"T",E:"\\b[0-1437]"},{T:Cw1pM=,P:0-3,L:"T",E:"float"},{T:Cw2y8=,P:0-1607,L:"T",E:"\\b[0-1607]"},{T:Cw2/I=,P:0,L:"P",E:"float minval = -0.5;\nfloat maxval = 0.5;\n\nSlider minSlider;\nSlider maxSlider;\n\nDiv frDiv;\n\nvoid setup() {\n  size(200, 200);\n  pixelDensity(1);\n\n  minSlider = new Slider(-2.5, 0, -2.5, 0.01);\n  maxSlider = new Slider(0, 2.5, 2.5, 0.01);\n\n  frDiv = new Div(\"\");\n}\n\nvoid draw() {\n  int maxiterations = 100;\n\n  loadPixels();\n  for (int x = 0; x < width; x++) {\n    for (int y = 0; y < height; y++) {\n\n      float a = map(x, 0, width, minSlider.getValue(), maxSlider.getValue());\n      float b = map(y, 0, height, minSlider.getValue(), maxSlider.getValue());\n\n      float ca = a;\n      float cb = b;\n\n      int n = 0;\n\n      while (n < maxiterations) {\n        float aa = a * a - b * b;\n        float bb = 2 * a * b;\n        a = aa + ca;\n        b = bb + cb;\n        if (a * a + b * b > 16) {\n          break;\n        }\n        n++;\n      }\n\n      float bright = map(n, 0, maxiterations, 0, 1);\n      bright = map(sqrt(bright), 0, 1, 0, 255);\n\n      if (n == maxiterations) {\n        bright = 0;\n      }\n\n      int pix = (x + y * width) * 4;\n      pixels[pix + 0]}