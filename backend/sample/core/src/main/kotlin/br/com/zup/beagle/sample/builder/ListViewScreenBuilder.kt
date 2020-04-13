/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.builder

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.layout.Spacer
import br.com.zup.beagle.widget.ui.ListDirection
import br.com.zup.beagle.widget.ui.ListView
import br.com.zup.beagle.widget.ui.Text

object ListViewScreenBuilder : ScreenBuilder {
    override fun build() = Screen(
        navigationBar = NavigationBar(
            title = "Beagle ListView",
            showBackButton = true,
            navigationBarItems = listOf(
                NavigationBarItem(
                    text = "",
                    image = "informationImage",
                    action = ShowNativeDialog(
                        title = "ListView",
                        message = "Is a Layout component that will define a list of views natively. " +
                            "These views could be any Server Driven Component.",
                        buttonText = "OK"
                    )
                )
            )
        ),
        child = ScrollView(
            scrollDirection = ScrollAxis.VERTICAL,
            children = listOf(
                getStaticListView(ListDirection.VERTICAL),
                Spacer(20.0),
                getStaticListView(ListDirection.HORIZONTAL),
                Spacer(20.0),
                getDynamicListView(ListDirection.VERTICAL),
                Spacer(20.0),
                getDynamicListView(ListDirection.HORIZONTAL)
            )
        )
    )

    private fun getStaticListView(listDirection: ListDirection) = Container(
        children = listOf(
            Text("Static $listDirection ListView"),
            Spacer(10.0),
            ListView(rows = (1..10).map(this::createText), direction = listDirection)
        )
    )

    private fun getDynamicListView(listDirection: ListDirection) = Container(
        children = listOf(
            Text("Dynamic $listDirection ListView"),
            Spacer(10.0),
            ListView.dynamic(size = 20, direction = listDirection, rowBuilder = this::createText)
        )
    )

    private fun createText(index: Int) = Text("Hello $index")
}