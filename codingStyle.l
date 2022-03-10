%option noyywrap

%{
#include <string>
#include <iostream>
using namespace std;
unsigned int needTab = 0;
bool isRight = false;
void print_word(char* yytext)
{
	string str(yytext);
	while(isspace(str[0])){
	str.erase(0,1);
	}
	if (str.empty())
		return;
	for(int i=0; i<needTab; i++){
		cout << "\t";
	}
	isRight=true;
	cout << str;
}
void print_left(char* yytext)
	{
		if ( isRight == false){
			for(int i=0; i<needTab; i++){
				cout << "\t";
			}
		}
        	needTab++;
        	string str(yytext);
        	cout << str;
        	isRight = false;
	}
void print_eol(char* yytext)
{
	string str(yytext);
	isRight = false;
	cout << str;
}
void elimTab(char* yytext)
{
	string str(yytext);
}
%}
left		\{
right	\}
word	[^\t\n{}]+
eol		\n
tab		\t

%%

{left}	{  print_left(yytext); }
{right}	{ needTab--; print_word(yytext); }
{word}	{ print_word(yytext); }
{eol}	{ print_eol(yytext) ; }
{tab}	{ elimTab(yytext); }

%%

int main(void) {
		yylex();
		return 0;
}