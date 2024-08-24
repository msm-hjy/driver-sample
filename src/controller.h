/**
 * @file controller.h
 * @brief Header file for the Video Capture Driver.
 */

#pragma once

#include "common.h"

/**
 * @brief Initializes the video capture.
 *
 * @param DriverObject Pointer to the driver object.
 */
void InitializeController(PDRIVER_OBJECT DriverObject);

/**
 * @brief Cleans up the video capture.
 */
void UninitializeController();
