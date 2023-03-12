from django.http import HttpResponse
from django.shortcuts import render
import web3 as wb3

def home(request):
    return render(request,"index.html")


# Registration of Institutions
def reg_institute(request):
    con = wb3.Web3(wb3.Web3.HttpProvider(
        url = "http://127.0.0.1:7545"
    ))

    

    return render(request,"registration.html")
