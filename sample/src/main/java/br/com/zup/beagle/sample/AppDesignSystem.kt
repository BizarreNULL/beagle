package br.com.zup.beagle.sample

import android.app.Application
import br.com.zup.beagle.setup.DesignSystem

class AppDesignSystem(
    private val context: Application
) : DesignSystem {
    override fun image(name: String): Int {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun theme(): Int {
        return R.style.AppTheme
    }

    override fun textAppearance(name: String): Int {
        return when (name) {
            "DesignSystem.Text.H2" -> R.style.DesignSystem_Text_H2
            "DesignSystem.Text.H3" -> R.style.DesignSystem_Text_H3
            else -> R.style.DesignSystem_Text_Default
        }
    }

    override fun buttonStyle(name: String): Int {
        return when (name) {
            "DesignSystem.Button.White" -> R.style.DesignSystem_Button_White
            "DesignSystem.Button.Text" -> R.style.DesignSystem_Button_Text
            else -> R.style.DesignSystem_Button_Default
        }
    }
}