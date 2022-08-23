%% feasible region for maximising power output
clear;
clc;

A = [[1.074 0.712];   % 1.074x + 0.712y <= 196 (spacing constraint)
     [4 2.5];   %  4x +  2.5y <= 1500 (cost constraint)
     [-1 0];  % non-negativity constraint x>=0
     [0 -1];  % non-negativity constraint y>=0
    ];
b = [196;
     1500;
     0;
     0;
    ];
lower_b = [0; 0];
upper_b = [230; 260];
c = [8; 5];
figure(1)
[sorted_vertices, ...
 h_fes, h_bnd, h_fill, h_vert, h_int, h_max, g_labels] = ...
    plot_feasible(A, b, c, lower_b, upper_b, ...
		  'linecolor', 'b', ...
		  'linestyle', ':', ...
		  'filllinestyle', ':', ...
		  'backgroundcolor', [0.6 1 1], ...
		  'linesep', 20, ...
		  'plot_vertices', 'ko', ...
		  'label_vertices', 1, ...
		  'label_vertices_size', 10, ...
		  'label_vertices_prec', 0, ...
		  'label_vertices_color', 'b', ...
		  'plot_max', 'r*');
set(h_max, 'markersize', 30)
d = 120;
text(d, 200, 'maximize', 'fontsize', 10);
text(d, 185, 'f = 8x + 5y', 'fontsize', 10, 'FontName', 'Courier');
text(d, 170, 'subject to ', 'fontsize', 10);
text(d, 155, '1.074x + 0.712y \leq 196', 'fontsize', 10, 'FontName', 'Courier');
text(d, 140, '     4x +  2.5y \leq 1500', 'fontsize', 10, 'FontName', 'Courier');
text(d, 125, '              x \geq 0', 'fontsize', 10, 'FontName', 'Courier');
text(d, 110, '              y \geq 0', 'fontsize', 10, 'FontName', 'Courier');
axis square
set(gcf, 'PaperPosition', [0 0 4 4]);
print('-dpng', 'plot_feasible.png');





