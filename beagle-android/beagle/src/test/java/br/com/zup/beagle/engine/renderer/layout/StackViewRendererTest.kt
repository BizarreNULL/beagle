package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.widget.layout.Stack
import br.com.zup.beagle.widget.ui.Button
import com.facebook.yogalayout.YogaLayout
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test
import kotlin.test.assertTrue

class StackViewRendererTest {

    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var rootView: RootView

    private var children = listOf(Button(""), Button(""))

    @RelaxedMockK
    private lateinit var stack: Stack

    @RelaxedMockK
    private lateinit var beagleFlexView:BeagleFlexView

    @InjectMockKs
    private lateinit var stackViewRenderer: StackViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
        every { stack.children } returns children
    }

    @Test
    fun build() {
        // Given
        val context = mockk<Context>()
        val viewRenderer = mockk<ViewRenderer<*>>()
        val view = mockk<View>()
        every { beagleFlexView.addView(any()) } just Runs
        every { beagleFlexView.context } returns context
        every { viewFactory.makeBeagleFlexView(any(), any()) } returns beagleFlexView
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { viewRenderer.build(any()) } returns view
        every { rootView.getContext() } returns context

        // When
        val actual = stackViewRenderer.build(rootView)

        // Then
        verify(exactly = 2) { beagleFlexView.addView(view) }
        assertTrue(actual is YogaLayout)
    }
}