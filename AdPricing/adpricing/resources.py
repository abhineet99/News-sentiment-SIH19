from tastypie.resources import ModelResource
from .models import AdData

class AdDataResource(ModelResource):
    class Meta:
        queryset = AdData.objects.all()
        resource_name = "ad_data"