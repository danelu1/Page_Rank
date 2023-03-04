function [B] = PR_Inv(A)
  [m n] = size(A); #algoritm pentru factorizarea QR folosind Gram-Schmidt
  Q = zeros(n,n);
  R = zeros(n,n);
  for j = 1 : n
    for i = 1 : j - 1
      R(i,j) = Q(:,i)' * A(:,j);
    endfor
    s = zeros(n,1);
    for i = 1 : j - 1
      s = s + R(i,j) * Q(:,i);
    endfor
    aux = A(:,j) - s;
    R(j,j) = norm(aux,2);
    Q(:,j) = aux / R(j,j);
  endfor
  
  B = zeros(n); #inversa matricei A
  C = eye(n); #matricea din care vom scoatele coloanele matricei unitate
  for i = 1 : n
    B(:,i) = SST(R, Q' * C(:,i)); #calculul inversei lui A folosind o functie ce rezolva un sistem superior triunghiular
  endfor
endfunction