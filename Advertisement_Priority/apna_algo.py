import numpy
import csv
import statistics
#a=[21,45,996]
#print(statistics.stdev(a))

stdev_rate=0
stdev_read=0
mean_read=0
mean_rate=0
mean_one_by_rate=0
class newspaper:
	def getRead(self):
		return self.readers
	def getRate(self):
		return self.rate
	def getName(self):
		return self.name
	def getRateScore(self):
		to_ret=0.0
		to_ret=1/self.rate
		to_ret=to_ret/mean_one_by_rate
		return to_ret
	def getReadScore(self):
		to_ret=0.0
		to_ret=self.readers/mean_read
		return to_ret
	def __init__(self,name,location,edition,frequency,reach_scale,language,ca,ca_num,rate,mobile,readers):
		self.name=name
		self.location=location
		self.readers=readers
		self.rate=rate
		self.edition=edition
		self.frequency=frequency
		self.reach_scale=reach_scale
		self.language=language
		self.ca=ca
		self.ca_num=ca_num
		self.mobile=mobile
	def print_it(self):
		print(self.name)
		print(self.location)
		print(self.edition)
		print(self.frequency)
		print(self.reach_scale)
		print(self.language)
		print(self.ca)
		print(self.ca_num)
		print(self.mobile)
		print(self.rate)
		print(self.readers)
		print("_______________________")
		

		return
			
	def __lt__(self,other):
		#print("hello")
		if(self.getRead()>other.getRead()):
			print("hello")
			if(self.getRate()<other.getRate()):
				return 1;
			elif((self.getRate()-other.getRate())<stdev_rate):
				return 1;
			elif((self.getRead()-other.getRead())>stdev_read):
				score_self=0.7*self.getReadScore()+0.3*self.getRateScore()
				score_other=0.7*other.getReadScore()+0.3*self.getRateScore()	
				if score_self>score_other:
					return 1
				else:
					return 0	
			else:
				score_self=0.6*self.getReadScore()+0.4*self.getRateScore()
				score_other=0.6*other.getReadScore()+0.4*self.getRateScore()	
				if score_self>score_other:
					return 1
				else:
					return 0	

def main():
	one_by_rate_list=[]

	object_list=[]
	rate_list=[]
	read_list=[]
	with open('sample1.csv') as csv_file:
	    csv_reader = csv.reader(csv_file, delimiter=',')
	    line_count = 0
	    for row in csv_reader:
	        if line_count == 0:
	            #print(f'Column names are {", ".join(row)}')
				line_count += 1
	        else:
				name=row[0]
				location=row[1]
				edition=row[2]
				frequency=row[3]
				reach_scale=row[4]
				language=row[5]
				ca=row[6]
				ca_num=row[7]
				mobile=row[9]
				rate=float(row[8])
				readers=int(row[10])
				one_by_rate=1.0/float(rate)
				rate_list.append(rate)
				one_by_rate_list.append(one_by_rate)
				read_list.append(readers)
				object1=newspaper(name,location,edition,frequency,reach_scale,language,ca,ca_num,rate,mobile,readers)
				object_list.append(object1)
	            #print(f'\t{row[0]} works in the {row[1]} department, and was born in {row[2]}.')
				line_count += 1
	global stdev_rate
	global stdev_read
	global mean_read
	global mean_rate
	global mean_one_by_rate			
	stdev_rate=statistics.stdev(rate_list)
	stdev_read=statistics.stdev(read_list)
	mean_read=statistics.mean(read_list)
	mean_rate=statistics.mean(rate_list)
	mean_one_by_rate=statistics.mean(one_by_rate_list)	
	# print(stdev_rate)

	print(mean_read)	
	# print(stdev_read)
	# print(mean_read)
	# print(mean_rate)
	# print(mean_one_by_rate)		
	# for each in object_list:
	# 	each.print_it()		
	# print(len(object_list))		
	#BUBBLE SORT
	j=0
	i=len(object_list)
	i=i-1
	#label loop:
	for j in range(len(object_list)):
		while i>j:
			if (object_list[i].getRead()<object_list[i-1].getRead()):
				#print("hey")
				temp=object_list[i]
				object_list[i]=object_list[i-1]
				object_list[i-1]=temp
			if (object_list[i]<object_list[i-1]):
				#print("hey")
				temp=object_list[i]
				object_list[i]=object_list[i-1]
				object_list[i-1]=temp
			i=i-1


	for each in object_list:
		each.print_it()	
	with open('sorted_news.csv',"w+") as csv_file:

		writer.writerow(['Name', 'State', 'Edition','Periodicity','Size', 'Language', 'Circulation' , 'CirculationScore', 'Rate', 'Mobile', 'Readers' ])
		for each in object_list:
			writer=csv.writer(csv_file)
			writer.writerow([each.name,each.location,each.edition,each.frequency,each.reach_scale,each.language,each.ca,each.ca_num,each.rate,each.mobile,each.readers])

	return
main()	            

						

