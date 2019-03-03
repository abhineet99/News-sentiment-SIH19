from django.shortcuts import render
from .models import AdData
# Create your views here.
def home(request):
    ad_data = AdData.objects.all()
    context = {
        'ad_data':ad_data,
    }
    return render(request, 'adpricing/home.html', context=context)