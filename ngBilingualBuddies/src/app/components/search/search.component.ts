import { Component } from "@angular/core";
import { Language } from "src/app/models/language";
import { User } from "src/app/models/user";
import { EnabledUsersPipe } from "src/app/pipes/enabled-users.pipe";
import { UserLanguagePipe } from "src/app/pipes/user-language.pipe";
import { LanguageService } from "src/app/services/language.service";
import { UserService } from "src/app/services/user.service";

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css'],
})
export class SearchComponent {
  sponsor = false;
  languages: Language[] = [];
  currLangId: string = '1';
  showName = false;
  showLoc = true;
  searchName = '';
  searchLocation = '';
  users: User[] = [];

  switch() {
    this.showName = !this.showName;
    this.showLoc = !this.showLoc;
    this.users = [];
  }

  constructor(
    private langServ: LanguageService,
    private userServ: UserService,
    private enabledUser: EnabledUsersPipe,
    private lang: UserLanguagePipe
  ) {}

  ngOnInit() {
    this.loadLanguages();
  }

  loadLanguages() {
    this.langServ.index().subscribe({
      next: (data) => {
        this.languages = data;
      },
      error: (err) => {
        console.log(
          'SearchComponent.loadLanguages: Error loading languages ' + err
        );
      },
    });
  }

  searchByName(searchName: string) {}
  searchByLocation(searchLocation: string) {
    console.log('Loc');
  }

  loadUsers(num: number, input: string) {
    this.userServ.index().subscribe({
      next: (data) => {
        if (num == 1) {
          this.searchByName(input);
        } else if (num == 2) {
          this.searchByLocation(input);
        }
      },
      error: (err) => {
        console.log(
          'SearchComponent.loadLanguages: Error loading languages ' + err
        );
      },
    });
  }

  filterByEnabledAndLanguage(data: User[]) {
    let enabled = this.enabledUser.transform(data);
    this.users = this.lang.transform(enabled, this.currLangId);
    if (this.sponsor){
      // filter by sponsor
    }
  }






}
