from django.conf.urls import include, urls
from django.contrib import admin

urlpatterns = [
	url(r'^$', views.post_list, name='post_list'),
]