% Binary to Decimal
function d = bi2de (b, p, f)
  switch (nargin)
    case 1,
      p = 2;
      f = 'right-msb';
     case 2,
      if (isstr(p))
        f = p;
        p = 2;
      else
        f = 'right-msb';
      endif
     case 3,
      if (isstr(p))
        tmp = f;
        f = p;
        p = tmp;
      endif
   otherwise
      error ("usage: d = bi2de (b, [p])");
  endswitch
  if ( any (b (:) < 0) || any (b (:) > p - 1) )
    error ("bi2de: d must only contain value in [0, p-1]");
  endif
  if (strcmp(f,'left-msb'))
    b = b(:,size(b,2):-1:1);
  elseif (!strcmp(f,'right-msb'))
    error("bi2de: unrecognized flag");
  endif
  if (length (b) == 0)
    d = [];
  else
    d = b * ( p .^ [ 0 : (columns(b)-1) ]' );
  endif
endfunction;