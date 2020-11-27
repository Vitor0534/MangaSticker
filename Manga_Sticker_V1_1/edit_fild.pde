/* Description:
//         this class manages all the editing area, that is, the area where the user is allowed to paste the components
//         the idea is to create a class based on the size of a PGraphic, in this way besides allowing the management of the area as well as its
//         coordinate, it is still possible to resize the area according to sheet size, for example A3, A4, card and etc.
// note: with the implementation of this class, the program loses dependence on the dimensions of the background, this makes it possible to resize the screen in real time
//       the program also loses dependence on global layer variables and the functions of the editing area are all encapsulated in a single object
// obs2: with the presence and use of this class, it is also possible to work on the idea of N editing areas, this is interesting to create other types of artifacts
//       such as books in tunnels or even working with more layers of leaves
// obs 3: the class also makes it possible to change the work area in real time, this means that it is possible to change the dimensions from A3 to A4 or to card, for example
*/


// class that defines a dynamic workspace for the circuit sticker design
// the class has an ID parameter that allows differentiating between the circuit and Figure work areas
class Edit_Field
{
  // parametros
  PGraphics Area_ED;
  PGraphics Layer_PDF;
  String ID;
  int largura;
  int altura;
  int x;
  int y;
  
  Edit_Field(int x, int y, int largura, int altura, String ID)
  {
  this.largura=largura;
  this.altura=altura;
  this.x=x;
  this.y=y;
  this.Area_ED = createGraphics(this.largura,this.altura,P2D);
  this.ID=ID;
  }
  
  PGraphics get_Layer()
  {
    return this.Area_ED;
  }
  void set_Layer(PGraphics Area_ED)
  {
    this.Area_ED=Area_ED;
  }

  int x()
  {
    return this.x;
  }
  int y()
  {
    return this.y;
  }
  void x(int x)
  {
    this.x=x;
  }
  void y(int y)
  {
    this.y=y;
  }
  String ID()
  {
    return this.ID;
  }
  int Largura(){
    return this.largura;
  }
  void Largura(int largura){
    this.largura=largura;
  }
  
  int Altura(){
    return this.altura;
  }
  void Altura(int altura){
    this.altura=altura;
  }
  
  void set_dimensao(int largura, int altura)
  {
    this.largura=largura;
    this.altura=altura;
  }

  //função que verifica se o mouse está sobre este item 
  boolean isOver_mouse(float Mx, float My)
  {
    if (( Mx>=this.x && Mx<= (this.x+this.Area_ED.width) ) &&
      (My>=this.y && My<= (this.y+this.Area_ED.height)))
    {
      return true;
    }
    return false;
  }
  // function that checks if the object is on this item
  boolean isOver_Obj(Obj_Componente obj,float Mx, float My)
  {
    if (( Mx>=this.x && (Mx + obj.get_Pimage().width)<= (this.x+this.Area_ED.width) ) &&
        (My>=this.y && (My + + obj.get_Pimage().height)<= (this.y+this.Area_ED.height)))
    {
      return true;
    }
    return false;
  }
  
  
  void Draw_Layer(ArrayList <Obj_Componente> lista_Obj, int tint)
{
  // draws all circuit objects on the screen
  //Layer.beginDraw();
  //Layer.clear();  //tem um bug que deixa a tela preta, e impede de usar o ctrl+z tem que ver isso  undo/redo
  if (lista_Obj != null && lista_Obj.size()>0) {
    //println("Draw_layer/ lista_Obj.size()" + lista_Obj.size());
    for (int i=0; i<lista_Obj.size(); i++)
    {
      // println("Mostra item = " + i);
      //if(i<test)
      //if(lista_Obj.get(i)!=null)
      Obj_Draw(this.Area_ED, lista_Obj.get(i), tint);

      //tint(255, tint);
      //Layer.beginDraw();
      //Layer.clear();
      //Layer.image(lista_Obj.get(i).get_Pimage(), lista_Obj.get(i).x, lista_Obj.get(i).y);
      //println("Draw_Layer i= " + i);
      //Layer.endDraw();
    }

    //Layer.endDraw();
    //tint(255, tint);
    //image(Layer, 0, 0);
  }
}

// Draw the object on the specified layer
void Obj_Draw(PGraphics Area_ED, Obj_Componente obj, int tint)
{

  Area_ED.beginDraw();
  Area_ED.clear();
  Area_ED.image(obj.get_Pimage(), obj.x, obj.y);
  Area_ED.endDraw();
  tint(255, tint);
  image(Area_ED,this.x,this.y);  // the presence of this command here solved the bug of disappearing the previous objs and made the tint work correctly
}

// **************** function that draws objects directly into PDF based on layer size ******************* ***** //
void Draw_Layer_On_PDF(ArrayList <Obj_Componente> lista_Obj, String nome_PDF)
{
 
  //desenha todos os objetos do array passado no PDF
  if (lista_Obj != null && lista_Obj.size()>0) {
    
    //println("Imprimindo...");
      //Cria PDF que será salvo
    this.Layer_PDF= createGraphics(this.largura,this.altura,PDF,PDF_folder+nome_PDF+".pdf");
    
    //println("Draw_layer/ lista_Obj.size()" + lista_Obj.size());
    Layer_PDF.beginDraw();
    Layer_PDF.background(255);
    for (int i=0; i<lista_Obj.size(); i++)
    {

      // println("Mostra item = " + i);
      //if(i<test)
      tint(255, 255);
      Layer_PDF.image(lista_Obj.get(i).get_Pimage(), lista_Obj.get(i).x, lista_Obj.get(i).y);
      //Obj_Draw_PDF(this.Layer_PDF, lista_Obj.get(i), 255);
      
    }
    
    if(Grid_Graduada.get_condicao_de_ativamento()){
    Grid_Graduada.draw_Grid_PDF(color(0,0,255),0.5, Layer_PDF, LayerEd_Figuras,Pixel_to_cm);
    }
    
    Layer_PDF.dispose();   //it´s necessary when drawing into pdf
    Layer_PDF.endDraw();
    
   // println("Impressão completa...");

  }
  
}

// Draw the object on the specified PDF layer
void Obj_Draw_PDF(PGraphics Area_ED_PDF, Obj_Componente obj, int tint)
{
  Area_ED_PDF.beginDraw();
  Area_ED_PDF.background(255);
  tint(255, tint);
  Area_ED_PDF.image(obj.get_Pimage(), obj.x, obj.y);
  Area_ED_PDF.dispose();
  Area_ED_PDF.endDraw();
}

} 

// fim obejto da area de edição

void fundo_Edit_Field(Edit_Field field)
{
  fill(255);
  noStroke();
  rect(field.x(), field.y(), field.Largura(), field.Altura());
}

// this approach makes the program super slow
//void fundo_Edit_Field(Edit_Field field)
//{
//  PGraphics fundo = createGraphics(field.Largura(),field.Altura(),P2D);
//  fundo.beginDraw();
//  fundo.clear();
//  fundo.fill(255);
//  fundo.noStroke();
//  fundo.rect(field.x(), field.y(), field.Largura(), field.Altura());
//  fundo.endDraw();
//  image(fundo,field.x(),field.y());
//}
