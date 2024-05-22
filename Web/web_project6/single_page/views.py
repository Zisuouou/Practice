from django.shortcuts import render

# Create your views here.
def landing(request):
    return render(request,'landing.html')     # ~~/ 는 ~~ 안에서의 주소를 뜻함

def about_me(request):
    return render(request, 'about_me.html' )