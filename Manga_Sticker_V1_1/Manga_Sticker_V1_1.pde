/**
*  MangaSticker:
*
* This is a project created as a final course work, in the computer engineering course by PUC-GO
*
* MangaSticker is a tool for creating interactive manga by integrating circuit sticker with manga
* The purpose of the tool is to provide a modeling environment where you can view the manga and the circuit sticker
* concomitantly. Artifacts can be designed using the editing area and tools. The tool
* has the option to print interactive mangas on two A4 sheets, one for the manga side and the other
* for the circuit side. Once printed, the components must be positioned on the circuit sheet and that sheet
* is superimposed with the manga to generate the interactive manga.
*
* 
* As standard, the tool brings some pre-modeled characters and elements of scenarios and inserted in the lists.
* Simple circuit elements are also present, such as LEDs, conductive tape and PushButtons
*
*
* By Vitor de Almeida Silva, 2020
*
*/

// importing required libraries
import java.util.ArrayList;
import java.io.*;
import processing.pdf.*;  // Import PDF code, for printing frames in a pdf file
import controlP5.*;       // library for using buttons and interface interaction functionse
import java.io.File;
import uibooster.*;       // library for controlling pop-up notifications for the user
import uibooster.components.*;

//Componente_Circuito


// configuration of path prefixes for object folders, pictures and default buttons
String Buttons_folder = "Buttons/";
String Circuit_folder ="/Circuit_Components/";
String Figure_folder ="/Figure_Components/";
String PDF_folder = "PDFs_Projects/";
String Project_Folder = "Projects/";

// creation of fonts to be used in program messages 
PFont font_arial;


// variable that contains the value of 1 centimeter in pixels according to the dimensions of the ed area
int Pixel_to_cm = 47;

// Creating background variables;
PImage Background;
PImage Background_2;
//PImage Background_3;


//Layers
PGraphics rect1;  // circuit layer
PGraphics rect2;  // manga layer
PGraphics Cursor; // layer for selected objects
PGraphics toobox_Circuito; // Layers for the available circuit components
PGraphics toobox_Figuras;  // Layers for figures available for editing

// component and figure editing area
Edit_Field  LayerEd_Componentes;
Edit_Field  LayerEd_Figuras;

// ArrayList to store objects, the idea is to keep two lists one for each layer, Components and characters
ArrayList<Obj_Componente> lista_Objetos_manga;

// ArrayList to store circuit objects
ArrayList<Obj_Componente> lista_Objetos_Circuit;

// ArrayList to store the Figures from the toolbox
ArrayList<Obj_Componente> lista_Figuras_TooBox;

// ArrayList to store the Toolbox Components
ArrayList<Obj_Componente> lista_Circuito_TooBox;



// ************* tool settings *****************************

// ************ creating tool object for undo / redo *************** //
undo_redo_obj undo_redo;

// class for dragging objects in the editing area
dragObj Tool_drag;
// create editing tool
Edit_Obj edicao_obj;

// creating XY axis tool for component alignment 
eixo_xy eixo_XY_Ed;
Grid Grid_Graduada;

// creating editing tool toolbox
toolbox_Edicao toolbox_ED;


// ****** button configuration ***** ////
ControlP5 cp5; // all buttons will be created from this controlP5 to cp5
int button=0;

// ******* notification window configuration for user ******************* //
UiBooster booster;
WaitingDialog waitingDialog;  // waiting message

// *** images for the back button of screen 2 ************** //
PImage [] face;

// ************* object used to drag components across the screen *************** //
componente_Drag follow_mouse_obj;  // create a new OBJECT from dragging objects



void setup()
{
  // setting the dimensions of windows and layers
  //size(1200, 800, P2D);
  size(1690, 930, P2D);
  //surface.setResizable(true);  // allows the window size to be resized
  //surface.setSize(200,200);
  //frameRate(100);  // this rate can generate an error in the initialization of the program "5000ms waited"


 
  // ************ MangaCircuit environment wait message
  booster = new UiBooster();
  waitingDialog = booster.showWaitingDialog( "Configuring environment, please wait ....", "Setting up environment");

  //******* configuração da área de edição**************************//
  //layer 1 componentes de circuito
  rect1= createGraphics(width, height, P2D);   //circuito
  rect2= createGraphics(width, height, P2D);   //Fugura

  // ************ The edit_Field class is now being used ******************** //
  //Edit_Field(int x, int y, int largura, int altura, String ID)
  //LayerEd_Componentes = new Edit_Field(15, 16, 763, 773, "C");
  //LayerEd_Figuras = new Edit_Field(15, 16, 763, 773, "F");
  LayerEd_Componentes = new Edit_Field(15, 31, 1248, 882, "C");
  LayerEd_Figuras = new Edit_Field(15, 31, 1248, 882, "F");


  Cursor = createGraphics(width, height, P2D);
  toobox_Circuito= createGraphics(width, height, P2D);
  toobox_Figuras= createGraphics(width, height, P2D);

  //*****************************************************************//

  // Configurando background para a janela 2
  Background_2 = loadImage("Screen_2_Gray.png");
  Background_2.resize(width, height);


// ***************** initializing program sources ******************* //
waitingDialog.setMessage("initializing program sources ....");
font_arial = createFont("arial",32);



  //inicializando ArrayList de objetos manga
  lista_Objetos_manga = new ArrayList();

  //inicializando ArrayList de objetos de circuito
  lista_Objetos_Circuit = new ArrayList();

  //inicializando ArrayList de Figuras
  lista_Figuras_TooBox= new ArrayList();

  //inicializando ArrayList de componentes de circuito
  lista_Circuito_TooBox= new ArrayList();


  //***** Configurando toobox de cicuito e figuras ********//
  waitingDialog.setMessage("Configuring circuit and figure toolbox ....");
  configura_TooBox_Circuito();
  configura_TooBox_Figuras(Figure_folder);

  waitingDialog.setMessage("Configuring buttons and tool toolbox ....");
  
  //**********Configurando botões***********************//
   
  //inicializa objeto ControlP5
  cp5 = new ControlP5(this);

  cria_botoes_Tela_1(); //cria botões da tela 1

  cria_botoes_Tela_2(); //cria botões da tela 2

 


  //********************configuração do objeto de arrastar e colar *************************//
  //a principio só é declarado, posteriormente será acionado quando um objeto for selecionado na toolbox
  follow_mouse_obj = new componente_Drag (null, false);


  //************configurações do arrastar pela tela obj da área de edição****************//
  Tool_drag = new dragObj(lista_Objetos_manga, LayerEd_Figuras);
  
  //************configurações das ferramentas de alinhamento de componentes *******************//
  // eixo_xy(boolean condicao_de_ativamento)
  // Grid(boolean condicao_de_ativamento)
  eixo_XY_Ed = new eixo_xy(false);
  Grid_Graduada = new  Grid(false);
  
  
  //************************ configurando toolbox para ferramentas de edição de objetos da área de edição *****************//
  //toolbox_ED = new toolbox_Edicao(buttons_images, "TED", 1019, 406, 140, 140, 2, 2, 
  //               50, 50, true,false);
  //Configura_Toolbox_ED(int x, int y, int largura, int altura, int N_linhas, 
  //                        int N_coluna, int espaco_Linha, int espaco_Coluna, String Buttons_folder)
  Configura_Toolbox_ED(1019,406,140,140,2,2,50,50,Buttons_folder);
  
  
  //************ criando objeto tool para undo/redo ***************//
  //undo_redo_obj(ArrayList<Obj_Componente>  lista_Objetos_Circuit, ArrayList<Obj_Componente> lista_Objetos_manga)
  undo_redo=new undo_redo_obj (lista_Objetos_Circuit, lista_Objetos_manga);

  //************* cria ferramenta de dição de objetos na área de edição ***********************************//
  //Edit_Obj(ArrayList<Obj_Componente> Array_obj, Edit_Field area_ed,  undo_redo_obj undo_redo)
  //loadImage(Buttons_folder+"drag_button.png"); //imagem pequena que indica a ferramenta selecionada
  edicao_obj = new Edit_Obj(lista_Objetos_manga, LayerEd_Figuras, undo_redo,loadImage(Buttons_folder+"Select_button.png"));
  
  
  button=1;  // variável que abilita os botões para funcionar, importante para não gerar erro na inicialização
  waitingDialog.setMessage("Configured environment :)");
  waitingDialog.close(); // fecha mensagem de carregamento
  
}

