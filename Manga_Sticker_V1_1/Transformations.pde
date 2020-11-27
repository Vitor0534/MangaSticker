// in this file the transformation functions will be implemented


 // * Descriptions:
 //
 // Test 1: So far, 3 transformations, mirror, rotation and resize have been implemented, so the following points can be highlighted:
 //                 * for the transparent pixel to remain transparent in the new transformed image, it is necessary to create an image with the mode
 //                   of ARGB co and use the transparent color which is color (255.0) for RGB and color (0.0,0,0) for ARGB;
 //                 * resize problem: as expected, the resize has a problem with the quality of the png image, whenever a
 //                                   resize transformation, the quality of the figure drops. to alleviate this problem, what can be done is to implement
 //                                   a PImage caching logic on objects, that is, maintaining two variables, a Pimage_otiginal, for a high image
 //                                   quality that will be used as a reference for the transformations and a Pimage_edit variable, that the image that will be shown
 //                                   on the screen and receive any and all edits. done!
 //                                   the hypotese, is that if a high quality image is maintained and it is always used in the transformations only when receiving the
 //                                   result in another variable, the quality of the resize may be a little better, without adding the error; right
 //                 * rotate problem: as seen in the function, rotate calculates the size of the new image based on the image set for transformation,
 //                                   the question is, even if with transparent pixels the new image increases in size in the rotated angle factor, which makes
 //                                   make it look giant and outside the dimensions of the editing area. this happens at angles like 45 degrees, at 90 degrees not
 //                                             solution:  one way to solve it, would be to know if the original size of rotating the drawing then move on to the next step
 //                                                        generate a larger resulting image.


void rotacionar(Obj_Componente obj, int angle) {
  PImage image = obj.get_Pimage().copy();
  int x=obj.get_Pimage().width;
  int y=obj.get_Pimage().height;
  float rads = 2*PI*angle/360;

   // calculates the size of the row and column vectors of the new image. That is
   // made so that the original image fits within the dimensions of the next
   // image after rotation. Using the absolute value ensures that no
   // negative values returned. in case this operation is not done, the corners
   // of the rotated image can be cropped.

  int rowsf=ceil(x*abs(cos(rads))+y*abs(sin(rads)));                      
  int colsf=ceil(x*abs(sin(rads))+y*abs(cos(rads))); 

  //define an PImage withcalculated dimensionsand fill the Pimage  with transparent
  PImage image_new = new PImage(rowsf, colsf, ARGB);
  for (int i=0; i<image_new.width; i++)
    for (int j=0; j<image_new.height; j++)
      image_new.set(i, j, color(0, 0, 0, 0));

  //calculating center of original and final image
  int xo=ceil(x/2);   
  int yo=ceil(y/2); 
  int midx=ceil(image_new.width/2);
  int midy=ceil(image_new.height/2);

   //% the center of the image is important as the new image will rotate around
   //% of this amount

   //% loop to calculate the corresponding pixel coordinates of the new image
   //% according to each pixel in the original image

  for (int i=0; i<image_new.width; i++)
  {
    for (int j=0; j<image_new.height; j++)
    {
      float xn= (i-midx)*cos(rads)+(j-midy)*sin(rads);  // calculate to return the line value in the new image                                   
      float yn= -(i-midx)*sin(rads)+(j-midy)*cos(rads); // Calculate to return the column value in the new image                          
      int xp=round(xn)+xo;                              // The round function rounds the number to the nearest integer
      int yp=round(yn)+yo;                              // add the point to the center to compensate for the displacement

      if (x>=1 && y>=1 && x<=image.width &&  y<=image.height ) {                //% checks if the coordinate is within the image
        image_new.set(i, j, image.get(xp, yp));                               //% add the pixel in the x, y coordinate calculated in places
      }
    }
  }

  obj.set_Pimage(image_new);
}


