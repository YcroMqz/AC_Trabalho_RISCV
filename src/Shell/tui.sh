#!/bin/bash

# pega a pasta exata onde o script atual ta salvo.
# assim nao importa de onde voce chama ele no terminal.
dir_base="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# arquivos de saida (agora sempre salvos junto do script).
out_cpp="$dir_base/resultado_cpp.txt"
out_s="$dir_base/resultado_asm.txt"

# caminho pro rars flexivel.
# por padrao procura o rars1_6.jar na mesma pasta deste script.
# se tiver em outro lugar voce pode alterar o caminho abaixo.
rars_jar="${RARS_JAR:-$dir_base/rars1_6.jar}"

while true; do
    # cria o menu de escolha usando o whiptail.
    escolha=$(whiptail --title "executor de scripts" --menu "selecione uma opção para rodar:" 15 60 4 \
        "1" "rodar scripts" \
        "2" "comparação computacional" \
        "3" "comparação computacional (sem vista grossa)" \
        "4" "sair" 3>&1 1>&2 2>&3)

    # verifica se o usuário apertou "cancelar".
    if [ $? -ne 0 ]; then
        echo "operação cancelada pelo usuário."
        exit 0
    fi

    # processa a escolha do usuário.
    case $escolha in
        "1")
            echo "executando o programa c++..."
            
            # --- execução do cpp ---
            if "$dir_base/../C++/main" > "$out_cpp"; then
                whiptail --title "sucesso [c++]" --msgbox "script c++ executado!\nresultado salvo em:\n$out_cpp\n\npressione [enter] para voltar." 10 60     
            else
                whiptail --title "erro" --msgbox "falha ao executar o programa c++." 8 45
            fi
            
            # --- execução do programa assembly ---  
            echo "executando o programa em assembly..."
            
            # checa se o jar do rars existe pra evitar erros confusos na tela.
            if [ ! -f "$rars_jar" ]; then
                whiptail --title "erro" --msgbox "rars nao encontrado em:\n$rars_jar\n\ncoloque o jar na pasta ou mude o caminho no script." 12 60
            elif java -jar "$rars_jar" nc "$dir_base/../Codigo_Assembly/"*.s > "$out_s"; then
                whiptail --title "sucesso" --msgbox "script assembly executado!\nresultado salvo em:\n$out_s\n\npressione [enter] para voltar." 10 60            
            else
                whiptail --title "erro" --msgbox "falha ao executar o programa assembly." 8 45
            fi 
            ;;
 
        "2")
            echo "comparando as strings..."
            
            resultado_diff=$(diff -sw "$out_cpp" "$out_s" 2>&1)
            
            whiptail --title "comparação de resultados" \
                --msgbox "resultado do diff:\n\n$resultado_diff\n\n[enter] para voltar." 20 70
            ;;

        "3")
            echo "comparando as strings (sem vista grossa)..."
            
            resultado_diff=$(diff "$out_cpp" "$out_s" 2>&1)
            
            whiptail --title "comparação de resultados" \
                --msgbox "resultado do diff:\n\n$resultado_diff\n\npressione [enter] para voltar." 20 70
        ;;

        "4")
            echo "saindo..."
            break
            ;;
        *)
            whiptail --title "erro" --msgbox "opção inválida." 8 45
            ;;
    esac
done
