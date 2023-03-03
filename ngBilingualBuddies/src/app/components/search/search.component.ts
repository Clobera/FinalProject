import { Router } from '@angular/router';
import { UserInCityPipe } from './../../pipes/user-in-city.pipe';
import { CityPipe } from './../../pipes/city.pipe';
import { Component, EventEmitter, Output } from '@angular/core';
import { Address } from 'src/app/models/address';
import { Language } from 'src/app/models/language';
import { User } from 'src/app/models/user';
import { EnabledUsersPipe } from 'src/app/pipes/enabled-users.pipe';
import { NameSearchPipe } from 'src/app/pipes/name-search.pipe';
import { UserLanguagePipe } from 'src/app/pipes/user-language.pipe';
import { UserSponsorPipe } from 'src/app/pipes/user-sponsor.pipe';
import { AddressService } from 'src/app/services/address.service';
import { LanguageService } from 'src/app/services/language.service';
import { UserService } from 'src/app/services/user.service';
import { Team } from 'src/app/models/team';
import { Meetup } from 'src/app/models/meetup';
import { TeamSearchPipe } from 'src/app/pipes/team-search.pipe';
import { TeamService } from 'src/app/services/team.service';
import { EnabledTeamsPipe } from 'src/app/pipes/enabled-teams.pipe';
import { MeetupService } from 'src/app/services/meetup.service';
import { EnabledMeetupsPipe } from 'src/app/pipes/enabled-meetups.pipe';
import { MeetupInCityPipe } from 'src/app/pipes/meetup-in-city.pipe';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css'],
})
export class SearchComponent {
  sponsor = false;
  languages: Language[] = [];
  currLangId: string = '1';
  showName = true;
  showLoc = false;
  searchName = '';
  searchLocation = '';
  users: User[] = [];
  teams: Team[] = [];
  meetups: Meetup[] = [];
  searchTeams: Team[] = [];
  searchMeetups: Meetup[] = [];
  currCity = '';
  addresses: Address[] = [];

  selectedType: string = 'users';

  types = [
    'users',
    'teams',
    'meetups'
  ];

  constructor(
    private langServ: LanguageService,
    private userServ: UserService,
    private teamServ: TeamService,
    private meetupServ: MeetupService,
    private enabledUser: EnabledUsersPipe,
    private enabledTeams: EnabledTeamsPipe,
    private enabledMeetups: EnabledMeetupsPipe,
    private lang: UserLanguagePipe,
    private sponsorship: UserSponsorPipe,
    private nameSearch: NameSearchPipe,
    private teamSearch: TeamSearchPipe,
    private addrServ: AddressService,
    private cityPipe: CityPipe,
    private userInCityPipe: UserInCityPipe,
    private meetupInCityPipe: MeetupInCityPipe,
    private router: Router
  ) {}

  assignSelectedTypes(){

  }

  switchName() {
    this.showName = true;
    this.showLoc = false;
    this.emptyUsers();
  }
  switchLoc() {
    this.showLoc = true;
    this.showName = false;
    this.emptyUsers();
  }
  emptyUsers() {
    this.users = [];
  }

  ngOnInit() {
    this.loadLanguages();
    this.loadAddresses();
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

  searchUsersByName(searchName: string) {
    this.users = this.nameSearch.transform(this.users, searchName);
  }

  searchTeamsByName(searchName: string) {
    this.searchTeams = this.teamSearch.transform(this.teams, searchName);


  }

  searchUserByLocation(searchLocation: string) {
    this.users = this.userInCityPipe.transform(this.users, this.currCity);
    console.log('currCity:' + this.currCity);
  }

  searchMeetupByLocation(searchLocation: string) {
    this.meetups = this.meetupInCityPipe.transform(this.meetups, this.currCity);
    console.log('currCity:' + this.currCity);
    console.log(this.meetups.length + "******************** num meetups in currcity");
  }

  loadUsers(num: number, input: string) {
    this.userServ.index().subscribe({
      next: (data) => {
        this.filterByEnabledAndLanguageAndSponsor(data);
        if (num == 1) {
          this.searchUsersByName(input);
        } else if (num == 2) {
          this.searchUserByLocation(input);
        }
      },
      error: (err) => {
        console.log('SearchComponent.loadUsers: Error loading users ' + err);
      },
    });

  }

  loadTeams(num: number, input: string) {
    this.teamServ.index().subscribe({
      next: (data) => {
        this.filterTeamsByEnabled(data);
        if (num == 1) {
          this.searchTeamsByName(input);
        }
      },
      error: (err) => {
        console.log('SearchComponent.loadUsers: Error loading teams ' + err);
      },
    });

  }

  loadMeetups(num: number, input: string) {
    this.meetupServ.index().subscribe({
      next: (data) => {
        this.filterMeetupsByEnabled(data);
        if (num == 1) {
          this.searchTeamsByName(input);
        }else if (num == 2) {
          this.searchMeetupByLocation(input);
        }
      },
      error: (err) => {
        console.log('SearchComponent.loadUsers: Error loading meetups ' + err);
      },
    });

  }

  filterByEnabledAndLanguageAndSponsor(data: User[]) {
    let enabled = this.enabledUser.transform(data);
    console.log(enabled);
    this.users = this.lang.transform(enabled, this.currLangId);
    if (this.sponsor) {
      this.users = this.sponsorship.transform(this.users);
    }
  }

  filterTeamsByEnabled(data: Team[]) {
    this.teams = this.enabledTeams.transform(data);
    console.log(this.teams);
  }

  filterMeetupsByEnabled(data: Meetup[]) {
    this.meetups = this.enabledMeetups.transform(data);
    console.log(this.meetups);
  }

  loadAddresses() {
    this.addrServ.index().subscribe({
      next: (data) => {
        this.addresses = data;
      },
      error: (err) => {
        console.log(
          'SearchComponent.loadAddresses: Error loading Addresses ' + err
        );
      },
    });
  }

  routeUser(user: User) {
    this.router.navigateByUrl('other/' + user.username);
  }
}
