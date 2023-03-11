
#stampa la matrice a console
def stampa_matrice(matrice)
    matrice.each_with_index do |item, i|
        item.each_with_index do |item2, j|
            print matrice[i][j]
        end
        puts ""
    end
end


#il metodo prende in input una matrice e gli indici riga e colonna (i,j) di un elemento
#restituisce il numero di vicini vivi
def vicini_vivi(matrice,i,j)
    num_righe = matrice.length
    num_colonne = matrice[0].length
    alto_sinistra_i = i-1
    alto_sinistra_j = j-1
    alto_i = i-1
    alto_j = j
    alto_destra_i = i-1
    alto_destra_j = j+1
    sinistra_i = i
    sinistra_j = j-1
    destra_i = i
    destra_j = j+1
    basso_sinistra_i = i+1
    basso_sinistra_j = j-1
    basso_i = i+1
    basso_j = j
    basso_destra_i = i+1
    basso_destra_j = j+1
    #controlliamo tutte  le posizioni
    vivi = 0
    if alto_sinistra_i >= 0 && alto_sinistra_j >=0 
        if matrice[alto_sinistra_i][alto_sinistra_j] == '*'
            vivi += 1
        end
    end
    if alto_i >= 0 
        if matrice[alto_i][alto_j] == '*'
            vivi += 1
        end
    end
    if alto_destra_i >= 0 && alto_destra_j < num_colonne 
        if matrice[alto_destra_i][alto_destra_j] == '*'
            vivi += 1
        end
    end
    if sinistra_i >= 0 
        #puts "controllo superato"
        if matrice[sinistra_i][sinistra_j] == '*'
            vivi += 1
        end
    end
    if  destra_j < num_colonne
        if matrice[destra_i][destra_j] == '*'
            vivi += 1
        end
    end
    if basso_sinistra_i < num_righe && basso_sinistra_j >=0
        if matrice[basso_sinistra_i][basso_sinistra_j] == '*'
            vivi += 1
        end
    end
    if basso_i < num_righe 
        if matrice[basso_i][basso_j] == '*'
            vivi += 1
        end
    end
    if basso_destra_i < num_righe && basso_destra_j < num_colonne
        if matrice[basso_destra_i][basso_destra_j] == '*'
            vivi += 1
        end
    end

    return vivi

end

def calcola_prossimo_stato(matrice)
    
    nuovo_stato = Array.new(matrice.length)
    
    matrice.each_with_index do |item, i|
        riga_i = Array.new(matrice[0].length)
        item.each_with_index do |item2, j|
            vicini = vicini_vivi(matrice,i,j)
            if matrice[i][j] == '*' && vicini < 2
                riga_i[j] = '.'
            end
            if  matrice[i][j] == '*' && (vicini == 2 || vicini == 3)
                riga_i[j] = '*'
            end
            if  matrice[i][j] == '*' && vicini > 3
                riga_i[j] = '.'
            end
            if matrice[i][j] == '.' && vicini == 3
                riga_i[j] = '*'
            end
            if matrice[i][j] == '.' && (vicini < 3 || vicini > 3)
                riga_i[j] = '.'
            end

        end
        nuovo_stato[i] = Array.new(riga_i)    

    end
    
    return nuovo_stato
end


def leggi_dati
    linea = 0
    righe = 0
    colonne = 0
    generazione = 0
    file_ok = true
    matrice = nil
    File.readlines('start.txt').each do |line|
        if linea == 0
            generazione = line.split(" ")[0].to_i
        elsif linea == 1
            righe_colonne = line.split(" ")
            righe = righe_colonne[0].to_i
            colonne = righe_colonne[1].to_i
            matrice = Array.new(righe)
        else
            riga = line.split(" ")
            if colonne != riga.length()
                file_ok = false
                return nil,generazione,righe,colonne
            else
                matrice[linea-2] = riga
            end
            
        end
        linea += 1
    end
    return matrice,generazione,righe,colonne
end

matrice,generazione,righe,colonne = leggi_dati
if matrice != nil
    puts "Generation #{generazione+1}:"
    print righe
    puts " #{colonne}"
    stampa_matrice(calcola_prossimo_stato(matrice))
else
    puts "formato file non corretto"
end
