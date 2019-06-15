package co.edu.eafit.dis.st0270.s20181.duolujo;
import java_cup.runtime.*;
import java.io.Reader;
import java.io.FileReader;
import java.io.FileNotFoundException;
import java.util.*;

public class TigerMain {

    public static void usage(){
        System.err.println("TigerMain [-s] [-p] <files>");
        //System.exit(1);
    }

    public static void main(String[] args){

        if(args.length < 1){
            usage();
        }
	if(args[0].equals("-s")  ){
	    for(int i=1; i<args.length;i++){
		if(args[i].contains(".tgr")){
		    boolean par=false;
		    try{
			
			TigerLexer scan = new TigerLexer(new FileReader(args[i]));
			TigerParser parser = new TigerParser(scan);
			if(args[1].equals("-p") ){
			    try{
				TigerLexer scan2 = new TigerLexer(new FileReader(args[i]));
				TigerParser parser2 = new TigerParser(scan2);
				parser2.parse();
				par = true;
			    }catch(Exception e){
				par = false;
			    }catch(Error e){
				par =false;
			    }
			    
			}
			Symbol t = scan.next_token();
			while(!TigerSymbols.terminalNames[t.sym].equals("EOF")){
			    System.out.println("["+(scan.getLine()+1)+", "+columna(scan.getColumn(),t)+", "
					       +categoria(TigerSymbols.terminalNames[t.sym])+", \""+
					       (TigerSymbols.terminalNames[t.sym].equals("STRING")?"\""+t.value+"\"":t.value)
					       +"\" ]");
			    t = scan.next_token();
			}		        
			
		    }catch(FileNotFoundException fnfe){
			usage();
		    }catch(Exception e){	        
			//System.err.println(e);
			//System.exit(1);
		    }catch(Error e){
			//System.exit(1);

		    }

		    if(args[1].equals("-p") && par){
			String[] a = args[i].split("/");
			System.out.println("File: "+ a[a.length-1]+ " Parser: True \n");
			
	    
		    }else if(args[1].equals("-p") && !par){
			String[] a = args[i].split("/");
			System.out.println("File: "+ a[a.length-1]+ " Parser: False \n");
	    
		    }
		}

	    }

	}else {
	    int inicio=0;
	    if(args[0].equals("-p")){
		inicio=1;
	    }
	    
	    for(int i =inicio; i<args.length;i++){
		try{
	    
		    TigerLexer scan = new TigerLexer(new FileReader(args[i]));
		    TigerParser parser = new TigerParser(scan);
		    parser.parse();
		     String[] a = args[i].split("/");
		    System.out.println("File: "+ a[a.length-1]+ " Parser: True \n");
	    
		} catch (FileNotFoundException e){
		    usage();
		} catch (Exception e){
		     String[] a = args[i].split("/");
		    System.out.println("File: "+ a[a.length-1]+ " Parser: False \n");
                    //System.out.println(e.getMessage());
		    //System.exit(1);
		}catch(Error e){
		    String[] a = args[i].split("/");
		    System.out.println("File: "+ a[a.length-1]+ " Parser: False \n");
		    //System.exit(1);

		}
       
	    }
	}
    }

    public static String categoria(String type){
        List<String> keyword = Arrays.asList("ARRAY","IF","THEN","ELSE","IMPORT","WHILE","FOR","TO","DO","LET","IN","END","OF","BREAK","NIL","FUNCTION","VAR","TYPE","PRIMITIVE","CLASS","EXTENDS","METHOD","NEW");
	List<String> symbols = Arrays.asList("COMA","DP","PC","LPAREN","RPAREN","LCORCH","RCORCH","LLLAVE","RLLAVE","PUNTO","SUM","RES","MUL","DIV","IGUAL","MENOR","MAYOR","MENORI","MAYORI","AND","OR","DPIGUAL","MENMAY");

	if(type.equals("STRING")){
	    return "string";
	}else if (keyword.contains(type)){
	    return "keyword";
	}else if(symbols.contains(type)){
	    return "symbol";
	}else if(type.equals("INTEGER")){
	    return "number";
	}else{
	    return "id";
	}
	
    }

    public static int columna(int columna, Symbol t){
	if((TigerSymbols.terminalNames[t.sym].equals("STRING"))){
	    String a = (String)t.value;
		return columna - a.length()-1;

	    }else{
		return columna;

	    }
    }
}

