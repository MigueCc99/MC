%option noyywrap

/*---- Selección de Declaraciones ----*/

%{
#include <iostream>
#include <fstream>

using namespace std;

ifstream fichero;

float nota, media = 0.0;
int filas, numero_alumno_aprobado, numero_alumno_suspenso = 0;
bool aprobado;

string cadena;
%}

/*---- Selección de Reglas ----*/

%%

[a-z A-z]	{
    cadena+=yytext;
}

[0-9]+"."[0-9]*	{
    nota=atof(yytext);
    media+=nota;
    filas++;
}

\n	{
    media = media/filas;
    if(media>=5.0)
        aprobado = true;
    else
        aprobado = false;
    
    if(aprobado){
        cout << "El/La alumn@ " << cadena << " está aprobad@ con una media de " << media << endl;
        numero_alumno_aprobado++;
    }else{
        cout << "El/La alumn@ " << cadena << " está suspens@ con una media de " << media << endl;
        numero_alumno_suspenso++;       
    }

    filas=0;
    cadena="";
    media=0.0;
}

%%

/*---- Selección de Procedimientos ----*/

int main(int argc, char*argv[]){
    if(argc==2){
        fichero.open(argv[1]);
        if(!fichero){
            cerr << "Error en la lectura del archivo" << endl;
            exit(1);
        }
    }else{
        cout << "Formato: ./medias<Nombre-fichero>"<< endl;
        exit(1);
    }

    nota=0.0;
    filas=0.0;

    yyFlexLexer flujo(&fichero,0);
    flujo.yylex();

    float paprobados = (numero_alumno_aprobado*100)/(numero_alumno_aprobado+numero_alumno_suspenso);
    float psuspensos = (numero_alumno_suspenso*100)/(numero_alumno_aprobado+numero_alumno_suspenso);

    cout << "\n\nEl rendimiento del profesor es: " << endl;
    cout << "   - Aprobados => " << paprobados << "%" << endl;
    cout << "   - Suspensos => " << psuspensos << "%" << endl;

    return 0;
}
