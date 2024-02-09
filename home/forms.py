from django import forms
from .models import Visitor

class NewVisitorForm(forms.ModelForm):
    class Meta:
        model = Visitor
        fields = ['name']