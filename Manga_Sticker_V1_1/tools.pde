/*
// Description: this file is intended for attempts to produce tools specifically for the program, the following tools are being planned:
 //             * selecioanar_arrastar: the idea is to generate a button icon on the screen that indicates the option to select some object in the work area so that that object can
 //                                     to be dragged around the work area, something like follow_mouse, but directly on the object already present in the list; OK
 //             * delete: this function is more delicate, as it allows you to delete an object directly from the editing area. have to be aware of two issues, the arraylist of objects
 //                        and the arrayList of layers that save the buffer context of the undo function. the idea is as follows, whenever an object is excluded in position I of the 
 //                        array of objects, this same index is used to exclude the context of it from the layer arryList of the undo buffer. this has to be done in sync
 //                        so that the undo does not lose the context of the object and can perform the function normally; OK
 //                        
 //             * edit_obj: allows an object already added in the arrayList obj, to be edited as done in the follow_mouse function. to guarantee this function as well as the others, the ideal is to treat
 //                           the object properly allowing all the tools mentioned here to be used; [OK]
 //             * undo / redo: they are very important tools to facilitate the user's life, however, it is necessary to check them so that they live
 //                            in conjunction with the OK exclusion tool
 //             * Alignment: there are two lines representing the x and y axes, they follow the mouse coordinate and serve to assist the alignment of the components by the user;
 //             * Grid: it is a grid spaced in terms of centimeters in each region. the idea is to create regions of 1cm ^ 2 to give insights into the dimension of the project to 
 //                     user, also serves to align things;
 */

// This method must be associated with the mouse_drag function of processing to allow the button to be pressed continuously
// the idea is to keep a button that receives the choice of the drag option coming from the user, when he clicks on that button the parameter
// condicar_arrastar_ed is set to true and objects can now be selected from the work area to be dragged
// it is only possible to return to normal after having clicked on the drag button once more to unselect the drag option
// what the function does and track the coordinates in the mouse based on the region of the editing area and use the isOver () method
// present in each object to check if the mouse is over any object.
// the processing mousePressed primitive is used for this, so that when the user presses the mouse button above
// of any object on the desktop with the drag option, the co-coordinates of the same are changed to those of the mouse and this occurs
// until the mouse button is no longer pressed.
// once the user releases the mouse button, the option to select is set to false allowing another object to be selected
// when the user has finished he can press the button to drag the option again so the parameter condicao_arrastar_ed
// is set to false and the tool is decelected

class dragObj
{
  ArrayList<Obj_Componente> Array_obj;
  PGraphics Layer_Drag;
  Obj_Componente obj_draged;
  boolean selected;             // class control variables, indicates whether an object is selected
  boolean condicao_arrastar_ed;  // indicates whether dragging that object is allowed
  Edit_Field area_ed;
  PImage img_opcao;
  String ID;
  dragObj(ArrayList<Obj_Componente> Array_obj, Edit_Field area_ed)
  {
    this.Array_obj=Array_obj;
    this.selected=false;
    this.condicao_arrastar_ed=false;
    this.area_ed=area_ed;
    this.img_opcao = loadImage(Buttons_folder+"drag_button.png"); // small image indicating the selected tool
    this.Layer_Drag=createGraphics(50,50,P2D);
  }

  boolean get_selected()
  {
    return this.selected;
  }
  boolean get_condicao_arrastar_ed()
  {
    return this.condicao_arrastar_ed;
  }
  void set_condicao_arrastar_ed(boolean condicao_arrastar_ed)
  {
    this.condicao_arrastar_ed=condicao_arrastar_ed;
  }
  void ID(String ID)
  {
    this.ID=ID;
  }
  String ID()
  {
    return ID;
  }
  void drag(ArrayList<Obj_Componente> Array_obj, int Mx, int My)
  {
    // check if obj x has been selected
    if (selected==false && mousePressed) {
      for (int i=0; i<Array_obj.size(); i++) {
        //println("buscando objDrag");
        if (Array_obj.get(i).isOver(Mx - area_ed.x(), My - area_ed.y()))
        {
          obj_draged = Array_obj.get(i);
          this.selected=true;
          this.condicao_arrastar_ed=true;
          //println("achou objDrag");
          //obj_draged.x(mouseX);
          //obj_draged.y(mouseY);
        }
      }
    } else
    {
      //println("entrou no else Drag");
      if (this.selected==true && mousePressed)
      {
        obj_draged.x(Mx - area_ed.x());
        obj_draged.y(My - area_ed.y()); 

        // draws a rectangle around the selection to indicate that the user has inserted a new object
        noFill();
        strokeWeight(2);
        stroke(255, 0, 0);
        rect(Mx, My, obj_draged.get_Pimage().width, obj_draged.get_Pimage().height);

        //println("draging obj");
      } else {
        if (selected==true && !mousePressed)
        {
          //println("não dragando");
          selected=false; 
          //condicao_arrastar_ed=false;
        }
      }
    }

    // small image indicating the selected tool
    this.Layer_Drag.beginDraw();
    //this.Layer_Drag.tint(255,255);
    //this.Layer_Drag.image(img_opcao, mouseX+img_opcao.width/2, mouseY+img_opcao.height/2);
    this.Layer_Drag.image(img_opcao,0,0);
    this.Layer_Drag.endDraw();
    tint(255,255);
    image( this.Layer_Drag,mouseX+img_opcao.width/2, mouseY+img_opcao.height/2);
  }
}
// ************** End dragObj class in the editing area *************************** ************* //



