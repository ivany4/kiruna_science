% Define a new coordinate system with z along a given vector B
% y along bxr, with r=(0,0,1). Then return the coordinates of
% a vector v in this new coordinate system.
%
%

function [vOB]=OBsystem(v,B0)

Tflag=0;

[rowB colB]=size(B0);
if colB==4
    B=[B0(:,2) B0(:,3) B0(:,4)];
    Tflag=1;
end

[row col]=size(v);
if col==4
    v=[v(:,2) v(:,3) v(:,4)];
end

if (row~=rowB)
    disp('Input have not equal lengths');
    return;
end

vOB=zeros(row,3);

for i=1:row
r=[0 0 1];
Bnorm=sqrt(B(i,1)*B(i,1)+B(i,2)*B(i,2)+B(i,3)*B(i,3));
z=[B(i,1) B(i,2) B(i,3)]/Bnorm;
y=cross(z,r);
y=y/norm(y);
x=cross(y,z);
x=x/norm(x);
vi=[v(i,1) v(i,2) v(i,3)];
vOB(i,1)=dot(vi,x); 
vOB(i,2)=dot(vi,y); 
vOB(i,3)=dot(vi,z);
end

if (Tflag==1)
    vOB=[B0(:,1) vOB(:,1) vOB(:,2) vOB(:,3)];
else
    vOB=[vOB(:,1) vOB(:,2) vOB(:,3)];
end

end



