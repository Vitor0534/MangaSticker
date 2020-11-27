// ********** second attempt to create a list for screen 2, now using buttons ************************ //
// this time based on a list of buttons, the operation is described in the program header
// the function that captures the event of each button was made to return the user's choice to the main program
// in this way it is possible to relate the number of the button to the index of the toobox for selecting a new figure
// to use this approach, you have to change the selection methods in the clicked mouse, in a way that the object that
// paste in the edit field and dragged by the mouse, be an object x selected by the user in the object toobox

void redimenciona_Figura_button(PImage imagem, int largura, int altura)
{

  //imagem.resize(imagem.width/10, imagem.height/10);
  if (imagem.height >altura || imagem.width > largura) {
    imagem.resize(largura, altura);
  }

  //if (imagem.height >altura){
  //  imagem.resize(imagem.width, altura);
  //}else
  //{
  // if(imagem.width > largura) 
  // {
  //   imagem.resize(largura, imagem.height);
  // } 
  //}
}

// cria os botões e retorna o controle de cada um, essa função é combinada com a list para gerar os botões
Controller create_button_Figura(String name, int value, int x, int y, int largura, int altura, boolean hide, PImage Figura)
{
  // create a new button with name 'Imprimir'
  ControlP5 cp5 = new ControlP5(this);

  redimenciona_Figura_button(Figura, largura, altura);  //redimenciona a figura para caber no botão

  //altera a dimenção da imagem para dar interatividade aos botões 
  PImage [] figuras;
  figuras = new PImage[3];
  figuras[0]=Figura.copy();
  figuras[1]=Figura.copy();
  figuras[1].resize(Figura.width-1, Figura.height-1);
  figuras[2]=Figura.copy();
  figuras[2].resize(Figura.width+3, Figura.height+3);

  if (hide) {
    cp5.addButton(name)
      .setValue(value)
      .setPosition(x, y)
      .setSize(Figura)
      .setImages(figuras)
      .hide()
      ;
  } else
  {
    cp5.addButton(name)
      .setValue(value)
      .setSize(Figura)
      .setImages(figuras)
      ;
  }
  return cp5.getController(name);
}



//objeto de lista de botões com imagens que formar os campos da listview
class Lista_Buttons
{
  ArrayList<Controller>  Buttons;
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


  Lista_Buttons(ArrayList<Obj_Componente> Lista_Obj, String prefixo, int x, int y, int lagura_lista, int altura_lista, int qtd_Linhas, int qtd_Colunas, 
    int espaco_coluna, int espaco_linhas, boolean hide)
  {
    Buttons=new ArrayList<Controller> ();
    this.Lista_Obj = Lista_Obj;
    this.prefixo=prefixo;   //identifica qual lista está sendo selecionada
    this.x=x;
    this.y=y;
    this.inicio=0;
    int contx=this.x+10;
    int conty=this.y;
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
    int largura_button =this.lagura_lista/this.qtd_buttons;
    int altura_button  =this.altura_lista/this.qtd_buttons;

    println("qtd_Linhas= " + this.qtd_Linhas + "\n qtd_Colunas= " + this.qtd_Colunas + "\n qtd_buttons= " + this.qtd_buttons);

    //contador controla a passagem de linha e de coluna lista
    int contador=0;
    int contador_linhas=0;

     // creates all the buttons in the list, the buttons are already positioned within the coordinates of the list
     // the method is based on the number of elements per row and per column, so that whenever
     // print the number of elements equivalent to qty column, the variable line counter
     // causes a line to jump, it is possible to configure all of this in the list constructor
    for (int i=0; i<this.Lista_Obj.size(); i++) {

      // button name, this name follows according to the indexes of each object in the list, so that to return it just take the name of the control give and the index
      String nome = prefixo + ";" + String.valueOf(i);
      println("adiona botão P" + nome);
      //ControlP5 cp5_button = create_button_Figura(nome, i, contx,conty,largura_button,altura_button,hide,Lista_Obj.get(i).get_Pimage().copy());
      // capture the specific button control and put it in the bit control list
      //PImage redimenciona =  Lista_Obj.get(i).get_Pimage().copy();
      //for(;;)
      //{
      //  if(redimenciona.width < largura_button || redimenciona.height < altura_button)
      //      redimenciona.resize((int)redimenciona.width/2+1,(int)redimenciona.height/2+1);
      //  else
      //    break;
      //}

      Controller cp5_button = create_button_Figura(nome, i, contx, conty, largura_button, altura_button, hide, Lista_Obj.get(i).get_Pimage().copy());
      Buttons.add(cp5_button);

      println("Button_" + nome + "(" + contx + "," + conty + ")");

      contador++;
      contador_linhas++;

      //int qtd_Linhas;
      //int qtd_Colunas;
      //this.espaco_coluna=espaco_coluna;
      //this.espaco_linhas=espaco_linhas;
      if (contador == this.qtd_buttons)
      {
        contador=0;
        contador_linhas=0;
        contx=this.x+10;
        conty=this.y;
        println("\nif (contador == qtd_buttons) X= " + contx + ": Y= " + conty);
        println("if (contador == qtd_buttons) contador " + contador);
      } else {
        // espaçamento entre cada botão
        //contx+=largura_button+250;
        contx+=largura_button+this.espaco_coluna;
      }

      // verifica se é necessário imprimir na segunda linha da lista 
      if (contador_linhas==this.qtd_Colunas) {
        //conty= conty + this.altura_lista/2+altura_button;
        conty= conty + this.espaco_linhas + altura_button;
        contx=this.x+10;
        println("\nverifica index button X= " + contx + " : Y= " + conty);
        println("verifica index button contador_linhas= " +  contador_linhas);
        contador_linhas=0;
      }
    }


    //problema na hora de mostras os botões na tela;
    // problema resolvido

    //Buttons.get(1).show();

    //Controller c = Buttons.get(1).getController("P0");
    //c.show();
    //c = Buttons.get(1).getController("P1");
    //c.show();
    //Buttons.get(0).show();
    //Buttons.get(1).show();
    //println("mostra botões P0 e P1");
  }//********************fim do construtor ************************************//

