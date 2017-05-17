clear;
clc;

syms X Y

%% image import
src = imread('CTimage.png');
I = rgb2gray(src);
[row, col]=size(I);
imshow(I);

%% select surface edge
[x, y, P] = impixel(I);
ps = sortrows([x,y]);%sort(left->right)
ps_s = ps(1,:);%start point
ps_e = ps(end,:);%end point
pol_s= polyfit(ps(:,1),ps(:,2),2);%second order approximation
xs = ceil(ps_s(1,1):1:ps_e(1,1));ys = ceil(polyval(pol_s, xs));%surface points


surface = pol_s(1,1)*X^2 + pol_s(1,2)*X+pol_s(1,3) - Y;
df_surface = diff(surface, X);

%% select boundary edge1
[x, y, P] = impixel(I);
bp1 = sortrows([x,y]);%sort(left->right)
bp1_s = bp1(1,:);%start point
bp1_e = bp1(end,:);%end point
pol_b1= polyfit(bp1(:,1),bp1(:,2),2);%second order approximation
xb1 = ceil(bp1_s(1,1):1:bp1_e(1,1));yb1 = ceil(polyval(pol_b1, xb1));%surface points

boundary1 = pol_b1(1,1)*X^2 + pol_b1(1,2)*X+pol_b1(1,3) -Y;
df_boundary = diff(boundary1, X);

%% select boundary edge2
[x, y, P] = impixel(I);
bp2 = sortrows([x,y]);%sort(left->right)
bp2_s = bp2(1,:);%start point
bp2_e = bp2(end,:);%end point
pol_b2= polyfit(bp2(:,1),bp2(:,2),2);%second order approximation
xb2 = ceil(bp2_s(1,1):1:bp2_e(1,1));yb2 = ceil(polyval(pol_b2, xb2));%surface points

boundary2 = pol_b2(1,1)*X^2 + pol_b2(1,2)*X+pol_b2(1,3) -Y;
df_boundary2 = diff(boundary2, X);

%% select insertion point
%[x, y, P] = impixel(I);
%ip = [x,y];

for i=1:ceil(size(xs,2))
    ip(i,:) = [xs(i),ys(i)];
end

ip = [decimate(ip(:,1),30),decimate(ip(:,2),30)];%downsampling insertion point number

N = size(ip,1);

%% select target
[x, y, P] = impixel(I);
tp = [x(end),y(end)];

%% Show plot
plot(xs,row-ys);
hold on
plot(xb1, row-yb1);
plot(xb2, row-yb2);
plot(tp(1,1),row-tp(1,2),'o','MarkerSize',20);

for i=1:N
    %% insertion path
    [a,b,c] = CalcFirstOrder(ip(i,:), tp);
    path(i) = a*X + b*Y + c;
    df_path(i) = -a/b;
end

for i=1:N
    %% Calcuration cross point and angle
    % surface
    [solX,solY] = solve([surface == 0,path(i) == 0], [X,Y]);
    solX = sort(abs(solX), 1);solY = sort(abs(solY), 1);
    cp1(i,:) = [double(solX(1)),double(solY(1))];
    angle1(i) = atan(double(subs(df_surface, X, cp1(i,1))));
    angle1(i) = radtodeg(angle1(i));

    % boundary1
    [solX,solY] = solve([boundary1 == 0,path(i) == 0], [X,Y]);
    solX = sort(abs(solX), 1);solY = sort(abs(solY), 1);
    cp2(i,:) = [double(solX(1)),double(solY(1))];
    angle2(i) = atan(double(subs(df_boundary, X, cp2(i,1))));
    angle2(i) = radtodeg(angle2(i));
    
    % boundary2
    [solX,solY] = solve([boundary2 == 0,path(i) == 0], [X,Y]);
    solX = sort(abs(solX), 1);solY = sort(abs(solY), 1);
    cp3 = [double(solX(1)),double(solY(1))];
    angle3(i) = atan(double(subs(df_boundary, X, cp3(1,1))));
    angle3(i) = radtodeg(angle3(i));

    % path
    angle0(i) = radtodeg(atan(df_path(i)));
    if(angle0(i)<0)
        angle0(i) = angle0(i)+180;
    end
    
    % each angle
    delta_ang1(i) = 90-(angle0-angle1);
    delta_ang2(i) = 90-(angle0-angle2);
    delta_ang3(i) = 90-(angle0-angle3);    
    

    plot(ip(i,1),row-ip(i,2),'o');
    plot(cp1(i,1),row-cp1(i,2),'o');
    plot(cp2(i,1),row-cp2(i,2),'o');
    plot(cp3(i,1),row-cp3(i,2),'o');

end

%% Optimization of insertion point

SumAng = delta_ang1 + delta_ang2 + delta_ang3;
[M, id] = min(abs(SumAng));

plot(ip(id,1),row-ip(id,2),'*','MarkerSize',20);
