TARGET := iphone:clang:latest:15.6
INSTALL_TARGET_PROCESSES = com.tencent.xin
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WCTestHook

WCTestHook_FILES = Tweak.x
WCTestHook_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk