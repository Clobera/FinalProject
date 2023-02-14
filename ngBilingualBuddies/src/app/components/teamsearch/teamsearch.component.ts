import { AuthService } from './../../services/auth.service';
import { TeamService } from 'src/app/services/team.service';
import { Component } from '@angular/core';
import { Team } from 'src/app/models/team';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-teamsearch',
  templateUrl: './teamsearch.component.html',
  styleUrls: ['./teamsearch.component.css']
})
export class TeamsearchComponent {

teams: Team[] = [];
team = new Team();
selected : null  | Team = null;
user= new User();


constructor(private teamService: TeamService, private authService: AuthService){

}

ngOnInit(){
  this.loadTeams();
  this.getLoggedInUser();
}

loadTeams(){
  this.teamService.index().subscribe({
    next: (data) =>
    {this.teams = data
    for(let team of this.teams){
      if(team.members === undefined){
        team.members = [];
      }
    }
    },
    error: (err) => {
      console.error("error retrieving teams");
      console.error(err);
    }
  });
}

displayTeam(team: Team){
  this.selected = team;
}

joinTeam(team: Team){
  team.members.push(this.user)
  console.log(team.members);
  this.teamService.update(team).subscribe({
    next:(data) =>{
      this.team = data;
    },
    error: (err) => {
      console.log(
        'NavbarCompenent.loadUser: Error joining team'
      );
      console.log(err);
    }
  });

}

getLoggedInUser(){
  this.authService.getLoggedInUser().subscribe({
    next:(data) =>{
      this.user = data;
    },
    error: (err) => {
      console.log(
        'NavbarCompenent.loadUser: Error getting user'
      );
      console.log(err);
    }
  });
}

leaveTeam(team: Team){
  team.members.splice(team.members.indexOf(this.user), 1);
  this.teamService.update(team).subscribe({
    next:(data) =>{
      this.team = data;
    },
    error: (err) => {
      console.log(
        'NavbarCompenent.loadUser: Error leaving team'
      );
      console.log(err);
    }
  });

}

joinedTeam(){
  if(this.selected){
    for(let member of this.selected.members){
      if(this.user.id === member.id){
        return true;
      }
    }
  }
  return false;
}




}