  ArrayList<Obj_Componente> get_Lista_Obj()
  {
    return this.Lista_Obj;
  }

  void set_Lista_Obj(ArrayList<Obj_Componente> Lista_Obj)
  {
    this.Lista_Obj=Lista_Obj;
  }
   // this method only shows the visible range of the list, based on the number of figures you see at any given moment qtd_buttons
   // the start variable controls the display of items in the list, the increment or decrement of it, will pass to next objects
   // void lista_Butoons_show (int start)
  //{

  //  //imprime botões, somente nos intervalos visiveis naquele determinado momento isso é controlado pela variável início 

  void lista_Butoons_show()
  {
    // prints buttons, only at the intervals visible at that time it is controlled by the start variable
    println("lista_Butoons_show: Buttons.size()= " + Buttons.size());

    println("intervalo ["+this.inicio+", "+(this.inicio + this.qtd_buttons-1)+"]");

    for (int i=0; i<Buttons.size(); i++)
    {
      println("entra no for");
      if (i<this.inicio || i>this.inicio+qtd_buttons-1) {
        Buttons.get(i).hide();
        println("esconde botão P"+i);
      } else {
        Buttons.get(i).show();
        println("mostra botão P"+i);
      }
    }
  }

  // functions responsible for passing objects in the list
  void proximo()
  {
    if (this.inicio + this.qtd_buttons-1 < Buttons.size()-1) {
      println("proximo inicio= " + this.inicio + "\nqtd_buttons-1= " + (qtd_buttons -1) + "\nButtons.size()-1= " + (Buttons.size()-1));
      this.inicio+=this.qtd_buttons;
      lista_Butoons_show();
    }
  }
  void anterior()
  {
    if (this.inicio!=0) {

      if (this.inicio- this.qtd_buttons-1 >= 0) {
        this.inicio-=this.qtd_buttons;
      } else
      {
        inicio=0;
      }
      println("anterior");
      lista_Butoons_show();
    }
  }

   // function that triggers the background of the figure toobox list, ATTENTION: it must always be called in the loop after the background of the main screen
   // the buttons are above the controlP5 default pgraphic
  void Lista_Background(color c, int tint)
  {
    //mostra layer atráz dos botões
    this.Layer_Lista.beginDraw();
    this.Layer_Lista.background(c);
    this.Layer_Lista.endDraw();
    tint(255, tint);
    image(this.Layer_Lista, this.x, this.y);
  }

  // method that hides the list from being seen or disturbing other program screens
  void hide_Lista_toobox_tela2()
  {
    println("hide_Lista_toobox_tela2():   Buttons.size()= " + Buttons.size());
    for (int i=0; i<Buttons.size(); i++)
    {
      Buttons.get(i).hide();
      println("esconde botão P"+i);
    }
  }
}
//fim do objeto lista de botões ************************************************************************************//

