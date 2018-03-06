# Файл для включения в проект на CMAKE.
# Перед включением необходимо определить переменные
#    LIBUSB_DIR   - путь к директории, где находится ltimer.cmake
#
# После включения будут установлены следующие перменные:
#   LIBUSB_HEADERS - используемые заголовочные файлы
#   LIBUSB_SOURCES - используемые файлы исходных кодов
#   LIBUSB_LIBS    - используемые библиотеки

cmake_policy(PUSH)

cmake_minimum_required(VERSION 2.6)


include_directories(${LIBUSB_DIR} ${LIBUSB_DIR}/..)
set(LIBUSB_SOURCES 
    ${LIBUSB_DIR}/core.c
    ${LIBUSB_DIR}/descriptor.c
    ${LIBUSB_DIR}/hotplug.c
    ${LIBUSB_DIR}/io.c
    ${LIBUSB_DIR}/strerror.c
    ${LIBUSB_DIR}/sync.c
)

set(LIBUSB_HEADERS
    ${LIBUSB_DIR}/libusb.h
    ${LIBUSB_DIR}/libusbi.h
    ${LIBUSB_DIR}/hotplug.h
    ${LIBUSB_DIR}/version.h
    ${LIBUSB_DIR}/version_nano.h
)


if(WIN32)
    set(SOURCES ${SOURCES}
        ${LIBUSB_DIR}/os/poll_windows.c
        ${LIBUSB_DIR}/os/threads_windows.c
        ${LIBUSB_DIR}/os/windows_usb.c
    )
    set(HEADERS ${HEADERS}
        ${LIBUSB_DIR}/os/poll_windows.h
        ${LIBUSB_DIR}/os/threads_windows.h
        ${LIBUSB_DIR}/os/windows_common.h
    )
else(WIN32)
    message(FATAL_ERROR "unsupported os")
endif(WIN32)



if(MSVC)
    include_directories(${LIBUSB_DIR}/msvc)

    set(LIBUSB_HEADERS ${LIBUSB_HEADERS}
        ${LIBUSB_DIR}/msvc/config.h
        ${LIBUSB_DIR}/msvc/errno.h
        ${LIBUSB_DIR}/msvc/inttypes.h
        ${LIBUSB_DIR}/msvc/missing.h
        ${LIBUSB_DIR}/msvc/stdint.h
    )
else(MSVC)
    message(FATAL_ERROR "unsupported compiler")
endif(MSVC)


cmake_policy(POP)