// **************** start of the grid and alignment tools ************************** ****** //

// ***** alignment class //
// Description: this class manages the design of an alignment indicator in the region of the editing area
//           basically there are two lines parallel to the x and y axes, which follow the mouse coordinate
//           crossing from end to end the editing region. this tool serves as a type of alignment
//           for the user can use reference to build their projects


class eixo_xy
{
  //Edit_Field area_ed;
  boolean condicao_de_ativamento;

  eixo_xy(boolean condicao_de_ativamento)
  {
    //this.area_ed=area_ed;
    this.condicao_de_ativamento=condicao_de_ativamento;
  }
  void set_condicao_de_ativamento(boolean condicao_de_ativamento)
  {
    this.condicao_de_ativamento=condicao_de_ativamento;
  }
  boolean get_condicao_de_ativamento()
  {
    return this.condicao_de_ativamento;
  }


  void draw_eixo_XY(color c, float stroke_Weight, Edit_Field area_ed, int Mx, int My)
  {
    if (area_ed.isOver_mouse(Mx, My)) {

      //linha do eixo x
      stroke(c);
      strokeWeight(stroke_Weight);
      line(area_ed.x(), My, area_ed.x()+area_ed.Largura(), My);

      //linha do eixo y
      stroke(c);
      strokeWeight(stroke_Weight);
      line(Mx, area_ed.y(), Mx, area_ed.y()+area_ed.Altura());
    }
  }
}



// *** grid class ***************** //
// Description: the grid is a type of graduation that can be applied over the editing area
//              in this case, this grid can be spaced in several measures, however, the default is 1cm
//              the idea is to use successive lines until you create the entire grid above the work area
//              the grid can have a variable to set the spacing between the intervals in the grid

class Grid
{
  //Edit_Field area_ed;
  boolean condicao_de_ativamento;

  Grid(boolean condicao_de_ativamento)
  {
    //this.area_ed=area_ed;
    this.condicao_de_ativamento=condicao_de_ativamento;
  }
  void set_condicao_de_ativamento(boolean condicao_de_ativamento)
  {
    this.condicao_de_ativamento=condicao_de_ativamento;
  }
  boolean get_condicao_de_ativamento()
  {
    return this.condicao_de_ativamento;
  }


  void draw_Grid(color c, float stroke_Weight, Edit_Field area_ed, int espacamento)
  {
    boolean linha=false, coluna=false;
    for (int i=0; (linha==false || coluna==false) ; i += espacamento) {

      //traços na vertical
      if (i < area_ed.Largura()) {
        stroke(c);
        strokeWeight(stroke_Weight);
        line(area_ed.x()+i, area_ed.y(), area_ed.x()+i, area_ed.y()+area_ed.Altura());
      } else {
        linha=true;
      }
      //traços na horizontal
      if (i < area_ed.Altura())
      {
        stroke(c);
        strokeWeight(stroke_Weight);
        line(area_ed.x(), area_ed.y()+i, area_ed.x()+area_ed.Largura(), area_ed.y()+i);
      } else {
        coluna=true;
      }
    }
  }


  void draw_Grid_PDF(color c, float stroke_Weight, PGraphics Layer_PDF, Edit_Field area_ed, int espacamento)
  {
    boolean linha=false, coluna=false;
    for (int i=0; (linha==false || coluna==false) ; i+=espacamento) {

      if (i < area_ed.Largura()) {
        Layer_PDF.stroke(c);
        Layer_PDF.strokeWeight(stroke_Weight);
        Layer_PDF.line(area_ed.x()+i - area_ed.x(), area_ed.y()-area_ed.y(), area_ed.x()+i-area_ed.x(), area_ed.y()+area_ed.Altura()-area_ed.y());
      } else {
        linha=true;
      }
      if (i < area_ed.Altura())
      {
        Layer_PDF.stroke(c);
        Layer_PDF.strokeWeight(stroke_Weight);
        Layer_PDF.line(area_ed.x()-area_ed.x(), area_ed.y()+i-area_ed.y(), area_ed.x()+area_ed.Largura()-area_ed.x(), area_ed.y()+i-area_ed.y());
      } else {
        coluna=true;
      }
    }
  }

}
// ************************* end of grid class ****************** ************************ //



