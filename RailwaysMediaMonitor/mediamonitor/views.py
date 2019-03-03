from django.shortcuts import render
from .models import News

# Create your views here.
def home(request):
    #pass the News model as the context to fill in the table
    context = {
        'news_data': News.objects.all()
    }
    return render(request, "mediamonitor/home.html", context=context)