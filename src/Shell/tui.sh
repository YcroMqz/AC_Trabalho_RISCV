#!/bin/bash

# Arquivos de saída
OUT_CPP="resultado_cpp.txt"
OUT_S="resultado_asm.txt"

while true; do
    # Cria o menu de escolha usando o whiptail
    ESCOLHA=$(whiptail --title "Executor de Scripts" --menu "Selecione uma opção para rodar:" 15 60 4 \
        "1" "Rodar scripts" \
        "2" "Comparação Computacional" \
	"3" "Comparação Computacional (Sem vista grossa)" \
        "4" "Sair" 3>&1 1>&2 2>&3)

    # Verifica se o usuário apertou "Cancelar" (ESC ou botão Cancelar)
    if [ $? -ne 0 ]; then
        echo "Operação cancelada pelo usuário."
        exit 0
    fi

    # Processa a escolha do usuário
    case $ESCOLHA in
        "1")
        	echo "Executando o programa C++..."
            	# --- Execução do Cpp ---
		if ../C++/main > "$OUT_CPP"; then
                	whiptail --title "Sucesso [C++]" --msgbox "Script C++ executado!\nResultado salvo em: $OUT_CPP\n\nPressione [ENTER] para voltar ao menu." 10 50     
		else
        		whiptail --title "Erro" --msgbox "Falha ao executar o programa C++." 8 45
        	fi
		
		# --- Execução do programa Assembly ---  
		echo "Executando o programa em Assembly..."
	    
		if java -jar /home/hillan/.cache/yay/rars/rars1_6.jar nc ../Codigo_Assembly/*.s > "$OUT_S"; then
		    	whiptail --title "Sucesso" --msgbox "Script Assembly executado!\nResultado salvo em: $OUT_CPP\n\nPressione [ENTER] para voltar ao menu." 10 50   		
		else
			whiptail --title "Erro" --msgbox "Falha ao executar o programa Assembly" 8 45
		fi 
		;;
		        
	"2")
            	echo "Comparando as strings..."

		RESULTADO_DIFF=$(diff -sw "$OUT_CPP" "$OUT_S" 2>&1)

		whiptail --title "Comparação de Resultados" \
			--msgbox "Resultado do diff:\n\n$RESULTADO_DIFF\n\n[ENTER] para voltar." 20 70

	    ;;

	"3")
		echo "Comparando as string (Sem vista grossa)"

		RESULTADO_DIFF=$(diff "$OUT_CPP" "$OUT_S" 2>&1)

		whiptail --title "Comparação de Resultados" \
			--msgbox "Resultado do diff:\n\n$RESULTADO_DIFF\n\nPressione [ENTER] para voltar." 20 70
	;;

        "4")
            echo "Saindo..."
            break
            ;;
        *)
            whiptail --title "Erro" --msgbox "Opção inválida." 8 45
            ;;
    esac
done