//*************fim settup***********************************************


//************função que imprime uma mensagem qualquer na tela***************//
void msg_carregamento(String MSG, int x, int y, String font_name, int tam_font,color c)
{
  PFont font = createFont(font_name,tam_font);
  textFont(font);
  textSize(tam_font);
  fill(c);
  text(MSG,x,y);
}

// ************** End of function ******************************* *************** //

// Class that receives the objects used by the user
// it can be used with an arrayList to control each component created in the project
// this class applies the adapted sprite concept to the mangaCircuit tool
// the sprite allows both figure and circuit objects to be created
// with more versatility and simplicity, as well as, shown on the screen in an organized way
// and consistent
class Obj_Componente
{
  //atributos
  PImage componente; // low quality image for storage and use on the screen
  PImage cach_Image; // high quality image to perform transformations
  int x;
  int y;
  String ID; //C ou F
  String name;  // normally used to differentiate circuit components

  Obj_Componente(PImage componente, int x, int y)
  {
    this.componente = componente;
    this.x=x;
    this.y=y;
  }

  Obj_Componente(PImage componente, int x, int y, String ID, String name)
  {
    this.componente = componente;
    this.x=x;
    this.y=y;
    this.ID=ID;
    this.name=name;
  }

  Obj_Componente(PImage componente, PImage cach_Image, int x, int y, String ID, String name)
  {
    this.componente = componente;
    this.cach_Image = cach_Image;
    this.x=x;
    this.y=y;
    this.ID=ID;
    this.name=name;
  }

  PImage get_Pimage()
  {
    return this.componente;
  }
  void set_Pimage(PImage componente)
  {
    this.componente=componente;
  }
  PImage get_cach_image()
  {
    return this.cach_Image;
  }
  void  set_cach_image(PImage cach_imag)
  {
    this.cach_Image=cach_imag;
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

  String name()
  {
    return this.name;
  }

  // function that checks if the mouse is over this item
  boolean isOver(float Mx, float My)
  {
    if (( Mx>=this.x && Mx<= (this.x+this.componente.width) ) &&
      (My>=this.y && My<= (this.y+this.componente.height)))
    {
      return true;
    }
    return false;
  }
}

// ************************** order component object ******************* **************************** //


// ********************** Function that creates Component and sets its coordinates ****************** ***** //


void create_Componente(PGraphics layer, Obj_Componente componente, int x, int y)
{
  //layer.image(componente,x,y);
  if (layer == rect2) {
    //Obj_Componente(PImage componente, PImage cach_Image, int x, int y, String ID, String name)
    //lista_Objetos_manga.add(new Obj_Componente(componente, x - LayerEd_Figuras.x(), y-LayerEd_Figuras.y()));
    lista_Objetos_manga.add(new Obj_Componente(componente.get_Pimage().copy(),componente.get_cach_image().copy(), x - LayerEd_Figuras.x(), y-LayerEd_Figuras.y(), "F", componente.name()));
    println("ADD manga  nome = " + componente.name());
  } else {
    if (layer == rect1) {
      //repare que tem que ser feita a compensação da area de edição nas coordenada com a butração do ponto x,y da mesma
      lista_Objetos_Circuit.add(new Obj_Componente(componente.get_Pimage().copy(),componente.get_cach_image().copy(), x - LayerEd_Componentes.x(), y - LayerEd_Componentes.y(), "C", componente.name()));
      println("ADD circuito nome= " + componente.name());
    }
  }
  //desenha um retangulo em volta da seleção para indicar que o user inseriu um novo objeto
  noFill();
  strokeWeight(2);
  stroke(0, 0, 255);
  rect(x, y, componente.get_Pimage().width, componente.get_Pimage().height);
  //adiciona a informação da criação do objeto no buffer de undo/redo
  undo_redo.buffer_ctrrl_z(layer);
}

// ******************** fim da função que cria componentes ***************************************//


// class that manages dragging objects across the screen
// the follow_mouse function must be called within the draw () function
// likewise, for the dragging action to start, it is necessary to first set an object for the class and trigger the
// drag condition with a true
class componente_Drag
{
  PGraphics Layer_Drag_mouse;
  Obj_Componente componente_Dragable;
  boolean drag;

  componente_Drag(Obj_Componente componente_Dragable, boolean drag)
  {
    this. componente_Dragable = componente_Dragable;
    this.drag =drag;
    this.Layer_Drag_mouse = createGraphics(width, height, P2D);
  }

