from django.db import models
from django.urls import reverse

# Create your models here.
class Post(models.Model):
    title = models.CharField('제목', max_length=30)
    content = models.TextField('내용')
    created_at = models.DateTimeField('작성일자', auto_now_add=True)
    updated_at = models.DateTimeField('UPDATE DT', auto_now=True)

    def __str__(self):
        return f"[{self.id}]{self.title}"

    def get_absolute_url(self):
        return reverse("blog:post_detail", kwargs={"pk":self.pk})
