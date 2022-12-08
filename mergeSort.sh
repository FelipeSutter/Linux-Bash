#!/bin/bash

MergeSort (){

  local a=("$@") #declaração local da variavel de vetor. @ = saber o tam do vetor

  if [ ${#a[@]} -eq 1 ]; then #se tiver somente um elemento no vetor
    echo "${a[@]}" #imprime esse elemento
  elif [ ${#a[@]} -eq 2 ]; then #senão se vetor tiver 2 elementos
    if [ "${a[0]}" '>' "${a[1]}" ]; then #se o elemento na pos 0 for > do que o na pos 1
      echo "${a[1]}" "${a[0]}" #imprime o da pos 1 e depois o da 0, já que o da 1 é menor
    else
      echo "${a[@]}" #se for falso o teste, imprime na ordem que está 
    fi
  else #caso tenha mais de 2 elementos

    local p=($(( ${#a[@]} / 2 ))) #divide esse vetor em 2
    local m1=($(MergeSort "${a[@]::p}")) #declaração de uma metade do vetor, já os ordenando
    local m2=($(MergeSort "${a[@]:p}")) #outra metade do vetor, fazendo a mesma coisa
    local ret=() #declaração de uma função

    while [ ${#m1[@]} -gt 0 ] && [ ${#m2[@]} -gt 0 ]; do #enquanto as duas metades forem maiores que 0
      if [ "${m1[0]}" '>' "${m2[0]}" ]; then #se o elemento 1 da metade 1 for > que o da metade 2
        ret+=("${m2[0]}") #função recebe ela mesma + elemento pos 0 de metade 2
        m2=("${m2[@]:1}") #metade 2 recebe os elementos baseado no seu tamanho
      else #se for falso 
        ret+=("${m1[0]}") #função recebe ela mesma + elemento pos 0 de metade 1
        m1=("${m1[@]:1}") #metade 1 recebe os elementos baseado no seu tamanho
      fi #final da condição
    done #final do while
    echo "${ret[@]}" "${m1[@]}" "${m2[@]}" #imprime a função, pois ela teoricamente está com o menor elementos
                                           #depois a primeira metade, já ordenada, e a segunda metade
  fi
}

echo "Ordenação de números ou strings? [n-números / s-strings]"
read letra
if [[ "$letra" == "n" ]]; then #se a letra que digitei == n
    echo -n "Digite 10 números: "
else #se for qualquer outra letra
    echo -n "Digite 10 strings: "
fi
read -a a # -a serve para declarar a variavel como array
b=($(MergeSort "${a[@]}")) #ordenando o que o usuário digitar
echo "${b[@]}" #printando o que o usuário digitou ordenadamente
