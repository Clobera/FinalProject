import { Language } from './../../models/language';
import { Component } from '@angular/core';
import { LanguageService } from 'src/app/services/language.service';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent {
  sponsor = false;
  languages : Language[] = [];
  currLang : Language = new Language();

  constructor(private langServ : LanguageService){}

  ngOnInit (){
    this.loadLanguages();
  }
  loadLanguages(){
    this.langServ.index().subscribe({
      next: (data) => {

      },
      error: (err) => {
        console.log("SearchComponent.loadLanguages: Error loading languages " + err);
      }
    });
  }


}
