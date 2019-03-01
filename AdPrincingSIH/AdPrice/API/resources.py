from tastypie.resources import ModelResource
from AdPriceAPI.models import NEWSPAPER_DATA

class NEWSPAPER_DATA_RES (ModelResource):
	class Meta:
		queryset = NEWSPAPER_DATA.objects.all()
		allowed_methods = ['get']