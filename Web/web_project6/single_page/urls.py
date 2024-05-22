from django.urls import path
from . import views

app_name = "single_page"
urlpatterns = [
    path('', views.landing),
    path('about_me/', views.about_me),
]