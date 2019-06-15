package co.edu.eafit.dis.st0270.s20181.duolujo;

import java_cup.runtime.Symbol;
import java.util.Stack;
%%
%cup
%class TigerLexer
%line
%column

%{
      StringBuffer string = new StringBuffer();

      private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
      }
      private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
      }
%}


%{
 public Stack<Character> anidado = new Stack<Character>();
 
 public int getColumn(){
  return yycolumn;
 }
 public int getLine(){
 return yyline;
 }


%}


integer = [0-9][0-9]*
id = [:jletter:] [:jletterdigit:]*["_"]*|"_main"

whitespace = [ \t]+
newline = \n|\r|\r\n|\n\r


fincom ="*/" 
cont =  [^"*/""/*"] | ["*"]* | ["/"]* 
inicom ="/*"

%state STRING
%state COMMENT
%%

<YYINITIAL>{
  "array"      { return new Symbol(TigerSymbols.ARRAY,yytext()); }
  "if"	       { return new Symbol(TigerSymbols.IF,yytext()); }
  "then"       { return new Symbol(TigerSymbols.THEN,yytext()); }
  "else"       { return new Symbol(TigerSymbols.ELSE,yytext()); }
  "while"      { return new Symbol(TigerSymbols.WHILE,yytext()); }
  "for"        { return new Symbol(TigerSymbols.FOR,yytext()); }
  "to"         { return new Symbol(TigerSymbols.TO,yytext()); }
  "do"         { return new Symbol(TigerSymbols.DO,yytext()); }
  "let"        { return new Symbol(TigerSymbols.LET,yytext()); }
  "in"         { return new Symbol(TigerSymbols.IN,yytext()); }
  "end"        { return new Symbol(TigerSymbols.END,yytext()); }
  "of"         { return new Symbol(TigerSymbols.OF,yytext()); }
  "break"      { return new Symbol(TigerSymbols.BREAK,yytext()); }
  "nil"	       { return new Symbol(TigerSymbols.NIL,yytext()); }
  "function"   { return new Symbol(TigerSymbols.FUNCTION,yytext()); }
  "type"       { return new Symbol(TigerSymbols.TYPE,yytext()); }
  "import"     { return new Symbol(TigerSymbols.IMPORT,yytext()); }
  "primitive"  { return new Symbol(TigerSymbols.PRIMITIVE,yytext()); }
  "class"      { return new Symbol(TigerSymbols.CLASS,yytext()); }
  "extends"    { return new Symbol(TigerSymbols.EXTENDS,yytext()); }
  "method"     { return new Symbol(TigerSymbols.METHOD,yytext()); }
  "new"	       { return new Symbol(TigerSymbols.NEW,yytext()); }
  "var"        { return new Symbol(TigerSymbols.VAR,yytext()); }


"<="         { return new Symbol(TigerSymbols.MENORI,yytext()); }
">="         { return new Symbol(TigerSymbols.MAYORI,yytext()); }
":="         { return new Symbol(TigerSymbols.DPIGUAL,yytext()); }
"<>"         { return new Symbol(TigerSymbols.MENMAY,yytext()); }
"+"          { return new Symbol(TigerSymbols.SUM,yytext()); }
"-"          { return new Symbol(TigerSymbols.RES,yytext()); }
"*"          { return new Symbol(TigerSymbols.MUL,yytext()); }
"/"          { return new Symbol(TigerSymbols.DIV,yytext()); }
","          { return new Symbol(TigerSymbols.COMA,yytext()); }
":"          { return new Symbol(TigerSymbols.DP,yytext()); }
";"          { return new Symbol(TigerSymbols.PC,yytext()); }
"("          { return new Symbol(TigerSymbols.LPAREN,yytext()); }
")"          { return new Symbol(TigerSymbols.RPAREN,yytext()); }
"["          { return new Symbol(TigerSymbols.LCORCH,yytext()); }
"]"          { return new Symbol(TigerSymbols.RCORCH,yytext()); }
"{"          { return new Symbol(TigerSymbols.LLLAVE,yytext()); }
"}"          { return new Symbol(TigerSymbols.RLLAVE,yytext()); }
"."          { return new Symbol(TigerSymbols.PUNTO,yytext()); }
"="          { return new Symbol(TigerSymbols.IGUAL,yytext()); }
"<"          { return new Symbol(TigerSymbols.MENOR,yytext()); }
">"          { return new Symbol(TigerSymbols.MAYOR,yytext()); }
"&"          { return new Symbol(TigerSymbols.AND,yytext()); }
"|"          { return new Symbol(TigerSymbols.OR,yytext()); }
\"           { string.setLength(0); yybegin(STRING);  }

{integer}    { return new Symbol(TigerSymbols.INTEGER,yytext());}
{id}	     { return new Symbol(TigerSymbols.ID,yytext()); }
{whitespace} { }
{newline}    { }
{inicom}     { anidado.push('('); yybegin(COMMENT); }

}

<<EOF>>	     {if(anidado.isEmpty()){ return new Symbol(TigerSymbols.EOF);}else{ throw new Error("Comentario mal cerrado");} }

<STRING>{
      \"                             { yybegin(YYINITIAL); 
                                       return symbol(TigerSymbols.STRING,string.toString()); }
      [^\n\r\"\\]+                   { string.append(yytext()); }
      \\t                            { string.append(yytext()); }
      \\a                            { string.append(yytext()); }
      \\b                            { string.append(yytext()); }
      \\f                            { string.append(yytext()); }
      \\v                            { string.append(yytext()); }
      \\n                            { string.append(yytext()); }
      \\r                            { string.append(yytext()); }
      \\\"                           { string.append(yytext()); }
      \\                             { string.append(yytext()); }
      \\[0-3][0-7][0-7]              { string.append(yytext());}
      \\x[0-9a-fA-F][0-9a-fA-F]      { string.append(yytext());}
      
}
    
<COMMENT> {
{inicom} {anidado.push('(');  }
{cont}   {}
{fincom} { if(anidado.peek().equals('(')){ anidado.pop(); }  if(anidado.isEmpty()){ yybegin(YYINITIAL);}}
}

 [^]                              { throw new Error("Illegal character <"+ yytext()+">"+" al line "+yyline+" at column"+ yycolumn); }