  void follow_mouse(int X1ed, int X2ed, int Y1ed, int Y2ed, int tint)
  {
    // o objeto arrasto só é visualizado na área de edição, da mesma forma somente pode ser adicionado nesta área em expecífico
    if (componente_Dragable!=null && this.drag) {

      if ((mouseX >= X1ed && (mouseX+componente_Dragable.get_Pimage().width)<= X2ed) && (mouseY >= Y1ed && (mouseY+componente_Dragable.get_Pimage().height) <= Y2ed)) {
        Layer_Drag_mouse.beginDraw();
        pushMatrix();
        Layer_Drag_mouse.clear();
        //translate(mouseX,mouseY);

        //Layer_Drag_mouse.image(componente_Dragable, mouseX, mouseY);
        Layer_Drag_mouse.image(componente_Dragable.get_Pimage(), mouseX, mouseY);

        popMatrix();
        Layer_Drag_mouse.endDraw();
        tint(255, tint);
        image(Layer_Drag_mouse, 0, 0);
      }
    }
  }
  //isOver_Obj(Obj_Componente obj,float Mx, float My)
  void follow_mouse(Edit_Field Area, int tint)
  {
    // o objeto arrasto só é visualizado na área de edição, da mesma forma somente pode ser adicionado nesta área em expecífico
    if (componente_Dragable!=null && this.drag) {

      // verifica se o objeto a ser arrastado está dentro da área de edição
      if (Area.isOver_Obj(componente_Dragable, mouseX, mouseY)) {
        Layer_Drag_mouse.beginDraw();
        pushMatrix();
        Layer_Drag_mouse.clear();
        //translate(mouseX,mouseY);
        //Layer_Drag_mouse.image(componente_Dragable, mouseX, mouseY);
        Layer_Drag_mouse.image(componente_Dragable.get_Pimage(), mouseX, mouseY);
        popMatrix();
        Layer_Drag_mouse.endDraw();
        tint(255, tint);
        image(Layer_Drag_mouse, 0, 0);
      }
    }
  }
  void set_Obj_Dragable(Obj_Componente componente_Dragable)
  {
    this. componente_Dragable = componente_Dragable;
  }

  Obj_Componente get_Obj_Dragable()
  {
    return this. componente_Dragable;
  }

  void set_drag_acionador(boolean drag)
  {
    this.drag=drag;
  }
  boolean get_drag_acionador()
  {
    return this.drag;
  }