// ****************************** start class object editing ************* ****************************** //
// description: the idea is that this class makes it possible to edit a specific object in the editing area
//           be it F or C. in this case, the idea is to use a button to select the object once
//           when the user clicks on an object, it is selected and editing options are allowed.
//           it is necessary to pay attention to the editing rules, you have to leave it open to configure the same ones
//           Since circuit components and figures are treated differently. whereas, the circuit
//           there are differences in component-by-component editing Figures are free to transform
// Operation: the idea is to pass the parameters of component arraylists and have a trace of the objects
//            once the user clicks on the object in the editing area, it is outlined with a green rectangle, indicating
//            the editing option, after the necessary transformations or deletion have been made, it is enough that the user deselects
//            the option.


class Edit_Obj
{
  ArrayList<Obj_Componente> Array_obj;
  Obj_Componente obj_draged;
  int indice_obj;
  boolean selected;                  // indicates if you have an obj selected
  boolean condicao_de_edicao;        // indicates whether it is allowed to edit an object at that time
  boolean condicao_de_ativamento;    // indicates that the object editing class has been activated
  Edit_Field area_ed;
  PImage img_opcao;
  String ID;
  PGraphics Layer_Drag;
  undo_redo_obj undo_redo;

  //int cont_very=0;

  Edit_Obj(ArrayList<Obj_Componente> Array_obj, Edit_Field area_ed, undo_redo_obj undo_redo, PImage img_opcao)
  {
    this.Array_obj=Array_obj;
    this.selected=false;
    this.condicao_de_edicao=false;
    this.condicao_de_ativamento=false;
    this.area_ed=area_ed;
    this.img_opcao = img_opcao; //loadImage(Buttons_folder+"drag_button.png"); //imagem pequena que indica a ferramenta selecionada
    this.undo_redo = undo_redo;
    this.Layer_Drag=createGraphics(50,50,P2D);
  }

  boolean get_condicao_de_ativamento()
  {
    return this.condicao_de_ativamento;
  }
  void set_condicao_de_ativamento(boolean condicao_de_ativamento)
  {
    this.condicao_de_ativamento=condicao_de_ativamento;
  }

  boolean get_selected()
  {
    return this.selected;
  }
  void set_selected(boolean selected)
  {
    this.selected=selected;
  }
  boolean get_condicao_de_edicao()
  {
    return this.condicao_de_edicao;
  }
  void set_condicao_de_edicao(boolean condicao_de_edicao)
  {
    this.condicao_de_edicao=condicao_de_edicao;
  }
  void ID(String ID)
  {
    this.ID=ID;
  }
  String ID()
  {
    return ID;
  }
  void Selection(ArrayList<Obj_Componente> Array_obj, int Mx, int My)
  {
    this.Array_obj=Array_obj; //atribui o array de seleção ao parametro do objeto
    // verifica se o obj x foi selecionado
    if (selected==false && mousePressed && area_ed.isOver_mouse(Mx, My)) {
      //this.condicao_de_edicao=false;
      for (int i=0; i<Array_obj.size(); i++) {
        //println("buscando obj_edição");
        if (Array_obj.get(i).isOver(Mx - area_ed.x(), My - area_ed.y()))
        {
          obj_draged = Array_obj.get(i);
          this.indice_obj=i; //pega index do objeto para caso ouver uma exclusão
          this.selected=true;
          this.condicao_de_edicao=true;
          //println("achou o obj de edição");
          //obj_draged.x(mouseX);
          //obj_draged.y(mouseY);
        }
      }
      delay(40); // delay to compensate for mouse click time
    } else
    {
      //println("entrou no else Drag");
      if (this.selected==true && condicao_de_edicao==true && !mousePressed)//&& this.cont_very<2)
      {
        //obj_draged.x(Mx - area_ed.x());
        //obj_draged.y(My - area_ed.y()); 
        //if(mousePressed){
        //this.cont_very++;
        //delay(10); //delay para compensar o tempo de clique do mouse
        //}
        // draws a rectangle around the selection to indicate that the user has selected an object
        noFill();
        strokeWeight(2);
        stroke(0, 255, 0);
        rect(obj_draged.x()+area_ed.x(), obj_draged.y() + area_ed.y(), obj_draged.get_Pimage().width, obj_draged.get_Pimage().height);
        //println("espera por comando");// obj cont_very = " +  cont_very);
      } else {
        if (selected==true && mousePressed && area_ed.isOver_mouse(Mx, My))// this.cont_very==2)
        {
          //delay(40);
          //println("Nova Seleção");
          selected=false; 
          this.condicao_de_edicao=false;
          //this.cont_very=0;
          //condicao_arrastar_ed=false;
        }
      }
    }

    // small image indicating the selected tool
    //image(img_opcao, mouseX+img_opcao.width/2, mouseY+img_opcao.height/2, 20, 20);
    this.Layer_Drag.beginDraw();
    this.Layer_Drag.image(img_opcao,0,0,20,20);
    this.Layer_Drag.endDraw();
    tint(255,255);
    image(this.Layer_Drag,mouseX+img_opcao.width/2, mouseY+img_opcao.height/2);
  }



