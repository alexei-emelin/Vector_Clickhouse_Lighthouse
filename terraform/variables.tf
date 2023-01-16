# Заменить на ID своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_cloud_id" {
  default = ""
}

# Заменить на Folder своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_folder_id" {
  default = ""
}

variable "centos7" {
  default = "fd8ic5bmgr51h6e7bh1v"
}

# Указываем токен аутентификации
variable "oauth_token" {
  type = string
  default = ""
}