  PGraphics get_PGraphic()
  {
    return this.Layer_Drag_mouse;
  }
}
// ********************* fim classe dragable *************************//

//*********************** inicio configurações toolbox ********************************************//


// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
File[] listFiles(String dir) {
  println("Dir = " + dir);
  File file = new File(dir);
  if (file.isDirectory()) {
    println("pesquisando arquivos de figura...");
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    println("File não é um diretório");
    return null;
  }
}

// the configuration functions are responsible for generating the initial toobox models
// in this case, the circuit toobox is fixed, while the figure toobox can be added by adding more figures
void configura_TooBox_Circuito()
{
  // variáveis de edição
  PImage img_ed;
  PImage img_ori;
  //Obj_Componente(PImage componente, PImage cach_Image, int x, int y, String ID, String name)
  //Circuit_folder
  //Obj_Componente  obje_Tape_ink1 = new Obj_Componente(Tape_inkop2, 808, 37);
  //lista_Circuito_TooBox.add(0, obje_Tape_ink1);

  //tape ink
  lista_Circuito_TooBox.add(0, new Obj_Componente(loadImage(Circuit_folder+"tape_horizontalop2.png").copy(), loadImage(Circuit_folder+"tape_horizontalop2.png"), 808, 37, "C", "tape_horizontalop2.png"));
  lista_Circuito_TooBox.add(1, new Obj_Componente(loadImage(Circuit_folder+"Tape_Ink_1.png").copy(), loadImage(Circuit_folder+"Tape_Ink_1.png"), 808, 37, "C", "Tape_Ink_1.png"));
  lista_Circuito_TooBox.add(2, new Obj_Componente(loadImage(Circuit_folder+"Tape_Ink_2.png").copy(), loadImage(Circuit_folder+"Tape_Ink_2.png"), 808, 37, "C", "Tape_Ink_2.png"));
  lista_Circuito_TooBox.add(3, new Obj_Componente(loadImage(Circuit_folder+"Tape_Ink_3.png").copy(), loadImage(Circuit_folder+"Tape_Ink_3.png"), 808, 37, "C", "Tape_Ink_3.png"));

  // ************* push button, the default push button is 0.8x0.8 cm

  //lista_Circuito_TooBox.add(4, new Obj_Componente(loadImage(Circuit_folder+"Push_Button_1.png").copy(), loadImage(Circuit_folder+"Push_Button_1.png"), 808, 37, "C", "Push_Button_1.png"));
  //img_ed = loadImage(Circuit_folder+"Push_Button_1.png");
  //img_ed.resize(round(0.5*Pixel_to_cm), round(0.5*Pixel_to_cm));
  //img_ori = loadImage(Circuit_folder+"Push_Button_1.png");
  //img_ori.resize(round(0.5*Pixel_to_cm),round(0.5*Pixel_to_cm));
  //lista_Circuito_TooBox.add(4, new Obj_Componente(img_ed.copy(), img_ori.copy(), 808, 37, "C", "Push_Button_1.png"));
  
  img_ed = loadImage(Circuit_folder+"Push_Button_1.png").copy();
  img_ed.resize(round(0.7*Pixel_to_cm), round(0.432*Pixel_to_cm));
  img_ori = loadImage(Circuit_folder+"Push_Button_1.png");
  lista_Circuito_TooBox.add(4, new Obj_Componente(img_ed.copy(), img_ori.copy(), 808, 37, "C", "Push_Button_1.png"));
  
  img_ed = loadImage(Circuit_folder+"Push_Button_2.png").copy();
  img_ed.resize(round(0.432*Pixel_to_cm), round(0.7*Pixel_to_cm));
  img_ori = loadImage(Circuit_folder+"Push_Button_2.png");
  lista_Circuito_TooBox.add(5, new Obj_Componente(img_ed.copy(), img_ori.copy(), 808, 37, "C", "Push_Button_2.png"));
  
  img_ed = loadImage(Circuit_folder+"Push_Button_3.png").copy();
  img_ed.resize(round(0.9*Pixel_to_cm), round(0.7*Pixel_to_cm));
  img_ori = loadImage(Circuit_folder+"Push_Button_3.png");
  lista_Circuito_TooBox.add(6, new Obj_Componente(img_ed.copy(), img_ori.copy(), 808, 37, "C", "Push_Button_3.png"));
  
  img_ed = loadImage(Circuit_folder+"Push_Button_4.png").copy();
  img_ed.resize(round(0.9*Pixel_to_cm), round(0.7*Pixel_to_cm));
  img_ori = loadImage(Circuit_folder+"Push_Button_4.png");
  lista_Circuito_TooBox.add(7, new Obj_Componente(img_ed.copy(), img_ori.copy(), 808, 37, "C", "Push_Button_4.png"));
  
//************** LED default, os leds tem 2cm de largura e 2cm de comprimento *************************** //
  
  //lista_Circuito_TooBox.add(8, new Obj_Componente(loadImage(Circuit_folder+"LED_Default_1.png").copy(), loadImage(Circuit_folder+"LED_Default_1.png"), 808, 37, "C", "LED_Default_1.png"));
  img_ed = loadImage(Circuit_folder+"LED_Default_1.png");
  img_ed.resize(2*Pixel_to_cm, 2*Pixel_to_cm);
  img_ori = loadImage(Circuit_folder+"LED_Default_1.png");
  img_ori.resize(2*Pixel_to_cm, 2*Pixel_to_cm);
  lista_Circuito_TooBox.add(8, new Obj_Componente(img_ed.copy(), img_ori.copy(), 808, 37, "C", "LED_Default_1.png"));
  
  //lista_Circuito_TooBox.add(9, new Obj_Componente(loadImage(Circuit_folder+"LED_Default_2.png").copy(), loadImage(Circuit_folder+"LED_Default_2.png"), 808, 37, "C", "LED_Default_2.png"));
  img_ed = loadImage(Circuit_folder+"LED_Default_2.png");
  img_ed.resize(2*Pixel_to_cm, 2*Pixel_to_cm);
  img_ori = loadImage(Circuit_folder+"LED_Default_2.png");
  img_ori.resize(2*Pixel_to_cm, 2*Pixel_to_cm);
  lista_Circuito_TooBox.add(9, new Obj_Componente(img_ed.copy(),img_ori.copy(), 808, 37, "C", "LED_Default_2.png"));
  
  //lista_Circuito_TooBox.add(10, new Obj_Componente(loadImage(Circuit_folder+"LED_Default_3.png").copy(), loadImage(Circuit_folder+"LED_Default_3.png"), 808, 37, "C", "LED_Default_3.png"));
  img_ed = loadImage(Circuit_folder+"LED_Default_3.png");
  img_ed.resize(2*Pixel_to_cm, 2*Pixel_to_cm);
  img_ori = loadImage(Circuit_folder+"LED_Default_3.png");
  img_ori.resize(2*Pixel_to_cm, 2*Pixel_to_cm);
  lista_Circuito_TooBox.add(10, new Obj_Componente(img_ed.copy(),img_ori.copy(), 808, 37, "C", "LED_Default_3.png"));
  
  //lista_Circuito_TooBox.add(11, new Obj_Componente(loadImage(Circuit_folder+"LED_Default_4.png").copy(), loadImage(Circuit_folder+"LED_Default_4.png"), 808, 37, "C", "LED_Default_4.png"));
  img_ed = loadImage(Circuit_folder+"LED_Default_4.png");
  img_ed.resize(2*Pixel_to_cm, 2*Pixel_to_cm);
  img_ori = loadImage(Circuit_folder+"LED_Default_4.png");
  img_ori.resize(2*Pixel_to_cm, 2*Pixel_to_cm);
  lista_Circuito_TooBox.add(11, new Obj_Componente(img_ed.copy(),img_ori.copy(), 808, 37, "C", "LED_Default_4.png"));
  
// ************************** End of default LED element settings **************** ************************************* //

// ************************** start of separator settings 1, 5 and 10 cm *********** **************************** //

  //lista_Circuito_TooBox.add(8, new Obj_Componente(loadImage(Circuit_folder+"LED_Default_1.png").copy(), loadImage(Circuit_folder+"LED_Default_1.png"), 808, 37, "C", "LED_Default_1.png"));
  img_ed = loadImage(Circuit_folder+"U_Espacamento_1cm.png");
  img_ed.resize(1*Pixel_to_cm, 1*Pixel_to_cm);
  img_ori = loadImage(Circuit_folder+"U_Espacamento_1cm.png");
  img_ori.resize(1*Pixel_to_cm, 1*Pixel_to_cm);
  lista_Circuito_TooBox.add(12, new Obj_Componente(img_ed.copy(), img_ori.copy(), 808, 37, "C", "U_Espacamento_1cm.png"));
  
  //lista_Circuito_TooBox.add(9, new Obj_Componente(loadImage(Circuit_folder+"LED_Default_2.png").copy(), loadImage(Circuit_folder+"LED_Default_2.png"), 808, 37, "C", "LED_Default_2.png"));
  img_ed = loadImage(Circuit_folder+"U_Espacamento_1cm_op2.png");
  img_ed.resize(1*Pixel_to_cm, 1*Pixel_to_cm);
  img_ori = loadImage(Circuit_folder+"U_Espacamento_1cm_op2.png");
  img_ori.resize(1*Pixel_to_cm, 1*Pixel_to_cm);
  lista_Circuito_TooBox.add(13, new Obj_Componente(img_ed.copy(),img_ori.copy(), 808, 37, "C", "U_Espacamento_1cm_op2.png"));
  
  //lista_Circuito_TooBox.add(10, new Obj_Componente(loadImage(Circuit_folder+"LED_Default_3.png").copy(), loadImage(Circuit_folder+"LED_Default_3.png"), 808, 37, "C", "LED_Default_3.png"));
  img_ed = loadImage(Circuit_folder+"U_Espacamento_5cm.png");
  img_ed.resize(5*Pixel_to_cm, 5*Pixel_to_cm);
  img_ori = loadImage(Circuit_folder+"U_Espacamento_5cm.png");
  img_ori.resize(5*Pixel_to_cm, 5*Pixel_to_cm);
  lista_Circuito_TooBox.add(14, new Obj_Componente(img_ed.copy(),img_ori.copy(), 808, 37, "C", "U_Espacamento_5cm.png"));
  
  //lista_Circuito_TooBox.add(11, new Obj_Componente(loadImage(Circuit_folder+"LED_Default_4.png").copy(), loadImage(Circuit_folder+"LED_Default_4.png"), 808, 37, "C", "LED_Default_4.png"));
  img_ed = loadImage(Circuit_folder+"U_Espacamento_5cm_op2.png");
  img_ed.resize(5*Pixel_to_cm, 1*Pixel_to_cm);
  img_ori = loadImage(Circuit_folder+"U_Espacamento_5cm_op2.png");
  img_ori.resize(5*Pixel_to_cm, 1*Pixel_to_cm);
  lista_Circuito_TooBox.add(15, new Obj_Componente(img_ed.copy(),img_ori.copy(), 808, 37, "C", "U_Espacamento_5cm_op2.png"));
  
  
  img_ed = loadImage(Circuit_folder+"U_Espacamento_10cm.png");
  img_ed.resize(10*Pixel_to_cm, 10*Pixel_to_cm);
  img_ori = loadImage(Circuit_folder+"U_Espacamento_10cm.png");
  img_ori.resize(10*Pixel_to_cm, 10*Pixel_to_cm);
  lista_Circuito_TooBox.add(16, new Obj_Componente(img_ed.copy(),img_ori.copy(), 808, 37, "C", "U_Espacamento_10cm.png"));


//********************** fima da configuraçãos dos separadores ***********************************************************//

// ********************  Inicio configuração das tapes isolantes **********************************//
  
 //fita isolante horizontal
 lista_Circuito_TooBox.add(17, new Obj_Componente(loadImage(Circuit_folder+"fita_Isolante.png").copy(), loadImage(Circuit_folder+"fita_Isolante.png"), 808, 37, "C", "fita_Isolante.png"));
  
  //fita isolante diagonal
 lista_Circuito_TooBox.add(18, new Obj_Componente(loadImage(Circuit_folder+"fita_Isolante_diagonal.png").copy(), loadImage(Circuit_folder+"fita_Isolante_diagonal.png"), 808, 37, "C", "fita_Isolante_diagonal.png"));

// ********************  Fim da configuração das tapes isolantes   ***********************************//

}
// end of setting circuit


void configura_TooBox_Figuras(String Figure_folder_plus)
{
// create a vector file addresses for the paste of figures
   // this vector contains the name of all the images present in the figure paste
   // it can be used to create the objects in the figure toolbox
   // the path to the paste is the variable defined in the program header
  String path = sketchPath()+"/"+Figure_folder_plus;
  //String path=Figure_folder;
  File [] Figures_List = listFiles(path);

  //Obj_Componente(PImage componente, PImage cach_Image, int x, int y, String ID, String name)
  // preenche a toolbox de circuito com as imagens do diretorio de figuras
  for (int i=0; i< Figures_List.length; i++)
  {
    PImage Figure = loadImage(Figures_List[i].getAbsolutePath());

    //Figure.resize(111, 282);
    //verificar esse comando para redimencionar de acordo com as dimenssões da área de edição
    PImage Re_Figure = Figure.copy();
    Re_Figure.resize(Re_Figure.width/6, Re_Figure.height/6); //redimensiona a figura de edição para caber na área de ed a princípio
    Obj_Componente New_Obj = new Obj_Componente(Re_Figure, Figure, 0, 0, "F", Figures_List[i].getName());
    lista_Figuras_TooBox.add(i, New_Obj);
    println("insert picture= " +i + " name: " + New_Obj.name());
  }


  //Obj_Componente  obj_personagem1 = new Obj_Componente(Personagem1, 813, 436);
  //Obj_Componente  obj_personagem2 = new Obj_Componente(Personagem2, 863, 486);
  //lista_Figuras_TooBox.add(0, obj_personagem1);
  //lista_Figuras_TooBox.add(1, obj_personagem2);
  //Draw_Layer(toobox_Circuito, lista_Circuito_TooBox, 255);
}


// ******************* End of toolbox settings ************************ ******* //




// ************** main function loop draw ****************************** ************ //
// all screens were separated into functions in order to maintain the best possible organization of contexts


int tint_layer1=255;
int tint_layer2=255;
boolean imprimir_Circuito=false;
boolean imprimir_Manga = false;
int Numero_Tela=1;    // Variable that controls which screen should be shown at that moment
void draw()
{
  switch(Numero_Tela) {
  case 1:
    Tela_1_Edicao();
    break;
  case 2:
    Tela_2_Selecao_Figuras();
    break;
  case 3:
    break;
  default:
    break;
  }
}

//**********************fim draw******************************************************//





// ******************* Home Tela_1_Edicao ************************* ///

// variáveis que verificam a inicialização das listas
int Veri_list_Tela1=0;
int Veri_inicia_Tela1=0;

// configuration of the list of figures for selection;;

// ***** Pictures toolbox settings ******* //
Lista_Buttons  listToolBox_Figuras_Tela1;

String prefixo_ToolBox_Figuras = "F";
//int Coordenada_x_ToolBox_Figuras=797;
//int Coordenada_y_ToolBox_Figuras=406;
int Coordenada_x_ToolBox_Figuras=1279;
//int Coordenada_y_ToolBox_Figuras=406;
int Coordenada_y_ToolBox_Figuras=432;
int Largura_ToolBox_Figuras=382, Altura_ToolBox_Figuras=367;
int qtd_Linhas_Toolbox_Figuras=1;
int qtd_colunas_Toolbox_Figuras=1;
int distancia_Linhas_Toolbox_Figuras=40;
int distancia_Colunas_Toolbox_Figuras=40;
boolean hide__Toolbox_Figuras=true;


// ***** circuit toolbox settings ******* //
Lista_Buttons  listToolBox_Circuito_Tela1;

String prefixo_ToolBox_Circuito = "C";
int Largura_ToolBox_Circuito=382, Altura_ToolBox_Circuito=367;
int Coordenada_x_ToolBox_Circuito=1279;
//int Coordenada_y_ToolBox_Circuito=28;
int Coordenada_y_ToolBox_Circuito=54;
int qtd_Linhas_Toolbox_Circuit=3;
int qtd_colunas_Toolbox_Circuit=2;
int distancia_Linhas_Toolbox_Circuit=40;
int distancia_Colunas_Toolbox_Circuit=40;
boolean hide__Toolbox_Circuit=true;

void Cria_Listas_Tela_1()
{
  //Lista_Buttons(ArrayList<Obj_Componente> Lista_Obj,String prefixo, int x, int y, int lagura_lista, int altura_lista,int qtd_Linhas, int qtd_Colunas,
  //             int espaco_coluna, int espaco_linhas, boolean hide)


  // Para teste, substitua a lista de figuras pela lista de componentes manga  //lista_Objetos_manga  //lista_Figuras_TooBox
  listToolBox_Circuito_Tela1 = new Lista_Buttons(lista_Circuito_TooBox, prefixo_ToolBox_Circuito, Coordenada_x_ToolBox_Circuito, Coordenada_y_ToolBox_Circuito, 
    Largura_ToolBox_Circuito, Altura_ToolBox_Circuito, qtd_Linhas_Toolbox_Circuit, qtd_colunas_Toolbox_Circuit, 
    distancia_Linhas_Toolbox_Circuit, distancia_Colunas_Toolbox_Circuit, hide__Toolbox_Circuit);

  listToolBox_Figuras_Tela1 = new Lista_Buttons(lista_Figuras_TooBox, prefixo_ToolBox_Figuras, Coordenada_x_ToolBox_Figuras, Coordenada_y_ToolBox_Figuras, 
    Largura_ToolBox_Figuras, Altura_ToolBox_Figuras, qtd_Linhas_Toolbox_Figuras, qtd_colunas_Toolbox_Figuras, 
    distancia_Linhas_Toolbox_Figuras, distancia_Colunas_Toolbox_Figuras, hide__Toolbox_Figuras);
}


void inicia_toolbox()
{
  if (Veri_list_Tela1==0) {
    Cria_Listas_Tela_1();
    Veri_list_Tela1=1;
    Veri_inicia_Tela1=1;
  }
  if (Veri_inicia_Tela1==1)
  {
    listToolBox_Figuras_Tela1.lista_Butoons_show(); 
    listToolBox_Circuito_Tela1.lista_Butoons_show();
    Veri_inicia_Tela1=0;
  }
}


void Tela_1_Edicao()
{

  inicia_toolbox();

   // with each cycle of the loop draw the background is superimposed on everything, this ensures the update of the frames and cleaning of the background
   // it updates the background
  //background(Background);
  //background(194, 214, 237); //Azul
  background(230, 229, 232); //cinza
  //background(176, 157, 255); //rojo
  //background(92, 90, 255); //azul escuro
  //image(Background,width,height);
  //background(185,207,234);
  fundo_Edit_Field(LayerEd_Componentes);  // estranho pq isso buga o printf depois da adição de muitos obj
  
  LayerEd_Componentes.Draw_Layer(lista_Objetos_Circuit, tint_layer1);
  
  //desenha todos os objetos figuras na tela
  //Draw_Layer(rect2, lista_Objetos_manga, tint_layer2);
  LayerEd_Figuras.Draw_Layer(lista_Objetos_manga, tint_layer2);

  // ***************** checks the selected item to follow the mouse cursor ******************** **** //

  if (follow_mouse_obj.get_drag_acionador())
  {
    if (follow_mouse_obj.get_Obj_Dragable().ID.equals("C")) {
      //follow_mouse_obj.follow_mouse(X1ed, X2ed, Y1ed, Y2ed, tint_layer1);
      follow_mouse_obj.follow_mouse(LayerEd_Componentes, tint_layer1);
    } else {
      if (follow_mouse_obj.get_Obj_Dragable().ID.equals("F")) {
        //follow_mouse_obj.follow_mouse(X1ed, X2ed, Y1ed, Y2ed, tint_layer2);
        follow_mouse_obj.follow_mouse(LayerEd_Figuras, tint_layer2);
      }
    }
  }


  //******************função que arrasta o objeto da área de edição*********************//
  if (Tool_drag.get_condicao_arrastar_ed())
  {
    edicao_obj.set_condicao_de_edicao(false); //desabilita ferramenta de edição
    if (Tool_drag.ID.equals("F")  && LayerEd_Figuras.isOver_mouse(mouseX, mouseY)) {
      follow_mouse_obj.set_drag_acionador(false);
      Tool_drag.drag(lista_Objetos_manga, mouseX, mouseY);
    } else
    {
      if (Tool_drag.ID.equals("C") && LayerEd_Componentes.isOver_mouse(mouseX, mouseY)) {
        follow_mouse_obj.set_drag_acionador(false);
        Tool_drag.drag(lista_Objetos_Circuit, mouseX, mouseY);
      }
    }
  }

 // *************** Function that manages the selection of desktop objects for editing ****************** //
  if (edicao_obj.get_condicao_de_ativamento())
  {
    Tool_drag.set_condicao_arrastar_ed(false); // disable dragging tool
    follow_mouse_obj.set_drag_acionador(false); // disable selection of the component toolbox
    //toolbox_ED.Background(color(121,205,255),255);  //aciona background da toolbox de edição
    if (edicao_obj.ID.equals("F")){// && LayerEd_Figuras.isOver_mouse(mouseX, mouseY)) {
      
      edicao_obj.Selection(lista_Objetos_manga, mouseX, mouseY);
    } else
    {
      if (edicao_obj.ID.equals("C")){// && LayerEd_Componentes.isOver_mouse(mouseX, mouseY)) {
        edicao_obj.Selection(lista_Objetos_Circuit, mouseX, mouseY);
      }
    }
  }

  //**********************************************
   
// ************* XY axis alignment tool check ***************** //
  if(eixo_XY_Ed.get_condicao_de_ativamento()){
    //draw_eixo_XY(color c, float stroke_Weight, Edit_Field area_ed, int Mx, int My)
     eixo_XY_Ed.draw_eixo_XY(color(255,0,0),0.5, LayerEd_Figuras, mouseX, mouseY);
  } 

// ************ graduated grid for better reference of dimensions ****************** //
  if(Grid_Graduada.get_condicao_de_ativamento())
  {
    //draw_Grid(color c, float stroke_Weight, Edit_Field area_ed, int espacamento)
    //Grid_Graduada.draw_Grid(color(0),0.5, LayerEd_Figuras,59);
    Grid_Graduada.draw_Grid(color(0),0.5, LayerEd_Figuras,Pixel_to_cm);
  }
   
   
  // problem: for some reason the tint is directly influencing the opacity of the toolbox, the buttons have a low opacity or disappear when
  //          tint changes. If the background function is removed from the list, the buttons are influenced by the tint in the same way. this is strange why
  //          the main screen has several buttons and this was only observed in the toolbox lists
  //                                        (color(R,G,B),tint)
  listToolBox_Figuras_Tela1.Lista_Background(color(167, 167, 167), 255); // this function must be called in the loop
  listToolBox_Circuito_Tela1.Lista_Background(color(167, 167, 167), 255); // this function must be called in the loop
  
  if (edicao_obj.get_condicao_de_ativamento())
        toolbox_ED.Background(color(121,205,255),255);  //aciona background da toolbox de edição
        
        
}



//Obj_Componente new_Obj = follow_mouse_obj.get_Obj_Dragable();

//          if(new_Obj.ID().equals("C")){
//              create_Componente(rect1, new_Obj.get_Pimage().copy(), Mx, My);
//              println("Material = C");
//          }else{
//            if(new_Obj.ID().equals("F")){
//              create_Componente(rect2, new_Obj.get_Pimage().copy(), Mx, My);
//              println("Material = F");
//          }
//          }



//****************fim Tela_1_Edicao()*****************************//






// ****************** Tela_2_Selecao_Figuras ***************************** ** //

// There are two approaches to the new canvas
//        * I opened it on the main screen: using only the new background and options on the new screen
//        * Open it in a new screen: you would have to use that example object and open that screen there
//PGraphics Lista_graphic = createGraphics(width,height,P2D);
//Lista_Pgraphic Lista = new Lista_Pgraphic(lista_Figuras_TooBox);
//PGraphics Lita_quadro;
//Lista_Pgraphic Lista; 
int Veri_list=0;
int Veri_inicia=0;

//configuração da lista de figuras para seleção;
Lista_Buttons  lita_op2;
int Largura_Lista=1490, Altura_Lista=764;
int Coordenada_x_Lista=100;
int Coordenada_y_Lista=100;
int qtd_Linha_Lista_tela_2=3;
int qtd_Coluna_Lista_tela_2=4;
int espacamento_Linhas_lista_tela_2=250;
int espacamento_Colunas_lista_tela_2=240;
boolean hide_Lista_Tela_2=true;
void Cria_Lista_Tela_2()
{
  //Lita_quadro = createGraphics(width/2, height/2, P2D);

  //Lista_Pgraphic(ArrayList<Obj_Componente> Lista_Obj, int Largura_Lista, int Altura_Lista,int quantidade_Campos)
  //Lista = new Lista_Pgraphic(lista_Figuras_TooBox, 800,700,6,100,100);
  //Lista_Buttons(ArrayList<Obj_Componente> Lista_Obj, int x, int y, int lagura_lista,int altura_lista, int qtd_buttons, boolean hide)


  //Lista_Buttons(ArrayList<Obj_Componente> Lista_Obj,String prefixo, int x, int y, int lagura_lista, int altura_lista,int qtd_Linhas, int qtd_Colunas,
  //             int espaco_coluna, int espaco_linhas, boolean hide)

  // Para teste, substitua a lista de figuras pela lista de componentes manga  //lista_Objetos_manga  //lista_Figuras_TooBox
  lita_op2 = new Lista_Buttons(lista_Figuras_TooBox, "F", Coordenada_x_Lista, Coordenada_y_Lista, Largura_Lista, Altura_Lista,
                                qtd_Linha_Lista_tela_2,qtd_Coluna_Lista_tela_2, espacamento_Linhas_lista_tela_2, 
                                espacamento_Colunas_lista_tela_2, hide_Lista_Tela_2);
                                
  //tela_Lista = createGraphics(Largura_Lista,Altura_Lista,P2D);
  //lita_op2.lista_Butoons_show(0);
}

//função Draw tela 2
void Tela_2_Selecao_Figuras()
{
  if (Veri_list==0) {
    Cria_Lista_Tela_2();
    Veri_list=1;
    Veri_inicia=1;
  }
  if (Veri_inicia==1)
  {
    lita_op2.lista_Butoons_show(); 
    Veri_inicia=0;
  }
  //seta backgorund da tela 2
  //background(Background_2);
  image(Background_2,0,0,width,height);
  //background_Tela_2(color(255),color(194, 214, 237),color(0),30);

  //tela_Lista.beginDraw();
  //tela_Lista.background(200);
  //tela_Lista.endDraw();
  //image(tela_Lista,Coordenada_x_Lista,Coordenada_y_Lista);
  lita_op2.Lista_Background(color(200), 255); // this function needs to be called in the loop
  //Lista.Lista_Show(Lita_quadro, 0, 0);
  //Lista.Lista_isOver(mouseX, mouseY);
  //campo C= new campo(lista_Figuras_TooBox.get(0).get_Pimage().copy(), width/2, height/2, 300, 300);
  //C.campo_Show(Lista_graphic, 0, 0, 255);
  //campo C2= new campo(lista_Figuras_TooBox.get(1).get_Pimage().copy(), width/2, height/2, 300, 300);
  //C2.campo_Show(Lista_graphic, 310, 0, 255);




  //delay(50000);
  //c.show();
}
//***************fim metodo para criação da tela 2


//*********** início função de background tela 2 **************** //
void background_Tela_2(color cor_fundo, color cor_retangulos, color cor_font,int tam_font)
{
  background(cor_fundo);
  fill(cor_retangulos);
  noStroke();
  rect(0, 0, width, 70);
  
  fill(cor_retangulos);
  noStroke();
  rect(0, height - 57, width, height);
  
  msg("LIST OF FIGURES", width/2-60, 45, font_arial, tam_font,cor_font);
  msg("ADD", 84, 45, font_arial, tam_font, cor_font);
  msg("TO SELECT CLICK ON THE FIGURE", width/2+60, height - tam_font, font_arial, tam_font,cor_font);
  
}

//função que imprime uma mensagem na tela 
void msg(String MSG, int x, int y, PFont font, int tam_font,color c)
{
  //PFont font = createFont(font_name,tam_font);
  textFont(font);
  textSize(tam_font);
  fill(c);
  text(MSG,x,y);
}

//****************Fim Tela_2_Selecao_Figuras****************************//


// nessa parte foi separada a função de dragable, assim como as listas, em um arquivo especial 


// function that updates objects in a given layer
// Receive the layer and array of objects to be drawn
// can be used to control individual layers beyond the editing area
//int test=4;
void Draw_Layer(PGraphics Layer, ArrayList <Obj_Componente> lista_Obj, int tint)
{
  // draws all circuit objects on the screen
  if (lista_Obj != null && lista_Obj.size()>0) {
    //println("Draw_layer/ lista_Obj.size()" + lista_Obj.size());
    for (int i=0; i<lista_Obj.size(); i++)
    {

      Obj_Draw(Layer, lista_Obj.get(i), tint);
    }
  }
}

//Desenha o objeto na layer expecificada
void Obj_Draw(PGraphics Layer, Obj_Componente obj, int tint)
{

  Layer.beginDraw();
  Layer.clear();
  Layer.image(obj.get_Pimage(), obj.x, obj.y);
  Layer.endDraw();
  tint(255, tint);
  image(Layer, 0, 0);  //a presença deste comando aqui solucionou o bug de sumir os objs anteriores e fez o tint funcionar corretamente
}



void keyPressed()
{
  Obj_Componente obj;
  char button = key;
  switch(button)
  {
  case 'z':
    undo_redo.ctrl_Z_2 ();
    break;
  case 'Z':
    undo_redo.ctrl_Z_2 ();
    break;
  case 'y':
    undo_redo.ctrl_Y_2();
    break;
  case 'Y':
    undo_redo.ctrl_Y_2();
    break;
  case 't':
  
    switch(tint_layer2){
      case 255:
         tint_layer2=100;
         break;
      case 100:
         tint_layer2=50;
         break;
      case 50:
         tint_layer2=0;
         break;
      case 0:
         tint_layer2=255;
         break;
      default:
         break;
    }
    println("Manga_tint_layer2= " + tint_layer2);
    break;
    
  case 'r':
    tint_layer2=255;
    println("Manga_tint_layer2= " + tint_layer2);
    break;
  case 'w':
      switch(tint_layer1){
      case 255:
         tint_layer1=100;
         break;
      case 100:
         tint_layer1=50;
         break;
      case 50:
         tint_layer1=0;
         break;
      case 0:
         tint_layer1=255;
         break;
      default:
         break;
    }
    println("Circuito_tint_layer1= " + tint_layer1);
    break;
  case 'q':
    tint_layer1=255;
    println("Circuito_tint_layer1= " + tint_layer1);
    break;
  case 'm':
    imprimir_Circuito=true;
    println("Imprimindo Circuito...");
    break;
  case 'n':
    imprimir_Manga=true;
    println("Imprimindo Manga...");
    break;
  case 'l':
    if (follow_mouse_obj.get_drag_acionador()) {
      obj = follow_mouse_obj.get_Obj_Dragable();
      //obj.get_Pimage().resize(obj.get_Pimage().width*2,obj.get_Pimage().height*2);
      redimencionar(obj, 2, "+");
    }
    break;
  case 'ç':
    if (follow_mouse_obj.get_drag_acionador()) {
      obj = follow_mouse_obj.get_Obj_Dragable();
      //obj.get_Pimage().resize(obj.get_Pimage().width/2,obj.get_Pimage().height/2);
      redimencionar(obj, 2, "-");
    }
    break;
  case 'v':
    if (follow_mouse_obj.get_drag_acionador()) {
      obj = follow_mouse_obj.get_Obj_Dragable();
      //rotacionar(obj.get_Pimage());
      //rotacionar(obj,angulo);
      rotacionar(obj, 90);
    }
    break;
  case 'p':
    if (follow_mouse_obj.get_drag_acionador()) {
      obj = follow_mouse_obj.get_Obj_Dragable();
      mirror (obj, "vertical");
    }
    break;
  case 'o':
    if (follow_mouse_obj.get_drag_acionador()) {
      obj = follow_mouse_obj.get_Obj_Dragable();
      mirror (obj, "horizontal");
    }
    break;
  case '1':
  if(edicao_obj.get_condicao_de_edicao())
  {
    //Resize_Obj_Selected(String eixo, String condicao, int razao)
    edicao_obj.Resize_Obj_Selected("x","+",10);
    //ç;
  }
  break;
  case '2':
  if(edicao_obj.get_condicao_de_edicao())
  {
    //Resize_Obj_Selected(String eixo, String condicao, int razao)
    edicao_obj.Resize_Obj_Selected("x","-",10);
    //ç;
  }
  break;
  case '3':
  if(edicao_obj.get_condicao_de_edicao())
  {
    //Resize_Obj_Selected(String eixo, String condicao, int razao)
    edicao_obj.Resize_Obj_Selected("y","+",10);
    //ç;
  }
  break;
  case '4':
  if(edicao_obj.get_condicao_de_edicao())
  {
    //Resize_Obj_Selected(String eixo, String condicao, int razao)
    edicao_obj.Resize_Obj_Selected("y","-",10);
    //ç;
  }
  break;
  case '5':
  if(edicao_obj.get_condicao_de_edicao())
  {
    //Resize_Obj_Selected(String eixo, String condicao, int razao)
    edicao_obj.mirror ("vertical");
    //ç;
  }
  break;
  case '6':
  if(edicao_obj.get_condicao_de_edicao())
  {
    //Resize_Obj_Selected(String eixo, String condicao, int razao)
    edicao_obj.mirror ("horizontal");
    //ç;
  }
  break;
  case '7':
  if(edicao_obj.get_condicao_de_edicao())
  {
    //Resize_Obj_Selected(String eixo, String condicao, int razao)
    edicao_obj.Resize_Obj_Selected("xy","+",10);
    //ç;
  }
  break;
  case '8':
  if(edicao_obj.get_condicao_de_edicao())
  {
    //Resize_Obj_Selected(String eixo, String condicao, int razao)
    edicao_obj.Resize_Obj_Selected("xy","-",10);
    //ç;
  }
  break; 
  case '9':
  if(edicao_obj.get_condicao_de_edicao())
  {
    //Resize_Obj_Selected(String eixo, String condicao, int razao)
    edicao_obj.rotacionar(90);
  }
  break;
  case '0':
  if(edicao_obj.get_condicao_de_edicao())
  {
     edicao_obj.Excluir_Obj();

  } 
  break;
  default:
    break;
  }
}


// *****************adaptação para o uso das toolbox baseadas em botões



//void set_Obj_Dragable(Obj_Componente componente_Dragable)
// {
//   this. componente_Dragable = componente_Dragable; 
// }

// Obj_Componente get_Obj_Dragable()
// {
//   return this. componente_Dragable;
// }

// void set_drag_acionador(boolean drag)
// {
//  this.drag=drag; 
// }
// boolean get_drag_acionador()
// {
//  return this.drag;
// }

//// coordenadas da área de edição somente são adicionados novos objetos nessa área
//int X1ed = 15, X2ed = 776; //lagura
//int Y1ed = 14, Y2ed = 786; //altura

// rastreia a posição do mouse relacionando a cada objeto da configuração
void mouseClicked() {

  int Mx=mouseX;
  int My=mouseY;


  if (Numero_Tela==1) { //***********Início funções tela 1********* realiza as funções correpondentes a tela 1
                                     
    if (follow_mouse_obj.get_drag_acionador()) {

      Obj_Componente new_Obj = follow_mouse_obj.get_Obj_Dragable();
      //Area de edição
      if (LayerEd_Figuras.isOver_Obj(new_Obj ,Mx,My)){
        
        if (new_Obj.ID().equals("C")) {
          //create_Componente(rect1, new_Obj.get_Pimage().copy(), Mx, My);
          create_Componente(rect1, new_Obj, Mx, My);
          println("Material = C");
        } else {
          if (new_Obj.ID().equals("F")) {
            //create_Componente(rect2, new_Obj.get_Pimage().copy(), Mx, My);
            create_Componente(rect2, new_Obj, Mx, My);
            println("Material = F");
          }
        }
      }
      // desenha um reatangulo para indicar o click
    }


  }

  //*******Fim funções da tela 1

  println("mouseX= " + mouseX);
  println("mouseY= " + mouseY);
}



// Methods for selecting figures by the user
// the Method opens a search field for the user, he selects a png image
// which is the Figure he wants to add, the method generates an object from the image
// and it is added to the list of figures
File selection;
Obj_Componente Obj;
boolean very=false;
Obj_Componente Add_Figura()
{
  Obj=null;
  //void create_Componente(PGraphics layer, PImage componente, int x, int y)
  selectInput("Select a file to process:", "fileSelected");

   // wait for the object to be selected
   // this generates an error on account that takes control of Draw until the end of the action, but works normally
  while (very == false) {
    delay(100);
  }

  if (Obj==null)
  {
    println("\nObjeto null: sem seleção");
  } else {
    println("objeto= " + selection.getAbsolutePath());
    //Obj_Draw(rect2, Obj, 255);
    Obj.get_Pimage().resize(Obj.get_Pimage().width/6, Obj.get_Pimage().height/6);
    Obj.get_cach_image().copy().save(sketchPath() + Figure_folder + selection.getName());   // take the new image and save it in the image folder, this way the next image will already be inside the folder
    lista_Figuras_TooBox.add(Obj);
  }

// variable that verifies the completion of the selection action
  very=false;
  return  Obj;
}

void fileSelected(File path) {
  selection = path;

  // variable that verifies the completion of the selection action
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    PImage Figura = loadImage(selection.getAbsolutePath());
    Obj = new Obj_Componente(Figura, Figura.copy(), 988, 431, "F", selection.getName());      // can think of inserting a copy of the figure
  }
  very = true;
}
