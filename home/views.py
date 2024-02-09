from django.shortcuts import render, redirect
from django.contrib import messages
from .models import Visitor
from .forms import NewVisitorForm


# Create your views here.
def welcomepage(request):
    if request.method == 'POST':
        form = NewVisitorForm(request.POST)

        if form.is_valid():
            form.save()
        else:
            messages.error(request, 'Sorry, failed to save your name.')
        
        return redirect('/home')
    
    if request.method == 'GET':
        form = NewVisitorForm()
        return render(request, 'welcome.html', {'form': form})


def homepage(request):
    visitors = Visitor.objects.all()
    return render(request, 'home.html', {'visitors': visitors})