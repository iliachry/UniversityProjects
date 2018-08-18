function [ n_ref ] =n_ref( lamda , N)
%n_ref
%Returns the refractive index for a vector of
%wavelength lamda[um]
    a=[0.6961663 0.4079426 0.8974994];
    b=[0.004629148 0.01351206 97.934062];
    n_ref=zeros(1,N);
    for j=1:N
        n_sq=1;
        for i=1:3
            n_sq=n_sq+a(i)*lamda(j)^2/(lamda(j)^2 -b(i));
        end
        n_ref(j)=sqrt(n_sq);
    end
    figure; plot(lamda,n_ref);xlabel('wavelength [um]');
    title('Refractive index');
end

