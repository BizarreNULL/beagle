package br.com.zup.beagleui.framework.config.networking

data class RequestData(
    val url: String,
    val method: HttpMethod = HttpMethod.GET,
    val headers: Map<String, String> = mapOf()
)

enum class HttpMethod {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD,
    PATCH
}