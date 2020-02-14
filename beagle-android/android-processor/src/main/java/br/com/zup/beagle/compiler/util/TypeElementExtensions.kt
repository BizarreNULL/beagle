package br.com.zup.beagle.compiler.util

import javax.lang.model.element.TypeElement
import javax.lang.model.type.DeclaredType

fun TypeElement.implementsInterface(interfaceName: String): Boolean {
    for (interfaceTypeMirror in this.interfaces) {
        val typeMirror = ((interfaceTypeMirror as DeclaredType)).asElement()
        if (typeMirror.toString() == interfaceName) {
            return true
        }
    }
    return false
}