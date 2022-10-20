#include <stdint.h>
#include "internal/dart_api.h"
#include "internal/dart_native_api.h"
#include "internal/dart_api_dl.h"
#include "yvrtc_interface_c.h"

static int64_t nativePort;

static int32_t VideoReceiver(uint8_t *payload, int32_t size, int32_t frameType, void *pUser)
{
    Dart_CObject dart_object;
    dart_object.type = Dart_CObject_kTypedData;
    dart_object.value.as_typed_data.type = Dart_TypedData_kUint8;
    dart_object.value.as_typed_data.length = size;
    dart_object.value.as_typed_data.values = payload;
    Dart_PostCObject_DL(nativePort, &dart_object);
    return 0;
}

DART_EXPORT void YVRegisterSendPort(void *context, int64_t port, void *user){
    nativePort = port;
    YVPlayRegisterVideoReceiver(context, VideoReceiver, user);
}

DART_EXPORT intptr_t InitDartApiDL(void* data) {
  return Dart_InitializeApiDL(data);
}
