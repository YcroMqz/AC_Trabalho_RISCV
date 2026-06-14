#include <bits/stdc++.h>
using namespace std;

signed main() {
    locale::global(locale(""));
    
    wifstream arquivo("../String.txt");
    arquivo.imbue(locale(""));
    
    if (!arquivo) {
        wcerr << L"Erro ao abrir o arquivo.\n";
    }

    wstring linha;

    getline(arquivo, linha);

    unordered_map<wchar_t, wchar_t> acentuadas = {
        {L'á','a'},{L'à','a'},{L'â','a'},{L'ã','a'},{L'ä','a'},
        {L'Á','A'},{L'À','A'},{L'Â','A'},{L'Ã','A'},{L'Ä','A'},
        {L'é','e'},{L'è','e'},{L'ê','e'},{L'ë','e'},
        {L'É','E'},{L'È','E'},{L'Ê','E'},{L'Ë','E'},
        {L'í','i'},{L'ì','i'},{L'î','i'},{L'ï','i'},
        {L'Í','I'},{L'Ì','I'},{L'Î','I'},{L'Ï','I'},
        {L'ó','o'},{L'ò','o'},{L'ô','o'},{L'õ','o'},{L'ö','o'},
        {L'Ó','O'},{L'Ò','O'},{L'Ô','O'},{L'Õ','O'},{L'Ö','O'},
        {L'ú','u'},{L'ù','u'},{L'û','u'},{L'ü','u'},
        {L'Ú','U'},{L'Ù','U'},{L'Û','U'},{L'Ü','U'},
        {L'ç','c'},{L'Ç','C'}
    };

    wstring s;
    bool espaco = false;

    for (wchar_t x : linha) {
        if (x == L' ') {
            if (!espaco) {
                s += L' ';
                espaco = true;
            }
        } else {
            espaco = false;
            if (acentuadas.count(x)) {
                s += acentuadas[x];
            } else if (iswalnum(x)) {
                s += x;
            }
        }
    }

    wcout.imbue(locale(""));
    wcout << s << L'\n';
}