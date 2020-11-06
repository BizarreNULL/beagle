/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package br.com.zup.beagle.automatedtests.builders

import br.com.zup.beagle.widget.action.Alert
import br.com.zup.beagle.widget.action.Confirm
import br.com.zup.beagle.widget.context.ContextData
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Text

object ConfirmScreenBuilder {

    data class ConfirmTest(val title: String, val message: String)

    fun build() = Screen(
        child = Container(
            context = ContextData(
                id = "confirmContext",
                value = ConfirmTest(title = "ConfirmTitleViaExpression", message = "ConfirmMessageViaExpression")
            ),
            children =
            listOf(
                Text(text = "Confirm Screen"),
                Button(
                    text = "JustAMessage",
                    onPress = listOf(
                        Confirm(title = null, message = "ConfirmMessage")
                    )
                ),
                Button(
                    text = "JustAMessageViaExpression",
                    onPress = listOf(
                        Confirm(title = null, message = "@{confirmContext.message}")
                    )),
                Button(
                    text = "TitleAndMessage",
                    onPress = listOf(
                        Confirm(title = "ConfirmTitle", message = "ConfirmMessage")
                    )),
                Button(
                    text = "TitleAndMessageViaExpression",
                    onPress = listOf(
                        Confirm(title = "@{confirmContext.title}", message = "@{confirmContext.message}")
                    )),
                triggerActionConfirm(),
                customLabelConfirms()
            )
        )
    )

    private fun customLabelConfirms(): Container = Container(listOf(
        Button(
            text = "CustomConfirmOk",
            onPress = listOf(
                Confirm(
                    title = null,
                    message = "ConfirmMessage",
                    labelOk = "CustomLabel")
            )
        ),
        Button(
            text = "CustomConfirmCancel",
            onPress = listOf(
                Confirm(
                    title = null,
                    message = "ConfirmMessage",
                    labelOk = "CustomLabel")
            )
        )
    ))

    private fun triggerActionConfirm(): Container = Container(listOf(
        Button(
            text = "TriggersAnActionWhenConfirmed",
            onPress = listOf(
                Confirm(
                    title = null,
                    message = "ConfirmMessage",
                    onPressOk = Alert(message = "SecondAlert")
                )
            ),
        ),
        Button(
            text = "TriggersAnActionWhenCanceled",
            onPress = listOf(
                Confirm(
                    title = null,
                    message = "CancelMessage",
                    onPressCancel = Alert(message = "SecondAlert")
                )
            ),
        )
    ))
}