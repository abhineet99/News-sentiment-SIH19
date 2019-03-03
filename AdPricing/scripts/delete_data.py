# scripts/delete_all_news.py

from adpricing.models import AdData

def run():
    # Fetch all questions
    news = AdData.objects.all()
    # Delete questions
    news.delete()