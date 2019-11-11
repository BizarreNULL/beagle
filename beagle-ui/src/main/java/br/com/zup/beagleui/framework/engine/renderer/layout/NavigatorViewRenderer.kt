package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.action.NavigationActionHandler
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.navigation.Navigator

internal class NavigatorViewRenderer(
    private val widget: Navigator,
    private val navigationActionHandler: NavigationActionHandler = NavigationActionHandler(),
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(context: Context): View {
        return viewRendererFactory.make(widget.child).build(context).apply {
            setOnClickListener { navigationActionHandler.handle(context, widget.action) }
        }
    }
}
