// the reading of the button image depends on the prefix Buttons_folder

// *******function responsible for managing the creation of all control buttons on screen 1 ***** ***************************** //
void cria_botoes_Tela_1()
{
  PImage [] face_2;
  face_2=new PImage[3];

  // cria botões da tela 1 
  //create_button("Imprimir_Circuito", 0, 1081, 6, 100, 19, false);
  //create_button("Imprimir_Manga", 0, 971, 6, 100, 19, false);
  //create_button("Imprimir_Circuito", 0, Coordenada_x_ToolBox_Circuito+Largura_ToolBox_Circuito-100, Coordenada_y_ToolBox_Circuito-25, 100, 19, false);
  face_2[0] =  loadImage(Buttons_folder+"print_circuit_button.png");
  //create_button_IMG("Imprimir_Circuito", 0, Coordenada_x_ToolBox_Circuito+Largura_ToolBox_Circuito-100, Coordenada_y_ToolBox_Circuito-25, 100, 19, false,face_2);
  create_button_IMG("Imprimir_Circuito", 0, width-120, 2, 110, 35, false,face_2);
  
  //create_button("Imprimir_Manga", 0, Coordenada_x_ToolBox_Circuito+Largura_ToolBox_Circuito-220, Coordenada_y_ToolBox_Circuito-25, 100, 19, false);
  face_2[0] =  loadImage(Buttons_folder+"print_Manga_button.png");
  //create_button_IMG("Imprimir_Manga", 0, Coordenada_x_ToolBox_Circuito+Largura_ToolBox_Circuito-220, Coordenada_y_ToolBox_Circuito-25, 100, 19, false,face_2);
  create_button_IMG("Imprimir_Manga", 0, width - 240, 2, 110, 35, false,face_2);
  
  //create_button("Selecionar", 0, 1090, 775, 100, 19, false);
  //create_button("Selecionar", 0, Coordenada_x_ToolBox_Figuras+Largura_ToolBox_Figuras-100, 
                //Coordenada_y_ToolBox_Figuras + Altura_ToolBox_Figuras+3, 100, 19, false);
  face_2[0] =  loadImage(Buttons_folder+"Select_Figure_button_without_background.png");
  create_button_IMG("Selecionar", 0, Coordenada_x_ToolBox_Figuras+Largura_ToolBox_Figuras-100, 
                Coordenada_y_ToolBox_Figuras + Altura_ToolBox_Figuras+3, 110, 35, false,face_2);           
                
  //create_button("Carregar_Projeto", 0, 1, 2, 100, 19, false);
  face_2[0] =  loadImage(Buttons_folder+"Open_Project_button_without_background.png");
  create_button_IMG("Carregar_Projeto", 0, 1, 2, 100, 25, false, face_2);
  
  
  //create_button("Salvar_Projeto", 0, 105, 2, 100, 19, false);
  face_2[0] =  loadImage(Buttons_folder+"Save_Project_button_without_background.png");
  create_button_IMG("Salvar_Projeto", 0, 110, 2, 100, 25, false, face_2);
  

  //**************botão de ferramenta arrastar *****************//
  face_2[0] =  loadImage(Buttons_folder+"drag_button.png");
  create_button_IMG("Arrastar_Figura", 0, Coordenada_x_ToolBox_Figuras, Coordenada_y_ToolBox_Figuras + Altura_ToolBox_Figuras+3, 30, 30, false, face_2);
  create_button_IMG("Arrastar_Circuito", 0, Coordenada_x_ToolBox_Circuito, Coordenada_y_ToolBox_Circuito - 23, 30, 30, false, face_2);
  
  //************** botão de ferramentas de edição de obj *********// 
  face_2[0] =  loadImage(Buttons_folder+"Select_button.png");
  create_button_IMG("Editar_Figuras", 0, Coordenada_x_ToolBox_Figuras+35, Coordenada_y_ToolBox_Figuras + Altura_ToolBox_Figuras+3, 20, 20, false, face_2);
  create_button_IMG("Editar_Circuito", 0, Coordenada_x_ToolBox_Circuito+35, Coordenada_y_ToolBox_Circuito - 23, 20, 20, false, face_2);
  
  //************* botão da ferramenta de grid ********************//
  face_2[0] =  loadImage(Buttons_folder+"Grid_button.png");
  create_button_IMG("Grid_Graduada", 0, Coordenada_x_ToolBox_Circuito+70, Coordenada_y_ToolBox_Circuito - 23, 20, 20, false, face_2);
  
  //************* botão da ferramenta de eixoXY ********************//
  face_2[0] =  loadImage(Buttons_folder+"eixoXY_button.png");
  create_button_IMG("EixoXY", 0, Coordenada_x_ToolBox_Circuito+105, Coordenada_y_ToolBox_Circuito - 23, 20, 20, false, face_2);
  
  //************botões toolbox Circuito ***************************//
  face_2[0] =  loadImage(Buttons_folder+"button_next_little_arrow_1_R.png");
  face_2[1] =  loadImage(Buttons_folder+"button_next_little_arrow_2_R.png");
  face_2[2] =  loadImage(Buttons_folder+"button_next_little_arrow_3_R.png");
  //create_button_IMG("next_toolbox_Circuito", 0, 1356, 344, 30, 30, false, face_2);
  create_button_IMG("next_toolbox_Circuito", 0, Coordenada_x_ToolBox_Circuito+70, Coordenada_y_ToolBox_Circuito + Altura_ToolBox_Circuito-50, 30, 30, false, face_2);

  face_2[0] =  loadImage(Buttons_folder+"button_next_little_arrow_1_L.png");
  face_2[1] =  loadImage(Buttons_folder+"button_next_little_arrow_2_L.png");
  face_2[2] =  loadImage(Buttons_folder+"button_next_little_arrow_3_L.png");
  //create_button_IMG("back_toolbox_Circuito", 0, 1285, 344, 30, 30, false, face_2);
  create_button_IMG("back_toolbox_Circuito", 0, Coordenada_x_ToolBox_Circuito+10, 
                    Coordenada_y_ToolBox_Circuito + Altura_ToolBox_Circuito-50, 30, 30, false, face_2);

  //************botões toolbox Figura ***************************//
  face_2[0] =  loadImage(Buttons_folder+"button_next_little_arrow_1_R.png");
  face_2[1] =  loadImage(Buttons_folder+"button_next_little_arrow_2_R.png");
  face_2[2] =  loadImage(Buttons_folder+"button_next_little_arrow_3_R.png");
  //create_button_IMG("next_toolbox_Figura", 0, 1356, 720, 30, 30, false, face_2);
  create_button_IMG("next_toolbox_Figura", 0, Coordenada_x_ToolBox_Figuras+70, 
                    Coordenada_y_ToolBox_Figuras + Altura_ToolBox_Figuras-50, 30, 30, false, face_2);

  face_2[0] =  loadImage(Buttons_folder+"button_next_little_arrow_1_L.png");
  face_2[1] =  loadImage(Buttons_folder+"button_next_little_arrow_2_L.png");
  face_2[2] =  loadImage(Buttons_folder+"button_next_little_arrow_3_L.png");
  //create_button_IMG("back_toolbox_Figura", 0, 1285, 720, 30, 30, false, face_2);
  create_button_IMG("back_toolbox_Figura", 0, Coordenada_x_ToolBox_Figuras+10, 
                    Coordenada_y_ToolBox_Figuras + Altura_ToolBox_Figuras-50, 30, 30, false, face_2);

  // *********************** droplist para seleção das opções de salvar e carregar projetos ********************//
  //create_Scrolable_list( String nome, String [] itens, int x, int y, int largura_list, int altura_list, int altura_barra, int altura_item)
  //String [] itens = {"Salvar Projeto","Carregar Projeto"};
  //create_Scrolable_list("Arquivo",itens, 1,2,90,60,10,10);

  //************************ cria textField para recebere o nome do projeto quando o user foi salvar algum coisa *************//

  //Creat_TextField(String name, String Font, int Tamanho_font, int x, int y, int largura, 
  //                  int altura, boolean AutoClear, boolean setFocus, color c)
  Creat_TextField("Insira_o_nome_do_Projeto", "arial", "Insira o nome do projeto", 20, 210, 2, 300, 25, false, true, color(255));
}
//****** Fim botões tela 1***************************//


