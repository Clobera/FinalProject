import { Language } from './../../models/language';
import { Component } from '@angular/core';
import { LanguageService } from 'src/app/services/language.service';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent {
  sponsor = false;
  languages : Language[] = [];
  currLang : Language = new Language();
  showName = false;
  showLoc = true;
  searchName = "";
  searchLocation = "";
  users : User[] = [];

  switch(){
    this.showName = !this.showName;
    this.showLoc = !this.showLoc;
  }

  constructor(private langServ : LanguageService){}

  ngOnInit (){
    this.loadLanguages();
  }

  loadLanguages(){
    this.langServ.index().subscribe({
      next: (data) => {
        this.languages = data;
      },
      error: (err) => {
        console.log("SearchComponent.loadLanguages: Error loading languages " + err);
      }
    });
  }

  searchByName(searchName : string, currLang : Language, sponsor : boolean){
    console.log("searchByName");

  }
  searchByLocation(searchLocation : string, currLang : Language, sponsor : boolean){
    console.log("searchByLoc");

  }

}
