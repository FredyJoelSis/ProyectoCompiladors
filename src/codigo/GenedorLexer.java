/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package codigo;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 *
 * @author joel
 */
public class GenedorLexer {

    public static void main(String[] args) throws Exception {
       String ruta1 = "C:\\Cursos\\Java\\Fundamentos\\ProyectoFinalHTML\\src\\codigo\\Lexer.flex";
        String ruta2 = "C:\\Cursos\\Java\\Fundamentos\\ProyectoFinalHTML\\src\\codigo\\LexerCup.flex";
        String[] rutaS = {"-parser", "Sintax", "C:\\Cursos\\Java\\Fundamentos\\ProyectoFinalHTML\\src\\codigo\\Sintax.cup"};
        
        generar(ruta1, ruta2, rutaS);
    }
    
    public static void generar(String ruta1, String ruta2, String[] rutaS) throws IOException, Exception{
        File archivo;
        archivo = new File(ruta1);
        jflex.Main.generate(archivo);
        archivo = new File(ruta2);
        jflex.Main.generate(archivo);
        java_cup.Main.main(rutaS);
        
        Path rutaSym = Paths.get("C:\\Cursos\\Java\\Fundamentos\\ProyectoFinalHTML\\src\\codigo\\sym.java");
        if(Files.exists(rutaSym)){
            Files.delete(rutaSym);
        }
        
        Files.move(Paths.get("C:\\Cursos\\Java\\Fundamentos\\ProyectoFinalHTML\\sym.java"),
                Paths.get("C:\\Cursos\\Java\\Fundamentos\\ProyectoFinalHTML\\src\\codigo\\sym.java")
        );
        
        Path rutaSin = Paths.get("C:\\Cursos\\Java\\Fundamentos\\ProyectoFinalHTML\\src\\codigo\\Sintax.java");
        if(Files.exists(rutaSin)){
            Files.delete(rutaSin);
        }
        Files.move(Paths.get("C:\\Cursos\\Java\\Fundamentos\\ProyectoFinalHTML\\Sintax.java"),
                Paths.get("C:\\Cursos\\Java\\Fundamentos\\ProyectoFinalHTML\\src\\codigo\\Sintax.java")
        ); 
    }


  

}