//**************************** função responsável por gerenciar a criação de todos os botões de controle na tela 2**********************************//
void cria_botoes_Tela_2()
{
  //vetor de PImage que recebe as imagens a serem colocado em cada botão um botão por vez 
  PImage [] face_2;
  face_2 = new PImage[3];

  //face = new PImage[3];
  //face[0] =  loadImage(Buttons_folder+"Back_button_1.png");
  //face[1] =  loadImage(Buttons_folder+"Back_button_2.png");
  //face[2] =  loadImage(Buttons_folder+"Back_button_3.png");
  //for (int i=0; i<3; i++)
  //  face[i].resize(70, 70);
  //create_button("Voltar", 0, 1110, 2, 100, 19, true);

  //*** imagens para o botão de voltar da tela 2**************//
  face_2[0] =  loadImage(Buttons_folder+"Back_button_1.png");
  face_2[1] =  loadImage(Buttons_folder+"Back_button_2.png");
  face_2[2] =  loadImage(Buttons_folder+"Back_button_3.png");
  create_button_IMG("Voltar", 0, width-80, 3, 70, 70, true, face_2);

  //Plus_button_A1   //cria botão de adicionar figura tela 2 ta tela 2
  face_2[0] =  loadImage(Buttons_folder+"Plus_button_A1.png");
  face_2[1] =  loadImage(Buttons_folder+"Plus_button_A2.png");
  face_2[2] =  loadImage(Buttons_folder+"Plus_button_A3.png");
  create_button_IMG("Adicionar", 0, 15, 8, 70, 70, true, face_2);

  //cria botão de proximo na tela 2
  face_2[0] =  loadImage(Buttons_folder+"next_A_1.png");
  face_2[1] =  loadImage(Buttons_folder+"next_A_2.png");
  face_2[2] =  loadImage(Buttons_folder+"next_A_3.png");
  //create_button_IMG("proximo", 0, 1133, 100, 55, 600, true, face_2);
  create_button_IMG("proximo", 0, Coordenada_x_Lista + Largura_Lista+36, Coordenada_y_Lista +  Altura_Lista/2 - 300, 55, 600, true, face_2);

  //cria botão de anterior na tela 2
  face_2[0] =  loadImage(Buttons_folder+"next_B_1.png");
  face_2[1] =  loadImage(Buttons_folder+"next_B_2.png");
  face_2[2] =  loadImage(Buttons_folder+"next_B_3.png");
  //create_button_IMG("anterior", 0, 9, 100, 55, 600, true, face_2);
  create_button_IMG("anterior", 0, 9, Coordenada_y_Lista +  Altura_Lista/2 - 300, 55, 600, true, face_2);
}
//*************** fima botões tela 2 ************************************//


