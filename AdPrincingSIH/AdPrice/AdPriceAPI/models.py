from django.db import models

# Create your models here.
class NEWSPAPER_DATA (models.Model):
	ChoiceCirculationType = (
		('RNI', 'RNI'),
		('ABC', 'ABC'),
		('CA', 'CA'),
		('NA', 'Not Available' )
	)

	SNo 				= models.IntegerField()
	EditionArea 		= models.TextField()
	NewspaperName 		= models.TextField()
	Periodicity 		= models.TextField()
	Rate 				= models.FloatField()
	Language 			= models.TextField()
	Phone 				= models.TextField()
	RegularityStatus	= models.BooleanField(default = 'True' )
	Marks 				= models.BooleanField(default = 'True')
	CirculationType 	= models.CharField(max_length = 3 ,  choices = ChoiceCirculationType , default = 'NA' )
	CirculationScore	= models.IntegerField(null= True, blank= True) 


