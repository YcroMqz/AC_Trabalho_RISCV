# RISC-V Text Sanitizer

Projeto desenvolvido para a disciplina de Arquitetura de Computadores com o objetivo de implementar e comparar uma rotina de normalização textual em duas abordagens distintas: uma implementação em alto nível utilizando C++ e uma implementação equivalente em Assembly RISC-V (RV32I).

---

## Integrantes

- Yasmim Silva Cosme
- José Mateus Araújo Alves
- Icaro Marques de Sousa Oliveira
- Hillan Alves de Sousa

---

## Objetivo

O projeto busca comparar os resultados produzidos por duas implementações equivalentes de um mesmo algoritmo:

- Versão em C++
- Versão em Assembly RISC-V (RV32I)

A validação é realizada automaticamente por meio de um script Shell que executa ambas as versões e compara suas saídas.

---

## Funcionalidades

- Remoção de pontuações ASCII
- Remoção de símbolos ASCII e UTF-8
- Conversão de caracteres acentuados para ASCII
- Preservação de letras (`A-Z`, `a-z`)
- Preservação de números (`0-9`)
- Preservação de espaços
- Comparação automática entre as saídas das implementações

### Exemplo

**Entrada**

```text
A normalização de texto remove símbolos como %, $, @, # e converte caracteres acentuados: á, é, í, ó, ú, ç.
```

**Saída**

```text
A normalizacao de texto remove simbolos como e converte caracteres acentuados a e i o u c
```

---

## Tecnologias Utilizadas

- C++
- Assembly RISC-V (RV32I)
- RARS
- Shell Script
- Git

---

## Estrutura do Projeto

```text
AC_Trabalho_RISCV
├── Acentos_Mapeados.txt
├── README.md
└── src
    ├── C++
    │   ├── main
    │   └── main.cpp
    ├── Codigo_Assembly
    │   ├── main.s
    │   ├── read_input_file.s
    │   └── utf8_map.s
    ├── Shell
    │   ├── resultado_asm.txt
    │   ├── resultado_cpp.txt
    │   └── tui.sh
    └── String.txt
```

---

## Implementação em C++

A versão em C++ utiliza `wstring`, `wifstream` e `unordered_map` para realizar o processamento da string.

Os caracteres acentuados são armazenados em uma tabela de mapeamento, permitindo sua conversão para equivalentes ASCII durante a varredura da entrada. Caracteres alfanuméricos são preservados, enquanto símbolos e pontuações são descartados.

---

## Implementação em Assembly

A versão em Assembly utiliza uma tabela de conversão armazenada em memória (`utf8_map`) para mapear caracteres UTF-8 acentuados para seus equivalentes ASCII.

Durante o processamento:

1. O arquivo de entrada é carregado para memória.
2. Cada byte é analisado individualmente.
3. Caracteres ASCII válidos são copiados para a saída.
4. Caracteres UTF-8 iniciados por `0xC3` são consultados na tabela de conversão.
5. Símbolos e caracteres não suportados são descartados.

Essa abordagem usa conceitos fundamentais de:

- Manipulação de memória
- Lookup Tables
- Endereçamento
- Processamento de caracteres UTF-8
- Programação em baixo nível

---

## Fluxo de Execução

```text
String.txt
    │
    ├──► C++
    │       │
    │       └──► resultado_cpp.txt
    │
    └──► Assembly RISC-V
            │
            └──► resultado_asm.txt

resultado_cpp.txt
resultado_asm.txt
        │
        ▼
     Comparação
```

---

## Como Executar

Primeiramente clone o repositório:

```bash
git clone git@github.com:YcroMqz/AC_Trabalho_RISCV.git
cd AC_Trabalho_RISCV
```

A partir da pasta do script:

```bash
cd src/Shell
chmod +x tui.sh
./tui.sh
```

### Opções do Menu

| Opção | Descrição |
|---------|---------|
| 1 | Executa as versões C++ e Assembly |
| 2 | Compara as saídas usando `diff -sw` |
| 3 | Compara as saídas usando `diff` |
| 4 | Encerra o programa |

---

## Observações

A implementação em Assembly contempla apenas os caracteres previamente mapeados na tabela `utf8_map`.

Caracteres UTF-8 que não possuam correspondência definida nessa tabela são descartados durante o processamento.