// função que cria um botão com imagem, a função verifica a quantidade de imagens que o botão tem
// se tiver so uma imagem ela gera 3 a partir dessa 1, se tiver 3 ela coloca as imagens default
// para tanto, é necessário setar um vetor de PImages com 1 ou 3 imagens, e indicar a quantidade de figuras
void create_button_IMG(String name, int value, int x, int y, int largura, int altura, boolean hide, PImage [] face)
{

  PImage [] figuras;
  figuras = new PImage[3];

  //redimenciona_Figura_button(PImage imagem,int largura, int altura)

  //verifica a quantidade de imagens para gerar a quantidade certa para o botão
  if (face.length==1 || face[1] == null)
  {
    //redimenciona figura para o tamanho do botão
    redimenciona_Figura_button(face[0], largura, altura);
    //altera a dimenção da imagem para dar interatividade aos botões 
    figuras[0]=face[0].copy();
    figuras[1]=face[0].copy();
    figuras[1].resize(face[0].width-1, face[0].height-1);
    figuras[2]=face[0].copy();
    figuras[2].resize(face[0].width+3, face[0].height+3);
  } else
  {
    //redimenciona figura para o tamanho do botão
    for (int i=0; i<face.length; i++) {
      redimenciona_Figura_button(face[i], largura, altura);
    }

    if (face.length==3)
    {
      figuras[0]=face[0].copy();  //passa figuras para variável resposável pela adição de figuras no botão
      figuras[1]=face[1].copy();
      figuras[2]=face[2].copy();
    }
  }

  // create a new button 
  if (hide) {
    cp5.addButton(name)
      .setValue(128)
      .setPosition(x, y)
      .setSize(figuras[0])
      .setImages(figuras)
      .hide()
      ;
  } else
  {

    cp5.addButton(name)
      .setValue(value)
      .setPosition(x, y)
      .setSize(figuras[0])
      .setImages(figuras)
      ;
  }
}