// this function causes loss of quality in pnj and jpg images, such loss of quality is cumulative, that is
// the function is always used in an already transformed image it loses even more quality
// to solve this problem, a cach image logic was built, it can be said that, all operations
// that involve loss of information in the image are carried out in the cach image according to the dimensions of the editing image
// the cach image is a high quality image, in previous resizing, and also does not change, so
// whenever redize the image, the loss of quality is not mitigated;
void redimencionar(Obj_Componente obj, int escala, String condicao)
{
  //.resize(obj.get_Pimage().width*escala, obj.get_Pimage().height*escala);
  PImage image_alter;
  if (condicao.equals("+")) {
    image_alter=obj.get_cach_image().copy();
    image_alter.resize(obj.get_Pimage().width*escala, obj.get_Pimage().height*escala);
  } else {
    image_alter=obj.get_cach_image().copy();
    if( (obj.get_Pimage().width/escala >= 1) && (obj.get_Pimage().height/escala >= 1))
       image_alter.resize(obj.get_Pimage().width/escala, obj.get_Pimage().height/escala);
    else
       image_alter.resize(obj.get_Pimage().width, obj.get_Pimage().height);
  }
  obj.set_Pimage(image_alter);
}


// this function mirrors the object's image
// note that, it is necessary to create a new image in ARGB in order to manipulate the transparency element
// from the previous image, for this image mode, the function does not interfere with the background of the new transformed image 
void mirror (Obj_Componente obj, String condicao)
{
  PImage image = obj.get_Pimage().copy();
  int x=obj.get_Pimage().width;
  int y=obj.get_Pimage().height;
  PImage image_new = new PImage(x, y, ARGB);

  switch(condicao) {

  case "vertical":

    for (int i=0; i<=x; i++)
    {
      for (int j=0; j<=y; j++)
      {
        if (image.get(x-i, y-j) == color(255, 0)) {
          image_new.set(i, j, color(0, 0, 0, 0));
        } else
        {
          image_new.set(i, j, image.get(x-i, y-j));
        }
      }
    }
    obj.set_Pimage(image_new);
    break;
  case "horizontal":
    for (int i=0; i<=x; i++)
    {
      for (int j=0; j<=y; j++)
      {
        if (image.get(x-i, y-j) == color(255, 0)) {
          image_new.set(i, j, color(0, 0, 0, 0));
        } else {
          image_new.set(i, j, image.get(x-i, j));
        }
      }
    }
    obj.set_Pimage(image_new);
    break;
  default:
    println("ERRO: escolha inesistente metodo: mirro (Obj_Componente obj, String condicao)");
    break;
  }
}

//********************************************************************************************//


// **************** Transformation rules on objects *************************** ******** //
// the rule method controls what kind of component can undergo what kind of transformation
// this function is important to maintain the consistency of the components and not generate errors in the design
// it is important to note that the resize function is only applied to conductive tapes, since
// the other components have fixed sizes
boolean Transformation_Rules(Obj_Componente obj, String Name_Transformation)
{

  if (obj.name().equals("tape_horizontalop2.png") || obj.name().equals("Tape_Ink_1.png")
    || obj.name().equals("Tape_Ink_2.png") || obj.name().equals("Tape_Ink_3.png") ||
    obj.name().equals("fita_Isolante.png") || obj.name().equals("fita_Isolante_diagonal.png")) {

      switch(Name_Transformation){

      case "Resize_X-":
        if ((obj.get_Pimage().width <=10))
        {
          return false;
        }
        break;
      case "Resize_Y-":
        if ((obj.get_Pimage().height <=10))
        {
          return false;
        }
        break;
      case "XY-":
        if ((obj.get_Pimage().width <=10) || (obj.get_Pimage().height <=10))
        {
          return false;
        }
        break;
      }
      return true;
    } else {
      if(obj.ID().equals("F")){
       return true;
      }

      return false;
      //return true;
  }
}

//************** Fim do metodo de regras *********************************//
