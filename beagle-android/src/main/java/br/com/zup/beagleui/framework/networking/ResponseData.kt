package br.com.zup.beagleui.framework.networking

data class ResponseData(
    val statusCode: Int,
    val data: ByteArray,
    val headers: Map<String, String> = mapOf()
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false

        other as ResponseData

        if (statusCode != other.statusCode) return false
        if (headers != other.headers) return false
        if (!data.contentEquals(other.data)) return false

        return true
    }

    override fun hashCode(): Int {
        var result = statusCode
        result = 31 * result + headers.hashCode()
        result = 31 * result + data.contentHashCode()
        return result
    }
}