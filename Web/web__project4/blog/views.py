from django.shortcuts import render, redirect
from blog.models import Post

# Create your views here.
def index(request):
    return render(request, "index.html")

def post_list(request):
    posts = Post.objects.all() # 모든 Post객체를 가진 QuerySet

    # 템플릿에 전달할 딕셔너리
    context = {
        "posts" : posts,
    }
    return render(request, "post_list.html", context)

def post_detail(request, post_id):
    post = Post.objects.get(id=post_id) # id값이 URL에서 받은 post_id 값인 Post객체
    print(post) # 가져온 객체를 print 함수로 확인

    context = {
        "post" : post,
    }

    return render(request, "post_detail.html", context)

def post_add(request):
    if request.method == "POST": # method가 POST일 때
        title = request.POST["title"]
        content = request.POST["content"]

        post = Post.objects.create(
            title=title,
            content=content,
        )
        return redirect(f"/posts/{post.id}/")

    return render(request, "post_add.html")