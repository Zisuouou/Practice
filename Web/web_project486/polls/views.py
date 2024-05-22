from django.shortcuts import render
from django.http import HttpResponse


def index(request):
    return render("Hello, World. You're at the polls index.")

def detail(request, question_id):
    return render("You're looking at question %s." % question_id)

def results(request, question_id):
    response = "You're looking at the results of question %s."
    return render(response % question_id)

def vote(request, question_id):
    return render("You're voting on question %s." % question_id)
