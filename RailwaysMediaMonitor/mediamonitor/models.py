from django.db import models

# Create your models here.
class News(models.Model):
	#SNo 		= models.IntegerField()
	date = models.DateField()
	headline = models.CharField(default = "no headline", max_length=1000)
	sentiment_score = models.IntegerField()
	sentiment = models.CharField(max_length=100)
	source = models.CharField(max_length=200, default="no source")
	sourceURL = models.URLField(default='https://google.com')

	def __unicode__(self):
		return self.headline + " "+ self.source

	def __str__(self):
		return self.headline +" "+self.source