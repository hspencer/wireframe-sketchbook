
int numCols = 24;
int mobileCols = 4*2;
int tabletCols = 8*2;

PShape av;
PShape cs;
PDF pdf;
float u = 10;

void setup() {
  String filename = "grilla-"+year()+month()+day()+"-"+hour()+minute()+second()+".pdf";
  pdf = new PDF(this, mm(210), mm(297), sketchPath(filename));  
  av = loadShape("av.svg");
  cs = loadShape("cs.svg");
  pdf.strokeK(1.0);
  pdf.strokeWeight(0.2);
  pdf.strokeCap(PROJECT);
  drawGrid(4*u, 5*u, pdf.width - 8*u, pdf.height - 12*u, numCols, 1);
  pdf.shapeMode(CENTER);
  av.disableStyle();
  pdf.fillK(1);
  pdf.noStroke();
  pdf.shape(av, pdf.width/2, pdf.height - 4*u);
  pdf.dispose();
  exit();
  println("done.");
}

public float mm(float pt) {
  return pt * 2.83464567f;
}

public void drawGrid(float x, float y, float w, float h, int cols, int divs) {
  float gr = 3; // gutter ratio, expressed as 1/gr
  float gutw = w / ((cols * gr) + cols + 1);
  float colw = gutw * gr;
  float nw = cols*colw + (cols+1)*gutw; 
  h = int(h / gutw) * gutw;

  pdf.pushMatrix();
  {
    pdf.translate(x, y);
    pdf.noStroke();

    pdf.fillCMYK(.09, 0, 0, 0);
    for (int i = 0; i < cols; i++) {
      pdf.rect(i*colw + gutw*(i+1), 0, colw, h);
    }
    pdf.rectMode(CENTER);

    pdf.fillCMYK(0, 0, 0, 1f);
    for (float py = 0; py <= h + .1; py += gutw/divs) {
      for (float px = 0; px <= nw + .1; px += gutw/divs) {
        pdf.pushMatrix();
        pdf.translate(px, py);
        pdf.rotate(HALF_PI / 2);
        pdf.rect(0, 0, .5, .5);
        pdf.popMatrix();
        
      }
    }
  }

  float p1 = (gutw + colw) * (cols - tabletCols)/2  + gutw/divs;
  float p2 = (gutw + colw) * (cols - mobileCols)/2  + gutw/divs;
  float p3 = (gutw + colw) * (cols/2 + mobileCols/2)  + gutw/divs;
  float p4 = (gutw + colw) * (cols/2 + tabletCols/2) + gutw/divs;

  pdf.strokeWeight(.25);
  pdf.strokeCMYK(1, 0, 0, 0);

  pdf.line(p1, -gutw*1.5, p1, -gutw);
  pdf.line(p2, -gutw*1.5, p2, -gutw);
  pdf.line(p3, -gutw*1.5, p3, -gutw);
  pdf.line(p4, -gutw*1.5, p4, -gutw);

  pdf.line(p1, (-gutw*1.5 + -gutw)/2, p2-gutw/2, (-gutw*1.5 + -gutw)/2);
  pdf.line(p2, (-gutw*1.5 + -gutw)/2, p3, (-gutw*1.5 + -gutw)/2);
  pdf.line(p4, (-gutw*1.5 + -gutw)/2, p3+gutw/2, (-gutw*1.5 + -gutw)/2);

  pdf.popMatrix();
}