// função basica de criação de botões, permite a criação de botões default da controlP5, dando escolha
// se ele vai ser hide ou não

void create_button(String name, int value, int x, int y, int largura, int altura, boolean hide)
{
  // create a new button with name 'Imprimir'
  if (hide) {
    cp5.addButton(name)
      .setValue(128)
      .setPosition(x, y)
      .setSize(largura, altura)
      .hide()
      ;
  } else
  {
    cp5.addButton(name)
      .setValue(value)
      .setPosition(x, y)
      .setSize(largura, altura)
      ;
  }
}


void create_Scrolable_list( String nome, String [] itens, int x, int y, int largura_list, int altura_list, int altura_barra, int altura_item)
{
  //String [] l = {"a", "b", "c", "d", "e", "f", "g", "h"};
  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList(nome)
    .setPosition(x, y)
    .setSize( largura_list, altura_list)
    .setBarHeight(altura_barra)
    .setItemHeight(altura_item)
    .addItems(itens)
    .setOpen(false)
    //.setImage(loadImage("C:/Users/Vitor/Desktop/faculdade/TCC/Software Circuit_mangá/Testes/Manga_sticker_V6_8_persistencia_teste/Projetos/project_1_teste/project_1_testeF;1.png"))
    // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;
}

void Arquivo(int n) {
  /* request the selected item based on index n */
  // faz isso somente para o objeto arrastado não interferir na seleção da opção
  follow_mouse_obj.set_drag_acionador(false);



  String name = cp5.get(ScrollableList.class, "Arquivo").getItem(n).get("name").toString();
  println("Escolha na drop list: N=" + n + " name: " + name);
  if (name.equals("Salvar Projeto"))
  {
    Salvar_Projeto();
  } else
  {
    if (name.equals("Carregar Projeto"))
    {

      Carregar_Projeto();
    }
  }



  /* here an item is stored as a Map  with the following key-value pairs:
   * name, the given name of the item
   * text, the given text of the item by default the same as name
   * value, the given value of the item, can be changed by using .getItem(n).put("value", "abc"); a value here is of type Object therefore can be anything
   * color, the given color of the item, how to change, see below
   * view, a customizable view, is of type CDrawable 
   */
}

void Creat_TextField(String name, String Font, String msg, int Tamanho_font, int x, int y, int largura, 
  int altura, boolean AutoClear, boolean setFocus, color c)
{
  PFont font = createFont(Font, Tamanho_font);
  cp5.addTextfield(name)
    .setPosition(x, y)
    .setSize(largura, altura)
    .setFont(font)
    .setAutoClear(AutoClear)
    .setFocus(setFocus)
    .setColor(c)
    .setText(msg)
    .hide()
    ;
  //cp5.addBang("Enter_with_name")
  //   .setPosition(x+largura+5,y)
  //   .setSize(80,40)
  //   .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
  //   .hide()
  //   ;
}


