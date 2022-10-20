#ifndef INCLUDE_YVRTC_INTERFACE_H_
#define INCLUDE_YVRTC_INTERFACE_H_

#define YVRTC_INTERFACE_VERSION "1.0"

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

enum VideoFrameType
{
    VideoFrameTypeP = 0,
    VideoFrameTypeI,
    VideoFrameTypeB,
    VideoFrameUnknow
};

typedef struct
{
    int32_t uid;
    enum VideoFrameType frameType;
    int32_t size;
    int64_t timestamp;
    uint8_t *payload;
} YVRFrame;

void *YVPlayInit();

int32_t YVPlayDeinit(void *context);

int32_t YVPlayStart(void *context, char *url);

int32_t YVPlayStop(void *context);

int32_t YVPlayRegisterVideoReceiver(void *context, int32_t (*receiver)(uint8_t *payload, int32_t size, int32_t frameType, void *pUser), void *user);

int32_t YVPlayRegisterUdpDataReceiver(void *context, int32_t (*PRecvCallback)(unsigned char *buff, int size, int error, void *pUser), void *user);

int32_t YVPlayPutUdpData(void *context, char *buf, int32_t len);

#ifdef __cplusplus
}
#endif

#endif /* INCLUDE_YVRTC_INTERFACE_H_ */
