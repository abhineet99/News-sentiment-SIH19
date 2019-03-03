from django.conf.urls import include, url
from django.contrib import admin
from django.urls import path

from . import views
from mediamonitor.resources import NewsResource

news_resource = NewsResource()

urlpatterns = [
	path('', views.home),
	url(r'^api/', include(news_resource.urls))
]