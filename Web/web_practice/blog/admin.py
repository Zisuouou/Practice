from django.contrib import admin
from blog.models import Post

@admin.register(Post)
# Register your models here.
class PostAdmin(admin.ModelAdmin):
    list_display = ["__str__"]