  //************** redimencionar ******************//
  void Resize_Obj_Selected(String eixo, String condicao, int razao)
  {
    if (this.condicao_de_edicao==true && this.selected==true)
    {

      //println("RESIZE AREA DE EDIÇÃO");
      PImage image_alter;
      image_alter=this.obj_draged.get_cach_image().copy();

      if (eixo.equals("x") || eixo.equals("X")) {
        if (condicao.equals("+") && Transformation_Rules(this.obj_draged, "Resize_X+")) {
          image_alter.resize(this.obj_draged.get_Pimage().width + razao, this.obj_draged.get_Pimage().height);
        } else {
          if (condicao.equals("-") && Transformation_Rules(this.obj_draged, "Resize_X-")) {

            image_alter.resize(this.obj_draged.get_Pimage().width - razao, this.obj_draged.get_Pimage().height);
          } else {
            image_alter.resize(this.obj_draged.get_Pimage().width, this.obj_draged.get_Pimage().height);
          }
        }
        this.obj_draged.set_Pimage(image_alter);
      } else {


        if (eixo.equals("y") || eixo.equals("Y")) {

          if (condicao.equals("+") && Transformation_Rules(this.obj_draged, "Resize_Y+")) {

            image_alter.resize(this.obj_draged.get_Pimage().width, this.obj_draged.get_Pimage().height + razao);
          } else {

            if (condicao.equals("-") && Transformation_Rules(this.obj_draged, "Resize_Y-")) {

              image_alter.resize(this.obj_draged.get_Pimage().width, this.obj_draged.get_Pimage().height - razao);
            } else
            {
              image_alter.resize(this.obj_draged.get_Pimage().width, this.obj_draged.get_Pimage().height);
            }
          }
          this.obj_draged.set_Pimage(image_alter);
        } else {



          if (eixo.equals("xy") || eixo.equals("XY")) {
            if (condicao.equals("+") && Transformation_Rules(this.obj_draged, "XY+")) {
              image_alter.resize(this.obj_draged.get_Pimage().width + razao, this.obj_draged.get_Pimage().height + razao);
            } else {
              if (condicao.equals("-") && Transformation_Rules(this.obj_draged, "XY-")) {
                image_alter.resize(this.obj_draged.get_Pimage().width - razao, this.obj_draged.get_Pimage().height - razao);
              } else
              {
                image_alter.resize(this.obj_draged.get_Pimage().width, this.obj_draged.get_Pimage().height);
              }
            }
            this.obj_draged.set_Pimage(image_alter);
          }
        }
      }
    }
  }// ********** order resize ******************** //


  // ************** start rotate function ***************** //

  void rotacionar(int angle) {
    PImage image = this.obj_draged.get_Pimage().copy();
    int x=this.obj_draged.get_Pimage().width;
    int y=this.obj_draged.get_Pimage().height;
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

     // the center of the image is important as the new image will rotate around
     //of this amount

     // loop to calculate the corresponding pixel coordinates of the new image
     //according to each pixel in the original image

    for (int i=0; i<image_new.width; i++)
    {
      for (int j=0; j<image_new.height; j++)
      {
        float xn= (i-midx)*cos(rads)+(j-midy)*sin(rads);  // calculate to return the line value in the new image                                    
        float yn= -(i-midx)*sin(rads)+(j-midy)*cos(rads); // Calculate to return the column value in the new image                           
        int xp=round(xn)+xo;                              // The round function rounds the number to the nearest integer
        int yp=round(yn)+yo;                              // add the point to the center to compensate for the displacement

        if (x>=1 && y>=1 && x<=image.width &&  y<=image.height ) {               //% checks if the coordinate is within the image
          image_new.set(i, j, image.get(xp, yp));                               //% add the pixel in the x, y coordinate calculated in places
        }
      }
    }

    this.obj_draged.set_Pimage(image_new);
  }

 // ************ end function rotate ********************** //






// ********** mirror ********************* //


   // this function mirrors the object's image
   // note that, it is necessary to create a new image in ARGB in order to manipulate the transparency element
   // from the previous image, for this image mode, the function does not interfere with the background of the new transformed image
  void mirror (String condicao)
  {

    if (this.condicao_de_edicao==true && this.selected==true)
    {

      PImage image = this.obj_draged.get_Pimage().copy();
      int x=this.obj_draged.get_Pimage().width;
      int y=this.obj_draged.get_Pimage().height;

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
        this.obj_draged.set_Pimage(image_new);
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
        this.obj_draged.set_Pimage(image_new);
        break;
      default:
        println("ERROR: choose nonexistent method: mirror (Obj Component obj, String condition)");
        break;
      }
    }
  }
  // ************** end mirro ********************** //



