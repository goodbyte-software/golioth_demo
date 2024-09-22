/*
 * Copyright (c) 2023 Golioth, Inc.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#pragma once

#include <zephyr/net/wifi_mgmt.h>
#include "net_private.h"

int wifi_connect(void);
int cmd_wifi_status(struct wifi_iface_status *status);


