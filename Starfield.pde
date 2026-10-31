Particle[] particles = new Particle[200];

int canvasLeft;
int canvasRight;
int canvasTop;
int canvasBottom;

void setup() {
  size(400, 400);

  canvasLeft = width/2 - 150;
  canvasRight = width/2 + 150;
  canvasTop = height/3 - 20;
  canvasBottom = height/3 + 230;

  background(255, 239, 241);
}

void draw() {

  // Wall
  background(255, 239, 241);

  // Easel Legs
  stroke(120, 80, 40);
  strokeWeight(12);
  line(width/2 - 80, height, width/2, height/3);
  line(width/2 + 80, height, width/2, height/3);

  // Frame
  fill(160, 100, 50);
  noStroke();
  rect(canvasLeft - 10, canvasTop - 10, 320, 270);

  // Canvas
  fill(255);
  rect(canvasLeft, canvasTop, 300, 250);

  // Create firework when mouse is pressed
  if (mousePressed &&
      mouseX > canvasLeft &&
      mouseX < canvasRight &&
      mouseY > canvasTop &&
      mouseY < canvasBottom) {

    createExplosion(mouseX, mouseY);
  }

  // Show all particles
  for (int i = 0; i < particles.length; i++) {

    if (particles[i] != null) {

      particles[i].move();
      particles[i].show();
    }
  }
}

void createExplosion(float x, float y) {

  for (int i = 0; i < particles.length; i++) {

    if (i == 0) {
      particles[i] = new OddballParticle(x, y);
    } else {
      particles[i] = new Particle(x, y);
    }
  }
}


// =======================
// PARTICLE SUPERCLASS
// =======================

class Particle {

  double x;
  double y;

  double angle;
  double speed;

  color c;

  Particle(float startX, float startY) {

    x = startX;
    y = startY;

    angle = random(TWO_PI);
    speed = random(1, 5);

    c = color(
      random(255),
      random(255),
      random(255)
    );
  }

  void move() {

    x += cos((float)angle) * speed;
    y += sin((float)angle) * speed;
  }

  void show() {

    fill(c);
    noStroke();

    ellipse((float)x, (float)y, 8, 8);
  }
}


// =======================
// ODDBALL SUBCLASS
// =======================

class OddballParticle extends Particle {

  OddballParticle(float startX, float startY) {

    super(startX, startY);
  }

  void move() {

    x += cos((float)angle) * speed * 2;
    y += sin((float)angle) * speed;

    y += sin(frameCount * 0.2) * 2;
  }

  void show() {

    fill(255, 0, 0);
    noStroke();

    ellipse((float)x, (float)y, 16, 16);
  }
}