// ***************** function that deletes the selected object **************** //
  void Excluir_Obj()
  {
    if (this.condicao_de_edicao==true && this.selected==true)
    {
      this.undo_redo.Delete_index(this.obj_draged, this.indice_obj);
      Obj_Componente aux = Array_obj.remove(this.indice_obj);
      println("objeto "+aux.name()+" Excluido --> indice = "+this.indice_obj);

      // how the object was deleted, disables object selection
      this.condicao_de_edicao=false;
      this.selected=false;
    }
  }
  //**************** fim da função *****************************************//

// ************* start of top_down functions ******************* //
// such functions increase or decrease the index of the object selected in 1 to send it up or down in the array of objects
// this allows the user to choose which object overlaps the other

// increments the object's index by 1
  void to_Top()
  {
    if (this.condicao_de_edicao==true && this.selected==true)
    {

      if (this.indice_obj < this.Array_obj.size()-1)
      {
        this.Array_obj.remove(this.indice_obj); //remove o objeto da posição anterior
        this.indice_obj++;
        this.Array_obj.add(this.indice_obj, this.obj_draged);  //add o objeto no novo indice
        println("to_Top(): Adds the component: " + this.obj_draged.name()+ " in index = " +  this.indice_obj);
      }
    }
  }
  
// decrements the object's index by 1
  void to_Down()
  {
    if (this.condicao_de_edicao==true && this.selected==true)
    {
      if (this.indice_obj > 0)
      {
        this.Array_obj.remove(this.indice_obj); //remove o objeto da posição anterior
        this.indice_obj--;
        this.Array_obj.add(this.indice_obj, this.obj_draged); //add o objeto no novo indice
        println("to_Down(): Adds the component: " + this.obj_draged.name()+ " in index = " +  this.indice_obj);
      }
    }
  }
  
  
  
}

// ************************ End of editing class ******************* ****************************** //






// ********** Undo / Redo ************************** //

// * The following functions implement the undo and redo actions, in which case they work by manipulating the object and layer lists
// at first all lists in size () == 0, and all objects added to the lists are counted by the layer list
// the list of layers controls who should be excluded at that moment, the index indicates which component was last added which is where the undo should start
// flowchart:
  // 1) at each click the list of layers is incremented with the corresponding obj layer added, the index is incremented by 1;
  // 2) whenever an object is added, the corresponding list is incremented by this object lista_componente or lista_Figura
  // 3) undo: if an undo is triggered, the index in the layer list is checked to know that obj will be removed from the list_obj and added to your waiting list, the last one is always removed
 //            Figure: Lista_Espera_Figura.add (lista_Objetos_manga.remove (lista_Objetos_manga.size () - 1));
 //            Circuit: Lista_Espera_Circuito.add (lista_Objetos_Circuit.remove (lista_Objetos_Circuit.size () - 1));
 //            indice--;
  // 4) redo: whenever a redo is triggered, the next index of the layer list is checked (index + 1) to know which list of obj will be removed, the last one of the wait is removed and add to the_objlist
 //          Figure: lista_Objetos_manga.add (Lista_Espera_Figura.remove (Lista_Espera_Figura.size () - 1));
 //          Circuit: lista_Objetos_Circuit.add (Lista_Espera_Circuito.remove (Lista_Espera_Circuito.size () - 1));
 //          indice++;
 //  5) If an undo is used and then an obj is added, the layer list is cleared from the index forward and the waiting lists are also cleared to maintain the consistency of the program.

class undo_redo_obj
{

  ArrayList<Obj_Componente>  lista_Objetos_Circuit;
  ArrayList<Obj_Componente> lista_Objetos_manga;
  ArrayList<Obj_Componente>  Lista_Espera_Circuito;
  ArrayList<Obj_Componente>  Lista_Espera_Figura;
  ArrayList<PGraphics>  Lista_Layers;  // array that saves the context of changes
  int indice;

  undo_redo_obj(ArrayList<Obj_Componente>  lista_Objetos_Circuit, ArrayList<Obj_Componente> lista_Objetos_manga)
  {
    this.Lista_Layers = new ArrayList();
    this.Lista_Espera_Figura= new ArrayList();
    this.Lista_Espera_Circuito= new ArrayList();
    this.lista_Objetos_Circuit = lista_Objetos_Circuit;
    this.lista_Objetos_manga = lista_Objetos_manga;
    this.indice=0;
  }

  void set_lista_Objetos_Circuit(ArrayList<Obj_Componente>  lista_Objetos_Circuit)
  {
    this.lista_Objetos_Circuit=lista_Objetos_Circuit;
  }

  ArrayList<Obj_Componente> get_lista_Objetos_Circuit()
  {
    return this.lista_Objetos_Circuit;
  }

  void set_lista_Objetos_manga(ArrayList<Obj_Componente>  lista_Objetos_manga)
  {
    this.lista_Objetos_manga=lista_Objetos_manga;
  }

  ArrayList<Obj_Componente> get_lista_Objetos_manga()
  {
    return this.lista_Objetos_manga;
  }


