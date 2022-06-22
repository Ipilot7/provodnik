import 'dart:io';
import 'package:filesize/filesize.dart';
import 'utils.dart';

class Provodnik with Utils {
  menu() {
    print('Здравствуйте приветсвует наш проводник');
    print('--------------------------------------');
    print("""Выберите диск:
    1.С
    2.D
    3. Ввести путь вручную: """);
    int a = int.parse(stdin.readLineSync()!);
    switch (a) {
      case 1:
        viewFolders('C:');
        break;
      case 2:
        viewFolders('D:');
        break;
      case 3:
        String path = stdin.readLineSync()!;
        viewFolders(path);
        break;
      default:
        print('Нет такой меню. Программа завершена!');
        exit(0);
    }
  }

  void viewFolders(String path) async {
    try {
      int f = 1;
      // Utf8.decode("asd".codeUnits)
      var directory = Directory(path);
      List<FileSystemEntity> fSEntity = directory.listSync();

      fSEntity.sort((((a, b) => a
          .statSync()
          .type
          .toString()
          .compareTo(b.statSync().type.toString()))));

      print("   Номер  |  Тип    |  Имя           |  Размер файла");

      for (int i = 0; i < fSEntity.length; i++) {
        var sizefile = filesize(fSEntity[i].statSync().size);

        if (fSEntity[i] is Directory) {
          print(
              """       ${f++}  📘 Папка  -- ${fSEntity[i].toString().replaceAll("\\", '/').split("'")[1].split('/').last} """);
        } else {
          print("""       ${f++}  📝 Файл  -- ${fSEntity[i].toString().replaceAll("\\", '/').split("'")[1].split('/').last}  | $sizefile""");
        }
      }

      print('Чтобы вернутся назад наберите "0"');
      print('Для завершение наберите "z"');
      print("Выберите номер: ");
      String a = stdin.readLineSync()!;

      if (a.toLowerCase() == 'z') {
        exit(0);
      }

      int selectedNum = int.parse(a);
      if (selectedNum == 0) {
        //назад

        viewFolders(path.back());
      } else {
        if (selectedNum >= fSEntity.length) {
          print("Нет такой директории");
          exit(0);
        }
        if (fSEntity[selectedNum - 1] is Directory) {
          // войти внутрь
          viewFolders(fSEntity[selectedNum - 1]
              .toString()
              .replaceAll('\\', "/")
              .split("'")[1]);
        } else if (fSEntity[selectedNum] is File) {
          print("Это файл. Программа завершена");

          exit(0);
        }
      }
    } on FileSystemException {
      print("Ошибка!!! нет токой директории");
    } catch (e) {
      print("Ошибка: $e");
    }
  }
}
