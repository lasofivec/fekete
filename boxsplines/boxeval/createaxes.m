function createaxes(Parent1, YMatrix1)
%CREATEAXES(PARENT1,YMATRIX1)
%  PARENT1:  axes parent
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 15-Jan-2015 17:07:04

% Create axes
axes1 = axes('Parent',Parent1,'OuterPosition',[0 0 1 0.5]);
% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 60]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[-2.5905203908e-18 1.1]);
box(axes1,'on');
hold(axes1,'all');

% Create multiple lines using matrix input to plot
plot1 = plot(YMatrix1,'Parent',axes1);
set(plot1(1),'DisplayName','\Xi_{[e1, e2]}');
set(plot1(2),'DisplayName','bcol');
set(plot1(3),'DisplayName','dcol');

