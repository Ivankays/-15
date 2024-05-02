program ReverseNumbersStack;
type
  Stack = record
    data: Integer;
    next: ^Stack;
  end;

var
  inputFileName, outputFileName: string;
  numbers: ^Stack;

procedure Push(var s: ^Stack; num: Integer);
var
  newNode: ^Stack;
begin
  New(newNode);
  newNode^.data := num;
  newNode^.next := s;
  s := newNode;
end;

function Pop(var s: ^Stack): Integer;
begin
  if s = nil then
  begin
    Pop := -1; // Возвращаем -1 если стек пуст
  end
  else
  begin
    Pop := s^.data;
    s := s^.next;
  end;
end;

function IsEmpty(s: ^Stack): Boolean;
begin
  IsEmpty := (s = nil);
end;

procedure ReadNumbersFromFile(filename: string; var numbers: ^Stack);
var
  inputFile: Text;
  num: Integer;
begin
  Assign(inputFile, filename);
  Reset(inputFile);
  numbers := nil;

  while not EOF(inputFile) do
  begin
    Readln(inputFile, num);
    Push(numbers, num);
  end;

  Close(inputFile);
end;

procedure WriteNumbersToFile(filename: string; var numbers: ^Stack);
var
  outputFile: Text;
  num: Integer;
begin
  Assign(outputFile, filename);
  Rewrite(outputFile);

  while not IsEmpty(numbers) do
  begin
    num := Pop(numbers);
    Writeln(outputFile, num);
  end;

  Close(outputFile);
end;

begin
  writeln('Введите имя входного файла:');
  readln(inputFileName);
  writeln('Введите имя выходного файла:');
  readln(outputFileName);

  ReadNumbersFromFile(inputFileName, numbers);
  WriteNumbersToFile(outputFileName, numbers);

  writeln('Числа были переписаны в файл "', outputFileName, '" в обратном порядке.');
end.