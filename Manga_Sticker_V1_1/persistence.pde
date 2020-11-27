// **
// Description: this file is intended for creating the program's persistence. the idea is to use table objects in conjunction with arrays
 //             of objects to facilitate the process. in this case, persistence consists of two perspectives, loading and saving:
 //                * Save: in this point of view, the user creates a project and selects the option to save. in this case, the program creates a file in the format of
 //                          obj table, this file will contain information about all the components inserted by the user, which in this case 
 //                          consist of table rows with the following information:
 //                                  * Row: Nome_Figura_Ed; Nome_Figura_original; x, y, NomeObj, Tipo;
 //                          the idea is as follows, so that there are no errors with the changes made by the user, the program saves all the editing images of the objects
 //                          in the project folder, and when it will load, take two references, one from the figures folder and another from the saved figure from the previous project
 //                * Load: the load option is selected by the user, with which a search field is shown where he selects the project file
 //                            ,this file contains the information of all the objects previously created which consists of the objects to be inserted 
 //                            in the arrays of figure and circuit objects. in this case, the program reads the information from that file to the memorial, then
 //                            creates the objects of your life form and inserts them in the lists, with that, the objects will automatically be shown
 //                            for the user;
 

// this function receives the reference of the object arrays and the name of the project folder
// with that, the project is loaded, starting with the table and then generating obj by obj from
// the data from the table rows
// it is important to check the compensation of the editing area region, this is due to the fact that the function of creating objects
// already makes this option by subtracting x and y from editing the x and y of the main window, so it is necessary to add
// x and y editing on loading so that the coordinates of objects are not changed.
// Description: the function works as follows:
//     1. a table is created that receives the project file to be loaded from the disk;
//     2. the data is read from the table in order to assemble the objects according to the data in the table rows, both C and F
//     3. the create Component () function is used to insert all components of the loaded project in the component lists.
//        it is important to use the create_Componente () function not only to fill the lists but also to maintain the context of indexing
//        the functions of undo and redo, which in this case, are filled according to the creation of the objects;
//     5. with this, the previous project is successfully loaded.
// it is still necessary to insert error checking and allow the user to select the project with the selectFile folder browser;

boolean load_Project(ArrayList<Obj_Componente> Lista_Circuito, ArrayList<Obj_Componente> Lista_Manga,String Figure_folder, String Project_Folder)
{
  try{
   
  String name;
  // receives the name of the project folder through the user
  String full_name = Seleciona_Project_path();
  
  // check if a project file has been selected
  if(full_name ==null) 
     throw new Exception("ERROR: PROJECT NOT SELECTED...");
  
  
  String [] name_Split = split(full_name,".");
  name = name_Split[0];
  
  Table Projeto_MangaCircuit_Table = loadTable( sketchPath() + "/" + Project_Folder + name + "/" + name + ".csv","header");
  println("tabela lida: teste..." + Projeto_MangaCircuit_Table.getRow(0).getString("Nome_Figura_Ed"));
  // clear lists of objects present to load the selected project
   Lista_Circuito.clear();
   Lista_Manga.clear();
   
  println("carregando projeto...");
  //msg_carregamento(String MSG, int x, int y, String font_name, int tam_font)
  //msg_carregamento("CARREGANDO PROJETO...", width/2-400,height/2-100,"arial",30,color(0)); 
  // não mostra a mensagem por causa do loop do draw que tem que passar por ele, tem que pensar
  // em outra estratégia para mostrar a mensagem de carregamento
  //Solução: usar as funções da biblioteca uibooster para mensagens de notificação
  waitingDialog = booster.showWaitingDialog( "Loading project ...", "Loading project ...");
  
  for (int i=0;   i < Projeto_MangaCircuit_Table.getRowCount(); i++)
  {
    TableRow newRow = Projeto_MangaCircuit_Table.getRow(i);
    PImage Figura_Ed = loadImage(sketchPath() + "/" + Project_Folder + "/" + name +"/" + "Figures_Folder" + "/" + newRow.getString("Nome_Figura_Ed") + ".png");
    int x = newRow.getInt("x");
    int y = newRow.getInt("y");
    String NomeObj = newRow.getString("NomeObj");
    String ID = newRow.getString("Tipo");
    PImage Figura_Original;
    
    if(ID.equals("F")){
         Figura_Original = loadImage(sketchPath() + Figure_folder +  newRow.getString("Nome_Figura_original"));
    }
    else{
      //if(ID.equals("C")){
         Figura_Original = loadImage(sketchPath() + Circuit_folder + newRow.getString("Nome_Figura_original"));
      //}
    }
    
    //Obj_Componente(PImage componente, PImage cach_Image, int x, int y, String ID, String name)
    Obj_Componente new_Obj = new Obj_Componente(Figura_Ed, Figura_Original.copy(),x,y,ID,NomeObj);
    
    if(new_Obj.ID().equals("C"))
    {
      //create_Componente(rect1, new_Obj, Mx, My);
       // have to compensate for the sum of the editing area that is subtracted within the create component, if not
       // all components are moved whenever the project is loaded
      create_Componente(rect1, new_Obj, new_Obj.x() + LayerEd_Componentes.x(),new_Obj.y() + LayerEd_Componentes.y());
     // Lista_Circuito.add(new_Obj);
      println("Obj: "+new_Obj.ID()+ " : " + i + " carregado!");
    }else
    {
      if(new_Obj.ID().equals("F"))
      {
        //Lista_Manga.add(new_Obj);
        create_Componente(rect2, new_Obj, new_Obj.x() + LayerEd_Figuras.x(),new_Obj.y() + LayerEd_Figuras.y());
        println("Obj: "+new_Obj.ID()+ " : " + i + " carregado!");
      }
      
    }
    
    //println("Obj: "+new_Obj.ID()+ " : " + i + " carregado!");
  }
  
  waitingDialog.setMessage("Project loaded!");
  waitingDialog.close();
  
  return true;
  
  
  
  }catch (Exception ex)
  {
    ex.printStackTrace();
    return false;
  }
  
  
  
}


