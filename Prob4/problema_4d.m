function problema_4d
% Para ser utilizado con el texto H. Jorquera y C. Gelmi "M�todos Num�ricos
% Aplicados a Ingenier�a: Casos de estudio en Ingenier�a de Procesos usando
% MATLAB", Ediciones UC, 2014.
%
% �ltima revisi�n: 11/05/2024.

% Integraci�n del sistema diferencial
options = odeset('RelTol',1e-10,'AbsTol',1e-10);
[t,x] = ode15s(@est,[0 500],[2 5 1e-8],options);

% Grafica
subplot(2,1,1)
plot(t,x(:,1),'k','LineWidth',2)
hold on
plot(t,x(:,2),'k-.','LineWidth',2)
hold off
ylabel('Altura (m)')
legend('h_1','h_2','Location','Best')
subplot(2,1,2)
plot(t,x(:,3),'k','LineWidth',2)
xlabel('Tiempo (s)')
ylabel('Velocidad (m/s)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dx = est(t,x)

% Par�metros y constantes
cv = 0.1; D1 = 2.5; D2 = 3.0; Dt = 0.3;
F0 = 0; g = 9.8;  h1max = 4.0;
L = 100; mu = 0.001; ro = 1000; F2 = 0;

% Relaciones constitutivas
A1 = pi*D1^2/4;
A2 = pi*D2^2/4;
At = pi*Dt^2/4;
Re = Dt*ro*abs(x(3))/mu;

% Ecuaciones diferenciales
dx = zeros(3,1);
% Condici�n m�nima para la velocidad en la ca�er�a.
if x(1) >= 4 & x(3) < 0
    dx(1) = 0;
else
    dx(1) = (F0 - x(3)*At)/A1;
end
dx(2) = (x(3)*At-F2)/A2;
dx(3) = g/L*(x(1)-x(2));