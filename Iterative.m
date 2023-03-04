function [PR] = Iterative(nume, d, eps) 
  fid = fopen(nume, 'r'); #deschidem fisierul din interiorul caruia dorim sa citim date
  vector_size = fscanf(fid,'%d',[1 1]); #facem conversia string-ului prin intermediul functiei 'fscanf'
  A = size(vector_size, vector_size); #declaram matricea A , aceasta fiind matricea stocastica a grafului
  string = fgetl(fid); #citim linie cu linie datele din fisierul de intrare
  for i = 1 : vector_size
    ok = 0; #cu ajutorul variabilei 'ok' vom construi matricea A, dupa 2 cazuri posibile
    string = fgetl(fid); 
    B = sscanf(string, '%d'); #convertim liniile din fisier pentru a avea elemente de tip intreg
    B = B';
    x = B(1,1);
    nr = B(1,2);
    for j = 1 : nr
      if x == B(1, j + 2)
        ok = 1;
      endif
    endfor
    if ok == 1
      for j = 1 : nr
        A(B(1, j + 2), x) = 1 / (nr - 1); #ne construim matricea A in cazul in care un nod indica tot spre el in graful din fisierul nostru
      endfor
    endif
    if ok == 0
      for j = 1 : nr
        A(B(1, j + 2), x) = 1 / nr; #ne construim matricea A in cazul in care niciun nod nu indica spre el in fisierul nostru
      endfor
    endif
  endfor
  for i = 1 : vector_size
    A(i,i) = 0;
  endfor
  fclose(fid);
  
  N = size(A,1); #ne initializam numarul de elemente din fisier
  PR(1:vector_size, 1) = 1 / vector_size; #initializam vectorul Pagerank
  PR0 = rand(N,1);
  while norm(PR - PR0,2) > eps #comparam norma diferentei dintre vectorul Pagerank si vetorul Pagerank initial cu o eroare data ca parametru functiei 
    PR0 = PR;
    PR = (d * A) * PR + ((1 - d) / N) * ones(N,1); #formula prin care calculam iterativ vectorul Pagerank in cadrul conditiei impuse de 'while' 
  endwhile
endfunction