  //lsitas de espera
  void set_Lista_Espera_Figura(ArrayList<Obj_Componente>  Lista_Espera_Figura)
  {
    this.Lista_Espera_Figura=Lista_Espera_Figura;
  }

  ArrayList<Obj_Componente> get_Lista_Espera_Figura()
  {
    return this.Lista_Espera_Figura;
  }


  void set_Lista_Espera_Circuito(ArrayList<Obj_Componente>  Lista_Espera_Circuito)
  {
    this.Lista_Espera_Circuito=Lista_Espera_Circuito;
  }

  ArrayList<Obj_Componente> get_Lista_Espera_Circuito()
  {
    return this.Lista_Espera_Circuito;
  }

  void buffer_ctrrl_z(PGraphics Layer)
  {
    //if(indice == Lista_Layers.size()){
    // Lista_Layers.add(Layer);
    //indice++;
    //}
    if (indice != Lista_Layers.size()) {
      for (int i=Lista_Layers.size()-1; i>indice; i--) {
        PGraphics L = Lista_Layers.remove(i);
        if (L==rect1)
          println("rect1 -- i= "+i+" removed");
        else
          println("rect2 -- i= "+i+" removed");
      }
      indice=Lista_Layers.size();
    }

    Lista_Layers.add(Layer);
    indice++;
    println("add obj indice = "+ String.valueOf(indice));
    //println("entrei no lugar linha 291");

    if (indice == Lista_Layers.size())
      println("ok ok ok ok ok ok ok ok");

    if (Lista_Layers.size()>0 && indice-1>=0) {
      if (Lista_Layers.get(indice-1) == rect1) {
        println("indice = " + String.valueOf(indice) + " Layer = rect1");
      }
      if (Lista_Layers.get(indice-1) == rect2) {
        println("indice = " + String.valueOf(indice) + " Layer = rect2");
      }
    }
     // if a new object is created, the waiting list of the previous ones is cleared, this removes some bugs and inconsistencies
     // that may arise in the circuit design
    Lista_Espera_Figura.removeAll(Lista_Espera_Figura);
    Lista_Espera_Circuito.removeAll( Lista_Espera_Circuito);
  }

  void ctrl_Z_2 ()
  {
    // checks the position of the buffer and assigns the previous background to the current background

    if (Lista_Layers.size()>0) {

      PGraphics Layer;

      //verificia se o indice está dentro dos limites do array
      if (indice>0) {
        Layer = Lista_Layers.get(indice-1);
      } else {
        Layer = Lista_Layers.get(0);
      }

      if (Layer == rect1) {
        if (lista_Objetos_Circuit.size() >0 && lista_Objetos_Circuit.get(lista_Objetos_Circuit.size()-1) !=null ) {  // && contagem>0 && (contagem - contagem_Z)>0){
          //indice_buffer--;
          //Remove o ultimo elemento e adiciona na lista de espera 
          Lista_Espera_Circuito.add(lista_Objetos_Circuit.remove(lista_Objetos_Circuit.size()-1));
          //contagem_Z++;
          println("Undo: ");
          println("indice = " +  String.valueOf(indice) + " undo");
          println("Lista_Espera_Circuito.size() = " + Lista_Espera_Circuito.size());
          println("lista_Objetos_Circuit.size() = " + lista_Objetos_Circuit.size());
          if (indice>0)
            indice--;
        }
      } else {
        if (Layer == rect2) {
          if (lista_Objetos_manga .size() >0 && lista_Objetos_manga .get(lista_Objetos_manga .size()-1) !=null ) {  

            //Remove o ultimo elemento e adiciona na lista de espera 
            Lista_Espera_Figura.add(lista_Objetos_manga.remove(lista_Objetos_manga.size()-1));

            println("Undo: ");
            println("indice = " +  String.valueOf(indice) + " undo");
            println("Lista_Espera_Figura.size() = " + Lista_Espera_Figura.size());
            println("lista_Objetos_manga.size() = " + lista_Objetos_manga.size());


            if (indice>0)
              indice--;
          }
        }
      }
    }
  }

