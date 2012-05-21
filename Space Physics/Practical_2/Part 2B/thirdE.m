
% Computes the third e-field component assuming e.b=0. In case
% bz i zero, ez is set to zero.


function [e3]=thirdE(b3,e2)

EPS=1.e-8;

Tflag=0;

[rowB colB]=size(b3);
if colB==4
    b=[b3(:,2) b3(:,3) b3(:,4)];
    Tflag=1;
end

[row col]=size(e2);
if col>=3
    e2=[e2(:,2) e2(:,3)];
end

if (row~=rowB)
    disp('Input have not equal lengths');
    return;
end

e3=[e2(:,1) e2(:,2) e2(:,2)];

for i=1:row
    e=[e2(i,1) e2(i,2) 0];
    babs=sqrt(b(i,1)*b(i,1)+b(i,2)*b(i,2)+b(i,3)*b(i,3));
    if (abs(b(i,3)/babs)<EPS)
    e3(i,3)=0;
    else
    eb=dot(e,[b(i,1) b(i,2) b(i,3)]);
    e3(i,3)=-eb/b(i,3);
    end
end

if (Tflag==1)
    e3=[b3(:,1) e3(:,1) e3(:,2) e3(:,3)];
else
    e3=[e3(:,1) e3(:,2) e3(:,3)];
end

end