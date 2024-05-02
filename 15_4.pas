program FindMinMaxInLinkedList; //Односвязный список состоит из узлов, каждый из которых содержит данные и ссылку на следующий узел в списке. 
// В данном случае тип ListNode имеет поле next, которое указывает на следующий узел в списке. Это позволяет перемещаться только вперед по списку, начиная с головы.

type
  // Определение типа для элемента списка
  ListNodePtr = ^ListNode;
  ListNode = record
    data: Integer;
    next: ListNodePtr;
  end;

// Функция для добавления элемента в конец списка
procedure Append(var head: ListNodePtr; value: Integer);
var
  newNode, current: ListNodePtr;
begin
  New(newNode);
  newNode^.data := value;
  newNode^.next := nil;

  if head = nil then
    head := newNode
  else
  begin
    current := head;
    while current^.next <> nil do
      current := current^.next;
    current^.next := newNode;
  end;
end;

// Процедура для вывода списка
procedure PrintList(head: ListNodePtr);
var
  current: ListNodePtr;
begin
  current := head;
  while current <> nil do
  begin
    write(current^.data, ' ');
    current := current^.next;
  end;
  writeln;
end;

// Функция для поиска максимального и минимального элементов в списке
procedure FindMinMax(head: ListNodePtr; var min, max: Integer);
var
  current: ListNodePtr;
begin
  if head = nil then
  begin
    min := 0;
    max := 0;
    Exit;
  end;

  current := head;
  min := current^.data;
  max := current^.data;

  while current <> nil do
  begin
    if current^.data < min then
      min := current^.data;
    if current^.data > max then
      max := current^.data;
    current := current^.next;
  end;
end;

// Процедура для освобождения памяти, выделенной под список
procedure FreeList(var head: ListNodePtr);
var
  temp: ListNodePtr;
begin
  while head <> nil do
  begin
    temp := head;
    head := head^.next;
    Dispose(temp);
  end;
end;

var
  head: ListNodePtr;
  min, max: Integer;
  i: Integer;

begin
  // Инициализация головы списка
  head := nil;

  // Добавление элементов в список
  for i := 1 to 10 do
    Append(head, Random(100) + 1); // Добавляем случайные числа от 1 до 100

  // Вывод изначального списка
  writeln('Изначальный список:');
  PrintList(head);

  // Поиск минимального и максимального элементов в списке
  FindMinMax(head, min, max);

  // Вывод результатов
  writeln('Минимальный элемент в списке: ', min);
  writeln('Максимальный элемент в списке: ', max);

  // Освобождение памяти, выделенной под список
  FreeList(head);
end.
