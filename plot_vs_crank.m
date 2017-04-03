function [] = plot_vs_crank(theta, force_x, force_y)
mag = sqrt(force_x.^2 + force_y.^2);

plot(theta, mag)
end