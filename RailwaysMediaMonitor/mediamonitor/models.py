from django.db import models

# Create your models here.
class NEWS(models.Model):
	SNo 		= models.IntegerField()
	Datetime 	= models.DateTimeField()
	News 		= models.TextField()
	Sentiments 	= models.TextField()
	Senscore 	= models.IntegerField()
	reference   = models.TextField(default='Times Of India')
	urlchahiye  = models.URLField(default='https://docs.djangoproject.com/en/2.1/ref/models/fields/')

	def __unicode__(self):
		return self.title

	def save(self, *args, **kwargs):
		if not self.slug:
			self.slug = slugify(self.title)[:50]

		return super(NEWS, self).save(*args,**kwargs)