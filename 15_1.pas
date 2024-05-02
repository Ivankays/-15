var i: integer;
    i_ptr: ^integer;
begin
  i := 2;
  i_ptr := @i;
  writeln('Адрес i ='  , i_ptr); 
  writeln('i = ', i_ptr^); 

end.