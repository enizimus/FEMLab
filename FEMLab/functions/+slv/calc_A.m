function calc_A(files, optProb)
disp('-Setting up element matrices and calculating A')
tic

load(files.respth, 'elements', 'sRegions', 'nNodes', 'nElems',...
    'nodeProps', 'elemsRegion', 'nTris', 'nLines', 'triangles', 'x', 'y')

[f_K, f_R] = slv.get_funs('element', optProb);
[fun_K, fun_R] = slv.get_funs('quadrature', optProb);
[xTri, yTri] = msh.getTriXY(triangles, x, y, nTris);
tri_area = util.calc_tri_area(xTri, yTri, nTris);
ABCs = slv.calc_abcs(xTri, yTri, nTris, tri_area);
[paramsElem, paramsSour] = msh.getElemParams(optProb, elemsRegion, sRegions);
elems = reshape([elements(nLines+1:end).nodes], [3 nElems-nLines])';
[Uk, Ik] = slv.setup_known_U(elems, nTris, nodeProps, sRegions);

K = spalloc(nNodes, nNodes, 6*nNodes);
R = zeros(nNodes,1);

for i_el = nLines+1:nElems
    iTri = i_el-nLines;
    abc = reshape(ABCs(iTri,:,:), [3,3]);

    [tK, tR, tU, tn] = ... % U, fun_K, fun_R, f_K, f_R, A, abc, xe, ye, k1, f, I)
        slv.calc_element_RK(Uk(iTri,:)', fun_K, fun_R, f_K, f_R, tri_area(iTri),abc,...
        xTri(iTri,:), yTri(iTri,:), paramsElem(i_el), paramsSour(i_el), Ik(iTri,:));
    
    i_N = elements(i_el).nodes(tn);
    
    K(i_N, i_N) = K(i_N, i_N) + tK(tn, tn);
    R(i_N) = R(i_N) + tR(tn);
    
    elements(i_el).K = tK(tn, tn);
    elements(i_el).R = tR(tn);
    elements(i_el).U = tU;
    
end

Ap = zeros(nNodes, 1);

I = any(K,2);
u_unknown = I;
u_known = ~I;
K = K(I,:);
R = R(I);
I = any(K,1);
K = K(:,I);

U_known = slv.get_known_U(u_known, sRegions);
U_unknown = K\R;
Ap(u_unknown) = U_unknown;
Ap(u_known) = U_known;

% figure;surface(1:size(K,1),size(K,1):-1:1,K,K);colormap(util.bluewhitered);shading flat 
% eigenvals = eig(full(K));
% condition_number = max(abs(eigenvals))/min(abs(eigenvals));
% disp(['Condition Number: ',num2str(condition_number)]);

save(files.respth, 'elements', 'Ap', 'K', 'R', 'tri_area', 'ABCs', '-append');
disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])
end