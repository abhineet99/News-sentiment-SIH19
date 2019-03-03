from django.db import models


# Create your models here.
class AdData (models.Model):
	ChoiceCirculationType = (
		('RNI', 'RNI'),
		('ABC', 'ABC'),
		('CA', 'CA'),
		('NA', 'Not Available' )
	)

	LanguageChoices = (
		('1', 'English'),
		('2', 'Hindi'),
		('3', 'Punjabi'),
		('4', 'Urdu'),
		('5', 'Marathi'),
		('6', 'Others'),
	)


	
	edition_area 		= models.CharField(max_length=144)
	newspaper_name 		= models.CharField(max_length=144)
	periodicity 		= models.CharField(max_length=144)
	rate 				= models.FloatField()
	language 			= models.CharField(max_length=1 , choices = LanguageChoices , default = 6)
	phone 				= models.CharField(max_length=10)
	regularity_status	= models.BooleanField(default = 'True' )
	marks 				= models.BooleanField(default = 'True')
	circulation_type 	= models.CharField(max_length = 3 ,  choices = ChoiceCirculationType , default = 'NA' )
	circulation_score	= models.IntegerField(null= True, blank= True) 

	def __str__(self):
		return self.newspaper_name+" "+self.edition_area

