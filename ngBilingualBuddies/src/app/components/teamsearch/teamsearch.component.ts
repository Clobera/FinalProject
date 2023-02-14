import { TeamService } from 'src/app/services/team.service';
import { Component } from '@angular/core';
import { Team } from 'src/app/models/team';

@Component({
  selector: 'app-teamsearch',
  templateUrl: './teamsearch.component.html',
  styleUrls: ['./teamsearch.component.css']
})
export class TeamsearchComponent {

teams: Team[] = [];
team = new Team();


constructor(private teamService: TeamService){

}

ngOnInit(){
  this.loadTeams();
}

loadTeams(){
  this.teamService.index().subscribe({
    next: (data) =>
    {this.teams = data},
    error: (err) => {
      console.error("error retrieving teams");
      console.error(err);
    }
  });
}

loadTeam(id: number){
  this.teamService.show(id).subscribe({
    next: (data) =>
    {this.team = data},
    error: (err) => {
      console.error("error retrieving teams");
      console.error(err);
    }
  });
}



}
