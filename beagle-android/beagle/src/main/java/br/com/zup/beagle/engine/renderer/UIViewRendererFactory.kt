package br.com.zup.beagle.engine.renderer

import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.engine.renderer.layout.BuildableWidgetViewRenderer
import br.com.zup.beagle.engine.renderer.layout.FormInputViewRenderer
import br.com.zup.beagle.engine.renderer.layout.FormSubmitViewRenderer
import br.com.zup.beagle.engine.renderer.ui.ButtonViewRenderer
import br.com.zup.beagle.engine.renderer.ui.ImageViewRenderer
import br.com.zup.beagle.engine.renderer.ui.ListViewRenderer
import br.com.zup.beagle.engine.renderer.ui.NetworkImageViewRenderer
import br.com.zup.beagle.engine.renderer.ui.TabViewRenderer
import br.com.zup.beagle.engine.renderer.ui.TextViewRenderer
import br.com.zup.beagle.engine.renderer.ui.UndefinedViewRenderer
import br.com.zup.beagle.engine.renderer.ui.WidgetViewRenderer
import br.com.zup.beagle.widget.core.ComposeComponent
import br.com.zup.beagle.widget.core.WidgetView
import br.com.zup.beagle.widget.form.FormInput
import br.com.zup.beagle.widget.form.FormSubmit
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Image
import br.com.zup.beagle.widget.ui.ListView
import br.com.zup.beagle.widget.ui.NetworkImage
import br.com.zup.beagle.widget.ui.TabView
import br.com.zup.beagle.widget.ui.Text
import br.com.zup.beagle.widget.ui.UndefinedWidget

internal class UIViewRendererFactory : AbstractViewRendererFactory {

    override fun make(component: ServerDrivenComponent): ViewRenderer<*> {
        return if (component is ComposeComponent) {
            BuildableWidgetViewRenderer(component)
        } else {
            when (component) {
                is Button -> ButtonViewRenderer(component)
                is Text -> TextViewRenderer(component)
                is Image -> ImageViewRenderer(component)
                is NetworkImage -> NetworkImageViewRenderer(component)
                is ListView -> ListViewRenderer(component)
                is FormInput -> FormInputViewRenderer(component)
                is FormSubmit -> FormSubmitViewRenderer(component)
                is TabView -> TabViewRenderer(component)
                is WidgetView, !is UndefinedWidget -> WidgetViewRenderer(component as WidgetView)
                else -> UndefinedViewRenderer(component)
            }
        }
    }
}