void esconde_botoes_Tela_2()
{

  //esconde informações da tela 2
  lita_op2.hide_Lista_toobox_tela2();
  //Veri_list=0;
  //Veri_inicia=0; //variáveis que inicializam a lista na tela 2

  //esconde botão tela 2
  cp5.getController("Voltar").hide();  
  cp5.getController("Adicionar").hide();
  cp5.getController("proximo").hide();
  cp5.getController("anterior").hide();
}
void mostra_botoes_Tela_2()
{
  Veri_list=0;
  Veri_inicia=0; //variáveis que inicializam a lista na tela 2
  //esconde botão tela 2
  cp5.getController("Voltar").show();  
  cp5.getController("Adicionar").show();
  cp5.getController("proximo").show();
  cp5.getController("anterior").show();
}


void Configura_Toolbox_ED(int x, int y, int largura, int altura, int N_linhas, 
                          int N_coluna, int espaco_Linha, int espaco_Coluna, String Buttons_folder)
{
  //toolbox_Edicao(PImage [] buttons, String prefixo, int x, int y, int lagura_lista, int altura_lista, int qtd_Linhas, int qtd_Colunas, 
  //               int espaco_coluna, int espaco_linhas, boolean hide)
  
  //************* carrega imagens dos botões da toolbox de edição *******************//
  println("Configurando toolbox de edição...");
  ArrayList<PImage> buttons_images = new ArrayList<PImage>();
  buttons_images.add(loadImage(Buttons_folder+"button_X_plus.png"));
  buttons_images.add(loadImage(Buttons_folder+"button_X_minus.png"));
  buttons_images.add(loadImage(Buttons_folder+"button_Y_plus.png"));
  buttons_images.add(loadImage(Buttons_folder+"button_Y_minus.png"));
  buttons_images.add(loadImage(Buttons_folder+"button_resize_plus.png"));
  buttons_images.add(loadImage(Buttons_folder+"button_resize_minus.png"));
  buttons_images.add(loadImage(Buttons_folder+"button_rotate_right.png"));
  buttons_images.add(loadImage(Buttons_folder+"button_mirror_horizontal.png"));
  buttons_images.add(loadImage(Buttons_folder+"button_mirror_vertical.png"));   
  buttons_images.add(loadImage(Buttons_folder+"garbage_basket.png")); 
  buttons_images.add(loadImage(Buttons_folder+"button_to_top.png")); 
  buttons_images.add(loadImage(Buttons_folder+"button_to_down.png")); 
  toolbox_ED = new toolbox_Edicao(buttons_images, "TED", x, y, largura, altura, N_linhas, N_coluna, 
                                  espaco_Linha, espaco_Coluna, true,false);
  //toolbox_ED = new toolbox_Edicao(buttons_images, "TED", 1019, 406, 140, 140, 2, 2, 
  //               50, 50, true,false);
                 
                               
  println("toolbox de edição configurada");
           
}


//************** fim da criação de botões *********************************//



// ****************** Evento dos botões **********************//

//***************** Tela 1 *************************//

public void Imprimir_Circuito()
{
  // Seta a variável de impressão do circuito para true
  if (button==1) {
    //imprimir_Circuito=true;
    println("Printing Circuit ...");
    LayerEd_Componentes.Draw_Layer_On_PDF(lista_Objetos_Circuit,"Circuito");
    println("Full print, PDF generated!");
  }
}

public void Imprimir_Manga()
{
  // Seta a variável de impressão do manga para true
  if (button==1) {
    //imprimir_Manga=true;
    println("Printing Manga...");
    LayerEd_Figuras.Draw_Layer_On_PDF(lista_Objetos_manga,"Manga");
    println("Full print, PDF generated!");
  }
}

public void Selecionar()
{ 
  // Seta variável para abrir Tela 2
  if (button==1) {
    Numero_Tela=2;
    //somente para testar a função de salvar projeto
    Esconde_botoes_Tela_1();
    mostra_botoes_Tela_2();
  }
}

void Carregar_Projeto()
{
  if (button==1) {
    follow_mouse_obj.set_drag_acionador(false);
    // load_Project(ArrayList<Obj_Componente> Lista_Circuito, ArrayList<Obj_Componente> Lista_Manga, String name)
    //boolean load_Project(ArrayList<Obj_Componente> Lista_Circuito, ArrayList<Obj_Componente> Lista_Manga, String name,String Figure_folder, String Project_Folder)
    load_Project(lista_Objetos_Circuit, lista_Objetos_manga, Figure_folder, Project_Folder );
  }
}