  void ctrl_Y_2 ()
  {

    if (Lista_Layers.size()>0) {

      PGraphics Layer;

      //verificia se o indice está dentro dos limites do array
      if (indice < Lista_Layers.size()-1) {
        Layer = Lista_Layers.get(indice);
      } else {
        Layer = Lista_Layers.get(Lista_Layers.size()-1);
      }

      if (Layer == rect1 ) {
        if (Lista_Espera_Circuito.size() >0 && Lista_Espera_Circuito.get(0) !=null ) {  // && contagem>0 && (contagem - contagem_Z)>0){
          //indice_buffer--;
          //Remove o ultimo elemento e adiciona na lista de circuito
          lista_Objetos_Circuit.add(Lista_Espera_Circuito.remove(Lista_Espera_Circuito.size()-1));
          //contagem_Z++;
          indice++;

          println("Redo: ");
          println("indice = " +  String.valueOf(indice) + " redo");
          println("Lista_Espera_Circuito.size() = " + Lista_Espera_Circuito.size());
          println("lista_Objetos_Circuit.size() = " + lista_Objetos_Circuit.size());
        }
      } else {
        if (Layer == rect2) {
          if (Lista_Espera_Figura.size() >0 && Lista_Espera_Figura .get(0) !=null ) {  
            //Remove o ultimo elemento e adiciona na lista de Circuito
            lista_Objetos_manga.add(Lista_Espera_Figura.remove(Lista_Espera_Figura.size()-1));
            indice++;


            println("Undo: ");
            println("indice = " +  String.valueOf(indice) + " redo");
            println("Lista_Espera_Figura.size() = " + Lista_Espera_Figura.size());
            println("lista_Objetos_manga.size() = " + lista_Objetos_manga.size());
          }
        }
      }
    }
  }

  PGraphics Delete_index(Obj_Componente obj, int index)
  {
    if (Lista_Layers.size() > 0 && index < Lista_Layers.size() && Lista_Layers.get(index) != null) {

      int index_obj_Cont=0; // variable that checks the correct position of object exclusion
      int index_obj_very=0; // variable that counts the indices within the layer vector

      for (int i=0; i<Lista_Layers.size(); i++)
      {
        if (obj.ID().equals("F") && Lista_Layers.get(i) == rect2 && index_obj_very < index)
        {
          index_obj_Cont=i;
          index_obj_very++;
        } else
        {
          if (obj.ID().equals("C") && Lista_Layers.get(i) == rect1 && index_obj_very < index)
          {
            index_obj_Cont=i; // get correct position
            index_obj_very++; // add to the index count
          }
        }
      }

      this.indice--;
      println("Excludes position from arrayLayers do undo --> index_obj_Cont:" + index_obj_Cont);
      return this.Lista_Layers.remove(index_obj_Cont);
    } else {
      return null;
    }
  }

  boolean Insert_index(int index, PGraphics Layer)
  {
    this.Lista_Layers.add(index, Layer);
    return true;
  }
}

// *********************************** End of undo / redo class ****** ************************************* //




// ********************************** toolbox for editing selected components from the editing area ** *********************** //

// Description: The idea is that when the user uses the editing tool for objects in the editing area, a toobox is opened, which in this case is a
//              window containing buttons with the editing options that the user has for that object. the idea is that he can click on these buttons to perform
//              carry out the desired transformations on the object. thus, the transformation toolbox will contain the following options:
//                  * Resize:
//                           - X+;
//                           - X-;
//                           - Y+;
//                           - Y-
//                           - (+) : for both x and y;
//                           - (-) : for both x and y;
//                  * Rotate: in only one direction which is the one that is already implemented or can put in both, just see the step you have to use;
//                  * mirror: 
//                           - horizontal;
//                           - vertical;



// button list object with images that form the listview fields
class toolbox_Edicao
{

  boolean condicao_de_ativamento;  // indicates if the toolbox button was clicked and it is enabled for use

  ArrayList<Obj_Componente> Lista_Obj;
  PGraphics Layer_Lista;  //background da lista
  String prefixo;
  int x;
  int y;
  int lagura_lista;
  int altura_lista;
  int qtd_buttons;
  int inicio;
  boolean hide;
  int espaco_coluna;
  int espaco_linhas;
  int qtd_Linhas;
  int qtd_Colunas;
  ArrayList<PImage> buttons;
  Lista_Buttons lista_buttons_tools;
  PImage [] face_2;

   
  toolbox_Edicao(ArrayList<PImage> buttons, String prefixo, int x, int y, int lagura_lista, int altura_lista, int qtd_Linhas, int qtd_Colunas, 
    int espaco_coluna, int espaco_linhas, boolean hide, boolean condicao_de_ativamento)
  {
    this.Lista_Obj = new ArrayList<Obj_Componente>();
    this.buttons = buttons;
    //this.Lista_Obj = Lista_Obj;
    this.prefixo=prefixo;   //identifica qual lista está sendo selecionada
    this.x=x;
    this.y=y;
    this.inicio=0;
    this.lagura_lista=lagura_lista;
    this.altura_lista=altura_lista;
    Layer_Lista = createGraphics(this.lagura_lista, this.altura_lista, P2D);  //inicializa background da lista 
    //this.qtd_buttons=qtd_buttons;
    this.qtd_Linhas=qtd_Linhas;
    this.qtd_Colunas=qtd_Colunas;
    this.espaco_coluna=espaco_coluna;
    this.espaco_linhas=espaco_linhas;
    this.qtd_buttons=(this.qtd_Linhas*this.qtd_Colunas);
    this.hide=hide;
    this.condicao_de_ativamento=condicao_de_ativamento;

    // Obj_Componente(PImage componente, int x, int y)
    for (int i=0; i<this.buttons.size(); i++)
    {
      this.Lista_Obj.add(new Obj_Componente(this.buttons.get(i), 0, 0));
    }

    this.lista_buttons_tools = new Lista_Buttons(this.Lista_Obj, this.prefixo, this.x, this.y, this.lagura_lista, this.altura_lista, this.qtd_Linhas, this.qtd_Colunas, 
      this. espaco_coluna, this.espaco_linhas, this.hide);


    // ************ creating buttons for passing items next and previous ************* //

    face_2=new PImage[3];

    face_2[0] =  loadImage(Buttons_folder+"button_next_little_arrow_1_R.png");
    face_2[1] =  loadImage(Buttons_folder+"button_next_little_arrow_2_R.png");
    face_2[2] =  loadImage(Buttons_folder+"button_next_little_arrow_3_R.png");
    create_button_IMG("next_toolbox_Edicao", 0, 872, 344, 10, 10, true, face_2);

    face_2[0] =  loadImage(Buttons_folder+"button_next_little_arrow_1_L.png");
    face_2[1] =  loadImage(Buttons_folder+"button_next_little_arrow_2_L.png");
    face_2[2] =  loadImage(Buttons_folder+"button_next_little_arrow_3_L.png");
    create_button_IMG("back_toolbox_Edicao", 0, 801, 344, 10, 10, true, face_2);
  }// ******************** end of the constructor ************************* *********** //

