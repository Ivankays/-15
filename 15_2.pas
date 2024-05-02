program AlphabetFrequencyDictionary; 
type
  WordNodePtr = ^WordNode;
  WordNode = record
    word: string;
    count: Integer;
    next: WordNodePtr;
  end;
function Hash(word: string): Integer;
var
  hashValue: Integer;
  i: Integer;
begin
  hashValue := 0;
  for i := 1 to Length(word) do
    hashValue := hashValue + Ord(word[i]);
  Hash := hashValue mod 100;
end;
procedure AddWord(var head: WordNodePtr; word: string);
var
  newNode, current: WordNodePtr;
begin
  New(newNode);
  newNode^.word := word;
  newNode^.count := 1;
  newNode^.next := nil;

  if head = nil then
    head := newNode
  else
  begin
    current := head;
    while current^.next <> nil do
    begin
      if current^.word = word then
      begin
        current^.count := current^.count + 1;
        Dispose(newNode);
        Exit;
      end;
      current := current^.next;
    end;
    if current^.word = word then
      current^.count := current^.count + 1
    else
      current^.next := newNode;
  end;
end;
function CountDistinctWords(head: WordNodePtr): Integer;
var
  count: Integer;
  current: WordNodePtr;
begin
  count := 0;
  current := head;
  while current <> nil do
  begin
    count := count + 1;
    current := current^.next;
  end;
  CountDistinctWords := count;
end;
procedure FreeDictionary(var head: WordNodePtr);
var
  temp: WordNodePtr;
begin
  while head <> nil do
  begin
    temp := head;
    head := head^.next;
    Dispose(temp);
  end;
end;
procedure LoadText(filename: string; var head: WordNodePtr);
var
  fileText: Text;
  word: string;
begin
  Assign(fileText, filename);
  Reset(fileText);

  while not EOF(fileText) do
  begin
    Readln(fileText, word);
    AddWord(head, word);
  end;
  Close(fileText);
end;
var
  dictionary: array [0..99] of WordNodePtr; // Хеш-таблица для хранения списка слов
  filename: string;
  i, totalDistinctWords: Integer;
  currentWord: WordNodePtr;
begin
  for i := 0 to 99 do
    dictionary[i] := nil;
  writeln('Введите имя файла:');
  readln(filename);
  LoadText(filename, dictionary[Hash(filename)]);
  totalDistinctWords := 0;
  for i := 0 to 99 do
    totalDistinctWords := totalDistinctWords + CountDistinctWords(dictionary[i]);
  writeln('Количество различных слов в тексте: ', totalDistinctWords);
  for i := 0 to 99 do
    FreeDictionary(dictionary[i]);
end.
