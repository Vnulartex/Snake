function [userdata,direction] = zaloha(position,arena,userdata)
    function valid = Isfree(y,x)
        valid=true;
        [m,n]=size(arena);
        if y<1||y>m||x<1||x>n
            valid=false;
        elseif arena(y,x)~=1&&arena(y,x)~=7
            valid=false;
        end
    end
    %funkce zjisti zda je v danem smeru od souradnic prekazka vraci bool a
    %souradnice daneho mista
    function data = volno(rot,a,b)
        nat=mod(userdata.smer+rot-3,4)+1;
        switch nat
                case 1
                    x=a;
                    y=b-1;
                case 2
                    x=a-1;
                    y=b;
                case 3
                    x=a;
                    y=b+1;
                case 4
                    x=a+1;
                    y=b;
        end
        free = Isfree(x,y);
        data = [free, x, y];
    end
    %funkce vraci pocty sledovanych z ruznych souradnic pocet(1-3) 
    function tahy = sleduj
        tahy = [0 0 0];
        psmer=userdata.smer;
        for i = 1:3
            b = position(1);
            a = position(2);
            userdata.smer = psmer;
            data = volno(i, a, b);
            x = data(2);
            y = data(3);
            a = data(2);
            b = data(3);
            userdata.smer=mod(psmer-3+i,4)+1;
            zacatek=mod(userdata.smer-2,4)+1;
            pracuj = data(1);
            bool=true;
            while pracuj
                for smer = 1:4
                  data = volno(smer, x, y);
                  if (x == a && y == b) && ~bool && zacatek==(mod(userdata.smer+smer-3,4)+1)
                      pracuj = false;
                      break;
                  elseif data(1)
                    x = data(2);
                    y = data(3);
                    userdata.smer = userdata.smer+smer-2;
                    bool=false;
                    tahy(i) = tahy(i) + 1;
                    break;
                  end
                  if smer==4 
                      bool=false;
                  end
               end
            end
        end
        userdata.smer = psmer;
    end
    %funkce vyhodnoti pocet a rozhodne, kterym smerem jed (nastavi direction)
    %na zaklade hodnot, ktere urcuje hlavni cast
    function go(smer)
        tahy=sleduj();
        tahy=find(tahy==max(tahy));
        moznesmery=mod(userdata.smer+tahy-3,4)+1;
        if ismember(smer,moznesmery)
            direction=smer;
            userdata.smer=smer;
        else
            direction=moznesmery(1);
            userdata.smer=moznesmery(1);
        end 
    end
    %funkce vrati souradnice nejblizsiho jablka
    function [apple]=getapple
        [m,n]=size(arena);
        minrange=10000;
        for x = 1:m
            for y = 1:n
                if arena(x,y)==7
                    range=abs(position(2)-x)+abs(position(1)-y);
                    if range<minrange
                        minrange=range;
                        minx=x;
                        miny=y;
                    end
                end
            end
        end
        apple = [minx, miny];    
    end
    %deklarace promene aktualniho smeru, ktera se uchovava
    if(isfield(userdata,'smer')==0)
        userdata.smer=1;
    end
    %urcuje smer, kterym jed nenastane-li zadna prekazka
    apple=getapple;
    if position(1) > apple(2) 
            go(1);
    elseif position(1) < apple(2)
            go(3);
    else
        if position(2) > apple(1)
            go(2);
        elseif position(2) < apple(1)
            go(4);
        end
    end
end
