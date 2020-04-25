function y=fitness(x);
    y=sum(x.^2-10.*cos(2.*pi.*x)+10);
end