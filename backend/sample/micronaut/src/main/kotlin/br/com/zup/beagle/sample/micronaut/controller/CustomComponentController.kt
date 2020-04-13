/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.micronaut.controller

import br.com.zup.beagle.sample.constants.CUSTOM_WIDGET_ENDPOINT
import br.com.zup.beagle.sample.micronaut.service.CustomNativeService
import io.micronaut.http.annotation.Controller
import io.micronaut.http.annotation.Get

@Controller
class CustomComponentController(private val customNativeService: CustomNativeService) {
    @Get(CUSTOM_WIDGET_ENDPOINT)
    fun getCustomNativeWidget() = this.customNativeService.createCustomNativeWidget()
}