// the save function is the inverse of the loading function
// here the objects are collected from the component lists, and the table the table lines are assembled from each object
// Description: the function works as follows:
//     1. a table is created that receives the project object data to be saved on the disk;
//     2. the data is read from the component lists in order to assemble the table rows according to the data of each object, both C and F
//     3. the function create_Componente () is used to insert all components of the loaded project in the component lists.
//     5. with this, the previous project is successfully saved in the projects folder.
// it is still necessary to insert error checks and allow the user to select the name of the project to be saved and even the folder where it will be saved;
boolean Save_Project(ArrayList<Obj_Componente> Lista_Circuito, ArrayList<Obj_Componente> Lista_Manga, String name)
{
  
  
  Table Projeto_MangaCircuit_Table = new Table();

  // creating folder for the project, creates the project folder and the folder of the pictures used
  createOutput( sketchPath() + "/" + Project_Folder + "/" + name + "/"+name); 
  delay(10);
  createOutput( sketchPath() + "/" + Project_Folder + "/" + name + "/" + name + "/" + "Figures_Folder");

  Projeto_MangaCircuit_Table.addColumn("Nome_Figura_Ed");
  Projeto_MangaCircuit_Table.addColumn("Nome_Figura_original");
  Projeto_MangaCircuit_Table.addColumn("x");
  Projeto_MangaCircuit_Table.addColumn("y");
  Projeto_MangaCircuit_Table.addColumn("NomeObj");
  Projeto_MangaCircuit_Table.addColumn("Tipo");

  println("Saving Project ...");
  for (int i=0; i<Lista_Circuito.size(); i++)
  {
    TableRow newRow = Projeto_MangaCircuit_Table.addRow();
    Obj_Componente Obj_C = Lista_Circuito.get(i);
    newRow.setString("Nome_Figura_Ed", "C;"+i);
    newRow.setString("Nome_Figura_original", Obj_C.name());
    newRow.setInt("x", Obj_C.x());
    newRow.setInt("y", Obj_C.y());
    newRow.setString("NomeObj", Obj_C.name());
    newRow.setString("Tipo", Obj_C.ID());
    
    Obj_C.get_Pimage().copy().save(sketchPath() + "/" + Project_Folder + "/" + name +"/" + "Figures_Folder" + "/" + "C;" + i + ".png");
    
    println("obj_C: "+i);
  }

  for (int i=0; i<Lista_Manga.size(); i++)
  {
    TableRow newRow = Projeto_MangaCircuit_Table.addRow();
    Obj_Componente Obj_F = Lista_Manga.get(i);
    newRow.setString("Nome_Figura_Ed", "F;"+i);
    newRow.setString("Nome_Figura_original", Obj_F.name());
    newRow.setInt("x", Obj_F.x());
    newRow.setInt("y", Obj_F.y());
    newRow.setString("NomeObj", Obj_F.name());
    newRow.setString("Tipo", Obj_F.ID());
    Obj_F.get_Pimage().copy().save(sketchPath() + "/" + Project_Folder + "/" + name +"/" + "Figures_Folder" + "/" +  "F;" + i + ".png");
    
    println("obj_F: "+i);
  }
  
  saveTable(Projeto_MangaCircuit_Table, sketchPath() +"/" +  Project_Folder + "/" + name + "/" + name + ".csv" );
  
  println("Project saved!");
  
  return true;
}


// User selection methods for projects
// the Method opens a search field for the user, he selects a project in .csv or .xml
// which is the project he wants to load, the method returns the name of the selected project
File project_path;
boolean Selection_P= false;
String Seleciona_Project_path()
{
  selectInput("Select a project to process:", "folderSelected");
  
   // wait for the object to be selected
   // this generates an error on account that takes control of Draw until the end of the action, but works normally
  while (Selection_P == false) {
    delay(100);
  }
  // variable that verifies the completion of the selection action
  Selection_P=false;
  
  // check if a path has been selected correctly
  if (!(project_path == null))
  {
    println("\nProjeto selecionado: " + project_path.getName());
    return project_path.getName();
  }else
  {
   println("\nProjeto: sem seleção");
   return null; 
  }
}

void folderSelected(File path) {
  project_path = path;

  // variable that verifies the completion of the selection action
  if (project_path == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + project_path.getAbsolutePath());
  }
  Selection_P = true;
}
