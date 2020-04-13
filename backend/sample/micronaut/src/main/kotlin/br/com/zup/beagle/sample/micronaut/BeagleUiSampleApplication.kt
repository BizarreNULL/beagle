/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.micronaut

import io.micronaut.runtime.Micronaut

object BeagleUiSampleApplication {
    @JvmStatic
    fun main(args: Array<String>) {
        Micronaut.run(BeagleUiSampleApplication::class.java)
    }
}