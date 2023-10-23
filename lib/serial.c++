#include <windows.h>
#include <tchar.h>
#include <stdio.h>

extern "C" {
  typedef void (*DataCallback)(const TCHAR* data);

  __declspec(dllexport) void startSerialListening(DataCallback callback) {
    HANDLE hSerial = CreateFile(_T("COMx"), GENERIC_READ, 0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    if (hSerial == INVALID_HANDLE_VALUE) {
      // Handle error
    } else {
      TCHAR buffer[100];
      DWORD bytesRead;
      while (true) {
        ReadFile(hSerial, buffer, sizeof(buffer), &bytesRead, NULL);
        if (bytesRead > 0) {
          buffer[bytesRead] = '\0';
          callback(buffer);
        }
      }
    }
  }
}