//boolean Salva_Nome=false;
//String nome_Projeto="";
void Salvar_Projeto()
{
  if (button==1) {
    follow_mouse_obj.set_drag_acionador(false);
    // load_Project(ArrayList<Obj_Componente> Lista_Circuito, ArrayList<Obj_Componente> Lista_Manga, String name)
    //recebe o nome do projeto por intermédio do usuário
    cp5.get(Textfield.class, "Insira_o_nome_do_Projeto").show(); //mostra a área de texto para receber o nome do projeto
    cp5.get(Textfield.class, "Insira_o_nome_do_Projeto").setText("Enter the project name");
    //cp5.get(Bang.class,"Insira_o_nome_do_Projeto").show();

    println("Save Project");
    //while(Salva_Nome==false){println("loop_Salvar");delay(100);} // Espera pela resposta do usuário
    //Save_Project(lista_Objetos_Circuit, lista_Objetos_manga, nome_Projeto);
    //Salva_Nome=false;
    //c.hide();
  }
}

public void Insira_o_nome_do_Projeto(String nome_Projeto) {
  // automatically receives results from controller input
  if (button==1) {
    boolean hide=true; //variável que esconde o campo de texto de acordo com o comportamento definido para o mesmo
    println("a textfield event for controller 'input_Text' : "+nome_Projeto);
    //nome_Projeto=theText;
    if (nome_Projeto!=null && !(nome_Projeto.equals(13)) && !(nome_Projeto.equals(""))) {
      if (nome_Projeto.equals("Enter the project name")) {
        cp5.get(Textfield.class, "Insira_o_nome_do_Projeto").clear();
        hide=false;
      } else {
        waitingDialog = booster.showWaitingDialog( "Saving project...", "Saving project...");
        Save_Project(lista_Objetos_Circuit, lista_Objetos_manga, nome_Projeto);
        waitingDialog.setMessage( "Project Saved");
        waitingDialog.close();
        hide=true;
      }
    } else {
      println("NOTICE: Empty Name, save operation canceled");
      hide=true;
    }
    if (hide==true) {
      cp5.get(Textfield.class, "Insira_o_nome_do_Projeto").hide(); //esconde área de texto
      //cp5.get(Bang.class, "Insira_o_nome_do_Projeto").hide();
    }
  }
  //Salva_Nome=true;
}

//void Enter_with_name()
//{
//  if (button==1) {
//  cp5.get(Bang.class,"Insira_o_nome_do_Projeto").getBehavior();
//  }
//}

void next_toolbox_Circuito()
{
  if (button==1) {
    listToolBox_Circuito_Tela1.proximo();
  }
}

void back_toolbox_Circuito()
{
  if (button==1) {
    listToolBox_Circuito_Tela1.anterior();
  }
}

void next_toolbox_Figura()
{
  if (button==1) {
    listToolBox_Figuras_Tela1.proximo();
  }
}

void back_toolbox_Figura()
{
  if (button==1) {  
    listToolBox_Figuras_Tela1.anterior();
  }
}

int cheq=1;
void Arrastar_Figura()
{
  cheq_2=1;
  cheq_ed_2=1;
  cheq_ed=1;
  if (button==1) {
    if (cheq==1) {
      Tool_drag.set_condicao_arrastar_ed(true);
      Tool_drag.ID("F");       // seta o identificador para saber qual layer arrastar o objeto
      cheq=2;
    } else
    {
      Tool_drag.set_condicao_arrastar_ed(false);
      cheq=1;
    }
  }
}

int cheq_2=1;
void Arrastar_Circuito()
{
  cheq=1;
  cheq_ed_2=1;
  cheq_ed=1;
  if (button==1) {
    if (cheq_2==1) {
      Tool_drag.set_condicao_arrastar_ed(true);
      Tool_drag.ID("C"); // seta o identificador para saber qual layer arrastar o objeto
      cheq_2=2;
    } else
    {
      Tool_drag.set_condicao_arrastar_ed(false);
      cheq_2=1;
    }
  }
}

