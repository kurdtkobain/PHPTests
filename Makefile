ARCHS = armv7
TARGET = iphone:clang:6.1

include /var/theos/makefiles/common.mk

APPLICATION_NAME = PHPTest
PHPTest_FILES = main.m PHPTestApplication.mm RootViewController.mm
PHPTest_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/application.mk
