package main;

import main.Pkg1.Pkg1Class;
import main.Pkg2.Pkg2Class;

public class App {
  public static void main(String[] args) {
    Pkg1Class.pkg1class1();
    Pkg2Class.pkg2class1();
    System.out.println(System.getenv("PORT"));

  }
}
