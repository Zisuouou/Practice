from django.contrib import admin
from blog.models import Post

# @admin.register(Post)
# # Register your models here.
# class PostAdmin(admin.ModelAdmin):
#     list_display = ["__str__"]

# # admin.site.register(Post)          ## 관리자계정에 등록만 할거면 이렇게 해도 됨

admin.site.register(Post)