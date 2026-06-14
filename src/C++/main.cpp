#include <bits/stdc++.h>
using namespace std;
 
#define op ios::sync_with_stdio(false); cin.tie(NULL);
#define int long long
#define endl '\n'
#include <cctype>
 
signed main() {
    op

    ifstream arquivo("texto.txt");

    string linha;
    string s;
    getline(arquivo, linha);

    unordered_map<char, char> acentuadas = {
        {'á', 'a'}, {'à', 'a'}, {'â', 'a'}, {'ã', 'a'}, {'ä', 'a'},
        {'Á', 'A'}, {'À', 'A'}, {'Â', 'A'}, {'Ã', 'A'}, {'Ä', 'A'},
        {'é', 'e'}, {'è', 'e'}, {'ê', 'e'}, {'ë', 'e'},
        {'É', 'E'}, {'È', 'E'}, {'Ê', 'E'}, {'Ë', 'E'},
        {'í', 'i'}, {'ì', 'i'}, {'î', 'i'}, {'ï', 'i'},
        {'Í', 'I'}, {'Ì', 'I'}, {'Î', 'I'}, {'Ï', 'I'},
        {'ó', 'o'}, {'ò', 'o'}, {'ô', 'o'}, {'õ', 'o'}, {'ö', 'o'},
        {'Ó', 'O'}, {'Ò', 'O'}, {'Ô', 'O'}, {'Õ', 'O'}, {'Ö', 'O'},
        {'ú', 'u'}, {'ù', 'u'}, {'û', 'u'}, {'ü', 'u'},
        {'Ú', 'U'}, {'Ù', 'U'}, {'Û', 'U'}, {'Ü', 'U'},
        {'ç', 'c'}, {'Ç', 'C'}
    };

    bool espaco = false;

    for(char x : linha){

        if(x == ' '){
            if(!espaco){
                s.push_back(' ');
                espaco = true;
            }
        }
        else {
            espaco = false;

            if(acentuadas.count(x)){
                s.push_back(acentuadas[x]);
            }
            else if(isalnum(x)){
                s.push_back(x);
            }
        }
    }

    for(auto x : s){
        cout << x;
    }

}