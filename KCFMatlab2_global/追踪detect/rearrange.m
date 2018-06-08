function mat = rearrange(mat)
[cx,cy] = size(mat);

q0 = mat(1:cx/2, 1:cy/2);
q1 = mat(cx/2+1:cx, 1:cy/2);
q2 = mat(1:cx/2, cy/2+1:cy);
q3 = mat(cx/2+1:cx, cy/2+1:cy);

mat = [q3 q1; q2 q0];
end