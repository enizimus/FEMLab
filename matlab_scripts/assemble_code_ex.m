function assemble(file_name)
disp('-Assembling solution matrix and calculating solution ...')
tic
respth = ['.\results\', file_name];
load(respth)

K = zeros(n_nodes);
R = zeros(n_nodes,1);

i_elem = 1;
while(elements(i_elem).type == 1)
    i_elem = i_elem + 1;
end

for i_el=i_elem:n_elements
    
    i_n = elements(i_el).n;
    i_N = elements(i_el).nodes(i_n);
    
    K(i_N, i_N) = K(i_N, i_N) + elements(i_el).K(i_n, i_n);
    R(i_N) = R(i_N) + elements(i_el).R(i_n);
    
end

I = any(K,2);
K = K(I,:);
R = R(I);
I = any(K,1);
K = K(:,I);

U = K\R;

figure;surface(1:size(K,1),size(K,1):-1:1,K,K);colormap(bluewhitered);shading flat 
eigenvals = eig(K);
condition_number = max(abs(eigenvals))/min(abs(eigenvals));
disp(['Condition Number: ',num2str(condition_number)]);

save(respth, 'U', 'K', 'R','condition_number', '-append'); 
disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])
end