int cheq_ed=1;
void Editar_Figuras()
{
  cheq_ed_2=1;
  cheq=1;
  cheq_2=1;
  if (button==1) {
      
    if (cheq_ed==1) {
      
      //zera condição de edição para não gerar inconsistências
      edicao_obj.set_condicao_de_ativamento(false);
      edicao_obj.set_selected(false);
      edicao_obj.set_condicao_de_edicao(false);
      
      Tool_drag.set_condicao_arrastar_ed(false);
      edicao_obj.set_condicao_de_ativamento(true);
      edicao_obj.ID("F");       // seta o identificador para saber qual layer editar o objeto o objeto
      toolbox_ED.hide();
      toolbox_ED.set_condicao_de_ativamento(true);
      //toolbox_ED.show(1019,630); //mostra a toolbox de edição na área de toolbox de figuras
      toolbox_ED.show(Coordenada_x_ToolBox_Figuras+Largura_ToolBox_Figuras-toolbox_ED.get_Largura()-10, 
                      Coordenada_y_ToolBox_Figuras+Altura_ToolBox_Figuras-toolbox_ED.get_Altura()-10);
      cheq_ed=2;
    } else
    {
      //desativa edição de objetos
      edicao_obj.set_condicao_de_ativamento(false);
      edicao_obj.set_selected(false);
      edicao_obj.set_condicao_de_edicao(false);
      
      toolbox_ED.set_condicao_de_ativamento(false);
      toolbox_ED.hide();
      cheq_ed=1;
    }
  }
}

int cheq_ed_2=1;
void Editar_Circuito()
{
  cheq_ed=1;
  cheq=1;
  cheq_2=1;
  if (button==1) {
      
    if (cheq_ed_2==1) {
      
      //zera condição de edição para não gerar inconsistências
      edicao_obj.set_condicao_de_ativamento(false);
      edicao_obj.set_selected(false);
      edicao_obj.set_condicao_de_edicao(false);
      
      Tool_drag.set_condicao_arrastar_ed(false);
      edicao_obj.set_condicao_de_ativamento(true);
      edicao_obj.ID("C");       // seta o identificador para saber qual layer editar o objetor o objeto
      toolbox_ED.hide();
      toolbox_ED.set_condicao_de_ativamento(true);
      //toolbox_ED.show(1019,33);   //mostra a toolbox de edição na área de toolbox de circuito
      toolbox_ED.show(Coordenada_x_ToolBox_Circuito+Largura_ToolBox_Circuito-toolbox_ED.get_Largura()-10, 
                      Coordenada_y_ToolBox_Circuito+Altura_ToolBox_Circuito-toolbox_ED.get_Altura()-10);
      cheq_ed_2=2;
    } else
    {
      //desativa edição de objetos
      edicao_obj.set_condicao_de_ativamento(false);
      edicao_obj.set_condicao_de_edicao(false);
      edicao_obj.set_selected(false);
      
      toolbox_ED.set_condicao_de_ativamento(false);
      toolbox_ED.hide();
      cheq_ed_2=1;
    }
  }
}



void EixoXY()
{
  if (button==1) {
    if(eixo_XY_Ed.get_condicao_de_ativamento())
       eixo_XY_Ed.set_condicao_de_ativamento(false);
    else
       eixo_XY_Ed.set_condicao_de_ativamento(true);
  }
}

void Grid_Graduada()
{
  if (button==1) {
    if(Grid_Graduada.get_condicao_de_ativamento())
       Grid_Graduada.set_condicao_de_ativamento(false);
    else
       Grid_Graduada.set_condicao_de_ativamento(true);
  }
  
}







//*****************botões tela 1 fim ***************************//



//*****************botões tela 2 inicio *************************//

public void proximo()
{
  // Seta a variável de impressão do circuito para true
  if (button==1) {
    lita_op2.proximo();
  }
}

