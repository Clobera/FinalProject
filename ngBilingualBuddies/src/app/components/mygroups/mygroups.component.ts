import { TeamPipe } from './../../pipes/team.pipe';
import { TeamService } from './../../services/team.service';
import { AuthService } from 'src/app/services/auth.service';
import { Component } from '@angular/core';
import { Team } from 'src/app/models/team';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-mygroups',
  templateUrl: './mygroups.component.html',
  styleUrls: ['./mygroups.component.css']
})
export class MygroupsComponent {
  teams : Team[] = [];
  user : User = new User();

  constructor(private auth : AuthService, private teamServ: TeamService, private teamPipe: TeamPipe){}

  ngOnInit(){
    this.loadUser();
  }

  loadUser(){
    this.auth.getLoggedInUser().subscribe({
      next: (data) => {
        this.user = data;
        this.loadTeams();
      },
      error: (err) => {
        console.log("Error mygroupCompenent.loadUser(): error retrieving logged in user");

      }
    })

  }

  loadTeams(){
    this.teamServ.index().subscribe({
      next: (data) => {
        this.teams = this.teamPipe.transform(data, this.user);
      },
      error: (err) => {
        console.log("Error mygroupCompenent.loadTeams(): error retrieving teams");

      }
    })
  }

}