// function that captures the event for each control, that is, each button or GUI component
void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {  // groups are sets of controllers, list views, textbox and other groupings of controllers
    println("got an event from group "
      +theEvent.getGroup().getName()
      +", isOpen? "+theEvent.getGroup().isOpen()
      );
  } else if (theEvent.isController()) { //o sbotões são controladores

    String nome = theEvent.getController().getName();
    println("got something from a controller "
      +theEvent.getController().getName()
      );
// in this region it is necessary to return the chosen object to the selection variable

     // calls a function that manages the choice of objects in the toolbox
     // the method differentiates between figures and circuit using the same prefix
     // C for circuit and F for figures
     // String [] split_name = split (name, ";");

    if (button==1) {
      //if(nome_Split.length==2 && (nome_Split[0].equals('F') || nome_Split[0].equals('C')))
      seleciona_dragable_OBJ(nome);
      //else
      //if(nome_Split.length==2 && nome_Split[0].equals("TED"))
      button_toolbox_ED(nome);
    }
  }
}

// method that checks if the click event came from a toolbox
// in case of a toolbox, the name of the selected object is separated
// then it is checked which list that object belongs to by its prefix
// this way, based on the index returned by the toolbox the image of the object is collected
// in the toobox list is added to the dragable variable, which makes it possible
// drag object across the screen
// what happens when an object is selected is that through the index the object is collected
// of theToolbox_Figure list and through this, an object is created that as parameter of the class
// follow_mouse_obj and, from that class, when the user clicks to paste the obj in the editing area
// it will be collected from obj_dragable and added to list_Figure or circuit_list according to
// your ID
void seleciona_dragable_OBJ(String name)
{

  // dá o split para separar prefixo de indice
  // o prefcio indica o tipo de elemento e o indice se refere a posição dele na lista
  String[] Objeto_ID = split(name, ';');
  PImage componente_Dragable;
  PImage componente_Dragable_cach; //imagem de referência para qualidade

  if (Objeto_ID.length==2) { //*********** verifica se é um evento de toolbox

    //println(" Objeto_ID[0] = " + Objeto_ID[0] + "\nObjeto_ID[1] = "+Objeto_ID[1]);     // gera um erro por conta do nome dos outros botões que não tem split

    //tratamento da tela 1
    if (Numero_Tela==1 && Veri_inicia_Tela1==0 &&  Veri_list_Tela1==1 && Objeto_ID.length==2)
    { //somente é efetivo na tela 1


      println("Seleção na tela 1");
      println(" Objeto_ID[0] = " + Objeto_ID[0] + "\nObjeto_ID[1] = "+Objeto_ID[1]); 
      if (Objeto_ID[0].equals("F")) {
        componente_Dragable = listToolBox_Figuras_Tela1.get_Lista_Obj().get(Integer.parseInt(Objeto_ID[1])).get_Pimage().copy();
        //essa segunda imagem é a imagem de referência para que seja preservada a qualidade nas transformações
        componente_Dragable_cach =listToolBox_Figuras_Tela1.get_Lista_Obj().get(Integer.parseInt(Objeto_ID[1])).get_cach_image().copy();

        follow_mouse_obj.set_Obj_Dragable(new Obj_Componente(componente_Dragable, componente_Dragable_cach, 0, 0, "F", 
          listToolBox_Figuras_Tela1.get_Lista_Obj().get(Integer.parseInt(Objeto_ID[1])).name()));

        //follow_mouse_obj.set_Obj_Dragable(new Obj_Componente(componente_Dragable.copy(), 0, 0, "F", "Figura"));
        follow_mouse_obj.set_drag_acionador(true);
        println("foi selecionado um objeto de figura nome ( F;" + Objeto_ID[1] + ") - " + 
          listToolBox_Figuras_Tela1.get_Lista_Obj().get(Integer.parseInt(Objeto_ID[1])).name());
      } else {

        if (Objeto_ID[0].equals("C")) {
          componente_Dragable = listToolBox_Circuito_Tela1.get_Lista_Obj().get(Integer.parseInt(Objeto_ID[1])).get_Pimage().copy();
          componente_Dragable_cach =listToolBox_Circuito_Tela1.get_Lista_Obj().get(Integer.parseInt(Objeto_ID[1])).get_cach_image().copy();
          follow_mouse_obj.set_Obj_Dragable(new Obj_Componente(componente_Dragable, componente_Dragable_cach, 0, 0, "C", 
            listToolBox_Circuito_Tela1.get_Lista_Obj().get(Integer.parseInt(Objeto_ID[1])).name()));
          //follow_mouse_obj.set_Obj_Dragable(new Obj_Componente(componente_Dragable.copy(), 0, 0, "C", listToolBox_Circuito_Tela1.get_Lista_Obj().get(Integer.parseInt(Objeto_ID[1])).name()));
          follow_mouse_obj.set_drag_acionador(true);
          println("foi selecionado um objeto de circuito nome ( C;" + Objeto_ID[1] + ") - " + 
            listToolBox_Circuito_Tela1.get_Lista_Obj().get(Integer.parseInt(Objeto_ID[1])).name());
        }
      }

      // não foram selecionados objetos arrastáveis
      //componente_Dragable=null;
    } else {
      // tratamento da tela 2
      println("clique na toolbox Tela 2, nome= " + Objeto_ID[0] + " ID= " + Objeto_ID[1]);
      if (Numero_Tela==2 && Veri_inicia==0 &&  Veri_list==1 && Objeto_ID.length==2 && Objeto_ID[0].equals("F")) { //somente é efetivo na tela 2
        println("Objeto escolhido da toolbox_Figuras Tela 2");
        componente_Dragable = lita_op2.get_Lista_Obj().get(Integer.parseInt(Objeto_ID[1])).get_Pimage().copy();
        componente_Dragable_cach = lita_op2.get_Lista_Obj().get(Integer.parseInt(Objeto_ID[1])).get_cach_image().copy();
        follow_mouse_obj.set_Obj_Dragable(new Obj_Componente(componente_Dragable, componente_Dragable_cach, 0, 0, "F", 
        listToolBox_Figuras_Tela1.get_Lista_Obj().get(Integer.parseInt(Objeto_ID[1])).name()));
        follow_mouse_obj.set_drag_acionador(true);
      }

      //componente_Dragable=null;
    }
  }// ************************
}
//**********fim de seleção de objeto dragable********************************************************************//