public void anterior()
{
  // Seta a variável de impressão do circuito para true
  if (button==1) {
    lita_op2.anterior();
  }
}

public void Voltar()
{
  if (button==1) {

    //altera tela de volta para 1 e mostra botões da tela 1
    Numero_Tela=1;
    Mostra_botoes_Tela_1();
    esconde_botoes_Tela_2();
  }
}

public void atualiza_Tela_2()
{
  esconde_botoes_Tela_2();
  mostra_botoes_Tela_2();
}

public void Adicionar()
{
  // Seta a variável de impressão do manga para true
  if (button==1) {
    Add_Figura();
    Veri_inicia=0;
    atualiza_Tela_2();
  }
}


void Esconde_botoes_Tela_1()
{
  //esconde listas
  listToolBox_Figuras_Tela1.hide_Lista_toobox_tela2();
  listToolBox_Circuito_Tela1.hide_Lista_toobox_tela2();

  Controller c = cp5.getController("Imprimir_Circuito");
  c.hide();
  c = cp5.getController("Imprimir_Manga");
  c.hide();
  c = cp5.getController("Selecionar");
  c.hide();
  c = cp5.getController("back_toolbox_Figura");
  c.hide();
  c = cp5.getController("next_toolbox_Figura");
  c.hide();
  c = cp5.getController("back_toolbox_Circuito");
  c.hide();
  c = cp5.getController("next_toolbox_Circuito");
  c.hide();
  c = cp5.getController("Arrastar_Circuito");
  c.hide();
  c = cp5.getController("Arrastar_Figura");
  c.hide();
  //c = cp5.getController("Arquivo");
  //c.hide();
  c = cp5.getController("Salvar_Projeto");
  c.hide();
  c = cp5.getController("Carregar_Projeto");
  c.hide();
  c = cp5.getController("Editar_Figuras");
  c.hide();
  c = cp5.getController("Editar_Circuito");
  c.hide();
  c = cp5.getController("Grid_Graduada");
  c.hide();
  c = cp5.getController("EixoXY");
  c.hide();
  
      // disable object editing hides the transformation toolbox
      edicao_obj.set_condicao_de_ativamento(false);
      edicao_obj.set_selected(false);
      edicao_obj.set_condicao_de_edicao(false);
      
      toolbox_ED.set_condicao_de_ativamento(false);
      toolbox_ED.hide();
      cheq_ed=1;
      cheq_ed_2=1;
  
  
}


// whenever it is necessary to move from one screen to another, you must hide the buttons and lists present on the other screen
// this is done through the hide () function in the specific control of that button;
// the verification variables are used to initialize the listViews;
// one creates a new list view by filling in the correct values
// and another one triggers the listViw_show () function;
void Mostra_botoes_Tela_1()
{
 // add toolbox initialization variables
  Veri_list_Tela1=0;
  Veri_inicia_Tela1=0; //variáveis que inicializam a lista na tela 2

  //mostra informações da tela 1
  Controller c = cp5.getController("Imprimir_Circuito");
  c.show();
  c = cp5.getController("Imprimir_Manga");
  c.show();
  c = cp5.getController("Selecionar");
  c.show();
  c = cp5.getController("back_toolbox_Figura");
  c.show();
  c = cp5.getController("next_toolbox_Figura");
  c.show();
  c = cp5.getController("back_toolbox_Circuito");
  c.show();
  c = cp5.getController("next_toolbox_Circuito");
  c.show();
  c = cp5.getController("Arrastar_Circuito");
  c.show();
  c = cp5.getController("Arrastar_Figura");
  c.show();
  //c = cp5.getController("Arquivo");
  //c.show();
  c = cp5.getController("Salvar_Projeto");
  c.show();
  c = cp5.getController("Carregar_Projeto");
  c.show();
  c = cp5.getController("Editar_Figuras");
  c.show();
  c = cp5.getController("Editar_Circuito");
  c.show();
  c = cp5.getController("Grid_Graduada");
  c.show();
  c = cp5.getController("EixoXY");
  c.show();
}

// ***************** buttons screen 2 end ************************* //
