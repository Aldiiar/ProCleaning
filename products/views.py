from django.shortcuts import get_object_or_404
from django.views.generic import ListView, DetailView
from .models import Category_of_Machine, Machines


class MainPageView(ListView):
    model = Category_of_Machine
    template_name = 'layouts/index.html'
    context_object_name = 'machines'


class MachinePageView(ListView):
    model = Machines
    template_name = 'products/second.html'
    context_object_name = 'cards'

    def get_queryset(self):
        category = get_object_or_404(Category_of_Machine, pk=self.kwargs['category_id'])
        return Machines.objects.filter(category=category)


class MachineDetailView(DetailView):
    model = Machines
    template_name = 'products/info.html'
    context_object_name = 'cards'

    def get_object(self, queryset=None):
        category = get_object_or_404(Category_of_Machine, pk=self.kwargs['category_id'])
        return get_object_or_404(Machines, id=self.kwargs['id'], category=category)