  ArrayList<Obj_Componente> get_Lista_Obj()
  {
    return this.Lista_Obj;
  }

  void set_Lista_Obj(ArrayList<Obj_Componente> Lista_Obj)
  {
    this.Lista_Obj=Lista_Obj;
  }

  int get_Largura()
  {
   return this.lagura_lista;
  }
  void set_Largura(int lagura_lista)
  {
   this.lagura_lista=lagura_lista;
  }
  int get_Altura()
  {
   return this.altura_lista;
  }
  void set_Altura(int altura_lista)
  {
   this.altura_lista=altura_lista;
  }

  //funções responsáveis de passarem os objetos na lista
  void proximo()
  {
    this.lista_buttons_tools.proximo();
  }
  void anterior()
  {
    this.lista_buttons_tools.anterior();
  }

  void show(int x, int y)
  {
    this.lista_buttons_tools = null;
    this.lista_buttons_tools = new Lista_Buttons(this.Lista_Obj, this.prefixo, x, y, this.lagura_lista, this.altura_lista, this.qtd_Linhas, this.qtd_Colunas, 
      this. espaco_coluna, this.espaco_linhas, this.hide);
    //mostra botões de proximo e anterior
    this.lista_buttons_tools.lista_Butoons_show();
    cp5.get(Button.class, "back_toolbox_Edicao").setPosition(x+2, y+this.altura_lista-10);
    cp5.get(Button.class, "next_toolbox_Edicao").setPosition(x+cp5.get(Button.class, "back_toolbox_Edicao").getWidth()+7, y+this.altura_lista-10);
    cp5.get(Button.class, "next_toolbox_Edicao").show();
    cp5.get(Button.class, "back_toolbox_Edicao").show();
  }

  //metodo que esconde a lista para não ser vista e nem atrapalhar outras telas do programa 
  void hide()
  {
    cp5.get(Button.class, "next_toolbox_Edicao").hide();
    cp5.get(Button.class, "back_toolbox_Edicao").hide();
    this.lista_buttons_tools.hide_Lista_toobox_tela2();
  }

  boolean get_condicao_de_ativamento()
  {
    return this.condicao_de_ativamento;
  }
  void set_condicao_de_ativamento(boolean condicao_de_ativamento)
  {
    this.condicao_de_ativamento=condicao_de_ativamento;
  }


   // function that triggers the background of the figure toobox list, ATTENTION: it must always be called in the loop after the background of the main screen
   // the buttons are above the controlP5 default pgraphic
  void Background(color c, int tint)
  {
    // show layer behind buttons
    this.lista_buttons_tools.Lista_Background(c, tint);
  }
}

// ********** functions for next and previous controls ****************************** ********** //
void back_toolbox_Edicao()
{
  if (button==1)
    toolbox_ED.anterior();
}

void next_toolbox_Edicao()
{
  if (button==1)
    toolbox_ED.proximo();
}


// ********************** order toolbox of tools ********************** ******************************* //


// ********************* start of the Text tool NEXT UPDATES ********************* ************************************* //
/*
// Description: the idea of this class is to implement a common text tool. summary the idea is that the user can write a text or
//              in a random location on the screen, or inside a text box and, from that text, an image is generated that will be inserted
//              in the picture list. With this tool the user can insert texts in the interactive manga or annotations in the circuit so that it does not interfere with anything
//              the idea is that the basic text editing functions are present, such as:
//                     * space;
//                     * skip line with enter;
//                     * delete character;
//                     * copy and paste if possible;
//                     * select part if possible;
*/