// ******************* checking the component editing toolbox buttons ********************************* //

void button_toolbox_ED(String name)
{


  // dá o split para separar prefixo de indice
  // o prefcio indica o tipo de elemento e o indice se refere a posição dele na lista
  String[] Objeto_ID = split(name, ';');
  println("Toolbox_Ed");
  //  verifica se tem 2 unidades no prefixo //tratamento da tela 1  //somente é efetivo na toolbox_Ed        
  if (Objeto_ID.length==2 && Numero_Tela==1 && Objeto_ID[0].equals("TED") && edicao_obj.get_condicao_de_edicao()) { //*********** verifica se é um evento de toolbox_ED

    println("Seleção na tela 1 toolbox_Ed");
    println(" Objeto_ID[0] = " + Objeto_ID[0] + "\nObjeto_ID[1] = "+Objeto_ID[1]); 
    
    String N_button = Objeto_ID[1];
    
    switch(N_button){
     
      case "0": //resize x+  
        edicao_obj.Resize_Obj_Selected("x", "+", 10);
      break;
      case "1": //resize x- 
        edicao_obj.Resize_Obj_Selected("x", "-", 10);
      break;
      case "2": //resize y+  
        edicao_obj.Resize_Obj_Selected("y", "+", 10);
      break;
      case "3": //resize y-  
        edicao_obj.Resize_Obj_Selected("y", "-", 10);
      break;
      case "4": //resize xy+  
        edicao_obj.Resize_Obj_Selected("xy", "+", 10);
      break;
      case "5": //resize xy- 
        edicao_obj.Resize_Obj_Selected("xy", "-", 10);
      break;
      case "6": //rotate 90  
        edicao_obj.rotacionar(90);
      break;
      case "7": //mirror horizontal 
        edicao_obj.mirror ("horizontal");
      break;
      case "8": //mirror vertical  
        edicao_obj.mirror ("vertical");
      break;
      case "9": //delete item  
        edicao_obj.Excluir_Obj();
      break;
      case "10": //manda item um indice para cima  
        edicao_obj.to_Top();
      break;
      case "11": //manda item um indice para baixo
        edicao_obj.to_Down();
      break;
      default:
      println("opção não reconhecida --> button_toolbox_ED(String name)");
      break;
    }
    
  }
  
}

//*******************  fim verificação de botões da toolbox de edição de componentes *****************************//
