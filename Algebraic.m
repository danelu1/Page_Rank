function [PR] = Algebraic(nume, d)
  fid = fopen(nume, 'r'); #procedam exact ca la prima cerinta pentru a calcula matricea stocastica A
  vector_size = fscanf(fid,'%d',[1 1]);
  A = size(vector_size, vector_size);
  string = fgetl(fid);
  for i = 1 : vector_size
    ok = 0;
    string = fgetl(fid);
    B = sscanf(string, '%d');
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
        A(B(1, j + 2), x) = 1 / (nr - 1);
      endfor
    endif
    if ok == 0
      for j = 1 : nr
        A(B(1, j + 2), x) = 1 / nr;
      endfor
    endif
  endfor
  for i = 1 : vector_size
    A(i,i) = 0;
  endfor
  fclose(fid);
  
  N = size(A,1);
  PR = PR_Inv(eye(N) - d * A) * ((1 - d) / N) * ones(N,1); #calculam vectorul Pagerank folosind formula respectiva care rezulta din cea iterativa
                                                           #prin renuntare la iteratii