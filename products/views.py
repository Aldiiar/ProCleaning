from django.shortcuts import render, get_object_or_404
from .models import Category_of_Machine, Machines

def main_page_view(request):
    if request.method == 'GET':
        machines = Category_of_Machine.objects.all()
        context = {'machines': machines}
        return render(request, 'layouts/index.html', context=context)

def machine_page_view(request, category_id):
    if request.method == 'GET':
        category = get_object_or_404(Category_of_Machine, pk=category_id)
        cards = Machines.objects.filter(category=category)
        context = {'cards': cards}
        return render(request, 'products/second.html', context=context)
