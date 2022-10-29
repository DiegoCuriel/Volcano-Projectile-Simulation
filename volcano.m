clc;
clear all;


base = 25000;
crater = 2000;
h = 3020;
paso = 3;

m_crat = crater/2;
m_base = base/2;
ps_fj = crater/paso;

x = [-m_base,-m_crat, m_crat, m_base, -m_base];
y = [0,h, h, 0, 0];

set(gca, 'Color', 'cyan');
hold on;

fill(x, y, 'g');

for i = 1:paso
    s = -m_crat;
    sh = 300;
    x = [s+i*ps_fj-ps_fj, s+i*ps_fj, s+i*ps_fj-(ps_fj/2), s+i*ps_fj-ps_fj];
    y = [h, h, h-sh, h];
    fill(x, y, 'r');
end

offset_x = -32500;
offset_y = 3500;
size = 500;

x_nube = [0, 2, 3, 4, 5, 7, 8, 7, 6, 5, 3, 2, 1, 0];
x_nube = x_nube*5;
y_nube = [4, 6, 5, 6.5, 4, 5, 4, 3, 3.5, 2, 3, 1, 3, 4];

x_nube2 = [0, 2, 3, 4, 5, 7, 8, 7, 6, 5, 3, 2, 1, 0];
x_nube2 = x_nube2*5;
y_nube2 = [4, 6, 5, 6.5, 4, 5, 4, 3, 3.5, 2, 3, 1, 3, 4];

x_nube = (x_nube*size);
y_nube = (y_nube*size);

x_nube = x_nube + offset_x;
y_nube = y_nube + offset_y;

offset_x_2 = 14500;
offset_y_2 = 7500;
size = 600;

x_nube2 = (x_nube2*size);
y_nube2 = (y_nube2*size);

x_nube2 = x_nube2 + offset_x_2;
y_nube2 = y_nube2 + offset_y_2;

fill(x_nube, y_nube, 'w');
fill(x_nube2, y_nube2, 'w');



x = [0,m_base-m_crat, m_base-m_crat, 0];
y = [0,h, 0, 0];

%-------------------------------------------
title('Simulación Volcán');
xlabel('Desplazamiento X');
ylabel('Altura');

%-------------------------------------------------------------------------------

axis([-4.0474e+04,4.0474e+04,0,1.2098e+04]);

n = 3;

for i = 1:n
    
    %Variables
    vi = randi([100,300]);
    angulo = randi([25,155]);
    densidad_aire = 1.225;
    arrastre = 0.47;
    densidad_roca = 2700;
    radio_roca = randi([1,32]);
    volumen_roca = (4/3)*pi*radio_roca^3;
    area_roca = pi*(radio_roca^2) ;
    altura_volcan = 3020;
    g = 9.81;
    m = radio_roca^3*(4*pi/3)*densidad_roca;

    %Calculamos el coeficiente de friccion
    b = (1/2)*densidad_aire*arrastre*area_roca;

    vix = vi*cosd(angulo);
    viy = vi*sind(angulo);

    dt = 0.25;
    xn = 0;
    yn = altura_volcan;

    xnMENOS1 = xn-vix*dt;
    ynMENOS1 = yn-viy*dt + (1/2)*(-g)*dt^2;
    
    while yn > 0
        %Cálculos
        axn = (b*(vix^2))/m;
        ayn = (-g)-((viy/abs(viy)))*((b*(viy^2))/m);

        xnMAS1 = (2*xn-xnMENOS1)+(1/2*axn*(dt^2));
        ynMAS1 = (2*yn-ynMENOS1)+(1/2*ayn*(dt^2));

        vix = (xnMAS1-xn)/dt;
        viy = (ynMAS1-yn)/dt;

        %Actualizar variables
        xnMENOS1 = xn;
        xn = xnMAS1;
        ynMENOS1 = yn;
        yn = ynMAS1;

        hold on;
        plot(xn, yn, '.r');
        pause(1e-15);
    end
    redondeado=round(abs(xn),2);
    prueba = num2str(redondeado);
    txt="\fontsize{18}\bf El caso "+i+" tiene un alcance máximo horizontal de "+prueba+" m";
    text(-4*10^4,11500-i*450,txt);
end

